# Runs prior to every test
setup() {
    # Load our script file.
    export IS_TEST_ENV=true
    source ./run-tests.sh
    unset IS_TEST_ENV
}

DIFF_ARGS="-u --label actual --label expected"

@test 'Use custom parameters' {
    export api_key="DD_API_KEY"
    export app_key="DD_APP_KEY"
    export batch_timeout="123"
    export config_path="./some/other/path.json"
    export datadog_site="datadoghq.eu"
    export device_ids=$'device1\ndevice2'
    export fail_on_critical_errors=true
    export fail_on_missing_tests=true
    export fail_on_timeout=false
    export files="test1.json"
    export junit_report="reports/TEST-1.xml"
    export locations="aws:eu-west-1"
    export mobile_application_version="1.4.2"
    export mobile_application_version_file_path="example/test.apk"
    export public_ids="jak-not-now,jak-one-mor"
    export selective_rerun="true"
    export subdomain="app1"
    export test_search_query="apm"
    export tunnel=true
    export variables='START_URL=https://example.org,MY_VARIABLE="My title"'
    export DATADOG_CI_COMMAND="echo"

    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --batchTimeout 123 --failOnCriticalErrors --failOnMissingTests --no-failOnTimeout --tunnel --config ./some/other/path.json --files test1.json --jUnitReport reports/TEST-1.xml --override locations="aws:eu-west-1" --public-id jak-not-now --public-id jak-one-mor --selectiveRerun --search apm --variable START_URL=https://example.org --variable MY_VARIABLE=\"My title\" --mobileApplicationVersion 1.4.2 --mobileApplicationVersionFilePath example/test.apk --device-id device1 --device-id device2)
}

@test 'Use default parameters' {
    export api_key="DD_API_KEY"
    export app_key="DD_APP_KEY"
    export batch_timeout=""
    export config_path=""
    export datadog_site=""
    export device_ids=""
    export fail_on_critical_errors=false
    export fail_on_missing_tests=false
    export fail_on_timeout=true
    export files=""
    export junit_report=""
    export locations=""
    export mobile_application_version=""
    export mobile_application_version_file_path=""
    export public_ids=""
    export selective_rerun=""
    export subdomain=""
    export test_search_query=""
    export tunnel=false
    export DATADOG_CI_COMMAND="echo"

    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --failOnTimeout)
}

@test 'Support spaces and commas in filenames' {
    export DATADOG_CI_COMMAND="echo"

    export files="ci/file with space.json"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "ci/file with space.json")

    export files="{,!(node_modules)/**/}*.synthetics.json"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "{,!(node_modules)/**/}*.synthetics.json")

    export files="hello, i'm a file.txt"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "hello, i'm a file.txt")

    export files=$'file 1.json\nfile 2.json'
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --files "file 1.json" --files "file 2.json")
}

@test 'Selective rerun is an optional boolean' {
    export selective_rerun=""
    export DATADOG_CI_COMMAND="echo"

    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout)

    export selective_rerun="false"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --no-selectiveRerun)

    export selective_rerun="true"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --selectiveRerun)
}

@test 'Support spaces and commas in locations' {
    export DATADOG_CI_COMMAND="echo"

    export locations="aws:eu-west-1,aws:eu-west-2"
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --override locations="aws:eu-west-1;aws:eu-west-2")

    export locations=$'aws:eu-west-1\naws:eu-west-2'
    diff $DIFF_ARGS <(RunTests) <(echo synthetics run-tests --no-failOnTimeout --override locations="aws:eu-west-1;aws:eu-west-2")
}
