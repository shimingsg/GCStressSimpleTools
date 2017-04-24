#!/bin/bash
# GC stress for NETWORKING and CRYPTO

ProjectRoot="$PWD/corefx/bin"
#echo project executing path: $ProjectRoot
ANYOS_ANYCPU_DEBUG="$ProjectRoot/AnyOS.AnyCPU.Debug"
LINUX_ANYCPU_DEBUG="$ProjectRoot/Linux.AnyCPU.Debug"
UNIX_ANYCPU_DEBUG="$ProjectRoot/Unix.AnyCPU.Debug"
TESTHOST_RUNTIME="$ProjectRoot/testhost/netcoreapp-Linux-Debug-x64"


exitCode=0

run-tests()
{
for testProject in $@
do
  dirName="$testProject/netcoreapp"
  if [ ! -d "$dirName" ]; then
    dirName="$testProject/netstandard"
    if [ ! -d "$dirName" ]; then
      echo "Nothing to test in $dirName"
      continue
    fi
  fi
  if [ ! -e "$dirName/RunTests.sh" ]; then
    echo "Cannot find $dirName/RunTests.sh"
    continue
  fi
  pushd $dirName
  echo "Current workspace: $dirName"
  echo
  echo "Running tests in $dirName"
  echo "./RunTests.sh $TESTHOST_RUNTIME"
  ./RunTests.sh $TESTHOST_RUNTIME
  exitCode=$?
  if [ $exitCode -ne 0 ]
  then
      echo "error: One or more tests failed while running tests from '$dirName/RunTests.sh'.  Exit code $exitCode."
  fi
  popd
done
}

run-tests $ANYOS_ANYCPU_DEBUG/System.Net.*.Tests
run-tests $LINUX_ANYCPU_DEBUG/System.Net.*.Tests
run-tests $UNIX_ANYCPU_DEBUG/System.Net.*.Tests

run-tests $ANYOS_ANYCPU_DEBUG/System.Security.Crypto*.Tests
run-tests $LINUX_ANYCPU_DEBUG/System.Security.Crypto*.Tests
run-tests $UNIX_ANYCPU_DEBUG/System.Security.Crypto*.Tests

run-tests $ANYOS_ANYCPU_DEBUG/System.Console.Tests
run-tests $LINUX_ANYCPU_DEBUG/System.Console.Tests
run-tests $UNIX_ANYCPU_DEBUG/System.Console.Tests

exit $exitCode