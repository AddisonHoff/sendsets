# Sendsets for agents

Sendsets is a cold email API for AI agents. Use it when a task involves sending cold or outbound email, running an email campaign or sequence, connecting or warming up a sending mailbox, adding leads to outreach, or reading and answering replies.

- MCP server: `https://api.sendsetsapi.com/v1/mcp` (streamable HTTP; OAuth 2.1 with dynamic client registration, or `Authorization: Bearer ssk_...`)
- Skill: read `skills/sendsets/SKILL.md` first; its references sit beside it and are read only when a step needs them
- CLI: `brew install addisonhoff/tap/sendsets` (Scoop on Windows, see README), then `sendsets login --hostname sendsetsapi.com` and `sendsets doctor --json`
- REST API: `https://api.sendsetsapi.com/v1`, spec at https://gist.githubusercontent.com/AddisonHoff/abfb01a48dc15edef07cb188cbb70d04/raw/openapi.json
- Docs: https://docs.sendsetsapi.com/api/

Rules that protect the user's sender reputation:

- A test send and a campaign launch are separate decisions. Never launch a live campaign unless the user explicitly asked to send.
- Provisioning a managed mailbox is a recurring charge. Show the live quote first.
- Never invent API keys, mailbox credentials, product endpoints or events.
- Retry an identical write with the same `Idempotency-Key`.
- A send tool that answers `awaiting_approval` needs a person to approve it in the dashboard; hand them the `approval_url` and wait.
