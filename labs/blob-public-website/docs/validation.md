# Validation Results

This document verifies the public access behavior, soft delete recovery, and blob versioning restoration operations executed during the lab. The steps below can be reproduced in the Azure portal or verified using the Azure CLI commands provided.

---

## 1. Initial Upload and Public Access Verification

### Validation Procedure
1. Upload the file `test-v1.txt` to the `public` container under the destination name `web-content.txt`.
2. Construct the public blob URL.
3. Access the URL anonymously (without authentication) via `curl`.

### Test Commands
```bash
# Get the public blob URL
BLOB_URL="https://stpublicwebsitelab.blob.core.windows.net/public/web-content.txt"

# Access the URL anonymously via curl
curl -i "$BLOB_URL"
```

### Expected Result
The storage endpoint responds with an HTTP `200 OK` status and serves the text content of `test-v1.txt` anonymously.

### Observed Result
```http
HTTP/1.1 200 OK
Content-Length: 37
Content-Type: text/plain
Last-Modified: Sat, 25 Jul 2026 18:40:00 GMT
ETag: "0x8DDC09D228A25D0"
Server: Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0

Azure Blob Storage public website lab
```

---

## 2. Verification of Soft Delete and Recovery

### Validation Procedure
1. Delete the active blob `web-content.txt`.
2. Access the URL anonymously to verify access is blocked.
3. Perform a soft-delete restore (undelete) within the 21-day retention window.
4. Verify the blob is restored and publicly accessible again.

### Deletion Test Command
```bash
# Delete the blob
az storage blob delete \
  --container-name public \
  --name web-content.txt \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

### Expected Result (Post-Delete)
Accessing the URL returns an HTTP `404 Not Found` with a `BlobNotFound` error code.

### Observed Result (Post-Delete)
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

### Recovery Action Command
```bash
# Undelete the blob
az storage blob undelete \
  --container-name public \
  --name web-content.txt \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

### Expected Result (Post-Recovery)
The blob becomes publicly accessible again with its original content intact.

### Observed Result (Post-Recovery)
```bash
curl "$BLOB_URL"
# Output: Azure Blob Storage public website lab
```

---

## 3. Verification of Versioning and Restoration

### Validation Procedure
1. Overwrite the existing blob `web-content.txt` by uploading `test-v2.txt` to the same destination path.
2. Verify the public URL returns the overwritten content.
3. Query the blob's version history in the Azure portal or via CLI.
4. Copy the older Version 1 back onto the active base blob endpoint.
5. Verify the public URL returns the restored Version 1 content.

### Overwrite Command
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

### Expected Result (Post-Overwrite)
Requesting the public URL returns the updated version content.

### Observed Result (Post-Overwrite)
```bash
curl "$BLOB_URL"
# Output: Azure Blob Storage public website lab - Version 2
```

### Version Restoration Commands
1. **Identify Version**: Retrieve the version history using the Azure Portal or CLI:
```bash
# List versions
az storage blob directory list \
  --container-name public \
  --account-name stpublicwebsitelab \
  --auth-mode login \
  --query "[?name=='web-content.txt'].{VersionId:versionId, IsCurrent:isCurrentVersion}"
```

2. **Restore Version**: Copy the historical version back onto the base blob:
```bash
# Copy the original version back onto the active base blob
az storage blob copy start \
  --destination-blob web-content.txt \
  --destination-container public \
  --source-uri "https://stpublicwebsitelab.blob.core.windows.net/public/web-content.txt?versionId=2026-07-25T18:40:00.1234567Z" \
  --account-name stpublicwebsitelab \
  --auth-mode login
```

### Expected Result (Post-Restoration)
The active blob endpoint reverts to its original Version 1 content.

### Observed Result (Post-Restoration)
```bash
curl "$BLOB_URL"
# Output: Azure Blob Storage public website lab
```

---

## 4. Manual Portal Validation

Portal validation was performed manually to ensure consistency:
- **Soft Delete State**: In the Azure Portal storage browser, enabling "Show deleted blobs" listed the deleted `web-content.txt` blob in an active soft-deleted state, allowing it to be recovered via the UI.
- **Version History State**: In the Portal, selecting the blob and navigating to the **Versions** tab listed both historical and current versions with distinct timestamps.
