# Overview
An example of how to use the Cycle CLI Docker container within a Github Actions workflow. ▶️

# Cycle CLI Docker container in a Github Actions workflow
You can view our public example pipelines that are executing Cycle tests [here](https://github.com/CycleLabsGHA/dockerized-cycle/actions)!

![Pipeline Status](https://github.com/CycleLabsGHA/dockerized-cycle/actions/workflows/dockerized-cycle.yml/badge.svg)

# Documentation
We have documented how to use the Cycle CLI Docker container in great detail [here](https://hub.docker.com/repository/docker/cyclelabs/cycle-cli/general). This repository is where our code examples for Cycle CLI Docker container running tests within Github Actions will be shared.

# Workflow File

Here is a summary of how our [workflow file](https://github.com/CycleLabsGHA/dockerized-cycle/blob/main/.github/workflows/dockerized-cycle.yml) that is executing the Cycle tests with the Docker container. 

## 🔁 GitHub Actions: Run Dockerized Cycle Tests

This repository includes a GitHub Actions workflow that automatically runs Cycle test suites using Docker containers on a scheduled basis and via manual trigger.

### 📋 Workflow Overview

- **Workflow Name:** `Run Dockerized Cycle Tests`
- **Trigger:**
  - **Scheduled:** Every 4 hours (`cron: '0 */4 * * *'`)
  - **Manual:** On-demand via [workflow_dispatch](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch)
- **Runner:** `ubuntu-latest`

### ✅ Key Steps

1. **🛎️ Checkout Code**  
   Uses `actions/checkout@v3` to pull the repository contents.

2. **🔐 Log in to Azure**  
   Authenticates to Azure using credentials stored in `AZURE_CREDENTIALS`.

3. **⚙️ Install PowerShell**  
   Installs PowerShell to support secret handling and scripting.

4. **🧪 Retrieve Secrets from Azure Key Vault**  
   - Retrieves sensitive values like database passwords and API keys.
   - Exports them to `GITHUB_ENV` for use in subsequent steps.
   - Secrets are masked in logs for security.

5. **🧪 Run Cycle API Tests**  
   - Executes tests via `api-test-docker-compose.yml`.
   - Uses `--abort-on-container-exit` to ensure failures are caught.
   - Gracefully brings down containers afterward.

6. **🧪 Run Cycle Browser Tests**
   - **Chrome Tests:** Uses `chrome-test-docker-compose.yml`
   - **Edge Tests:** Uses `edge-test-docker-compose.yml`
   - Runs tests inside Selenium-capable Docker containers.

7. **🧹 Clean up Docker Containers**  
   Prunes unused containers to keep the environment clean.

### 📦 Dependencies

- Docker Compose files:
  - `api-test-docker-compose.yml`
  - `chrome-test-docker-compose.yml`
  - `edge-test-docker-compose.yml`
- Azure Key Vault secrets (referenced by secret names)
- PowerShell for scripting
