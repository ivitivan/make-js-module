#!/usr/bin/env bash

if [ -z "$1" ]
then
  echo "No arguments supplied. A module name should be supplied"
  exit 1
fi

if [ "$1" = "--help" ]
then
  echo "Usage: make-js-module [FILE]
Create a directory with index.js, moduleName.js, and moduleName.test.js.

  -h, --help                 display this help and exit
"
  exit
fi

mkdir ./$1
echo 'function '$1'() {
  return
}

module.exports = {
  '$1',
}' > ./$1/$1.js
echo "module.exports = require('./$1')" > ./$1/index.js
echo "const test = require('tape')
const {"$1"} = require('./"$1"')

test('"$1"', (t) => {
  t.plan(1)

  const expected = ''
  const actual = "$1"()

  t.deepEqual(actual, expected)
})" > ./$1/$1.test.js
