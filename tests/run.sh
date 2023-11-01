#!/bin/bash
PYTHONPATH=..
PYWEBVIEW_LOG='debug'
PYTEST_OPTIONS='-s --disable-pytest-warnings -r w'

# cd "${0%/*}"
# rm -r __pycache__ || true

exitcode=0
pywebviewtest() {
  python3 -m pytest "$@" || exitcode=$?
}

# cd ..
echo Starting tests...
python3 -m pytest --collect-only -q | grep ^test_
for test in $(python3 -m pytest --collect-only -q | grep ^test_); do
echo $test
  pywebviewtest $test ${PYTEST_OPTIONS}
done

if [ $exitcode != 0 ]; then
  echo -e '\033[0;31mTEST FAILURES HAVE OCCURRED!\033[0m'
  exit 1
fi
