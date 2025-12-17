#!/bin/bash

# --- Setup ---

target_script="update_zola_post_updated_date.sh"
target_script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/${target_script}"

# --- Define run_test ---

run_test() {
    local test_name="$1"
    local initial_content="$2"
    local expected_content="$3"

    local temp_file=$(mktemp test_XXXXXX.md)
    echo -e "$initial_content" > "$temp_file"

    echo "Running: $test_name..."

    if [[ -f "$target_script_path" ]]; then
        bash "$target_script_path" "$temp_file"
    else
        echo "Error: $target_script_path not found."
        rm "$temp_file"
        return 1
    fi

    local actual_content=$(sed -zn 's/\n/\\n/g;$s/\\n$//p' "$temp_file")

    if [[ "$actual_content" == "$expected_content" ]]; then
        echo -e "✅ PASS\n"
        result=0
    else
        echo "❌ FAIL"
        echo "   Expected: [$expected_content]"
        echo "   Actual:   [$actual_content]"
        echo ""
        result=1
    fi

    rm "$temp_file"
    return $result
}

# --- Predefined test case ---

date=$(date +%Y-%m-%d)

test_case_1=("TwoUpdated" "+++\ntitle = TwoUpdated\nupdated = 2025-01-01\nupdated = 2025-01-01\n+++" "+++\ntitle = TwoUpdated\nupdated = ${date}\nupdated = 2025-01-01\n+++")
test_case_2=("NoUpdatedTwoDate" "+++\ntitle = NoUpdatedTwoDate\ndate = 2025-01-01\ndate = 2025-01-01\n+++" "+++\ntitle = NoUpdatedTwoDate\ndate = 2025-01-01\nupdated = ${date}\ndate = 2025-01-01\n+++")
test_case_3=("NoUpdatedNoDate" "+++\ntitle = NoUpdatedNoDate\n+++" "+++\ntitle = NoUpdatedNoDate\n+++")

test_cases=("test_case_1" "test_case_2" "test_case_3")

# --- Execution ---

total_failed=0

for test_case_name in "${test_cases[@]}"; do
    declare -n test_case="$test_case_name"
    run_test "${test_case[0]}" "${test_case[1]}" "${test_case[2]}" || ((total_failed++))
done

if [ $total_failed -eq 0 ]; then
    echo "All tests passed successfully!"
    exit 0
else
    echo "$total_failed test(s) failed."
    exit 1
fi
