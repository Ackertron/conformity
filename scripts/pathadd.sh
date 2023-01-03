#!/bin/bash

function pathadd {
  PATH=:$PATH
  export PATH=$1${PATH//:$1:/:}
}
