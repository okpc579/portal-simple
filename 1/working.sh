#!/bin/bash

source portal-app-variable.yml

PORTALAPPNAME=portal-app-1.2.0

CURRENTDIRCTORY=$pwd

#########################################
# portal-app 1.2.0 download
## portal-app zip downloaded check
if [ -e $PORTALAPPNAME.zip ]; then
        echo "portal-app zip file exists - download skip"
else
        echo "portal-app zip file not exists - download zip file "
        ## portal-app.1.2.0.zip download
        wget --content-disposition https://nextcloud.paas-ta.org/index.php/s/cRHds5osDff5G3f/download
fi

#########################################
# portal-app unzip
if [ -d $PORTALAPPNAME ]; then
        echo "portal-app folder exists - delete folder"
        ## existing portal-app directory delete
        #ll | grep "portal-app-*" | grep ^d | awk '{print $NF}' | xargs rm -rf
fi
## portal-app unzip
echo "portal-app unzip"
#unzip $PORTALAPPNAME.zip

#########################################
#config change

#1.applyChangeVariable-change.sh
## COMMON VARIABLE
# DOMAIN
DOMAIN=$(grep -r "system_domain" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/DOMAIN=<DOMAIN>/DOMAIN=$DOMAIN/g"

# CF_USER_ADMIN_USERNAME
CF_USER_ADMIN_USERNAME=$(grep -r "paasta_admin_username" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/CF_USER_ADMIN_USERNAME=<CF_USER_ADMIN_USERNAME>/CF_USER_ADMIN_USERNAME=$CF_USER_ADMIN_USERNAME/g"

# CF_USER_ADMIN_PASSWORD
CF_USER_ADMIN_PASSWORD=$(grep -r "paasta_admin_password" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/CF_USER_ADMIN_PASSWORD=<CF_USER_ADMIN_PASSWORD>/CF_USER_ADMIN_PASSWORD=$CF_USER_ADMIN_PASSWORD/g"

# UAA_CLIENT_ID
## UAA_ADMIN_CLIENT_ID == UAA_CLIENT_ID
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_CLIENT_ID=<UAA_ADMIN_CLIENT_ID>/UAA_CLIENT_ID=$UAAC_ID/g"

# UAA_CLIENT_SECRET
## UAA_ADMIN_CLIENT_SECRET == UAA_CLIENT_SECRET
UAA_ADMIN_CLIENT_SECRET=$(grep -r "uaa_client_admin_secret" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_CLIENT_SECRET=<UAA_ADMIN_CLIENT_SECRET>/UAA_CLIENT_SECRET=$UAA_ADMIN_CLIENT_SECRET/g"


# UAA_ADMIN_CLIENT_ID
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_ADMIN_CLIENT_ID=<UAA_ADMIN_CLIENT_ID>/UAA_ADMIN_CLIENT_ID=$UAAC_ID/g"

# UAA_ADMIN_CLIENT_SECRET
UAA_ADMIN_CLIENT_SECRET=$(grep -r "uaa_client_admin_secret" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_ADMIN_CLIENT_SECRET=<UAA_ADMIN_CLIENT_SECRET>/UAA_ADMIN_CLIENT_SECRET=$UAA_ADMIN_CLIENT_SECRET/g"

# UAA_LOGIN_CLIENT_ID
## UAA_ADMIN_CLIENT_ID == UAA_LOGIN_CLIENT_ID
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_LOGIN_CLIENT_ID=<UAA_ADMIN_CLIENT_ID>/UAA_LOGIN_CLIENT_ID=$UAAC_ID/g"

# UAA_LOGIN_CLIENT_SECRET
## UAA_ADMIN_CLIENT_SECRET == UAA_LOGIN_CLIENT_SECRET
UAA_ADMIN_CLIENT_SECRET=$(grep -r "uaa_client_admin_secret" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_LOGIN_CLIENT_SECRET=<UAA_ADMIN_CLIENT_SECRET>/UAA_LOGIN_CLIENT_SECRET=$UAA_ADMIN_CLIENT_SECRET/g"


# PORTAL_DB_IP
PORTAL_DB_IP=$(bosh vms -d portal-container-infra | grep "infra" | cut -f 4)
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PORTAL_DB_IP=<PORTAL_DB_IP>/PORTAL_DB_IP=$PORTAL_DB_IP/g"

# PORTAL_DB_PORT
PORTAL_DB_PORT=$(grep -r "mariadb_port" $PORTAL_INFRA_VARS_PATH | cut -d ':' -f 2 | cut -d " " -f 2 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PORTAL_DB_PORT=<PORTAL_DB_PORT>/PORTAL_DB_PORT=$PORTAL_DB_PORT/g"

# PORTAL_DB_USER_PASSWORD
PORTAL_DB_USER_PASSWORD=$(grep -r "mariadb_admin_password" $PORTAL_INFRA_VARS_PATH | cut -d ':' -f 2 | cut -d " " -f 2 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PORTAL_DB_USER_PASSWORD=<PORTAL_DB_USER_PASSWORD>/PORTAL_DB_USER_PASSWORD=$PORTAL_DB_USER_PASSWORD/g"


## PORTAL-API
# MONITORING_API_URL
MONITORING_API_URL=$(grep -r "monitoring_api_url" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MONITORING_API_URL=<MONITORING_API_URL>/MONITORING_API_URL=$MONITORING_API_URL/g"



## PORTAL-COMMON-API
if [[ -n $(bosh is --ps -d paasta | grep "database" | grep "postgres") ]]; then
# PAASTA_DB_DRIVER
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PAASTA_DB_DRIVER=<PAASTA_DB_DRIVER>/PAASTA_DB_DRIVER=org.postgresql.Driver/g"
# PAASTA_DATABASE
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PAASTA_DATABASE=<PAASTA_DATABASE>/PAASTA_DATABASE=postgresql/g"

elif [[ -n $(bosh is --ps -d paasta | grep "database" | grep "pxc") ]]; then
# PAASTA_DB_DRIVER
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PAASTA_DB_DRIVER=<PAASTA_DB_DRIVER>/PAASTA_DB_DRIVER=com.mysql.jdbc.Driver/g"
# PAASTA_DATABASE
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PAASTA_DATABASE=<PAASTA_DATABASE>/PAASTA_DATABASE=mysql/g"
fi

# PAASTA_DB_IP
PAASTA_DB_IP=$(bosh vms -d paasta | grep "database" | cut -f 4)
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PAASTA_DB_IP=<PAASTA_DB_IP>/PAASTA_DB_IP=$PAASTA_DB_IP/g"

# PAASTA_DB_PORT
PAASTA_DB_PORT=$(grep -r "paasta_database_port" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/PAASTA_DB_PORT=<PAASTA_DB_PORT>/PAASTA_DB_PORT=$PAASTA_DB_PORT/g"

# CC_DB_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/CC_DB_NAME=<CC_DB_NAME>/CC_DB_NAME=$CC_DB_NAME/g"

# CC_DB_USER_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/CC_DB_USER_NAME=<CC_DB_USER_NAME>/CC_DB_USER_NAME=$CC_DB_USER_NAME/g"

# CC_DB_USER_PASSWORD
CC_DB_USER_PASSWORD=$(grep -r "paasta_cc_db_password" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/CC_DB_USER_PASSWORD=<CC_DB_USER_PASSWORD>/CC_DB_USER_PASSWORD=$CC_DB_USER_PASSWORD/g"

# UAA_DB_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_DB_NAME=<UAA_DB_NAME>/UAA_DB_NAME=$UAA_DB_NAME/g"

# UAA_DB_USER_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_DB_USER_NAME=<UAA_DB_USER_NAME>/UAA_DB_USER_NAME=$UAA_DB_USER_NAME/g"

# UAA_DB_USER_PASSWORD
UAA_DB_USER_PASSWORD=$(grep -r "paasta_uaa_db_password" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAA_DB_USER_PASSWORD=<UAA_DB_USER_PASSWORD>/UAA_DB_USER_PASSWORD=$UAA_DB_USER_PASSWORD/g"

# MAIL_SMTP_HOST
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MAIL_SMTP_HOST=<MAIL_SMTP_HOST>/MAIL_SMTP_HOST=$MAIL_SMTP_HOST/g"

# MAIL_SMTP_PORT
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MAIL_SMTP_PORT=<MAIL_SMTP_PORT>/MAIL_SMTP_PORT=$MAIL_SMTP_PORT/g"

# MAIL_SMTP_USERNAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MAIL_SMTP_USERNAME=<MAIL_SMTP_USERNAME>/MAIL_SMTP_USERNAME=$MAIL_SMTP_USERNAME/g"

# MAIL_SMTP_PASSWORD
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MAIL_SMTP_PASSWORD=<MAIL_SMTP_PASSWORD>/MAIL_SMTP_PASSWORD=$MAIL_SMTP_PASSWORD/g"

# MAIL_SMTP_USEREMAIL
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MAIL_SMTP_USEREMAIL=<MAIL_SMTP_USEREMAIL>/MAIL_SMTP_USEREMAIL=$MAIL_SMTP_USEREMAIL/g"

# MAIL_SMTP_PROPERTIES_AUTHURL
MAIL_SMTP_PROPERTIES_AUTHURL=portal-web-user.$(grep -r "system_domain" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g' | sed -e 's/\"//g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MAIL_SMTP_PROPERTIES_AUTHURL=<MAIL_SMTP_PROPERTIES_AUTHURL>/MAIL_SMTP_PROPERTIES_AUTHURL=$MAIL_SMTP_PROPERTIES_AUTHURL/g"



## PORTAL-STORAGE-API
# OBJECTSTORAGE_TENANTNAME
OBJECTSTORAGE_TENANTNAME=$(grep -r "binary_storage_tenantname" $PORTAL_INFRA_VARS_PATH | cut -d ':' -f 2 | cut -d " " -f 2 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/OBJECTSTORAGE_TENANTNAME=<OBJECTSTORAGE_TENANTNAME>/OBJECTSTORAGE_TENANTNAME=$OBJECTSTORAGE_TENANTNAME/g"

# OBJECTSTORAGE_USERNAME
OBJECTSTORAGE_USERNAME=$(grep -r "binary_storage_username" $PORTAL_INFRA_VARS_PATH | cut -d ':' -f 2 | cut -d " " -f 2 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/OBJECTSTORAGE_USERNAME=<OBJECTSTORAGE_USERNAME>/OBJECTSTORAGE_USERNAME=$OBJECTSTORAGE_USERNAME/g"

# OBJECTSTORAGE_PASSWORD
OBJECTSTORAGE_PASSWORD=$(grep -r "binary_storage_password" $PORTAL_INFRA_VARS_PATH | cut -d ':' -f 2 | cut -d " " -f 2 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/OBJECTSTORAGE_PASSWORD=<OBJECTSTORAGE_PASSWORD>/OBJECTSTORAGE_PASSWORD=$OBJECTSTORAGE_PASSWORD/g"

# OBJECTSTORAGE_IP
OBJECTSTORAGE_IP=$(bosh vms -d portal-container-infra | grep "infra" | cut -f 4)
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/OBJECTSTORAGE_IP=<OBJECTSTORAGE_IP>/OBJECTSTORAGE_IP=$OBJECTSTORAGE_IP/g"

# OBJECTSTORAGE_PORT
OBJECTSTORAGE_PORT=$(grep -r "binary_storage_auth_port" $PORTAL_INFRA_VARS_PATH | cut -d ':' -f 2 | cut -d " " -f 2 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/OBJECTSTORAGE_PORT=<OBJECTSTORAGE_PORT>/OBJECTSTORAGE_PORT=$OBJECTSTORAGE_PORT/g"



## PORTAL-WEBUSER
# UAAC_PORTAL_CLIENT_ID
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAAC_PORTAL_CLIENT_ID=<UAAC_PORTAL_CLIENT_ID>/UAAC_PORTAL_CLIENT_ID=$UAAC_PORTAL_CLIENT_ID/g"

# UAAC_PORTAL_CLIENT_SECRET
UAAC_PORTAL_CLIENT_SECRET=$(grep -r "uaa_client_portal_secret" $COMMON_VARS_PATH | cut -d ':' -f 2 | cut -f 1 | sed -e 's/ //g')
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/UAAC_PORTAL_CLIENT_SECRET=<UAAC_PORTAL_CLIENT_SECRET>/UAAC_PORTAL_CLIENT_SECRET=$UAAC_PORTAL_CLIENT_SECRET/g"

# USER_APP_SIZE_MB
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/USER_APP_SIZE_MB=<USER_APP_SIZE_MB>/USER_APP_SIZE_MB=$USER_APP_SIZE_MB/g"

# MONITORING_ENABLE
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/1.applyChangeVariable-change.sh -type f | xargs sed -i -e "s/MONITORING_ENABLE=<MONITORING_ENABLE>/MONITORING_ENABLE=$MONITORING_ENABLE/g"



#2.portalContainerPush-change.sh
# DOMAIN
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/DOMAIN=<DOMAIN>/DOMAIN=$DOMAIN/g"


# CF_USER_ADMIN_USERNAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/PAASTA_USER_ADMIN_USERNAME=<PAASTA_USER_ADMIN_USERNAME>/PAASTA_USER_ADMIN_USERNAME=$CF_USER_ADMIN_USERNAME/g"

# CF_USER_ADMIN_PASSWORD
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/PAASTA_USER_ADMIN_PASSWORD=<PAASTA_USER_ADMIN_PASSWORD>/PAASTA_USER_ADMIN_PASSWORD=$CF_USER_ADMIN_PASSWORD/g"

# PORTAL_QUOTA_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/PORTAL_QUOTA_NAME=<PORTAL_QUOTA_NAME>/PORTAL_QUOTA_NAME=$PORTAL_QUOTA_NAME/g"

# PORTAL_ORG_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/PORTAL_ORG_NAME=<PORTAL_ORG_NAME>/PORTAL_ORG_NAME=$PORTAL_ORG_NAME/g"

# PORTAL_SPACE_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/PORTAL_SPACE_NAME=<PORTAL_SPACE_NAME>/PORTAL_SPACE_NAME=$PORTAL_SPACE_NAME/g"

# PORTAL_SECURITY_GROUP_NAME
find $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/2.portalContainerPush-change.sh -type f | xargs sed -i -e "s/PORTAL_SECURITY_GROUP_NAME=<PORTAL_SECURITY_GROUP_NAME>/PORTAL_SECURITY_GROUP_NAME=$PORTAL_SECURITY_GROUP_NAME/g"

#########################################

cd $PORTAL_APP_WORKING_DIRECTORY/$PORTALAPPNAME/

## variable change
source 1.applyChangeVariable-change.sh

## app push
source 2.portalContainerPush-change.sh

#########################################

cd $CURRENTDIRCTORY
