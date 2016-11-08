#   (c) Copyright 2016 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Create a container for the specified account
#!
#! @input storage_account: Azure storage account name
#! @input key: Azure account key
#! @input container_name: the name you want to give to the new container
#! @input proxy_host: optional - proxy server used to access the web site
#! @input proxy_port: optional - proxy server port - Default: '8080'
#! @input proxy_username: optional - username used when connecting to the proxy
#! @input proxy_password: optional - proxy server password associated with the <proxy_username> input value
#!
#! @output output: the container name that was created
#! @output return_code: 0 if request completed successfully, -1 in case something went wrong
#! @output exception: the stacktrace of the operation in case something went wrong
#!
#! @result SUCCESS: Container created successfully.
#! @result FAILURE: There was an error while trying to create the container.
#!!#
########################################################################################################################

namespace: io.cloudslang.microsoft.azure.compute.storage.containers

operation:
  name: create_container
  inputs:
    - storage_account
    - storageAccount:
        default: ${get("storage_account", ""}
        required: false
        private: true
    - key:
        sensitive: true
    - container_name
    - containerName:
        default: ${get("container_name", ""}
        required: false
        private: true
    - proxy_host:
        required: false
    - proxyHost:
        default: ${get("proxy_host", "")}
        required: false
        private: true
    - proxy_port:
        required: false
    - proxyPort:
        default: ${get("proxy_port", "8080")}
        required: false
        private: true
    - proxy_username:
        required: false
    - proxyUsername:
        default: ${get("proxy_username", "")}
        required: false
        private: true
    - proxy_password:
        required: false
        sensitive: true
    - proxyPassword:
        default: ${get("proxy_password", "")}
        required: false
        private: true
        sensitive: true

  java_action:
    gav: 'io.cloudslang.content:cs-azure:0.0.4'
    class_name: io.cloudslang.content.azure.actions.storage.CreateContainer
    method_name: execute

  outputs:
    - output: ${returnResult}
    - return_code: ${returnCode}
    - exception

  results:
    - SUCCESS: ${returnCode == '0'}
    - FAILURE