from behave import *
import logging

from Utility.API_Utility import API_Utility
api_util = API_Utility()

@when('User sends GET request to endpoint "{endpoint}"')
def step_impl(context, endpoint):
    global response
    response = api_util.send_GET_request(context.table, context.config.userdata['ENV'], endpoint)

@when('User sends GET request to endpoint "{endpoint}" without api key')
def step_impl(context, endpoint):
    global response
    response = api_util.send_GET_request_no_api_key(context.table, context.config.userdata['ENV'], endpoint)

@when('User sends GET request to endpoint "{endpoint}" without touchpoint id')
def step_impl(context, endpoint):
    global response
    response = api_util.send_GET_request_no_touchpoint_id(context.table, context.config.userdata['ENV'], endpoint)

@when('User sends GET request to endpoint "{endpoint}" without api version')
def step_impl(context, endpoint):
    global response
    response = api_util.send_GET_request_no_api_version(context.table, context.config.userdata['ENV'], endpoint)

@then('User verifies the status code is "{status_code}"')
def step_impl(context, status_code):
    actual_status_code = response.status_code
    assert actual_status_code == int(status_code)

