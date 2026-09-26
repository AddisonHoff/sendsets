# Replies

Use `sendsets inbox list --json` and `sendsets inbox read THREAD_ID --json` to inspect conversations. Draft a response in the voice the user requested and preserve the original sending mailbox. Show the recipient, thread, and exact text before a real reply unless the user has already authorized that specific send.

`sendsets inbox reply` puts real mail on the wire. Agent policy may require an approval URL. A recipient's reply should stop the cold sequence; check campaign status if that did not happen. Respect removal requests and suppression rather than writing another follow-up.
