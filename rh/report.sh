# general variables
MY_SRL_FILE=dtests_phase_3.srl
MY_PROJECT=ENTMQCL

# Test Case related variables
MY_TESTCASES_XUINT_NAME='polarion.tc.xml'

# Test Run related variables
MY_PLAN='2_2_0'
SUT_BUILD_ID='CLIENTS-220_GA'
MY_TESTRUN_NAME='LP-AMQ-clients-220-AMQ-722-acceptance-ruby-openjdk-180-RHEL-80-201811070-x86_64'
MY_TESTRUN_XUNIT_NAME='polarion'
MY_KERBEROS_NICK='rkubis'

# generate test run data in xunit format
python ~/codes/dtests/dtests/dtools.py -a srl-to-junit \
  -o srl-to-junit/sut-build-id=${SUT_BUILD_ID} \
  -o srl-to-junit/planned-in=${MY_PLAN} \
  -o srl-to-junit/executed-by=${MY_KERBEROS_NICK} \
  -o srl-to-junit/input=${MY_SRL_FILE} \
  -o srl-to-junit/polarion-project-id=${MY_PROJECT} \
  -o srl-to-junit/polarion-test-run-name=${MY_TESTRUN_NAME} \
  -o srl-to-junit/output=${MY_TESTRUN_XUNIT_NAME} \
  -o srl-to-junit/test-suite-name-pattern=dtests -o srl-to-junit/test-case-name-pattern=TC \
  -o srl-to-junit/test-case-classname-pattern=DS.TCG \
  -o srl-to-junit/report-test-case-ignore-empty-ena=True \
  -o 'srl-to-junit/report-test-case-classname-ignore-re=^DS.*\.$' \
  -o 'srl-to-junit/report-test-case-name-ignore-re=test_nodes_.+_cleanup|test_nodes_service_ctrl' \
  -o srl-to-junit/output-format=xunit-importer

# import Test Run
curl -k -u 'amq_machine:**Builder098' -X POST -F file=@${MY_TESTRUN_XUNIT_NAME}.xunit.xml https://polarion.engineering.redhat.com/polarion/import/xunit
