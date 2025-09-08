# Datadog Continuous Testing for Bitrise

![GitHub Release](https://img.shields.io/github/v/release/DataDog/synthetics-test-automation-bitrise-step-run-tests)
[![Build Status](https://app.bitrise.io/app/7846c17b-8a1c-4fc7-aced-5f3b0b2ec6c4/status.svg?token=480MdFpG78E6kZASg5w1dw&branch=main)](https://app.bitrise.io/app/7846c17b-8a1c-4fc7-aced-5f3b0b2ec6c4)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Overview

With the `synthetics-test-automation-bitrise-step-run-tests` step, you can run Synthetic tests during your Bitrise CI, ensuring that all your teams using Bitrise can benefit from Synthetic tests at every stage of the software lifecycle.

For more information on the available configuration, see the [`datadog-ci synthetics run-tests` documentation][2].

## Setup

This step is not available on the official Bitrise Step Library.
To get started:

1. Add the following git URL to your workflow. See the [official Bitrise documentation][3] on how to do that though the Bitrise app. You can also configure it locally by referencing the git URL in your `bitrise.yml` file.

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
```

2. Add your API and application keys to your [secrets in Bitrise][4].
3. [Configure your step inputs][5]. You can also configure them in your `bitrise.yml` file. The only required inputs are the two secrets you configured earlier. For a comprehensive list of inputs, see the [Inputs section](#inputs).

When running the step locally with the Bitrise CLI, the secrets should be stored in a `.bitrise.secrets.yml` file. See [Managing secrets locally][6].

## Simple usage

### Example using public IDs

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - public_ids: |
      abc-d3f-ghi
      jkl-mn0-pqr
```

### Example task using existing `synthetics.json` files

```yaml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - files: 'e2e-tests/*.synthetics.json'
```

For an example test file, see this [`test.synthetics.json` file][7].

## Complex usage

### Example task using the `testSearchQuery`

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - test_search_query: 'tag:e2e-tests'
```

### Example task using the `testSearchQuery` and variable overrides

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - test_search_query: 'tag:e2e-tests'
   - variables: |
      START_URL=https://staging.website.com
      PASSWORD=$STAGING_PASSWORD
```

### Example task using a global configuration override with `configPath`

This task overrides the path to the global `global.config.json` file.

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - config_path: './global.config.json'
```

### Example including all possible configurations

For reference, this is an example of a complete configuration:

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v3.7.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - batch_timeout: 4200000
   - config_path: './global.config.json'
   - datadog_site: 'datadoghq.com'
   - device_ids: |
      apple iphone se (2022),15.4.1
      apple iphone 14 pro,16.1
   - fail_on_critical_errors: true
   - fail_on_missing_tests: true
   - fail_on_timeout: true
   - files: 'e2e-tests/*.synthetics.json'
   - junit_report: 'e2e-test-junit'
   - locations: 'aws:us-west-1'
   - mobile_application_version: '01234567-8888-9999-abcd-efffffffffff'
   - mobile_application_version_file_path: 'path/to/application.apk'
   - public_ids: 'abc-d3f-ghi,jkl-mn0-pqr'
   - selective_rerun: true
   - subdomain: 'myorg'
   - test_search_query: 'tag:e2e-tests'
   - tunnel: true
   - variables: |
      START_URL=https://staging.website.com
      PASSWORD=$STAGING_PASSWORD
```

## Inputs

For more information on the available configuration, see the [`datadog-ci synthetics run-tests` documentation][2].

| Name                                   | Description                                                                                                                                                                                                                                                                                                      |
| -------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `api_key`                              | (**Required**) Your Datadog API key. This key is [created in your Datadog organization][9] and should be stored as a secret.                                                                                                                                                                                     |
| `app_key`                              | (**Required**) Your Datadog application key. This key is [created in your Datadog organization][9] and should be stored as a secret.                                                                                                                                                                             |
| `batch_timeout`                        | Specifies the timeout duration in milliseconds for the CI batch. When a batch times out, the CI job fails and no new test runs are triggered, but ongoing test runs complete normally. <br><sub>**Default:** `1800000` (30 minutes)</sub>                                                                        |
| `config_path`                          | The path to the [global configuration file][10] that configures datadog-ci. <br><sub>**Default:** `datadog-ci.json`</sub>                                                                                                                                                                                        |
| `datadog_site`                         | Your Datadog site. The possible values are listed [in this table][16]. <br><sub>**Default:** `datadoghq.com`</sub> <!-- partial <br><br>Set it to {{< region-param key="dd_site" code="true" >}} (ensure the correct SITE is selected on the right). partial -->                                                 |
| `device_ids`                           | Override the list of devices on which to run the Synthetic tests, separated by new lines. <br><sub>**Default:** none</sub>                                                                                                                                                                                       |
| `fail_on_critical_errors`              | Fail the CI job if a critical error that is typically transient occurs, such as rate limits, authentication failures, or Datadog infrastructure issues. <br><sub>**Default:** `false`</sub>                                                                                                                      |
| `fail_on_missing_tests`                | Fail the CI job if the list of tests to run is empty or if some explicitly listed tests are missing. <br><sub>**Default:** `false`</sub>                                                                                                                                                                         |
| `fail_on_timeout`                      | Fail the CI job if the CI batch fails as timed out. <br><sub>**Default:** `true`</sub>                                                                                                                                                                                                                           |
| `files`                                | Glob patterns to detect Synthetic [test configuration files][7], separated by new lines. <br><sub>**Default:** `{,!(node_modules)/**/}*.synthetics.json`</sub>                                                                                                                                                   |
| `junit_report`                         | The filename for a JUnit report if you want to generate one. <br><sub>**Default:** none</sub>                                                                                                                                                                                                                    |
| `locations`                            | Override the list of locations to run the test from, separated by new lines or commas. The possible values are listed [in this API response][20]. <br><sub>**Default:** none</sub>                                                                                                                               |
| `mobile_application_version_file_path` | Override the mobile application version for [Synthetic mobile application tests][19] with a local or recently built application. You may use `$BITRISE_IPA_PATH` or `$BITRISE_APK_PATH` from your previous build steps. <br><sub>**Default:** none</sub>                                                         |
| `mobile_application_version`           | Override the mobile application version for [Synthetic mobile application tests][19]. The version must be uploaded and available within Datadog. You can use the [Bitrise step to upload an application][11] and use its `DATADOG_UPLOADED_APPLICATION_VERSION_ID` output here. <br><sub>**Default:** none</sub> |
| `public_ids`                           | Public IDs of Synthetic tests to run, separated by new lines or commas. If no value is provided, tests are discovered in Synthetic [test configuration files][7]. <br><sub>**Default:** none</sub>                                                                                                               |
| `selective_rerun`                      | Whether to only rerun failed tests. If a test has already passed for a given commit, it is not rerun in subsequent CI batches. By default, your organization's default setting is used. Set it to `false` to force full runs when your configuration enables it by default. <br><sub>**Default:** none</sub>     |
| `subdomain`                            | The custom subdomain to access your Datadog organization. If the URL used to access Datadog is `myorg.datadoghq.com`, the custom subdomain is `myorg`. <br><sub>**Default:** `app`</sub>                                                                                                                         |
| `test_search_query`                    | Use a [search query][12] to select which Synthetic tests to run. Use the [Synthetic Tests list page's search bar][15] to craft your query, then copy and paste it. <br><sub>**Default:** none</sub>                                                                                                              |
| `tunnel`                               | Use the [Continuous Testing tunnel][14] to launch tests against internal environments. <br><sub>**Default:** `false`</sub>                                                                                                                                                                                       |
| `variables`                            | Override existing or inject new local and [global variables][21] in Synthetic tests as key-value pairs, separated by new lines or commas. For example: `START_URL=https://example.org,MY_VARIABLE=My title`. <br><sub>**Default:** none</sub>                                                                    |

## Further reading

Additional helpful documentation, links, and articles:

- [Getting Started with Continuous Testing][17]
- [Continuous Testing and CI/CD Configuration][13]
- [Best practices for continuous testing with Datadog][18]

[2]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#run-tests-command
[3]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html#adding-steps-from-alternative-sources
[4]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[5]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html
[6]: https://devcenter.bitrise.io/en/bitrise-cli/managing-secrets-locally.html
[7]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#test-files
[9]: https://docs.datadoghq.com/account_management/api-app-keys/
[10]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file
[11]: https://github.com/DataDog/synthetics-test-automation-bitrise-step-upload-application
[12]: https://docs.datadoghq.com/synthetics/search/#search
[13]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[14]: https://docs.datadoghq.com/continuous_testing/environments/proxy_firewall_vpn#what-is-the-testing-tunnel
[15]: https://app.datadoghq.com/synthetics/tests
[16]: https://docs.datadoghq.com/getting_started/site/#access-the-datadog-site
[17]: https://docs.datadoghq.com/getting_started/continuous_testing/
[18]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
[19]: https://docs.datadoghq.com/synthetics/mobile_app_testing/
[20]: https://app.datadoghq.com/api/v1/synthetics/locations?only_public=true
[21]: https://docs.datadoghq.com/synthetics/platform/settings/?tab=specifyvalue#global-variables
