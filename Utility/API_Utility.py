import json
import requests


class API_Utility:
    data = json.load(open("utilities/env-config/settings.json"))
    shared_data = data["global"]
    touchpoint_id = "9999999999"
    dss_col_version = "v3"
    global response
    global api_base_url
    global env_data
    

    def send_GET_request(self, table, env, endpoint):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[endpoint]
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'version': self.dss_col_version, 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }
        
        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response

    def send_GET_request_no_api_key(self, table, env, endpoint):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[endpoint]
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'version': self.dss_col_version,
        }
        
        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response

    def send_GET_request_no_touchpoint_id(self, table, env, endpoint):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[endpoint]
        request_headers = {
            'version': self.dss_col_version, 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }
        
        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response

    def send_GET_request_no_api_version(self, table, env, endpoint):
        env_data = self.data[env]
        api_base_url = env_data["APIM_URL"]
        request_uri = api_base_url + self.shared_data[endpoint]
        request_headers = {
            'TouchpointId': self.touchpoint_id, 
            'Ocp-Apim-Subscription-Key': env_data["APIM_ACCESS_KEY"]
        }
        
        # send the GET request
        response = requests.get(request_uri, headers=request_headers)
        return response
       