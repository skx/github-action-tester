#!/bin/bash

#
# Terminate upon errors
#
set -e

#
# If the script is present ..
#
if [ -e .github/run-tests.sh ]; then

    #
    # Ensure it is executable.
    #
    chmod 755 .github/run-tests.sh

    #
    # Run it.
    #
    .github/run-tests.sh

    #
    # If the script exits with a non-zero status-code
    # then it will terminate this script due to the use
    # of `set -e`.
    #
    # So when we reach this point we know:
    #
    #  1.  We've executed the test-script.
    #
    #  2.  The test-script passed.
    #
    # Exit cleanly because we're done.
    #
    exit 0
fi


#
# There is no test-script within the repository.
#
# Show that, and exit with a failure-code.
#
echo "The repository does not contain a test-script '.github/run-tests.sh'"
exit 1

