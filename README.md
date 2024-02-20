# Datadog Continuous Testing for Bitrise

<!-- TODO add link to marketplace after we publish the step -->
<!-- [![Visual Studio Marketplace Version]()][A-1]  -->
<!-- [![Build Status](https://dev.azure.com/datadog-ci/Datadog%20CI%20Azure%20DevOps%20Extension/_apis/build/status%2FDevelopment?branchName=main)](https://dev.azure.com/datadog-ci/Datadog%20CI%20Azure%20DevOps%20Extension/_build/latest?definitionId=4&branchName=main) -->
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Overview

With the `synthetics-test-automation-bitrise-step-run-tests` step you can run Synthetics tests during your Bitrise CI and ensure all your teams using Bitrise can benefit from Synthetic tests at every stage of the software lifecycle. This step uses the [Datadog CI Synthetics command][B-2].

## Setup

To get started:

1. Add this step to your workflow. You can see Bitrise's documentation on how to do that [here][D-1]. You can also configure it locally by referencing this step in your `bitrise.yml`
2. Add you API and App Keys to your secrets in Bitrise. Documentation on how to do that can be found [here][D-2]
3. Configure your step inputs ([docs][D-3]). You can also configure them in your `bitrise.yml`. The only required inputs are the 2 secrets you configured earlier. The rest of the possible inputs will be described later on.

## How to use this Step locally

Can be run directly with the [bitrise CLI][B-3], just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be added to your `.bitrise.secrets.yml` file!*

Step by step:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`d)
5. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
6. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`
  * Best practice is to mark these options with something like `# define these in your .bitrise.secrets.yml`, in the `app:envs` section.
7. Once you have all the required secret parameters in your `.bitrise.secrets.yml` you can just run this step with the [bitrise CLI][B-3]: `bitrise run test`

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
   - public_ids: '012-345-678, 9ab-cde-fff'
```

### Example task using existing `synthetics.json` files

```yaml
- git::https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests.git:
   inputs:
   - api_key: $DATADOG_API_KEY
   - app_key: $DATADOG_APP_KEY
   - files: 'e2e-tests/*.synthetics.json'
```

For an example test file, see this [`test.synthetics.json` file][C-2].

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
      PASSWORD=$(StagingPassword)
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

For an example configuration file, see this [`global.config.json` file][B-1].

### Example including all possible configurations

There shouldn't be any cases where you would need to use all of the configurations at the same time as for example `public_ids` and `test_search_query` are mutually exclusive. However having an example for the value of each is useful.

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
   - public_ids: '012-345-678, 9ab-cde-fff'
   - site: 'datadoghq.com'
   - subdomain: 'myorg'
   - test_search_query: 'tag:e2e-tests'
   - tunnel: true
   - variables: |
      START_URL=https://staging.website.com
      PASSWORD=$(StagingPassword)
```


## Inputs

| Name                               | Requirement | Description                                                                                                                                                                                                           |
| -----------------------------------| :---------: | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `apiKey`                           | _required_  | Your Datadog API key. This key is created by your [Datadog organization][C-6] and will be accessed as an environment variable.                                                                                        |
| `appKey`                           | _required_  | Your Datadog application key. This key is created by your [Datadog organization][C-6] and will be accessed as an environment variable.                                                                                |
| `configPath`                       | _optional_  | The global JSON configuration is used when launching tests. See the [example configuration][C-3] for more details.                                                                                                    |
| `deviceIds`                        | _optional_  | Override the mobile device(s) to run your mobile test.                                                                                                                                                                |
| `failOnCriticalErrors`             | _optional_  | A boolean flag that fails the CI job if no tests were triggered, or results could not be fetched from Datadog. The default is set to `false`                                                                          |
| `failOnMissingTests`               | _optional_  | Fail the CI job if at least one specified test with a public ID (using `publicIds` or listed in a [test file][C-2] is missing in a run (for example, if it has been deleted programmatically or on the Datadog site). |
| `failOnTimeout`                    | _optional_  | A boolean flag that fails the CI job if at least one test exceeds the default test timeout. The default is set to `true`.                                                                                             |
| `files`                            | _optional_  | Glob patterns to detect Synthetic test [configuration files][B-2].                                                                                                                                                    |
| `jUnitReport`                      | _optional_  | The filename for a JUnit report if you want to generate one.                                                                                                                                                          |
| `locations`                        | _optional_  | String of locations separated by semicolons to override the locations where your tests run.                                                                                                                           |
| `mobileApplicationVersion`         | _optional_  | Override the default mobile application version for a Synthetic mobile application test. The version must be uploaded and available within Datadog.                                                                   |
| `mobileApplicationVersionFilePath` | _optional_  | Override the application version for Synthetic mobile application tests.                                                                                                                                              |
| `pollingTimeout`                   | _optional_  | The duration (in milliseconds) after which the batch is deemed as failed because of a time out. The default is 30 minutes.                                                                                            |
| `publicIds`                        | _optional_  | String of public IDs separated by commas for Synthetic tests you want to trigger.                                                                                                                                     |
| `site`                             | _optional_  | The Datadog site to send data to. If the `DD_SITE` environment variable is set, it takes precedence.                                                                                                                  |
| `subdomain`                        | _optional_  | The name of the custom subdomain set to access your Datadog application. If the URL used to access Datadog is `myorg.datadoghq.com`, the `subdomain` value needs to be set to `myorg`.                                |
| `testSearchQuery`                  | _optional_  | Trigger tests corresponding to a [search][C-5]  query. This can be useful if you are tagging your test configurations. See [best practices][C-7]  for more information on tagging.                                    |
| `tunnel`                           | _optional_  | Enable [tunnel][C-4] to interact with Datadog API.                                                                                                                                                                    |
| `variables`                        | _optional_  | Key-value pairs for injecting variables into tests. Must be formatted using `KEY=VALUE`.                                                                                                                              |

## Further reading

Additional helpful documentation, links, and articles:

- [Continuous Testing and CI/CD Configuration][C-1]
- [Best practices for continuous testing with Datadog][E-1]

<!-- Links to Marketplace -->
[A-1]: https://marketplace.visualstudio.com/items?itemName=Datadog.datadog-ci

<!-- Github links -->
[B-1]: https://github.com/DataDog/datadog-ci/blob/master/.github/workflows/e2e/global.config.json
[B-2]: https://github.com/DataDog/datadog-ci/tree/master/src/commands/synthetics#test-files
[B-3]: https://github.com/bitrise-io/bitrise

<!-- Links to datadog documentation -->
[C-1]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration
[C-2]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#test-files
[C-3]: https://docs.datadoghq.com/continuous_testing/cicd_integrations/configuration/?tab=npm#global-configuration-file-options
[C-4]: https://docs.datadoghq.com/continuous_testing/testing_tunnel
[C-5]: https://docs.datadoghq.com/synthetics/search/#search
[C-6]: https://docs.datadoghq.com/account_management/api-app-keys/
[C-7]: https://docs.datadoghq.com/developers/guide/what-best-practices-are-recommended-for-naming-metrics-and-tags/#rules-and-best-practices-for-naming-tags

<!-- Integration specific links -->
[D-1]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/adding-steps-to-a-workflow.html
[D-2]: https://devcenter.bitrise.io/en/builds/secrets.html#setting-a-secret
[D-3]: https://devcenter.bitrise.io/en/steps-and-workflows/introduction-to-steps/step-inputs.html

<!-- Other -->
[E-1]: https://www.datadoghq.com/blog/best-practices-datadog-continuous-testing/
