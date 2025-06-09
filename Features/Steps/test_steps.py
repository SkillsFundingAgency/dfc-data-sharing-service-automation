from behave import *
import logging
import json
from types import SimpleNamespace
from Utility.API_Utility import API_Utility
api_util = API_Utility()

#POST request - valid
@when('User sends POST {api} request to endpoint "{apim_route}" with {endpoint_ids} and the following details')
def step_impl(context, api, apim_route, endpoint_ids):
    global response
    endpoint_append = contruct_endpoint(endpoint_ids)
    response = api_util.send_POST_request(context.table, context.config.userdata['ENV'], apim_route, endpoint_append, api)
    set_object_ids(response.json(), api)

#GET request - no api key
@when('User sends GET {api} request to endpoint "{apim_route}" with {endpoint_ids} and without api key')
def step_impl(context, api, apim_route, endpoint_ids):
    global response
    endpoint_append = contruct_endpoint(endpoint_ids)
    response = api_util.send_GET_request_no_api_key(context.config.userdata['ENV'], apim_route, endpoint_append, api)

#GET request - no touchpoint id
@when('User sends GET {api} request to endpoint "{apim_route}" with {endpoint_ids} and without touchpoint id')
def step_impl(context, api, apim_route, endpoint_ids):
    global response
    endpoint_append = contruct_endpoint(endpoint_ids)
    response = api_util.send_GET_request_no_touchpoint_id(context.config.userdata['ENV'], apim_route, endpoint_append, api)

#GET request - no api version
@when('User sends GET {api} request to endpoint "{apim_route}" with {endpoint_ids} and without api version')
def step_impl(context, api, apim_route, endpoint_ids):
    global response
    endpoint_append = contruct_endpoint(endpoint_ids)
    response = api_util.send_GET_request_no_api_version(context.config.userdata['ENV'],apim_route, endpoint_append)

#GET request - valid
@when('User sends GET {api} request to endpoint "{apim_route}" with {endpoint_ids}')
def step_impl(context, api, apim_route, endpoint_ids):
    global response
    endpoint_append = contruct_endpoint(endpoint_ids)
    response = api_util.send_GET_request(context.config.userdata['ENV'], apim_route, endpoint_append, api)

#Status Code Check
@then('User verifies the status code is "{status_code}"')
def step_impl(context, status_code):
    actual_status_code = response.status_code
    assert actual_status_code == int(status_code)

#Response Content Check
@then('Response should contain')
def step_impl(context):
    response_json = response.json()
    for row in context.table:
        assert str(response_json[row["Field"]]).lower() == row["Value"].lower()

#helper functions
def contruct_endpoint(endpoint_ids):
    endpoint_ids_list = endpoint_ids.split(",")
    endpoint = ""
    for x in endpoint_ids_list:
        if x == "no ids":
            return endpoint
        elif x == "customerid":
            endpoint += created_customer_id;
        elif x == "interactionid":
            endpoint += "Interactions/" + created_interaction_id + "/"
        elif x == "actionPlanId":
            endpoint += f"ActionPlans/{created_action_plan_id}"
    return endpoint;

def set_object_ids(json, api):
    global created_customer_id
    global created_action_plan_id
    global created_interaction_id
    if api == "customers":
        created_customer_id = json["CustomerId"];
    elif api == "customers":
        created_action_plan_id = json["ActionPlanId"];
    elif api == "interactions":
        created_interaction_id = json["InteractionId"];