# pre-commit-hook

## update-zola-post-updated-date

This hook updates or adds the "updated = YYYY-MM-DD" metadata of a staged .md file based on its modification date.

### How to use

1.  Add the following to your `.pre-commit-config.yaml`.
    ```yaml
    -   repo: https://github.com/teyuanliu/pre-commit-hook
        rev: main
        hooks:
        -   id: update-zola-post-updated-date
    ```
1.  Install the hook.
    ```bash
    pre-commit install
    ```
1.  Run.
    ```
    pre-commit run
    ```
