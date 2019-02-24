# GitHub Action for Running tests

GitHub Action implementation of a general purpose testing script which allows
you to run a shell-script every time a pull-request is submitted, or updated.

## Sample Output

You can see a sample output here:

* https://github.com/skx/math-compiler/actions


## Usage

There are two steps to enable this action:

* Create the file `.github/main.workflow` in your repository, to enable the action:
  * This will enable the action.
* Create the shell-script `.github/run-tests.sh` in your repository, to run the tests.
  * The exit-code of this script will determine the result.


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
