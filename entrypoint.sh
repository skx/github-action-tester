#!/bin/bash
set -e

#
# If the script is present ..
#
if [ -e .github/run-tests.sh ]; then

    # Ensure it is executable.
    chmod 755 .github/run-tests.sh

    # Run it.
    .github/run-tests.sh

    # Preserve the exit-code
    exit $?

else

    #
    # Script is missing.
    #
    echo "Repository does not contain test-script '.github/run-tests.sh'"
    exit 1
fi
