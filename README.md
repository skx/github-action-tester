
# GitHub Action for Running tests

This repository contains a simple GitHub Action which allows you to run a shell-script every time an event occurs within your repository.

* [GitHub Action for Running tests](#github-action-for-running-tests)
  * [Overview](#overview)
  * [Enabling the action](#enabling-the-action)
  * [Sample Configuration](#sample-configuration)
  * [Advanced Configuration](#advanced-configuration)


## Overview

This action allows you to run a shell-script when your workflow action is triggered.  If your script terminates with an exit-code of 0 that is regarded as a pass, otherwise the action will be marked as a failure.

The expectation is that you'll use this action to launch your project-specific test-cases, ensuring that all pull-requests, commits, or both, are tested automatically.

Because the action ultimately executes a shell-script contained in your repository you can be as simple or complex as you can like, for example a [golang](https://golang.org/) project might contain a script such as this:

    #!/bin/sh
    # Run the go-vet tool.
    go vet ./..           || exit 1
    # Run the test-cases, with race-detection.
    go test -race ./...   || exit 1
    # Everything passed, exit cleanly.
    exit 0

A C-based project could contain something like this instead:

    #!/bin/sh
    make && make test

But as you can install/invoke arbitrary commands, and update them as your project grows, you can do almost anything you wish.



## Enabling the action

There are two steps required to use this action:

* Enable the action inside your repository.
  * You'll probably want to enable it upon pull-requests, to ensure their quality.
  * You might also want to enable it to run each time a push is made to your repository, for completeness.
* Add your project-specific test-steps to a script in your repository.
  * By default this action will execute `.github/run-tests.sh`, but you can specify a different name if you prefer.
  * The exit-code of your script will determine the result.



## Sample Configuration

Defining Github Actions requires that you create a directory `.github/workflows` inside your repository.  Inside the workflow-directory you create files which are processed when various events occur.

For example:

* .`github/workflows/pull_request.yml`
  * This is used when a pull-request is created/updated upon your repository.
* `.github/workflows/push.yml`
  * This is used when a commit is pushed to your repository.

The simplest example of using this action would be to create the file `.github/workflows/pull_request.yml` with the following contents:

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

This example will run the default test-script, `.github/run-tests.sh`, every time a pull-request is created, edited, or updated.



## Advanced Configuration

As noted github actions can be launched on multiple events, for example pushes to branches, new releases, pull-request related events, and similar.

Because you probably wish to run different tests/scripts on these different events it is possible to override the name/path of the shell-script which is executed on a per-event basis.

For example you might wish to run more thorough tests upon pull-requests, and a smaller subset when a push is made to your `master` branch (on the assumption that commits there are rare, and the usual workflow will have ensured the full-tests will have been executed via pull-requests).

As an example you might create a workflow for use solely with pushes to master, in the file `.github/workflows/push.yml`:

```
on:
  push:
    branches:
    - master
name: Push Event
jobs:
  test:
    name: Run tests
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Test
      uses: skx/github-action-tester@master
      with:
        script: .github/fast-tests.sh
```

Here we've done two things:

* We've limited the action to only apply to pushes made to the `master` branch.
* We've explicitly set the name of the testing-script to `.github/fast-tests.sh`
  * With the expectation this script contains only "quick" tests.
  * With slower tests being applied to pull-requests.
