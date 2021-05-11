#!/usr/bin/env bash
# Generate man pages for docker/cli
set -eu -o pipefail

GO=${GO:-"go"}

mkdir -p ./man/man1

if ! command -v go-md2man &> /dev/null; then
	echo "=== building go-md2man"
	# yay, go install creates a binary named "v2" ¯\_(ツ)_/¯
	$GO build -o "/go/bin/go-md2man" ./vendor/github.com/cpuguy83/go-md2man/v2
fi

# Generate man pages from cobra commands
echo "=== generate manpages"
$GO build -o /tmp/gen-manpages github.com/docker/cli/man
/tmp/gen-manpages --root "$(pwd)" --target "$(pwd)/man/man1"

echo "=== running legacy manpage build"
# Generate legacy pages from markdown
./man/md2man-all.sh -q
