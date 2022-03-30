#!/usr/bin/env bash

set -euo pipefail

echo "args:"
echo "$@"
echo ""

path=$(pwd)/sentry-cli/$(printf "%s/" "$@")
mkdir -p "$path"

if [[ $# -eq 0 ]] ; then
  sentry-cli --version > $(pwd)/sentry-cli/_version
  sentry-cli --help > $(pwd)/sentry-cli/help.txt
fi

subcommands=$(sentry-cli "$@" --help | sed -n '/SUBCOMMANDS:/,$p' | tail -n +2 | cut -d' ' -f5)

for scmd in ${subcommands}; do
	if [ "$scmd" = "help" ]; then
		echo "Skipping 'help' sub-command..."
		continue
	fi

	echo "${path}${scmd}"
	mkdir -p "${path}/${scmd}"
	echo "sentry-cli ${scmd} --help > ${path}/${scmd}/help.txt"
	sentry-cli "$@" "${scmd}" --help > "${path}/${scmd}/help.txt"
	./crawl.sh "$@" "${scmd}"
done
