#!/usr/bin/env bash
# Generate yaml for docker/cli reference docs
set -eu -o pipefail

GO=${GO:-"go"}

mkdir -p docs/yaml/gen

$GO build -o build/yaml-docs-generator github.com/docker/cli/docs/yaml
build/yaml-docs-generator --root "$(pwd)" --target "$(pwd)/docs/yaml/gen"
