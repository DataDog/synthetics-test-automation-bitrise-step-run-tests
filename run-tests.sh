RunTests() {
    if [[ -n "${DD_SITE}" ]]; then
        site=${DD_SITE}
    fi

    DATADOG_CI_VERSION="3.2.0"

    unamestr=$(uname)

    # Not run when running unit tests.
    if [[ -z "${DATADOG_CI_COMMAND}" ]]; then
        if [[ "$unamestr" == 'Darwin' ]]; then
            curl -L --fail "https://github.com/DataDog/datadog-ci/releases/download/v${DATADOG_CI_VERSION}/datadog-ci_darwin-x64" --output "./datadog-ci"
        elif [[ "$unamestr" == 'Linux' ]]; then
            curl -L --fail "https://github.com/DataDog/datadog-ci/releases/download/v${DATADOG_CI_VERSION}/datadog-ci_linux-x64" --output "./datadog-ci"
        fi
        chmod +x ./datadog-ci

        DATADOG_CI_COMMAND="./datadog-ci"
    fi

    args=()
    if [[ -n $batch_timeout ]]; then
        args+=(--batchTimeout "${batch_timeout}")
    fi
    if [[ $fail_on_critical_errors == "true" ]]; then
        args+=(--failOnCriticalErrors)
    fi
    if [[ $fail_on_missing_tests == "true" ]]; then
        args+=(--failOnMissingTests)
    fi
    if [[ $fail_on_timeout == "true" ]]; then
        args+=(--failOnTimeout)
    else
        args+=(--no-failOnTimeout)
    fi
    if [[ $tunnel == "true" ]]; then
        args+=(--tunnel)
    fi
    if [[ -n $config_path ]]; then
        args+=(--config "${config_path}")
    fi
    if [[ -n $files ]]; then
        IFS=$'\n'
        for file in ${files}; do
            args+=(--files "${file}")
        done
        unset IFS
    fi
    if [[ -n $junit_report ]]; then
        args+=(--jUnitReport "${junit_report}")
    fi
    if [[ -n $public_ids ]]; then
        IFS=$'\n,'
        for public_id in ${public_ids}; do
            args+=(--public-id "${public_id}")
        done
        unset IFS
    fi
    if [[ -n $test_search_query ]]; then
        args+=(--search "${test_search_query}")
    fi
    if [[ -n $variables ]]; then
        IFS=$'\n,'
        for variable in ${variables}; do
            args+=(--variable "${variable}")
        done
        unset IFS
    fi
    if [[ -n $mobile_application_version ]]; then
        args+=(--mobileApplicationVersion "${mobile_application_version}")
    fi
    if [[ -n $mobile_application_version_file_path ]]; then
        args+=(--mobileApplicationVersionFilePath "${mobile_application_version_file_path}")
    fi
    if [[ -n $device_ids ]]; then
        IFS=$'\n,'
        for device_id in ${device_ids}; do
            args+=(--device-id "${device_id}")
        done
        unset IFS
    fi

    if [[ -n $locations ]]; then
        export DATADOG_SYNTHETICS_LOCATIONS="${locations}"
    fi

    DATADOG_API_KEY="${api_key}" \
        DATADOG_APP_KEY="${app_key}" \
        DATADOG_SUBDOMAIN="${subdomain}" \
        DATADOG_SITE="${site}" \
        DATADOG_SYNTHETICS_CI_TRIGGER_APP="bitrise_step" \
        $DATADOG_CI_COMMAND synthetics run-tests \
        "${args[@]}"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [ "$IS_TEST_ENV" != "true" ]; then
    RunTests
fi
