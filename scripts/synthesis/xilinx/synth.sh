#!/bin/sh

## Clean old compilation results
## Keep the reports only

export toplevel=$1

export ROOT_DIR=`echo $PWD | awk -F"/scripts" '{print $1}'`
echo "root dir is $ROOT_DIR"
export scr_dir=$PWD
export synth_dir=$ROOT_DIR/backend/synthesis/$toplevel

mkdir -p $synth_dir
cd $synth_dir

echo "script directory is $scr_dir"

xst -ifn $scr_dir/settings.xst -ofn $toplevel".srp"
