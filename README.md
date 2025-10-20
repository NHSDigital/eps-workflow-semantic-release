# eps-workflow-semantic-release

Workflows to handle semantic versioning, releases and changelog generation.

## Usage

### Tag Release

This workflow uses the semantic-release npm package to generate a new version tag, changelog, and github release for a repo.

#### Inputs

- `dry_run`: Whether to run in dry_run mode (do not create tags) or not
- `tagFormat`: Default `v\\${version}`. A template for the version tag.
- `branch_name`: The branch name to base the release on
- `publish_package`: Default false. If true, semantic-release will publish npm package.
- `asdfVersion`: Override the version of asdf to install.

#### Outputs

- `version_tag`: The version tag created by semantic-release.
- `change_set_version`: A timestamped string that con be used for creating changesets.

#### Example

To use this workflow in your repository, call it from another workflow file:

```yaml
name: Release

on:
  workflow_dispatch:

jobs:
  tag_release:
    uses: NHSDigital/eps-workflow-semantic-release/.github/workflows/tag-release.yml@1.0.0
  with:
    tagFormat: "v\\${version}-beta"
    dry_run: true
    asdfVersion: 0.18.0
    branch_name: main
    publish_package: false
```

#### Mechanics

`tag-release.yml` uses asdf to install node, then install semantic-release and its dependencies globally using npm. This leaves `~/.asdf` as a directory containing semantic-release and its dependencies, which is uploaded as a workflow artifact.

`npm` packages are installed globally by first extracting their versions from `package.json` using `jq`. This is to allow dependabot to keep the versions up to date.

The `tag_release` job will fetch this artifact, unzip it, setup `PATH` to use asdf, then call semantic-release.

### PR Title Check

This workflow checks that all pull requests have a title that matches the required format, and comments on the PR with a link to the relevant ticket if a ticket reference is found.

#### Example

To use this workflow in your repository, call it from another workflow file:

```yaml
name: Pull Request

on:
  pull_request:
    branches: [main]

jobs:
  pr_title_format_check:
    uses: NHSDigital/eps-workflow-semantic-release/.github/workflows/pr_title_check.yml@1.0.0
```
