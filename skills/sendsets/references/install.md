# CLI installation

Use `scripts/install.sh` on macOS or Linux. It downloads the published CLI installer and its checksum, checks it, then runs it. On Windows use `irm https://sendsetsapi.com/cli.ps1 | iex` in PowerShell. The CLI installer verifies the release archive against its published checksums before installing.

Confirm with `sendsets version`. The Unix binary defaults to `~/.local/bin/sendsets`; use that path if the current shell has not loaded the new PATH. A hosted workspace uses the default host. For self-hosted use `SENDSETS_HOST` or `--host`.

Run `scripts/doctor.sh` after authentication. It checks auth and calls `sendsets doctor --json`. A fresh workspace can report missing mailboxes or app connections. These are next actions, not evidence that the CLI install failed.

`assets/campaign.example.yaml` is an editable example for `sendsets run`. Check the current CLI help before adapting it to a customer campaign.
