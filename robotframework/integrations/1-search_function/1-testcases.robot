*** Settings ***
Resource    ../robotframework/supports/common_resources.robot 
Suite Setup    Open Officemate Site
Suite Teardown    Close All Browsers

*** Test Cases ***
UI: Search function with Search Query
    [Tags]    UI
    Press Keys    //input[@data-testid='txt-SearchBar']    ปากกา    RETURN
    Wait Until Page Does Not Contain    กรุณารอสักครู่
    Wait Until Element Contains    //div[@class='knEvI']    ค้นพบสินค้า
    ${total}=    Calling Search API    ${3481}    ปากกา
    ${expected}=    Number To String    ${total}
    Element Should Contain    //div[@class='knEvI']    ${expected}

UI: Search function with Search Query and Category
    [Tags]    UI
    Scroll Element Into View    //div[@filter-option='Category_ปากกาลูกลื่น']
    Click Element    //div[@filter-option='Category_ปากกาลูกลื่น']
    Wait Until Page Does Not Contain    กรุณารอสักครู่
    Wait Until Element Contains    //div[@class='knEvI']    ค้นพบสินค้า
    ${total}=    Calling Search API    ${576}    ปากกา    109
    ${expected}=    Number To String    ${total}
    Element Should Contain    //div[@class='knEvI']    ${expected}

UI: Search function with Search Query, Category, and Brand Name
    [Tags]    UI
    Scroll Element Into View    //div[@filter-option='Brand_ควอนตั้ม']
    Click Element    //div[@filter-option='Brand_ควอนตั้ม']
    Wait Until Page Does Not Contain    กรุณารอสักครู่
    Wait Until Element Contains    //div[@class='knEvI']    ค้นพบสินค้า
    ${total}=    Calling Search API    ${100}    ปากกา    109    ควอนตั้ม
    ${expected}=    Number To String    ${total}
    Element Should Contain    //div[@class='knEvI']    ${expected}

UI: Search function with Search Query, Catagory, Brand Name, and Price Range
    [Tags]    UI
    Scroll Element Into View    //div[@role='slider'][2]
    Drag And Drop By Offset    //div[@role='slider'][2]    ${-354}    ${0}
    Scroll Element Into View    //div[@id='btn-Filter-PriceRange']
    Click Element    //div[@id='btn-Filter-PriceRange']
    Wait Until Page Does Not Contain    กรุณารอสักครู่
    Wait Until Element Contains    //div[@class='knEvI']    ค้นพบสินค้า
    ${total}=    Calling Search API    ${49}    ปากกา    109    ควอนตั้ม    4-50
    ${expected}=    Number To String    ${total}
    Element Should Contain    //div[@class='knEvI']    ${expected}

API: Search function with Search Query
    [Tags]    API
    Calling Search API    ${3481}    ปากกา

API: Search function with Search Query and Category
    [Tags]    API
    Calling Search API    ${576}    ปากกา    109

API: Search function with Search Query, Category, and Brand Name
    [Tags]    API
    Calling Search API    ${100}    ปากกา    109    ควอนตั้ม

API: Search function with Search Query, Category, Brand Name, and Price Range
    [Tags]    API
    Calling Search API    ${49}    ปากกา    109    ควอนตั้ม    4-50

*** Keywords ***
Calling Search API
    [Arguments]    ${expected_total}    ${search_query}    ${category_id}=${None}    ${brand_name}=${None}    ${price_range}=${None}
    ${headers}    Create Dictionary    Content-Type    application/json    x-store-code    th
    ${parameters}=    Create Parameters    ${search_query}    ${category_id}    ${brand_name}    ${price_range}
    ${response}=    GET    ${endpoint_api_url}/search/products    headers=${headers}    params=${parameters}    expected_status=200
    Should Be Equal    ${expected_total}    ${response.json()['products']['total_count']}
    [Return]    ${response.json()['products']['total_count']}