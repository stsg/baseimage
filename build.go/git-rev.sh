#!/bin/bash

# parse git revision without .git/object

# .git/HEAD with linke like "ref: refs/heads/master"
head_full=$(cat .git/HEAD)
head_full_elems=(${head_full//:/ })
ref=${head_full_elems[1]}

# get last elements from ref value, i.e. "refs/heads/master"
head_short=(${head_full_elems[1]//// })
head=${head_short[@]: -1:1}

# get hash
full_hash=$(cat .git/$ref)
short_hash=${full_hash:0:7}

# get time stamp
log=$(tail -n1 .git/logs/$ref)
log_elems=(${log// / })

e=${log_elems[3]}
if [[ ${e:0:1} == "<" ]]; then
    ts=$(date -d "@${log_elems[4]}" +'%Y%m%dT%H:%M:%S')
fi

e=${log_elems[4]}
if [[ ${e:0:1} == "<" ]]; then
    ts=$(date -d "@${log_elems[5]}" +'%Y%m%dT%H:%M:%S')
fi

echo "$head"-"$short_hash"-"$ts"
