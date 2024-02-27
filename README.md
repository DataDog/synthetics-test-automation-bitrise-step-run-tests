# Datadog Continuous Testing for Bitrise

<!-- TODO add link to marketplace after we publish the step -->
<!-- [![Visual Studio Marketplace Version]()][1001]  -->
[![Build Status](https://app.bitrise.io/app/7846c17b-8a1c-4fc7-aced-5f3b0b2ec6c4/status.svg?token=480MdFpG78E6kZASg5w1dw&branch=main)](https://app.bitrise.io/app/7846c17b-8a1c-4fc7-aced-5f3b0b2ec6c4)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Overview

With the `synthetics-test-automation-bitrise-step-run-tests` step, you can run Synthetics tests during your Bitrise CI and ensure all your teams using Bitrise can benefit from Synthetic tests at every stage of the software lifecycle. This step uses the [Datadog CI Synthetics command][2002].

## Setup

To get started:

1. Add this step to your workflow. You can see [Bitrise's documentation][4001] on how to do that. You can also configure it locally by referencing this step in your `bitrise.yml`.
2. Add your API and App keys to your secrets in Bitrise. Documentation on how to do that can be found here: [Setting a Secret][4002].
3. Configure your step inputs (see the [Step Inputs documentation][4003]). You can also configure them in your `bitrise.yml`. The only required inputs are the two secrets you configured earlier. The rest of the possible inputs are described in a later section.

## How to use this Step locally

This Step can be run directly with the [Bitrise CLI][2003].

To get started:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`d)
5. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
6. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`
7. Once you have the required secret parameters in your `.bitrise.secrets.yml`, run this step with the [Bitrise CLI][2003]: `bitrise run test`.

An example `.bitrise.secrets.yml` file:

```
envs:
- A_SECRET_PARAM_ONE: the value for secret one
- A_SECRET_PARAM_TWO: the value for secret two
```

## Simple usage

### Example using public IDs

<!-- TODO: change git urls to step references after we publish it -->
```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - public_ids: 'abc-d3f-ghi, jkl-mn0-pqr'
```

### Example task using existing `synthetics.json` files

```yaml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - files: 'e2e-tests/*.synthetics.json'
```

For an example test file, see this [`test.synthetics.json` file][3002].

## Complex usage

### Example task using the `testSearchQuery`

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - test_search_query: 'tag:e2e-tests'
```

### Example task using the `testSearchQuery` and variable overrides

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - test_search_query: 'tag:e2e-tests'
   - variables: |
      START_URL=https://staging.website.com
      PASSWORD=$STAGING_PASSWORD
```

### Example task using a global configuration override with `configPath`

This task overrides the path to the global `datadog-ci.config.json` file.

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - config_path: './synthetics-config.json'
```

For an example configuration file, see the [`global.config.json` file][2001].

### Example including all possible configurations

For reference here's how a full configuration could look:

```yml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
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
   - polling_timeout: 4200000
   - public_ids: 'abc-d3f-ghi, jkl-mn0-pqr'
   - site: 'datadoghq.com'
   - subdomain: 'myorg'
   - test_search_query: 'tag:e2e-tests'
   - tunnel: true
   - variables: |
      START_URL=https://staging.website.com
      PASSWORD=$STAGING_PASSWORD
```


## Inputs

| Name                               | Requirement | Description                                                                                                                                                                                                             |
| -----------------------------------| :---------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `apiKey`                           | _required_  | Your Datadog API key. This key is created by your [Datadog organization][3006] and will be accessed as an environment variable.                                                                                         |
| `appKey`                           | _required_  | Your Datadog application key. This key is created by your [Datadog organization][3006] and will be accessed as an environment variable.                                                                                 |
| `configPath`                       | _optional_  | The global JSON configuration is used when launching tests. See the [example configuration][3003] for more details.                                                                                                     |
| `deviceIds`                        | _optional_  | Override the mobile device(s) to run your mobile test.                                                                                                                                                                  |
| `failOnCriticalErrors`             | _optional_  | A boolean flag that fails the CI job if no tests were triggered, or results could not be fetched from Datadog. The default is set to `false`.                                                                           |
| `failOnMissingTests`               | _optional_  | Fail the CI job if at least one specified test with a public ID (using `publicIds` or listed in a [test file][3002]) is missing in a run (for example, if it has been deleted programmatically or on the Datadog site). |
| `failOnTimeout`                    | _optional_  | A boolean flag that fails the CI job if at least one test exceeds the default test timeout. The default is set to `true`.                                                                                               |
| `files`                            | _optional_  | Glob patterns to detect Synthetic test [configuration files][2002].                                                                                                                                                     |
| `jUnitReport`                      | _optional_  | The filename for a JUnit report if you want to generate one.                                                                                                                                                            |
| `locations`                        | _optional_  | String of locations separated by semicolons to override the locations where your tests run.                                                                                                                             |
| `mobileApplicationVersion`         | _optional_  | Override the default mobile application version for a Synthetic mobile application test. The version must be uploaded and available within Datadog.                                                                     |
| `mobileApplicationVersionFilePath` | _optional_  | Override the application version for Synthetic mobile application tests.                                                                                                                                                |
| `pollingTimeout`                   | _optional_  | The duration (in milliseconds) after which the batch is deemed as failed because of a timeout. The default is 30 minutes.                                                                                               |
| `publicIds`                        | _optional_  | String of public IDs separated by commas for Synthetic tests you want to trigger.                                                                                                                                       |
| `site`                             | _optional_  | The Datadog site to send data to. If the `DD_SITE` environment variable is set, it takes precedence.                                                                                                                    |
| `subdomain`                        | _optional_  | The name of the custom subdomain set to access your Datadog application. If the URL used to access Datadog is `myorg.datadoghq.com`, the `subdomain` value needs to be set to `myorg`.                                  |
| `testSearchQuery`                  | _optional_  | Trigger tests corresponding to a [search][3005] query. This can be useful if you are tagging your test configurations. See [best practices][3007] for more information on tagging.                                      |
| `tunnel`                           | _optional_  | Enable [tunnel][3004] to interact with Datadog API.                                                                                                                                                                     |
| `variables`                        | _optional_  | Key-value pairs for injecting variables into tests. Must be formatted using `KEY=VALUE`.                                                                                                                                |

## Further reading

Additional helpful documentation, links, and articles:

- [Continuous Testing and CI/CD Configuration][3001]
- [Best practices for continuous testing with Datadog][5001]

<!-- Links to Marketplace -->
[1001]: https://marketplace.visualstudio.com/items?itemName=Datadog.datadog-ci

<!-- Github links -->
[2001]: https://github.com/DataDog/datadog-ci/blob/master/.github/workflows/e2e/global.config.json
[2002]: https://github.com/DataDog/datadog-ci/tree/master/src/commands/synthetics#test-files
[2003]: https://github.com/bitrise-io/bitrise

<!-- Links to datadog documentation -->
[3001]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[3002]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#test-files
[3003]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file-options
[3004]: https://docs.datadoghq.com/continuous_testing/testing_tunnel
[3005]: https://docs.datadoghq.com/synthetics/search/#search
[3006]: https://docs.datadoghq.com/account_management/api-app-keys/
[3007]: https://docs.datadoghq.com/developers/guide/what-best-practices-are-recommended-for-naming-metrics-and-tags/#rules-and-best-practices-for-naming-tags

<!-- Integration specific links -->
[4001]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html
[4002]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[4003]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html

<!-- Other -->
[5001]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
