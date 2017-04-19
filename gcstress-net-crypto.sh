#!/bin/bash
# GC stress for NETWORKING and CRYPTO

ProjectRoot="$PWD/corefx/bin"
echo project executing path: $ProjectRoot
ANYOS_ANYCPU_DEBUG="$ProjectRoot/AnyOS.AnyCPU.Debug"
LINUX_ANYCPU_DEBUG="$ProjectRoot/Linux.AnyCPU.Debug"
UNIX_ANYCPU_DEBUG="$ProjectRoot/Unix.AnyCPU.Debug"
CURRENT_RUNTIME="$ProjectRoot/testhost/netcoreapp-Linux-Debug-x64"


pushd $ANYOS_ANYCPU_DEBUG
echo "PWD : $PWD"
for testProject in $ANYOS_ANYCPU_DEBUG/System.Net.*.Tests
do
  dirName="$testProject/netcoreapp"

  if [! -d "$dirName"]; then
    dirName="$testProject/netstandard"
    if [! -d "$dirName"]; then
      echo "Nothing to test in $testProject"
      continue
    fi
  fi

  if [! -e "$dirName/RunTest.sh"]; then
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

exit $exitCode