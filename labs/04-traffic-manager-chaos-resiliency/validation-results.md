# Validation Results

This file records sanitized results from the completed live Azure deployment. Resource names are generalized and no subscription or identity information is included.

## Initial State

```text
Primary application state: Running
Primary endpoint monitor status: Online
Backup endpoint monitor status: Online
```

Traffic Manager HTTP response:

```html
<h1>PRIMARY — SWEDEN CENTRAL</h1>
```

DNS result:

```text
traffic-manager-profile.trafficmanager.net
canonical name = primary-app.azurewebsites.net
```

## Chaos Experiment

```text
Fault: Stop App Service
Target: Sweden Central primary application
Duration: 10 minutes
Identity: System-assigned managed identity
Permission scope: Target web application
```

State during the experiment:

```text
Primary application state: Stopped
```

Traffic Manager failover response:

```html
<h1>BACKUP — CANADA CENTRAL</h1>
```

DNS during failover:

```text
traffic-manager-profile.trafficmanager.net
canonical name = backup-app.azurewebsites.net
```

## Recovery and Failback

```text
Primary application state: Running
Primary endpoint monitor status: Online
Backup endpoint monitor status: Online
```

Traffic Manager failback response:

```html
<h1>PRIMARY — SWEDEN CENTRAL</h1>
```

DNS after recovery:

```text
traffic-manager-profile.trafficmanager.net
canonical name = primary-app.azurewebsites.net
```

## Conclusion

The test confirmed automatic failover from Sweden Central to Canada Central and automatic failback after the primary application recovered.
