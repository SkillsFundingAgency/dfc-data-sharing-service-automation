import json
import requests
import logging

class API_Utility:
    data = json.load(open("utilities/env-config/settings.json"))
    shared_data = data["global"]
    touchpoint_id = "9999999999"
    api_versions = {
        "collections": "v3",
        "customers": "v4"
        }
    global response
    global api_base_url
    global env_data

    def table_to_json(table):
        json_table = {}
        for row in table:
            json_row = {row["Field"]: row["Value"]}
            json_table.update(json_row)
        return json_table
    
    def send_GET_request(self, env, apim_route, endpoint_ids, api):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[apim_route] + endpoint_ids
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'version': self.api_versions[api], 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }

        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response

    def send_POST_request(self, table, env, apim_route, endpoint_ids, api):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[apim_route] + endpoint_ids
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'version': self.api_versions[api], 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }
        body = API_Utility.table_to_json(table)

        # send the POST request
        response = requests.post(request_uri, headers=request_headers, json=body)
        return response

    def send_GET_request_no_api_key(self, env, apim_route, endpoint_ids, api):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[apim_route] + endpoint_ids
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'version': self.api_versions[api],
        }

        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response

    def send_GET_request_no_touchpoint_id(self, env, apim_route, endpoint_ids, api):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[apim_route] + endpoint_ids
        request_headers = {
            'version': self.api_versions[api], 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }
        
        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response

    def send_GET_request_no_api_version(self, env, apim_route, endpoint_ids):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[apim_route] + endpoint_ids
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }
        
        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response
       