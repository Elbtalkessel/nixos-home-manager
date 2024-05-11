#!/usr/env/bin bash

set -e

# Calls `home-manager switch` and `hyprctl reload`.
# For some reason Hyprland doesn't autoreload on configuration change.
home-manager switch
hyprctl reload
exit 0
