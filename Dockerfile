FROM alpine:latest
LABEL maintainer="Mike SoRelle <mike@webskills.net>"

ENV GIT_REPO=""
ENV GIT_BRANCH="master"
ENV GIT_ORIGIN="origin"
ENV COMMIT_USER="Git Service"
ENV COMMIT_EMAIL="git@example.com"
ENV WORKING_DIR=""
ENV SSH_KEY=""
ENV FILES_TO_COMMIT="."
ENV SLEEP_INTERVAL="600"
ENV UID="1001"
ENV GID="100"
ENV USER="gituser"
ENV HOME=/home/$USER


RUN apk update && \
        apk add git && \
	apk add openssh-client && \
        apk add sudo

RUN     adduser -u $UID -G users -D $USER \
        && mkdir -p /etc/sudoers.d \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME

COPY entrypoint.sh /entrypoint.sh

CMD echo "User $(whoami) id info: $(id) running from $PWD with premissions: $(sudo -l)"
#ENTRYPOINT ["/entrypoint.sh"]
