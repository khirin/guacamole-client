#!/bin/sh
        echo -e "\n\t\t[#] init.sh [#]"

if [ ! -f "/var/init_guacamole_ok" ]; then

# Directories
        echo -e "\n\t[i] Create directories"
        mkdir -p ${GUACAMOLE_HOME}/classpath ${GUACAMOLE_HOME}/lib ${GUACAMOLE_HOME}/extensions

# guacamole.properties
	echo -e "\t[i] Create guacamole.properties"
	echo "# General" > ${GUACAMOLE_HOME}/guacamole.properties
	echo "guacd-hostname: ${GUACAMOLE_GUACD_SRV}" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo -e "guacd-port: ${GUACAMOLE_GUACD_PORT}\n" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "# Libs" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo -e "#lib-directory: /guacamole/classpath\n" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "# Authentification MySQL" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo -e "auth-provider: net.sourceforge.guacamole.net.auth.mysql.MySQLAuthenticationProvider\n" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "# MySQL properties" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "mysql-hostname: ${GUACAMOLE_DB_SRV}" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "mysql-port: ${GUACAMOLE_DB_PORT}" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "mysql-database: ${GUACAMOLE_DB}" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "mysql-username: ${GUACAMOLE_DB_USER}" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo -e "mysql-password: `echo ${GUACAMOLE_DB_PASSWORD} | base64 -d`\n" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "# Authentificatin Basic" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo -e "#auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider\n" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo "# Properties used by BasicFileAuthenticationProvider" >> ${GUACAMOLE_HOME}/guacamole.properties
	echo -e "#basic-user-mapping: /conf/user-mapping.xml\n" >> ${GUACAMOLE_HOME}/guacamole.properties

# MySQl extension installation
        echo -e "\t[i] Install MySQL extension"
	tar -xzf /tmp/guacamole-auth-jdbc-${GUACAMOLE_VERSION}-incubating.tar.gz -C ${GUACAMOLE_HOME}/classpath --strip-components=2 guacamole-auth-jdbc-${GUACAMOLE_VERSION}-incubating/mysql/guacamole-auth-jdbc-mysql-${GUACAMOLE_VERSION}-incubating.jar
	tar -xzf /tmp/guacamole-auth-jdbc-${GUACAMOLE_VERSION}-incubating.tar.gz -C ${GUACAMOLE_HOME}/extensions --strip-components=2 guacamole-auth-jdbc-${GUACAMOLE_VERSION}-incubating/mysql/guacamole-auth-jdbc-mysql-${GUACAMOLE_VERSION}-incubating.jar
	tar -xzf /tmp/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz -C ${GUACAMOLE_HOME}/classpath --strip-components=1 mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}-bin.jar
	tar -xzf /tmp/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz -C ${GUACAMOLE_HOME}/lib --strip-components=1 mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}-bin.jar
	tar -xzf /tmp/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz -C ${GUACAMOLE_HOME}/classpath --strip-components=3 mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/src/lib/
	tar -xzf /tmp/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz -C ${GUACAMOLE_HOME}/lib --strip-components=3 mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/src/lib/

# Permissions
        echo -e "\t[i] Set permissions"
	chown -R tomcat:tomcat ${GUACAMOLE_HOME}
	chmod -R 770 ${GUACAMOLE_HOME}
	chown tomcat:tomcat ${CATALINA_HOME}/webapps/guacamole.war
	chmod 660 ${CATALINA_HOME}/webapps/guacamole.war
		
# Create init flag /var/init_guacamole_ok
        echo -e "\t[i] Create init flag /var/init_guacamole_ok\n"
        touch /var/init_guacamole_ok
else
        echo -e "\n\t[i] Settings already done ...\n"
fi
