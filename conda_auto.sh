#!/bin/bash

function _conda_auto_activate() {
  if [ -e "environment.yml" ]; then
    ENV="${"${"$(yq '.name' environment.yml)"%\"}"#\"}"

    # Check to see if already activated to avoid redundant activating
    if [[ $PATH == *"$ENV"* ]]; then
      echo "Conda env '$ENV' already activated."
    else
      conda activate "$ENV"
    fi
  fi
}

function chpwd() {
  _conda_auto_activate
}
