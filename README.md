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
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
```

2. Add your API and application keys to your [secrets in Bitrise][4].
3. [Configure your step inputs][5]. You can also configure them in your `bitrise.yml` file. The only required inputs are the two secrets you configured earlier. For a comprehensive list of inputs, see the [Inputs section](#inputs).

## How to use this step locally

You can run this step directly using the [Bitrise CLI][6].

To run this step locally:

1. Open your terminal or command line.
2. `git clone` the [Bitrise repository][6].
3. `cd` into the directory of the step (the one you just `git clone`d).
4. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`. The `.bitrise.secrets.yml` file is a Git-ignored file, so you can store your secrets in it.
5. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`.
6. Once you have the required secret parameters in your `.bitrise.secrets.yml` file, run this step with the [Bitrise CLI][6]: `bitrise run test`.

An example `.bitrise.secrets.yml` file:

```yml
envs:
- A_SECRET_PARAM_ONE: the value for secret one
- A_SECRET_PARAM_TWO: the value for secret two
```

## Simple usage

### Example using public IDs

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - public_ids: |
      abc-d3f-ghi
      jkl-mn0-pqr
```

### Example task using existing `synthetics.json` files

```yaml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - files: 'e2e-tests/*.synthetics.json'
```

For an example test file, see this [`test.synthetics.json` file][7].

## Complex usage

### Example task using the `testSearchQuery`

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - test_search_query: 'tag:e2e-tests'
```

### Example task using the `testSearchQuery` and variable overrides

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
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
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - config_path: './global.config.json'
```

### Example including all possible configurations

For reference, this is an example of a complete configuration:

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git@v2.2.0:
   inputs:
   - api_key: <DATADOG_API_KEY>
   - app_key: <DATADOG_APP_KEY>
   - batch_timeout: 4200000
   - config_path: './global.config.json'
   - device_ids: 'apple iphone se (2022),15.4.1, apple iphone 14 pro,16.1'
   - fail_on_critical_errors: true
   - fail_on_missing_tests: true
   - fail_on_timeout: true
   - files: 'e2e-tests/*.synthetics.json'
   - junit_report: 'e2e-test-junit'
   - locations: 'aws:us-west-1'
   - mobile_application_version: '01234567-8888-9999-abcd-efffffffffff'
   - mobile_application_version_file_path: 'path/to/application.apk'
   - public_ids: 'abc-d3f-ghi,jkl-mn0-pqr'
   - site: 'datadoghq.com'
   - subdomain: 'myorg'
   - test_search_query: 'tag:e2e-tests'
   - tunnel: true
   - variables: |
      START_URL=https://staging.website.com
      PASSWORD=$STAGING_PASSWORD
```

## Inputs

For more information on the available configuration, see the [`datadog-ci synthetics run-tests` documentation][2].

| Name                                   | Description                                                                                                                                                                                                                                                        |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `api_key`                              | (**Required**) Your Datadog API key. This key is [created in your Datadog organization][9] and should be stored as a secret.                                                                                                                                       |
| `app_key`                              | (**Required**) Your Datadog application key. This key is [created in your Datadog organization][9] and should be stored as a secret.                                                                                                                               |
| `batch_timeout`                        | The duration in milliseconds after which the CI batch fails as timed out. This does not affect the outcome of a test run that already started. <br><sub>**Default:** `1800000` (30 minutes)</sub>                                                                  |
| `config_path`                          | The path to the [global configuration file][10] that configures datadog-ci. <br><sub>**Default:** `datadog-ci.json`</sub>                                                                                                                                          |
| `device_ids`                           | Override the list of devices on which to run the Synthetic tests. <br><sub>**Default:** none</sub>                                                                                                                                                                 |
| `locations`                            | String of locations separated by semicolons to override the locations where your tests run. <br><sub>**Default:** none</sub>                                                                                                                                       |
| `fail_on_critical_errors`              | Fail the CI job if a critical error that is typically transient occurs, such as rate limits, authentication failures, or Datadog infrastructure issues. <br><sub>**Default:** `false`</sub>                                                                        |
| `fail_on_missing_tests`                | Fail the CI job if at least one specified test with a public ID (using `publicIds` or listed in a [test file][7]) is missing in a run (for example, if it has been deleted programmatically or on the Datadog site). <br><sub>**Default:** `false`</sub>           |
| `fail_on_timeout`                      | A boolean flag that fails the CI job if at least one test exceeds the default test timeout. <br><sub>**Default:** `true`</sub>                                                                                                                                     |
| `files`                                | Glob patterns to detect Synthetic test [configuration files][2]. <br><sub>**Default:** `{,!(node_modules)/**/}*.synthetics.json`</sub>                                                                                                                             |
| `junit_report`                         | The filename for a JUnit report if you want to generate one. <br><sub>**Default:** none</sub>                                                                                                                                                                      |
| `mobile_application_version`           | Override the default mobile application version for a Synthetic mobile application test. The version must be uploaded and available within Datadog. This version is also outputted by the [`datadog-mobile-app-upload` step][11]. <br><sub>**Default:** none</sub> |
| `mobile_application_version_file_path` | Override the application version for [Synthetic mobile application tests][19]. <br><sub>**Default:** none</sub>                                                                                                                                                    |
| `public_ids`                           | Public IDs of Synthetic tests to run, separated by newlines or commas. If no value is provided, tests are discovered in `*.synthetics.json` files. <br><sub>**Default:** none</sub>                                                                                |
| `site`                                 | Your Datadog site. The possible values are listed [in this table][16]. <br><sub>**Default:** `datadoghq.com`</sub>                                                                                                                                                 |
| `subdomain`                            | The name of the custom subdomain set to access your Datadog application. If the URL used to access Datadog is `myorg.datadoghq.com`, the `subdomain` value needs to be set to `myorg`. <br><sub>**Default:** `app`</sub>                                           |
| `test_search_query`                    | Trigger tests corresponding to a [search][12] query. This can be useful if you are tagging your test configurations. See [best practices][15] for more information on tagging. <br><sub>**Default:** none</sub>                                                    |
| `tunnel`                               | Enable [Local and Staging Environments][14] to interact with the Datadog API. <br><sub>**Default:** `false`</sub>                                                                                                                                                  |
| `variables`                            | Key-value pairs for injecting variables into tests, separated by newlines or commas. For example: `START_URL=https://example.org,MY_VARIABLE=My title`. <br><sub>**Default:** none</sub>                                                                           |

## Further reading

Additional helpful documentation, links, and articles:

- [Getting Started with Continuous Testing][17]
- [Continuous Testing and CI/CD Configuration][13]
- [Best practices for continuous testing with Datadog][18]

[1]: https://bitrise.io/integrations/steps/datadog-mobile-app-run-tests
[2]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#run-tests-command
[3]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html#adding-steps-from-alternative-sources
[4]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[5]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html
[6]: https://github.com/bitrise-io/bitrise
[7]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#test-files
[8]: https://github.com/DataDog/datadog-ci/blob/master/.github/workflows/e2e/global.config.json
[9]: https://docs.datadoghq.com/account_management/api-app-keys/
[10]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file
[11]: https://github.com/DataDog/synthetics-test-automation-bitrise-step-upload-application
[12]: https://docs.datadoghq.com/synthetics/search/#search
[13]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[14]: https://docs.datadoghq.com/continuous_testing/environments/multiple_env
[15]: https://docs.datadoghq.com/developers/guide/what-best-practices-are-recommended-for-naming-metrics-and-tags/#rules-and-best-practices-for-naming-tags
[16]: https://docs.datadoghq.com/getting_started/site/#access-the-datadog-site
[17]: https://docs.datadoghq.com/getting_started/continuous_testing/
[18]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
[19]: https://docs.datadoghq.com/synthetics/mobile_app_testing/
