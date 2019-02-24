# GitHub Action for Running tests

GitHub Action implementation of a general purpose testing script by [https://github.com/skx/github-action-tester](@skx/github-action-tester).

## Usage

You can use it as a Github Action like this:

_.github/main.workflow_
```
workflow "Github Tests" {
  resolves = ["Execute"]
  on = "pull_request"
}

action "Execute" {
  uses = "skx/github-action-tester@master"
}

```

The expectation is that the docker container will spin up and execute `.github/run-tests.sh` in your repository.  If that script exits cleanly then all is OK, otherwise the result will be marked as a failure.
