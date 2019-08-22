# GitHub Action for Running tests

This repository contains a simple GitHub Action implementation, which allows you to run a shell-script every time a pull-request is created/updated, or a commit is made to your repository.

The expectation is that you'll use this action to launch your project-specific tests, by executing a shell-script.  The  exit code of the script will determine the success/failure result.

For example a golang-project might contain nothing more than:

    #!/bin/sh
    # Run the go-vet tool
    go vet ./..           || exit 1
    # Run the test-cases
    go test -race ./...   || exit 1
    exit 0

Or a C-based project might contain:

    #!/bin/sh
    make && make test


## Enabling the action

There are two steps required to use this action:

* Enable the action inside your repository.
  * You'll probably want to enable it upon pull-requests, to ensure their quality.
  * You might also want to enable it to run each time a push is made to your repository, for completenes.
* Add your project-specific tests to the script `.github/run-tests.sh`.
  * The exit-code of this script will determine the result.


## Sample Configuration

Defining Github Actions requires that you create a directory `.github/workflows` inside your repository.  Inside the workflow-directory you create files which are processed when various events occur.

For example:

* .`github/workflows/pull_request.yml`
  * This is used when a pull-request is created/updated upon your repository.
* `.github/workflows/push.yml`
  * This is used when a commit is pushed to your repository.

You can use content like this to invoke this action:

```
on: pull_request
name: Pull Request
jobs:
  test:
    name: Run tests
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Test
      uses: skx/github-action-tester@master
```

You can also limit the tests to only executing when specific branches are updated, and chain events.  For more details please consult the [Github Actions documentation](https://developer.github.com/actions/).
