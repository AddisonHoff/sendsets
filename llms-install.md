# Installing the Sendsets MCP server

Sendsets is a hosted (remote) MCP server. There is nothing to build or run locally.

- URL: `https://api.sendsetsapi.com/v1/mcp`
- Transport: streamable HTTP
- Auth: OAuth 2.1 (clients that support MCP OAuth open a browser sign-in), or a static API key sent as `Authorization: Bearer ssk_...`

## Steps

1. Ask the user for a Sendsets API key. They create one in the dashboard at https://app.sendsetsapi.com under Settings > API keys (sign up free at https://app.sendsetsapi.com/auth/register). Keys start with `ssk_`. Never invent one.
2. Add this entry to the MCP settings file (for Cline, `cline_mcp_settings.json`), replacing the key:

```json
{
  "mcpServers": {
    "sendsets": {
      "type": "streamableHttp",
      "url": "https://api.sendsetsapi.com/v1/mcp",
      "headers": { "Authorization": "Bearer ssk_REPLACE_ME" },
      "disabled": false
    }
  }
}
```

3. Confirm the connection by calling the `list_mailboxes` tool. An empty list is fine for a new workspace.

If the client supports MCP OAuth, the `headers` block can be left out and the user signs in through the browser instead.

## Using it safely

- Send tools (`start_campaign`, `compose_email`, `send_reply`) can return `awaiting_approval` with an `approval_url`. Give that URL to the user and wait.
- Do not start a live campaign unless the user explicitly asked to send.
- The skill in `skills/send-cold-email/SKILL.md` walks through a full campaign.
