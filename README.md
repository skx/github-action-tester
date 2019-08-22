# GitHub Action for Running tests

This repository contains a simple GitHub Action implementation, which allows you to run a shell-script every time an event occurs within your repository.

If your shell-script terminates with an exit-code of 0 that is regarded as a pass, otherwise the action will be marked as a failure.

The expectation is that you'll use this action to launch your project-specific test-cases, ensuring that all pull-requests are tested automatically.

Because the action ultimately just executes a shell-script, contained in your repository, you can be as simple or complex as you can imagine.  For example a [golang](https://golang.org/) project might contain a simple script such as this:

    #!/bin/sh
    # Run the go-vet tool
    go vet ./..           || exit 1
    # Run the test-cases
    go test -race ./...   || exit 1
    exit 0

A C-based project might contain something like this:

    #!/bin/sh
    make && make test

But as you can install/invoke arbitrary commands, and update them as your project grows, you can do almost anything you wish.


## Enabling the action

There are two steps required to use this action:

* Enable the action inside your repository.
  * You'll probably want to enable it upon pull-requests, to ensure their quality.
  * You might also want to enable it to run each time a push is made to your repository, for completeness.
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
