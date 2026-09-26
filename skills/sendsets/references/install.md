# CLI installation

On macOS or Linux, download https://sendsetsapi.com/cli.sh and https://sendsetsapi.com/cli.sh.sha256 into one directory, check the installer with `shasum -a 256 -c cli.sh.sha256` (or `sha256sum -c cli.sh.sha256`), and run `sh cli.sh` only if the check passes. On Windows, download https://sendsetsapi.com/cli.ps1 and run it with `powershell -ExecutionPolicy Bypass -File cli.ps1`. The CLI installer verifies the release archive against its published checksums before installing.

Confirm with `sendsets version`. The Unix binary defaults to `~/.local/bin/sendsets`; use that path if the current shell has not loaded the new PATH. A hosted workspace uses the default host. For self-hosted use `SENDSETS_HOST` or `--host`.

Run `scripts/doctor.sh` after authentication. It checks auth and calls `sendsets doctor --json`. A fresh workspace can report missing mailboxes or app connections. These are next actions, not evidence that the CLI install failed.

`assets/campaign.example.yaml` is an editable example for `sendsets run`. Check the current CLI help before adapting it to a customer campaign.
