FROM golang:latest

LABEL "com.github.actions.name"="PHP Lint"
LABEL "com.github.actions.description"="Run tests against pull requests"
LABEL "com.github.actions.icon"="eye"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="http://github.com/skx/github-action-tester"
LABEL homepage="http://github.com/skx/github-action-tester"
LABEL maintainer="Steve Kemp <steve@steve.fi>"

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
