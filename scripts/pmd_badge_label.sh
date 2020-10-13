#!/bin/bash

FILE=$1

nboccurrences() {
    export PRIORITY=$1

    cat $2 | jq -r ' .files[].violations[]  |  select( .priority | tostring | contains(env.PRIORITY) ).priority ' \
        | wc -l \
        | xargs
}

BLOCKERS=$(nboccurrences 1 $FILE)
FATALS=$(nboccurrences 2 $FILE)
MAJORS=$(nboccurrences 3 $FILE)
MINORS=$(nboccurrences 4 $FILE)
INFOS=$(nboccurrences 5 $FILE)
DT=$( date )

echo "B:${BLOCKERS} F:${FATALS} M:${MAJORS} m:${MINORS} i:${INFOS} ($DT)"
