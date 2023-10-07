# Sets the base image for subsequent instructions
ARG ARG_BUILD_FROM="ghcr.io/entelecheia/invokeai:latest-base"
FROM $ARG_BUILD_FROM

# Setting ARGs and ENVs for user creation and workspace setup
ARG ARG_USERNAME="app"
ARG ARG_USER_UID=9001
ARG ARG_USER_GID=$ARG_USER_UID
ARG ARG_WORKSPACE_ROOT="/workspace"
ENV USERNAME $ARG_USERNAME
ENV USER_UID $ARG_USER_UID
ENV USER_GID $ARG_USER_GID
ENV WORKSPACE_ROOT $ARG_WORKSPACE_ROOT

# Setting ARGs and ENVs for Stable-Diffusion-WebUI GitHub repository
ARG ARG_APP_SOURCE_REPO="entelecheia/InvokeAI"
ARG ARG_APP_INSTALL_ROOT="/opt"
ARG ARG_APP_CLONE_DIRNAME="invokeai"
ARG ARG_APP_SOURCE_BRANCH="main"
ARG ARG_APP_SERVICE_NAME="app"
ENV APP_SOURCE_REPO $ARG_APP_SOURCE_REPO
ENV APP_INSTALL_ROOT $ARG_APP_INSTALL_ROOT
ENV APP_CLONE_DIRNAME $ARG_APP_CLONE_DIRNAME
ENV APP_SOURCE_BRANCH $ARG_APP_SOURCE_BRANCH
ENV APP_SERVICE_NAME $ARG_APP_SERVICE_NAME

ENV INVOKEAI_SRC=${APP_INSTALL_ROOT}/${APP_CLONE_DIRNAME}
ENV VIRTUAL_ENV=${APP_INSTALL_ROOT}/.venvs/${APP_CLONE_DIRNAME}
ENV INVOKEAI_ROOT=${WORKSPACE_ROOT}/${APP_CLONE_DIRNAME}
# Add the path of the cloned repository to PATH
ENV PATH="$INVOKEAI_SRC:$PATH"

# Install the local package.
# Editable mode helps use the same image for development:
# the local working copy can be bind-mounted into the image
# at path defined by ${INVOKEAI_SRC}
RUN git clone --branch $APP_SOURCE_BRANCH https://github.com/${ARG_APP_SOURCE_REPO}.git ${INVOKEAI_SRC} &&\
    cd ${INVOKEAI_SRC} &&\
    git checkout $APP_SOURCE_BRANCH

WORKDIR ${INVOKEAI_SRC}
RUN pip install -e ".[xformers]"

# build patchmatch
RUN cd /usr/lib/$(uname -p)-linux-gnu/pkgconfig/ && ln -sf opencv4.pc opencv.pc
RUN python3 -c "from patchmatch import patch_match"

# Creates a non-root user with sudo privileges
# check if user exists and if not, create user
RUN if id -u $USERNAME >/dev/null 2>&1; then \
    echo "User exists"; \
    else \
    groupadd --gid $USER_GID $USERNAME && \
    adduser --uid $USER_UID --gid $USER_GID --force-badname --disabled-password --gecos "" $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    adduser $USERNAME sudo && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME; \
    fi

# Sets up the workspace for the user
RUN rm -rf $WORKSPACE_ROOT && mkdir -p $WORKSPACE_ROOT/projects

# Sets the working directory to workspace root
WORKDIR $WORKSPACE_ROOT
# Copies scripts from host into the image
COPY ./.docker/scripts/ ./scripts/

ENV HF_HOME=$APP_INSTALL_ROOT/.cache/huggingface
RUN mkdir -p $HF_HOME

# Changes ownership of the workspace to the non-root user
RUN chown -R $USERNAME:$USERNAME $WORKSPACE_ROOT
RUN chown -R $USERNAME:$USERNAME $APP_INSTALL_ROOT

# Specifies the command that will be executed when the container is run
CMD ["bash"]
