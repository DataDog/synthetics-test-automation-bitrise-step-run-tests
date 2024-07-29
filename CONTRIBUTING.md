# Contributing

First of all, thanks for contributing!

This document provides some basic guidelines for contributing to this repository. To propose improvements, feel free to submit a pull request.

## Submitting issues

GitHub issues are welcome, feel free to submit error reports and feature requests.

- Ensure the bug was not already reported by searching on GitHub under [Issues][1].
- If you're unable to find an open issue addressing the problem, [open a new one][2].
- Make sure to add enough details to explain your use case.

If you require further assistance, contact [Datadog Support][3].

## Submitting pull requests

Have you fixed a bug or wrote a new feature and want to share it? Thanks!

To expedite your pull request's review, follow these best practices when submitting your pull request:

- **Write meaningful commit messages**: Messages should be concise and explanatory. The commit message describes the reason for your change, which you can reference later.

- **Keep it small and focused**: Pull requests should contain only one fix or one feature improvement. Bundling several fixes or features in the same PR makes it more difficult to review, and takes longer to release.

- **Write tests for the code you wrote**: Each script should be tested. The tests for a script are located in the [`tests` folder][4], under a file with the same name as the script.
**Note:** Datadog's internal CI is not publicly available, so if your pull request status is failing, make sure that all tests pass locally. The Datadog team can help you address errors flagged by the CI.

### Publishing

The title of the pull request must contain a special semver tag, `[semver:<segment>]`, where `<segment>` is replaced by one of the following values.

| Increment | Description|
| ----------| -----------|
| major     | Issue a 1.0.0 incremented release|
| minor     | Issue a x.1.0 incremented release|
| patch     | Issue a x.x.1 incremented release|
| skip      | Do not issue a release|

Example: `[semver:major]`

* Update the public `CHANGELOG.md` with the release changes.
* Squash and merge. Ensure the semver tag is preserved and entered as a part of the commit message.
* On merge, after manual approval, the orb will automatically be published to the Orb Registry.

## Style guide

The code under this repository follows a format enforced by [Prettier][5], and a style guide enforced by [eslint][6].

## Releasing a new version

The integration has workflows set up to automate the release process, by creating commits, PRs, tags and releases.

The PRs created as part of the release process will need to be merged manually and each will contain instructions inside them for what needs to be done.

Whenever a new version of [datadog-ci][7] is released, a new PR will automatically be created on the current repository. The PR will be named `[dep] Bump datadog-ci to {version}` and will contain the changes to update to the latest version of datadog-ci and the steps you need to follow to continue the release process.

After completing the steps from the **[dep]** PR, a new **[release]** PR will automatically be created. When this happens, go to the PR and follow the instructions there on how to finalize the release process.

You can see examples of past releases [here][8].

## Asking questions

Need help? Contact [Datadog support][3].

[1]: https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests/issues
[2]: https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests/issues/new
[3]: https://docs.datadoghq.com/help/
[4]: https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests/tree/main/tests
[5]: https://prettier.io/
[6]: https://eslint.org/docs/rules/
[7]: https://github.com/DataDog/datadog-ci
[8]: https://github.com/DataDog/synthetics-test-automation-bitrise-step-run-tests/pulls?q=is%3Apr+is%3Aclosed+%28%22%5Bdep%5D+Bump+datadog-ci%22+OR+%22%5Brelease%3Aminor%22%29+