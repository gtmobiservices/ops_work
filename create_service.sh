#!/bin/bash

# Set the name of the service
SERVICE_NAME=$APP_NAME

# Create the YAML file header
echo "apiVersion: v1" > service.yaml
echo "kind: Service" >> service.yaml
echo "metadata:" >> service.yaml
echo "  name: $SERVICE_NAME" >> service.yaml
echo "  labels:" >> service.yaml
echo "    app: $SERVICE_NAME" >> service.yaml
echo "spec:" >> service.yaml
echo "  selector:" >> service.yaml
echo "    app: $SERVICE_NAME" >> service.yaml
echo "  type: NodePort" >> service.yaml
echo "  ports:" >> service.yaml
# Read the port rules from the file and add them to the YAML file
while IFS=',' read -r PORT_NAME PORT_NUMBER
do
  echo "  - name: $PORT_NAME" >> service.yaml
  echo "    port: $PORT_NUMBER" >> service.yaml
  if [[ $PORT_NUMBER == 80 ]]
  then
    echo "    targetPort: 8082" >> service.yaml
    echo "    nodePort: 30080" >> service.yaml
  else
    echo "    targetPort: $PORT_NUMBER" >> service.yaml
    echo "    nodePort: 3$PORT_NUMBER" >> service.yaml
  fi
done < enabled_traccar_ports
