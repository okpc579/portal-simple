#!/bin/bash
  
#VARIABLE
DOMAIN=<DOMAIN>                           # PaaS-TA System Domain
PAASTA_USER_ADMIN_USERNAME=<PAASTA_USER_ADMIN_USERNAME>                      # PaaS-TA Admin Username
PAASTA_USER_ADMIN_PASSWORD=<PAASTA_USER_ADMIN_PASSWORD>                      # PaaS-TA Admin Password
PORTAL_QUOTA_NAME=<PORTAL_QUOTA_NAME>                        # PaaS-TA Portal Quota Name
PORTAL_ORG_NAME=<PORTAL_ORG_NAME>                                        # PaaS-TA Portal Org Name
PORTAL_SPACE_NAME=<PORTAL_SPACE_NAME>                                      # PaaS-TA Portal Space Name
PORTAL_SECURITY_GROUP_NAME=<PORTAL_SECURITY_GROUP_NAME>                                     # PaaS-TA Portal Space Name


# PaaS-TA LOGIN
cf login -a https://api.${DOMAIN} --skip-ssl-validation -u ${PAASTA_USER_ADMIN_USERNAME} -p ${PAASTA_USER_ADMIN_PASSWORD} << EOF


EOF

# Create Portal Org, Space
cf create-quota ${PORTAL_QUOTA_NAME} -m 20G -i -1 -s -1 -r -1 --reserved-route-ports -1 --allow-paid-service-plans
cf create-org ${PORTAL_ORG_NAME} -q ${PORTAL_QUOTA_NAME}
cf create-space ${PORTAL_SPACE_NAME} -o ${PORTAL_ORG_NAME}

cf target -o ${PORTAL_ORG_NAME} -s ${PORTAL_SPACE_NAME}


# Create Portal Security Group
cf create-security-group ${PORTAL_SECURITY_GROUP_NAME} portal-rule.json
cf bind-running-security-group ${PORTAL_SECURITY_GROUP_NAME}
cf bind-staging-security-group ${PORTAL_SECURITY_GROUP_NAME}

# Portal Container Push
cd portal-api-2.4.0/
cf push
cd ..

cd portal-common-api-2.2.0/
cf push
cd ..

cd portal-gateway-2.1.0/
cf push
cd ..

cd portal-log-api-2.2.0/
cf push
cd ..

cd portal-registration-2.1.0/
cf push
cd ..

cd portal-storage-api-2.2.0/
cf push
cd ..

cd portal-web-admin-2.3.0/
cf push
cd ..

cd portal-web-user-2.3.1/
cf push
cd ..

cd portal-ssh-1.0.0/
cf push
cd ..

# tcp port open : portal-log-api
# find APP_GUID
APP_GUID=$(cf app portal-log-api --guid)
echo "$APP_GUID"

# create tcp domain
cf create-shared-domain tail-log.$DOMAIN --router-group default-tcp

# listen port 5555
cf curl /v2/apps/$APP_GUID -X PUT -d '{"ports": [8080, 5555]}'

# map-route tcp 1024
cf map-route portal-log-api tail-log.$DOMAIN --port 1024

# find port 1122 ROUTE_GUID
ROUTE_GUID=$(cf curl /v2/routes?q=port:1024 | grep \"guid\" | awk -F \" '{ print $4 }')
echo "$ROUTE_GUID"

# find route_mapping default port 8080
DEFAULT_ROUTE_GUID=$(cf curl /v2/routes/$ROUTE_GUID/route_mappings | grep \"guid\" | awk -F \" '{ print $4 }')
echo "$DEFAULT_ROUTE_GUID"

# delete route_mapping default port 8080
cf curl /v2/route_mappings/$DEFAULT_ROUTE_GUID -X DELETE -d ''

# add route_mapping app_port 5555
cf curl /v2/route_mappings -X POST -d '{"app_guid": "'"$APP_GUID"'", "route_guid": "'"$ROUTE_GUID"'", "app_port": 5555}'

cf restart portal-log-api

cf apps
