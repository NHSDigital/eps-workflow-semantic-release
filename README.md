# eps-workflow-semantic-release

Workflows to handle semantic versioning, releases and changelog generation.

## Usage

### Tag Release

This workflow uses the semantic-release npm package to generate a new version tag, changelog, and github release for a repo.

#### Inputs

- `tagFormat`: Default `v${version}`. A template for the version tag.
- `semRelArgs`: Optional arguments to use when calling semantic-release

#### Example

To use this workflow in your repository, call it from another workflow file:

```yaml
name: Release

on:
  workflow_dispatch:

jobs:
  tag_release:
    uses: NHSDigital/eps-workflow-semantic-release/.github/workflows/tag-release.yml@1.0.0
```

#### Mechanics

When this workflow is called, it will clone this repository and install semantic release. Then, the calling repo is partial cloned (So only the `.git` directory is included). This allows the workflow lightweight access to the full git history and tags for the release process.

For semantic versioning to work correctly, commits against main must be properly formatted according to the convention defined in CONTRIBUTING.md.

It is recommended to use the pr_title_check workflow to enforce these conventions, and enforce squash commits on pull requests with a default message of the PR title on your repo.

### PR Title Check

This workflow checks that all pull requests have a title that matches the required format.

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

