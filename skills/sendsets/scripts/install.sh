#!/bin/sh
set -eu

main() {
  installer_url=https://sendsetsapi.com/cli.sh
  checksum_url=https://sendsetsapi.com/cli.sh.sha256
  temp_dir=$(mktemp -d)
  trap 'rm -rf "$temp_dir"' 0 HUP INT TERM
  curl -fsSL "$installer_url" -o "$temp_dir/cli.sh"
  curl -fsSL "$checksum_url" -o "$temp_dir/cli.sh.sha256"
  expected=$(awk '{print $1}' "$temp_dir/cli.sh.sha256")
  if command -v sha256sum >/dev/null 2>&1; then
    actual=$(sha256sum "$temp_dir/cli.sh" | awk '{print $1}')
  else
    actual=$(shasum -a 256 "$temp_dir/cli.sh" | awk '{print $1}')
  fi
  if [ "$actual" != "$expected" ]; then
    printf '%s\n' 'Sendsets CLI installer checksum mismatch' >&2
    exit 1
  fi
  sh "$temp_dir/cli.sh" "$@"
}

main "$@"
