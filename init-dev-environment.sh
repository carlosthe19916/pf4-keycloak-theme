#!/usr/bin/env bash
#
# Copyright 2019 Project OpenUBL, Inc. and/or its affiliates
# and other contributors as indicated by the @author tags.
#
# Licensed under the Eclipse Public License - v 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.eclipse.org/legal/epl-2.0/
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

wget https://github.com/keycloak/keycloak/releases/download/12.0.1/keycloak-12.0.1.tar.gz -P workload/
tar xvzf workload/keycloak-*.tar.gz -C workload/

xmlstarlet ed \
-L \
-N s=urn:jboss:domain:14.0 \
-N su=urn:jboss:domain:keycloak-server:1.1 \
-u '/s:server/s:profile/su:subsystem/su:theme/su:staticMaxAge' -v "-1" \
-u '/s:server/s:profile/su:subsystem/su:theme/su:cacheThemes' -v "false" \
-u '/s:server/s:profile/su:subsystem/su:theme/su:cacheTemplates' -v "false" \
-u '/s:server/s:profile/su:subsystem/su:theme/su:dir' -v "$(pwd)/src/main/resources/themes" \
workload/keycloak-*/standalone/configuration/standalone.xml

cp -r workload/keycloak-*/themes/* src/main/resources/themes/
