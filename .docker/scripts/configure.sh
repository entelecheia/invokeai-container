#!/bin/bash
# add your custom commands here that should be executed every time the docker container starts
echo "Confiuguring InvokeAI..."


# Configure InvokeAI and install a starting set of image generation models (you only need to do this once):
invokeai-configure --root ./invokeai

# Configure InvokeAI and install a starting set of image generation models (you only need to do this once):
invokeai-configure --root ./invokeai
