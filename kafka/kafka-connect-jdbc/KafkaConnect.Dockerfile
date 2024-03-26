FROM confluentinc/cp-kafka-connect:latest

# Use apt-get or yum based on the base image
USER root

# Install unzip utility, necessary for unzipping the connector
RUN yum update -y && yum install -y unzip 

# Install the JDBC Connector plugin using the Confluent Hub client
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.2.5

# Download and unzip the specific version of the JDBC connector
RUN wget -O /tmp/confluentinc-kafka-connect-jdbc-10.7.6.zip https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-jdbc/versions/10.7.6/confluentinc-kafka-connect-jdbc-10.7.6.zip && \
    unzip /tmp/confluentinc-kafka-connect-jdbc-10.7.6.zip -d /usr/share/java/ && \
    rm /tmp/confluentinc-kafka-connect-jdbc-10.7.6.zip

# Copy the connector configuration file from your local machine to the container
COPY ./account-connector-config.json /etc/kafka-connect/account-connector-config.json

# Use a custom entrypoint script to add the connector configuration on startup
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
