#!/bin/sh

while : ; do
	mpc idle >/dev/null && kill -41 $(pidof dwmblocks) || break
done
