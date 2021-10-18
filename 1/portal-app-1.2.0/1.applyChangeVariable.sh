#!/bin/bash

# COMMON VARIABLE
DOMAIN=<DOMAIN>                          # PaaS-TA System Domain
CF_USER_ADMIN_USERNAME=<CF_USER_ADMIN_USERNAME>                          # PaaS-TA Admin Username
CF_USER_ADMIN_PASSWORD=<CF_USER_ADMIN_PASSWORD>                          # PaaS-TA Admin Password
UAA_CLIENT_ID=<UAA_ADMIN_CLIENT_ID>                                           # UAA Client ID
UAA_CLIENT_SECRET=<UAA_ADMIN_CLIENT_SECRET>                        # UAA Cliant Secret
UAA_ADMIN_CLIENT_ID=<UAA_ADMIN_CLIENT_ID>                                     # UAA Admin Client ID
UAA_ADMIN_CLIENT_SECRET=<UAA_ADMIN_CLIENT_SECRET>          # UAA Admin Client Secret
UAA_LOGIN_CLIENT_ID=<UAA_ADMIN_CLIENT_ID>                                     # UAA Login Client ID
UAA_LOGIN_CLIENT_SECRET=<UAA_ADMIN_CLIENT_SECRET>          # UAA Login Client Secret
PORTAL_DB_IP=<PORTAL_DB_IP>                                      # portal-container-infra IP
PORTAL_DB_PORT=<PORTAL_DB_PORT>                                          # portal-container-infra Port
PORTAL_DB_USER_PASSWORD=<PORTAL_DB_USER_PASSWORD>           # portal-container-infra DB Password

# PORTAL-API
ABACUS_URL=""                                                           # Abacus URL(Not required)
MONITORING_API_URL=<MONITORING_API_URL>                                           # Monitoring API URL(Not required) (e.g. 45.55.120.54)

# PORTAL-COMMON-API
PAASTA_DB_DRIVER=<PAASTA_DB_DRIVER>        # PaaS-TA DB Driver (e.g. org.postgresql.Driver OR com.mysql.jdbc.Driver)
PAASTA_DATABASE=<PAASTA_DATABASE>                            # PaaS-TA DB (e.g. postgresql OR mysql)
PAASTA_DB_IP=<PAASTA_DB_IP>                                       # PaaS-TA DB IP
PAASTA_DB_PORT=<PAASTA_DB_PORT>                                           # PaaS-TA DB Port (e.g. 5524(postgres) OR 13307(mysql))
CC_DB_NAME=<CC_DB_NAME>                           # PaaS-TA CCDB Name
CC_DB_USER_NAME=<CC_DB_USER_NAME>                      # PaaS-TA CCDB ID
CC_DB_USER_PASSWORD=<CC_DB_USER_PASSWORD>                          # PaaS-TA CCDB Password
UAA_DB_NAME=<UAA_DB_NAME>                                                       # PaaS-TA UAA Name
UAA_DB_USER_NAME=<UAA_DB_USER_NAME>                                          # PaaS-TA UAA id
UAA_DB_USER_PASSWORD=<UAA_DB_USER_PASSWORD>                        # PaaS-TA UAA Password
MAIL_SMTP_HOST=<MAIL_SMTP_HOST>                         # Mail-SMTP Host
MAIL_SMTP_PORT=<MAIL_SMTP_PORT>                                            # Mail-SMTP Port
MAIL_SMTP_USERNAME=<MAIL_SMTP_USERNAME>                                     # Mail-SMTP User Name
MAIL_SMTP_PASSWORD=<MAIL_SMTP_PASSWORD>                                     # Mail-SMTP Password
MAIL_SMTP_USEREMAIL=<MAIL_SMTP_USEREMAIL>         # Mail-SMTP User Email
MAIL_SMTP_PROPERTIES_AUTHURL=<MAIL_SMTP_PROPERTIES_AUTHURL>                 # Mail-SMTP Properties Auth URL

# PORTAL-STORAGE-API
OBJECTSTORAGE_TENANTNAME=<OBJECTSTORAGE_TENANTNAME>        # portal-container-infra Binary Storage Tenant Name
OBJECTSTORAGE_USERNAME=<OBJECTSTORAGE_USERNAME>          # portal-container-infra Binary Storage User Name
OBJECTSTORAGE_PASSWORD=<OBJECTSTORAGE_PASSWORD>                         # portal-container-infra Binary Storage Password
OBJECTSTORAGE_IP=<OBJECTSTORAGE_IP>                          # portal-container-infra IP
OBJECTSTORAGE_PORT=<OBJECTSTORAGE_PORT>                                      # portal-container-infra Binary Storage Port

# PORTAL-WEBUSER
UAAC_PORTAL_CLIENT_ID=<UAAC_PORTAL_CLIENT_ID>            # UAAC Portal Client ID
UAAC_PORTAL_CLIENT_SECRET=<UAAC_PORTAL_CLIENT_SECRET>        # UAAC Poral Client Secret
USER_APP_SIZE_MB=<USER_APP_SIZE_MB>                                                      # USER My App size(MB), if value==0 -> unlimited
MONITORING_ENABLE=<MONITORING_ENABLE>                                         # Monitoring Enable Option

# COMMON VARIABLE
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-gateway-2.1.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-registration-2.1.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-storage-api-2.2.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-web-admin-2.3.0 -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-web-user-2.3.1/config -type f | xargs sed -i -e 's/<DOMAIN>/'${DOMAIN}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<CF_USER_ADMIN_USERNAME>/'${CF_USER_ADMIN_USERNAME}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<CF_USER_ADMIN_USERNAME>/'${CF_USER_ADMIN_USERNAME}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<CF_USER_ADMIN_PASSWORD>/'${CF_USER_ADMIN_PASSWORD}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<CF_USER_ADMIN_PASSWORD>/'${CF_USER_ADMIN_PASSWORD}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<UAA_CLIENT_ID>/'${UAA_CLIENT_ID}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_CLIENT_ID>/'${UAA_CLIENT_ID}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<UAA_CLIENT_SECRET>/'${UAA_CLIENT_SECRET}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_CLIENT_SECRET>/'${UAA_CLIENT_SECRET}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<UAA_ADMIN_CLIENT_ID>/'${UAA_ADMIN_CLIENT_ID}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_ADMIN_CLIENT_ID>/'${UAA_ADMIN_CLIENT_ID}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<UAA_ADMIN_CLIENT_SECRET>/'${UAA_ADMIN_CLIENT_SECRET}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_ADMIN_CLIENT_SECRET>/'${UAA_ADMIN_CLIENT_SECRET}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<UAA_LOGIN_CLIENT_ID>/'${UAA_LOGIN_CLIENT_ID}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_LOGIN_CLIENT_ID>/'${UAA_LOGIN_CLIENT_ID}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<UAA_LOGIN_CLIENT_SECRET>/'${UAA_LOGIN_CLIENT_SECRET}'/g'
find ./portal-log-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_LOGIN_CLIENT_SECRET>/'${UAA_LOGIN_CLIENT_SECRET}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PORTAL_DB_IP>/'${PORTAL_DB_IP}'/g'
find ./portal-web-admin-2.3.0 -type f | xargs sed -i -e 's/<PORTAL_DB_IP>/'${PORTAL_DB_IP}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PORTAL_DB_PORT>/'${PORTAL_DB_PORT}'/g'
find ./portal-web-admin-2.3.0 -type f | xargs sed -i -e 's/<PORTAL_DB_PORT>/'${PORTAL_DB_PORT}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PORTAL_DB_USER_PASSWORD>/'${PORTAL_DB_USER_PASSWORD}'/g'
find ./portal-web-admin-2.3.0 -type f | xargs sed -i -e 's/<PORTAL_DB_USER_PASSWORD>/'${PORTAL_DB_USER_PASSWORD}'/g'

# PORTAL-API
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<ABACUS_URL>/'${ABACUS_URL}'/g'
find ./portal-api-2.4.0 -type f | xargs sed -i -e 's/<MONITORING_API_URL>/'${MONITORING_API_URL}'/g'

# PORTAL-COMMON-API
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PAAS-TA_DB_DRIVER>/'${PAASTA_DB_DRIVER}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PAAS-TA_DATABASE>/'${PAASTA_DATABASE}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PAAS-TA_DB_IP>/'${PAASTA_DB_IP}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<PAAS-TA_DB_PORT>/'${PAASTA_DB_PORT}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<CC_DB_NAME>/'${CC_DB_NAME}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<CC_DB_USER_NAME>/'${CC_DB_USER_NAME}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<CC_DB_USER_PASSWORD>/'${CC_DB_USER_PASSWORD}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_DB_NAME>/'${UAA_DB_NAME}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_DB_USER_NAME>/'${UAA_DB_USER_NAME}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<UAA_DB_USER_PASSWORD>/'${UAA_DB_USER_PASSWORD}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<MAIL_SMTP_HOST>/'${MAIL_SMTP_HOST}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<MAIL_SMTP_PORT>/'${MAIL_SMTP_PORT}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<MAIL_SMTP_USERNAME>/'${MAIL_SMTP_USERNAME}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<MAIL_SMTP_PASSWORD>/'${MAIL_SMTP_PASSWORD}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<MAIL_SMTP_USEREMAIL>/'${MAIL_SMTP_USEREMAIL}'/g'
find ./portal-common-api-2.2.0 -type f | xargs sed -i -e 's/<MAIL_SMTP_PROPERTIES_AUTHURL>/'${MAIL_SMTP_PROPERTIES_AUTHURL}'/g'

# PORTAL-STORAGE-API
find ./portal-storage-api-2.2.0 -type f | xargs sed -i -e 's/<OBJECTSTORAGE_TENANTNAME>/'${OBJECTSTORAGE_TENANTNAME}'/g'
find ./portal-storage-api-2.2.0 -type f | xargs sed -i -e 's/<OBJECTSTORAGE_USERNAME>/'${OBJECTSTORAGE_USERNAME}'/g'
find ./portal-storage-api-2.2.0 -type f | xargs sed -i -e 's/<OBJECTSTORAGE_PASSWORD>/'${OBJECTSTORAGE_PASSWORD}'/g'
find ./portal-storage-api-2.2.0 -type f | xargs sed -i -e 's/<OBJECTSTORAGE_IP>/'${OBJECTSTORAGE_IP}'/g'
find ./portal-storage-api-2.2.0 -type f | xargs sed -i -e 's/<OBJECTSTORAGE_PORT>/'${OBJECTSTORAGE_PORT}'/g'

# PORTAL-WEBUSER
find ./portal-web-user-2.3.1/config -type f | xargs sed -i -e 's/<UAAC_PORTAL_CLIENT_ID>/'${UAAC_PORTAL_CLIENT_ID}'/g'
find ./portal-web-user-2.3.1/config -type f | xargs sed -i -e 's/<UAAC_PORTAL_CLIENT_SECRET>/'${UAAC_PORTAL_CLIENT_SECRET}'/g'
find ./portal-web-user-2.3.1/config -type f | xargs sed -i -e 's/<USER_APP_SIZE_MB>/'${USER_APP_SIZE_MB}'/g'
find ./portal-web-user-2.3.1/config -type f | xargs sed -i -e 's/<MONITORING_ENABLE>/'${MONITORING_ENABLE}'/g'

cd portal-web-user-2.3.1/config
source applyChangeConfig.sh
cd ../../

#SECURITY GROUP
find . -name portal-rule.json -type f | xargs sed -i -e 's/<PORTAL_DB_IP>/'${PORTAL_DB_IP}'/g'
find . -name portal-rule.json -type f | xargs sed -i -e 's/<PAAS-TA_DB_IP>/'${PAASTA_DB_IP}'/g'
