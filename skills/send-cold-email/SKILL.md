---
name: send-cold-email
description: Send cold email and run outbound email campaigns from an agent with Sendsets. Connect or check sending mailboxes, turn a lead list (CSV or inline) into a multi-step email sequence with follow-ups, validate merge fields, send a test, launch, and read and answer replies. Use when the user asks to send cold emails, email a list of prospects or leads, run an outreach or outbound sequence, or follow up with contacts by email.
---

# Send cold email with Sendsets

Sendsets is a cold email API for agents. Work through the Sendsets MCP tools when they are connected (`list_mailboxes`, `create_campaign_draft`, `add_campaign_step`, `add_contact`, `start_campaign`, `list_threads`, `send_reply`, ...). Otherwise use the `sendsets` CLI with `--json`. Both act on the same workspace.

Not connected yet? Pick one:

- MCP: `claude mcp add --transport http sendsets https://api.sendsetsapi.com/v1/mcp` (OAuth sign-in in the browser; other clients use the same URL)
- CLI: download https://sendsetsapi.com/cli.sh and https://sendsetsapi.com/cli.sh.sha256, check the SHA-256 matches (`shasum -a 256 -c cli.sh.sha256`), run `sh cli.sh`, then `sendsets login` (it prints a code and URL for the user to approve) and `sendsets doctor --json`

A new workspace is free for up to 10 mailboxes: https://app.sendsetsapi.com/auth/register

## 1. Senders

`sendsets mailbox list --json`. With no mailbox, connect one:

- Gmail or Google Workspace: the user creates an app password at https://myaccount.google.com/apppasswords, then `sendsets mailbox add --provider gmail --email ADDRESS --smtp-pass APP_PASSWORD`
- Microsoft 365: `sendsets mailbox add --provider outlook` prints a consent link for the user
- Anything else: `sendsets mailbox add --provider smtp_imap` with the host, port and password the user gives you

Never guess credentials. A fresh mailbox should warm up first (`sendsets mailbox warmup enable MAILBOX_ID`) and start around 10 to 20 cold emails a day.

## 2. The campaign

Write a run file (see `assets/campaign.yaml`) and create it as a draft; nothing sends:

```bash
sendsets campaign import campaign.yaml --dry-run --wait --json
```

- Leads come from `csv: leads.csv` (columns `email`, `first_name`, `last_name`, `company`, `phone`; any other column becomes a custom field) or an inline `leads:` list
- Merge fields are `{{.FirstName}}`, `{{.Company}}`, custom fields as `{{.key}}`; give fallbacks with `{{.FirstName | default "there"}}`. Spintax uses single braces: `{Hi|Hey}`
- The mailbox signature and the opt-out footer are appended automatically. Do not write a sign-off or an unsubscribe line
- A `type: wait` step spaces follow-ups; `stop_on_reply: true` ends the sequence for anyone who answers
- `daily_limit` is per mailbox across all campaigns

Then `sendsets campaign validate CAMPAIGN_ID --json` and `sendsets campaign preflight CAMPAIGN_ID --json`. Fix `campaign_variable_missing` and `campaign_variable_incomplete` before going further: a blank field sends as a gap.

## 3. Test, then launch

Show the user the rendered first email and who receives it. A test is real mail, so ask before it: `sendsets campaign test CAMPAIGN_ID --prospect EMAIL --wait`.

Launch only when the user explicitly asked to send: `sendsets campaign start CAMPAIGN_ID --yes`. An answer of `awaiting_approval` carries an `approval_url` for the user to open; `plan_required` means the workspace needs a plan under Settings > Billing, not a new sign-in.

## 4. Replies

`sendsets inbox list --json`, `sendsets inbox read THREAD_ID --json`. Draft in the user's voice and show the exact text before `sendsets inbox reply`. Honor removal requests; suppressed addresses are skipped automatically.

## Rules

- A test send and a launch are separate decisions
- Do not raise sending limits because the list is large; add mailboxes instead
- If bounces or complaints rise, stop the campaign and report the mailbox state
- Retry an identical write with the same idempotency key

More: the `sendsets` skill (product-led campaign ideas) and `sendsets-cli` (full command reference) in https://github.com/AddisonHoff/sendsets, docs at https://docs.sendsetsapi.com/api/
