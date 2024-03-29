#!/bin/bash

MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"

. ${MY_DIR}/cyber_dojo_helpers.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_SUCCESS_exits_zero_no_stderr_prints_to_stdout() { :; }
test_FAILURE_exits_non_zero_no_stdout_prints_to_stderr() { :; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_CLEAN() { :; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test___success() { :; }

test_____help_arg_prints_use()
{
  local readonly expected_stdout="
Use: cyber-dojo clean

Removes dangling docker images/volumes and exited containers"
  assertClean --help
  assertStdoutEquals "${expected_stdout}"
  assertNoStderr
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_____no_args_produces_no_output_leaves_no_dangling_images_or_exited_containers()
{
  local readonly dangling_images=`docker images --quiet --filter='dangling=true'`
  local readonly exited_containers=`docker ps --all --quiet --filter='status=exited'`
  assertClean
  assertNoStdout
  assertNoStderr
  assertEquals "" "${dangling_images}"
  assertEquals '' "${exited_containers}"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test___failure() { :; }

test_____unknown_arg()
{
  local readonly name=extra
  refuteClean ${name}
  assertNoStdout
  assertStderrEquals "FAILED: unknown argument [${name}]"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_____unknown_args()
{
  local readonly extra1=salmon
  local readonly extra2=parr
  refuteClean ${extra1} ${extra2}
  assertNoStdout
  assertStderrIncludes "FAILED: unknown argument [${extra1}]"
  assertStderrIncludes "FAILED: unknown argument [${extra2}]"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

. ${MY_DIR}/shunit2_helpers.sh
. ${MY_DIR}/shunit2
