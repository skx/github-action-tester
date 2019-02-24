#!/bin/bash
set -e

if [ -e .github/run-tests.sh ]; then
    chmod 755 .github/run-tests.sh
    .github/run-tests.sh
else
    echo "Repository does not contain test-script '.github/run-tests.sh'"
    exit 1
fi
