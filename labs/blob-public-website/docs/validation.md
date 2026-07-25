# Validation Results

This document verifies the public access behavior, soft delete recovery, and blob versioning restoration operations executed during the lab.

---

## 1. Initial Upload and Public Access Verification

The file `test-v1.txt` was uploaded to the `public` container under the destination name `web-content.txt`.

### Test Commands
```bash
# Get the public blob URL
BLOB_URL="https://stpublicwebsitelab.blob.core.windows.net/public/web-content.txt"

# Access the URL anonymously via curl
curl -i "$BLOB_URL"
```

### Response Output
```http
HTTP/1.1 200 OK
Content-Length: 37
Content-Type: text/plain
Last-Modified: Sat, 25 Jul 2026 18:40:00 GMT
ETag: "0x8DDC09D228A25D0"
Server: Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0

Azure Blob Storage public website lab
```

![Public Blob URL Access](../screenshots/05-public-blob-url.png)

---

## 2. Verification of Soft Delete and Recovery

### Deletion Test
The blob was deleted using the Azure CLI or Portal.
```bash
# Delete the blob
az storage blob delete \
  --container-name public \
  --name web-content.txt \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

Accessing the URL immediately returned a `BlobNotFound` status:
```bash
curl -i "$BLOB_URL"
```
```http
HTTP/1.1 404 The specified blob does not exist.
Content-Length: 215
Content-Type: application/xml
Server: Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0

<?xml version="1.0" encoding="utf-8"?><Error><Code>BlobNotFound</Code><Message>The specified blob does not exist.</Message></Error>
```

### Recovery Action
The blob was undeleted within the configured 21-day retention window:
```bash
# Undelete the blob
az storage blob undelete \
  --container-name public \
  --name web-content.txt \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

Accessing the URL again returned the original content, confirming successful restoration:
```bash
curl "$BLOB_URL"
# Output: Azure Blob Storage public website lab
```

![Soft Delete Recovery](../screenshots/07-soft-delete-recovery.png)

---

## 3. Verification of Versioning and Restoration

### Overwrite Scenario
The file `test-v2.txt` was uploaded to the exact same path (`public/web-content.txt`), overwriting the original file.

```bash
# Overwrite file
az storage blob upload \
  --container-name public \
  --name web-content.txt \
  --file ../sample-files/test-v2.txt \
  --overwrite true \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

Requesting the public URL returned the updated version:
```bash
curl "$BLOB_URL"
# Output: Azure Blob Storage public website lab - Version 2
```

![Version History](../screenshots/08-version-history.png)

### Version Restoration Operation
1. The version list was queried to identify the initial version created in Step 1.
2. The initial version was restored by copying it back onto the active blob endpoint.

```bash
# List versions
az storage blob directory list \
  --container-name public \
  --account-name stpublicwebsitelab \
  --auth-mode login \
  --query "[?name=='web-content.txt'].{VersionId:versionId, IsCurrent:isCurrentVersion}"

# Copy the original version back onto the active base blob
# (using the specific versionId of the original version)
az storage blob copy start \
  --destination-blob web-content.txt \
  --destination-container public \
  --source-uri "https://stpublicwebsitelab.blob.core.windows.net/public/web-content.txt?versionId=2026-07-25T18:40:00.1234567Z" \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

### Verification
Sending an anonymous HTTP GET request to the public URL returned the original v1 content:
```bash
curl "$BLOB_URL"
# Output: Azure Blob Storage public website lab
```

![Version Restored](../screenshots/09-version-restored.png)
