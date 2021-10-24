def create_parameters(search_query, category_id=None, brand_name=None, price_range=None):
    if category_id == None and brand_name == None and price_range == None:
        parameters = 'searchQuery=' + search_query + '&visibility=4'
        return parameters
    if category_id != None and brand_name == None and price_range == None:
        parameters = 'searchQuery=' + search_query + '&category_id=' + category_id + '&visibility=4'
        return parameters
    if category_id != None and brand_name != None and price_range == None:
        parameters = 'searchQuery=' + search_query + '&category_id=' + category_id + '&brand_name=' + brand_name + '&visibility=4'
        return parameters
    if category_id != None and brand_name != None and price_range != None:
        price_range = price_range.split('-')
        parameters = 'searchQuery=' + search_query + '&category_id=' + category_id + '&brand_name=' + brand_name + '&priceFrom=' + price_range[0] + '&priceTo=' + price_range[1] + '&visibility=4'
        return parameters

def number_to_string(number: int):
    return "{:,}".format(number)