#!/bin/bash

CC="clang"

[[ -z "which ${CC}" ]] && echo "GCC is not installed. Exiting..." && exit 1
