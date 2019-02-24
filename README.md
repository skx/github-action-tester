# GitHub Action for Running tests

GitHub Action implementation of a general purpose testing script which allows
you to run a shell-script every time a pull-request is submitted, or updated.

## Sample Output

You can see a sample output here:

* https://github.com/skx/math-compiler/actions
* https://github.com/skx/math-compiler/actions


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
