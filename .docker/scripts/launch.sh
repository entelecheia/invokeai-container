#!/bin/bash
# add your custom commands here that should be executed every time the docker container starts
echo "Starting docker container..."

# Launch the web server (do it every time you run InvokeAI):
invokeai-web --host 0.0.0.0
