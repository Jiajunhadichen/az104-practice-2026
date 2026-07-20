# Chaos Studio Configuration Notes

Configure the experiment in Azure Chaos Studio:

1. Register the `Microsoft.Chaos` resource provider.
2. Open **Chaos Studio → Targets**.
3. Select only the primary App Service.
4. Enable it as a **service-direct target**.
5. Create an experiment with a system-assigned managed identity.
6. Add the `Stop App Service` fault.
7. Set duration to 10 minutes.
8. Select the primary App Service as the target.
9. Use the automatically generated Website Contributor role assignment scoped to the target web application.
10. Start the experiment.
11. Validate:
    - Primary app becomes `Stopped`.
    - Traffic Manager returns the backup application.
    - DNS resolves to the backup endpoint.
    - Primary app returns to `Running`.
    - Both endpoints become `Online`.
    - Traffic Manager fails back to the primary endpoint.

Do not target the backup application during this experiment.
