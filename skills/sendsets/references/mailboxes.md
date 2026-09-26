# Mailboxes

Use `sendsets mailbox list --json` and `sendsets mailbox health MAILBOX_ID --json` to inspect existing senders. Gmail and Google Workspace connect with a Google app password the user creates at https://myaccount.google.com/apppasswords: `sendsets mailbox add --provider gmail --email ADDRESS --smtp-pass APP_PASSWORD` (Google sign-in is not used for sending mailboxes). `sendsets mailbox add --provider outlook` prints a Microsoft consent link for the user. SMTP/IMAP needs supplied credentials; never guess them.

For managed accounts, read `sendsets mailbox provision providers --json`, then `sendsets mailbox provision quote --help` and request a live quote. Show the provider, domain, recurring price, any tenant or domain cost, and what will be ordered. Provision only after the user accepts that exact quote. A quote can expire; re-quote instead of assuming an old price still applies.

Use `sendsets mailbox test MAILBOX_ID --json` before assigning a sender to a campaign. If a managed renewal needs action, surface its fix rather than retrying blindly.
