#!/usr/bin/env bats

# load custom assertions and functions
load bats_helper


# setup is run beofre each test
function setup {
  INPUT_PROJECT_CONFIG=${BATS_TMPDIR}/input_config-${BATS_TEST_NUMBER}
  PROCESSED_PROJECT_CONFIG=${BATS_TMPDIR}/packed_config-${BATS_TEST_NUMBER} 
  JSON_PROJECT_CONFIG=${BATS_TMPDIR}/json_config-${BATS_TEST_NUMBER} 
	echo "#using temp file ${BATS_TMPDIR}/"

  # the name used in example config files.
  INLINE_ORB_NAME="cloudfoundry"
}


@test "Job: individual jobs expands properly" {
  # given
  process_config_with test/inputs/jobs-separate.yml

  # when
  assert_jq_match '.jobs | length' 2
  assert_jq_match '.jobs["cloudfoundry/dark_deploy"].steps | length' 4
  assert_jq_match '.jobs["cloudfoundry/dark_deploy"].steps[0]' "checkout"
  assert_jq_match '.jobs["cloudfoundry/dark_deploy"].steps[1].attach_workspace.at' '/tmp'
  assert_jq_match '.jobs["cloudfoundry/dark_deploy"].steps[2].run.name' 'Setup CF CLI'
  assert_jq_match '.jobs["cloudfoundry/dark_deploy"].steps[3].run.name' 'Cloud Foundry Dark Deployment'



  assert_jq_match '.jobs["cloudfoundry/live_deploy"].steps | length' 2
  assert_jq_match '.jobs["cloudfoundry/live_deploy"].steps[0].run.name' "Setup CF CLI"
  assert_jq_match '.jobs["cloudfoundry/live_deploy"].steps[1].run.name' 'Cloud Foundry - Re-route live Domain'

}

@test "Job: merged expands properly" {
  # given
  process_config_with test/inputs/jobs-merged.yml

  # when
  assert_jq_match '.jobs | length' 1
  assert_jq_match '.jobs["cloudfoundry/blue_green"].steps | length' 5
  assert_jq_match '.jobs["cloudfoundry/blue_green"].steps[0]' "checkout"
  assert_jq_match '.jobs["cloudfoundry/blue_green"].steps[1].attach_workspace.at' '/tmp'
  assert_jq_match '.jobs["cloudfoundry/blue_green"].steps[2].run.name' 'Setup CF CLI'
  assert_jq_match '.jobs["cloudfoundry/blue_green"].steps[3].run.name' 'Cloud Foundry Dark Deployment'
  assert_jq_match '.jobs["cloudfoundry/blue_green"].steps[4].run.name' 'Cloud Foundry - Re-route live Domain'

}


@test "Job: push job expands properly" {
  # given
  process_config_with test/inputs/job-push.yml

  # when
  assert_jq_match '.jobs | length' 1
  assert_jq_match '.jobs["cloudfoundry/push"].steps | length' 4
  assert_jq_match '.jobs["cloudfoundry/push"].steps[0]' "checkout"
  assert_jq_match '.jobs["cloudfoundry/push"].steps[1].attach_workspace.at' '/tmp'
  assert_jq_match '.jobs["cloudfoundry/push"].steps[2].run.name' 'Setup CF CLI'
  assert_jq_match '.jobs["cloudfoundry/push"].steps[3].run.name' 'Cloud Foundry Push'

}









