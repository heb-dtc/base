#!/bin/bash

state=$(mpc | grep playing| wc -l)

# 0 is stopped
# 1 is playing

if [[ $state = 1 ]]; then
	mpc pause >> /dev/null
else
	mpc play >> /dev/null
fi
exit 0
