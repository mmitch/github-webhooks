#!/bin/sh

grep_shebang()
{
    grep -nm1 "$@" | grep sh:1: | cut -d: -f 1
}

STATUS=0

for SCRIPT in $(grep_shebang /bin/sh *.sh); do
    if ! sh -n "$SCRIPT"; then
	STATUS=1
	echo "sh: error in $SCRIPT"
    else
	echo "$SCRIPT syntax OK"
    fi
done

for SCRIPT in $(grep_shebang /bin/bash *.sh); do
    if ! bash -n "$SCRIPT"; then
	STATUS=1
	echo "bash: error in $SCRIPT"
    else
	echo "$SCRIPT syntax OK"
    fi
done

for SCRIPT in *.pl; do
    if ! perl -c "$SCRIPT"; then
	STATUS=1
	echo "perl: error in $SCRIPT"
    fi
done

exit $STATUS
