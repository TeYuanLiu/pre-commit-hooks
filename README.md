# pre-commit-hook

## update-zola-post-updated-date

A Zola post usually has the "date" metadata in its front matter to indicate the post creation date. It can also has the "updated" metadata to specify the post updated date. This hook looks at each markdown file that is neither README.md nor _index.md, and then adds or updates the "updated" metadata of the file based on its modification date.

### How to use

1.  Add the following to your `.pre-commit-config.yaml`.
    ```yaml
    -   repo: https://github.com/teyuanliu/pre-commit-hook
        rev: v1.0.0
        hooks:
        -   id: update-zola-post-updated-date
    ```
1.  Install the hook.
    ```bash
    pre-commit install
    ```
1.  Run.
    ```bash
    pre-commit run
    ```
1.  Here is an example output when a file modification occurred.
    ```bash
    update-zola-post-updated-date............................................Failed
    - hook id: update-zola-post-updated-date
    - files were modified by this hook

    Adding the updated date: 2025-12-31 to the next line of the date: 2025-01-01 in: example.md
    ```
1.  Well done!
