#!/usr/bin/env bash
cd "$(dirname "$0")"
export base="$(pwd)"
source ./scriptdata/lib/environment-variables.sh
source ./scriptdata/lib/functions.sh
source ./scriptdata/lib/package-installers.sh
source ./scriptdata/lib/options.sh

prevent_sudo_or_root
set -e

#####################################################################################
# For uninstall script
  if [[ "${EXPERIMENTAL_UNINSTALL_SCRIPT}" = true ]]; then
    source ./scriptdata/exp/uninstall.sh
    exit
  fi
#####################################################################################
# 0. Before we start
if [[ "${SKIP_ALLGREETING}" != true ]]; then
  source ./scriptdata/step/0.install-greeting.sh
fi
#####################################################################################
if [[ "${SKIP_ALLDEPS}" != true ]]; then
  printf "${STY_CYAN}[$0]: 1. Install dependencies\n${STY_RST}"
  source ./scriptdata/step/1.install-deps-selector.sh
fi
#####################################################################################
if [[ "${SKIP_ALLSETUPS}" != true ]]; then
  printf "${STY_CYAN}[$0]: 2. Setup for permissions/services etc\n${STY_RST}"
  source ./scriptdata/step/2.install-setups-selector.sh
fi
#####################################################################################
if [[ "${SKIP_ALLFILES}" != true ]]; then
  printf "${STY_CYAN}[$0]: 3. Copying config files\n${STY_RST}"
  if [[ "${EXPERIMENTAL_FILES_SCRIPT}" != true ]]; then
    source ./scriptdata/step/3.install-files.sh
  else
    source ./scriptdata/step/3.install-files.experimental.sh
  fi
fi
