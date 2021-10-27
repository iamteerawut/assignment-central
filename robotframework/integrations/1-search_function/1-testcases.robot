*** Settings ***
Resource    ../robotframework/supports/common_resources.robot 
Suite Setup    Open Officemate Site
Suite Teardown    Close All Browsers

*** Variables ***
${item_type}    ปากกา
${category_id}    109
${brand_name}    ควอนตั้ม
${price_range}    4-153

*** Test Cases ***
UI: Search function with Search Query
    [Tags]    UI
    Press Keys    //input[@data-testid='txt-SearchBar']    ${item_type}    RETURN
    Verify Total Amount Product    ${3514}    ${item_type}

UI: Search function with Search Query and Category
    [Tags]    UI
    Scroll Element Into View    //div[@filter-option='Category_ปากกาลูกลื่น']
    Click Element    //div[@filter-option='Category_ปากกาลูกลื่น']
    Verify Total Amount Product    ${600}    ${item_type}    ${category_id}

UI: Search function with Search Query, Category, and Brand Name
    [Tags]    UI
    Scroll Element Into View    //div[@filter-option='Brand_ควอนตั้ม']
    Click Element    //div[@filter-option='Brand_ควอนตั้ม']
    Verify Total Amount Product    ${117}    ${item_type}    ${category_id}    ${brand_name}

UI: Search function with Search Query, Catagory, Brand Name, and Price Range
    [Tags]    UI
    Scroll Element Into View    //div[@role='slider'][2]
    Drag And Drop By Offset    //div[@role='slider'][2]    ${-354}    ${0}
    Scroll Element Into View    //div[@id='btn-Filter-PriceRange']
    Click Element    //div[@id='btn-Filter-PriceRange']
    Verify Total Amount Product    ${81}    ${item_type}    ${category_id}    ${brand_name}    ${price_range}

API: Search function with Search Query
    [Tags]    API
    Calling Search API    ${3514}    ปากกา

API: Search function with Search Query and Category
    [Tags]    API
    Calling Search API    ${600}    ปากกา    109

API: Search function with Search Query, Category, and Brand Name
    [Tags]    API
    Calling Search API    ${117}    ปากกา    109    ควอนตั้ม

API: Search function with Search Query, Category, Brand Name, and Price Range
    [Tags]    API
    Calling Search API    ${81}    ปากกา    109    ควอนตั้ม    4-153

*** Keywords ***
Verify Total Amount Product
    [Arguments]    ${expected_total}    ${search_query}    ${category_id}=${None}    ${brand_name}=${None}    ${price_range}=${None}
    Wait Until Page Does Not Contain    กรุณารอสักครู่
    Wait Until Element Contains    //div[@class='knEvI']    ค้นพบสินค้า
    ${total}=    Calling Search API    ${expected_total}    ${search_query}    ${category_id}    ${brand_name}    ${price_range}
    ${expected}=    Number To String    ${total}
    Element Should Contain    //div[@class='knEvI']    ${expected}

Calling Search API
    [Arguments]    ${expected_total}    ${search_query}    ${category_id}=${None}    ${brand_name}=${None}    ${price_range}=${None}
    ${headers}    Create Dictionary    Content-Type    application/json    x-store-code    th
    ${parameters}=    Create Parameters    ${search_query}    ${category_id}    ${brand_name}    ${price_range}
    ${response}=    GET    ${endpoint_api_url}/search/products    headers=${headers}    params=${parameters}    expected_status=200
    Should Be Equal    ${expected_total}    ${response.json()['products']['total_count']}
    [Return]    ${response.json()['products']['total_count']}