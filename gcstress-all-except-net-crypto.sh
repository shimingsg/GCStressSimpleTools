#!/usr/bin/env bash
ConfigurationGroup="Release"
ProjectRoot="$PWD/corefx/bin"
ANYOS_ANYCPU_DEBUG="$ProjectRoot/AnyOS.AnyCPU.$ConfigurationGroup"
LINUX_ANYCPU_DEBUG="$ProjectRoot/Linux.AnyCPU.$ConfigurationGroup"
UNIX_ANYCPU_DEBUG="$ProjectRoot/Unix.AnyCPU.$ConfigurationGroup"
TESTHOST_RUNTIME="$ProjectRoot/testhost/netcoreapp-Linux-$ConfigurationGroup-x64"
EXCLUDE_NET_TESTS="System.Net"
EXCLUDE_CRYPTO_TESTS="System.Security.Crypto"
exitCode=0

run-tests()
{
  for testProject in $@
  do
      if [[ ${testProject/${EXCLUDE_NET_TESTS}//} == $testProject ]]; then
	    echo "Ignore networking tests"
		continue
	  fi
      if [[ ${testProject/${EXCLUDE_CRYPTO_TESTS}//} == $testProject ]]; then
	    echo "Ignore crypto tests"
		continue
	  fi
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

run-tests "$ANYOS_ANYCPU_DEBUG/*.Tests"
run-tests "$LINUX_ANYCPU_DEBUG/*.Tests"
run-tests "$UNIX_ANYCPU_DEBUG/*.Tests"

exit $exitCode