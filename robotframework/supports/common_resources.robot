*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    ../robotframework/supports/CustomLibrary/custom.py

*** Variables ***
${endpoint_url}    https://www.officemate.co.th
${endpoint_api_url}    ${endpoint_url}/api
${browser}    Chrome

*** Keywords ***
Open Officemate Site
    Open Browser    ${endpoint_url}    ${browser}
    Set Selenium Speed    0.2s
    Set Selenium Implicit Wait    0.3s
    Maximize Browser Window
    Wait Until Page Contains Element    //iframe[contains(@class,'sp-fancybox-iframe-535')]
    Select Frame    //iframe[contains(@class,'sp-fancybox-iframe-535')]
    Click Element    //i[@class="fa fa-times element-close-button"]
    Unselect Frame
    Click Button    //button[contains(text(), 'ยอมรับ')]