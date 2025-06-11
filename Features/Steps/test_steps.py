from behave import *
import logging
import json
from types import SimpleNamespace
from Utility.API_Utility import API_Utility
api_util = API_Utility()

#POST request - no api key
@when('User sends POST {api} request with {endpoint_ids} and the following details without api key')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_POST_request_no_api_key(context.table, context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids) , api)

#POST request - no touchpoint id
@when('User sends POST {api} request with {endpoint_ids} and the following details without touchpoint id')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_POST_request_no_touchpoint_id(context.table, context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api)

#POST request - no api version
@when('User sends POST {api} request with {endpoint_ids} and the following details without api version')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_POST_request_no_api_version(context.table, context.config.userdata['ENV'],construct_endpoint(api, endpoint_ids))

#POST request - valid
@when('User sends POST {api} request with {endpoint_ids} and the following details')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_POST_request(context.table, context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api)
    set_object_ids(response.json(), api)

#POST request - name validation
@when('User sends POST {api} request with {endpoint_ids} and the {field} with value {value}')
def step_impl(context, api, endpoint_ids, field, value):
    global response
    request_body = API_Utility.table_to_json(context.table)
    request_body[field] = value
    response = api_util.send_POST_request_given_values(request_body, context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api)
   
#POST request - valid with subcontractor id
@when('User sends POST {api} request with {endpoint_ids} and the following details - with subcontractorid')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_POST_request(context.table, context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api, "99999999")

#PATCH request - valid
@when('User sends PATCH {api} request with {endpoint_ids} and the following details')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_PATCH_request(context.table, context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api)

#GET request - no api key
@when('User sends GET {api} request with {endpoint_ids} and without api key')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_GET_request_no_api_key(context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids) , api)

#GET request - no touchpoint id
@when('User sends GET {api} request with {endpoint_ids} and without touchpoint id')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_GET_request_no_touchpoint_id(context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api)

#GET request - no api version
@when('User sends GET {api} request with {endpoint_ids} and without api version')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_GET_request_no_api_version(context.config.userdata['ENV'],construct_endpoint(api, endpoint_ids))

#GET request - valid
@when('User sends GET {api} request with {endpoint_ids}')
def step_impl(context, api, endpoint_ids):
    global response
    response = api_util.send_GET_request(context.config.userdata['ENV'], construct_endpoint(api, endpoint_ids), api)

#Status Code Check
@then('User verifies the status code is "{status_code}"')
def step_impl(context, status_code):
    actual_status_code = response.status_code
    assert actual_status_code == int(status_code)

#Response Content Checks
@then('Response should contain error')
def step_impl(context):
    response_string = json.dumps(response.json())
    for row in context.table:
        assert row["ErrorMessage"] in response_string

@then('Response should contain')
def step_impl(context):
    #logging.warning(response.json())
    response_json = response.json()
    for row in context.table:
        if str(response_json[row["Field"]]).lower() != row["Value"].lower():
            logging.warning(row["Field"])
            logging.warning(str(response_json[row["Field"]]).lower())
            logging.warning(row["Value"].lower())
        assert str(response_json[row["Field"]]).lower() == row["Value"].lower()

@then('Response should contain {field} with value {value}')
def step_impl(context, field, value):
    #logging.warning(response.json())
    response_json = response.json()
    assert str(response_json[field]).lower() == value.lower()

#helper functions
def construct_endpoint(api, endpoint_ids):
    endpoint_ids_list = endpoint_ids.split(",")
    endpoint = ""
    for x in endpoint_ids_list:
        if x == "customerid":
            endpoint += "customers/" + created_customer_id + "/";
        elif x == "interactionid":
            endpoint += "interactions/" + created_interaction_id + "/"
        elif x == "actionPlanId":
            endpoint += "actionplans/" + created_action_plan_id + "/"
    if api not in endpoint:
        endpoint += api
    return api + "/api/" + endpoint;

def set_object_ids(json, api):
    global created_customer_id
    global created_action_plan_id
    global created_interaction_id
    if response.status_code == 201:
        if api == "customers":
            created_customer_id = json["CustomerId"];
        elif api == "customers":
            created_action_plan_id = json["ActionPlanId"];
        elif api == "interactions":
            created_interaction_id = json["InteractionId"];