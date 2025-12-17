#!/bin/bash

updated_date_pattern="^updated\s?=\s?([0-9-]{8,10})$"
date_pattern="^date\s?=\s?([0-9-]{8,10})$"

for file in $@; do
    desired_updated_date=$(date -r $file +%Y-%m-%d)

    if grep -q -E "$updated_date_pattern" $file; then
        actual_updated_date=$(grep -m 1 -Po "^updated\s?=\s?\K([0-9-]{8,10})$" $file)

        if [[ $actual_updated_date == $desired_updated_date ]]; then
            echo "No changes in: $file"
            continue
        fi

        echo "Updating the updated date from: $actual_updated_date to: $desired_updated_date in: $file"

        sed -i -E "0,/$updated_date_pattern/s/$updated_date_pattern/updated = $desired_updated_date/" $file
    elif grep -q -E "$date_pattern" $file; then
        actual_date=$(grep -m 1 -Po "^date\s?=\s?\K([0-9-]{8,10})$" $file)

        echo "Adding the updated date: $desired_updated_date to the next line of the date: $actual_date in: $file"

        sed -i -E "0,/$date_pattern/s//&\nupdated = $desired_updated_date/" $file
    else
        echo "No changes in: $file"
    fi
done
