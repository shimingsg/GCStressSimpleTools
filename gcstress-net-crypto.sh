#!/bin/bash
# GC stress for NETWORKING and CRYPTO

ProjectRoot="$PWD/corefx/bin"
echo project executing path: $ProjectRoot
ANYOS_ANYCPU_DEBUG="$ProjectRoot/AnyOS.AnyCPU.Debug"
LINUX_ANYCPU_DEBUG="$ProjectRoot/Linux.AnyCPU.Debug"
UNIX_ANYCPU_DEBUG="$ProjectRoot/Unix.AnyCPU.Debug"
CURRENT_RUNTIME="$ProjectRoot/testhost/netcoreapp-Linux-Debug-x64"

echo "PWD : $PWD"
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
  echo
  echo "Running tests in $dirName"
  echo "./RunTests.sh $CURRENT_RUNTIME"
  exitCode=$?
  popd
done
}

run-tests $ANYOS_ANYCPU_DEBUG/System.Net.*.Tests
run-tests $LINUX_ANYCPU_DEBUG/System.Net.*.Tests
run-tests $UNIX_ANYCPU_DEBUG/System.Net.*.Tests

run-tests $ANYOS_ANYCPU_DEBUG/System.Security.Crypto*.Tests
run-tests $LINUX_ANYCPU_DEBUG/System.Security.Crypto*.Tests
run-tests $UNIX_ANYCPU_DEBUG/System.Security.Crypto*.Tests

exit $exitCode