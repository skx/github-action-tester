# GitHub Action for Running tests

GitHub Action implementation of a general purpose testing script which allows
you to run a shell-script every time a pull-request is submitted, or updated.

## Sample Configuration & Output

You can see the output of various runs here:

* https://github.com/skx/math-compiler/actions

And the corresponding configuration files are:

* [.github/main.workflow](https://raw.githubusercontent.com/skx/math-compiler/master/.github/main.workflow)
  * This enables the action, and triggers it to run on pushes or pull-requests.
* [.github/run-tests.sh](https://raw.githubusercontent.com/skx/math-compiler/master/.github/run-tests.sh)
  * This actually runs some tests.
     * First of all a standard `go test ./..`
     * Then a custom functional-test which exercises the application.


## Enabling

There are two steps to enable this action:

* Create the file `.github/main.workflow` in your repository, to enable the action.
* Create the shell-script `.github/run-tests.sh` in your repository, to run the tests.
  * The exit-code of this script will determine the result.


## Configuration

The following sample `.github/main.workflow` file will run tests when commits are pushed __and__ when pull-requests are submitted/updated:

```
# pushes
workflow "Push Event" {
  on = "push"
  resolves = ["Execute"]
}

# pull-requests
workflow "Pull Request" {
  on = "pull_request"
  resolves = ["Execute"]
}

# Run the magic
action "Execute" {
  uses = "skx/github-action-tester@master"
}

```
