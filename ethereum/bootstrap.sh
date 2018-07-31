#!/bin/sh

current_dir=`dirname $0`;
scripts_dir="$current_dir/scripts";

source "$scripts_dir/env.sh";
source "$scripts_dir/func.sh";

bootstrap "$@"
