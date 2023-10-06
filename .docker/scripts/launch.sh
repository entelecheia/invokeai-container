#!/bin/bash
set -e -o pipefail

### Container entrypoint
# Runs the CMD as defined by the Dockerfile or passed to `docker run`
# Can be used to configure the runtime dir
# Bypass by using ENTRYPOINT or `--entrypoint`

### Set INVOKEAI_ROOT pointing to a valid runtime directory
# Otherwise configure the runtime dir first.

### Configure the InvokeAI runtime directory (done by default)):
# docker run --rm -it <this image> --configure
# or skip with --no-configure

### Set the USER_UID envvar to match your user.
# Ensures files created in the container are owned by you:
#   docker run --rm -it -v /some/path:/invokeai -e USER_UID=$(id -u) <this image>
# Default UID: 1000 chosen due to popularity on Linux systems. Possibly 501 on MacOS.

USER_UID=${USER_UID:-1000}
USER=${USERNAME:-app}
usermod -u "${USER_UID}" "${USER}" 1>/dev/null

configure() {
    # Configure the runtime directory
    if [[ -f "${INVOKEAI_ROOT}/invokeai.yaml" ]]; then
        echo "${INVOKEAI_ROOT}/invokeai.yaml exists. InvokeAI is already configured."
        echo "To reconfigure InvokeAI, delete the above file."
        echo "======================================================================"
    else
        mkdir -p "${INVOKEAI_ROOT}"
        chown --recursive "${USER}" "${INVOKEAI_ROOT}"
        gosu "${USER}" invokeai-configure --yes --default_only
    fi
}

## Skip attempting to configure.
## Must be passed first, before any other args.
if [[ $1 != "--no-configure" ]]; then
    configure
else
    shift
fi

### Set the $PUBLIC_KEY env var to enable SSH access.
# It is useful to have the full SSH server e.g. on Runpod.
# (use SCP to copy files to/from the image, etc)
if [[ -n "$SSH_PUB_KEY" ]] && [[ ! -d "${HOME}/.ssh" ]]; then
    mkdir -p "${HOME}/.ssh"
    echo "${SSH_PUB_KEY}" > "${HOME}/.ssh/authorized_keys"
    chmod -R 700 "${HOME}/.ssh"
    service ssh start
fi

cd "${INVOKEAI_ROOT}"

# Run the CMD as the Container User (not root).
exec gosu "${USER}" invokeai-web --host 0.0.0.0 "$@"
