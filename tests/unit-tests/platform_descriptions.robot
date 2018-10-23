*** Settings ***
Suite Setup                   Get Test Cases
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Resource                      ${CURDIR}/../../src/Renode/RobotFrameworkEngine/renode-keywords.robot

*** Variables ***
@{cpus_path}=		      ${CURDIR}/../../platforms/cpus
@{pattern}= 		      *.repl

*** Keywords ***
Get Test Cases
    Setup
    @{platforms}=  List Files In Directory Recursively	@{cpus_path}	@{pattern}
    Set Suite Variable        @{platforms}

Run Test Case
    [Arguments]		      ${repl}
    Execute Command           mach create
    Execute Command           machine LoadPlatformDescription @${repl}

*** Test Cases ***
Should Load Repls
    :FOR  ${test}  IN  @{platforms}
    \	  Run Test Case       ${test}
    \     Reset Emulation
