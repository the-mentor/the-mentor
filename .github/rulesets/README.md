# Repository rulesets

Rulesets configured through the GitHub UI live only in GitHub's settings and are
invisible to the repository. These files keep the definitions in version control
so they can be reviewed, diffed, and reapplied to other repositories.

## `no-ai-attribution.json`

Rejects any push whose commits carry AI-assistant attribution. Evaluated
server-side before the push is accepted, so a violating commit never lands —
unlike a CI check, which only turns red after the fact and leaves a history
rewrite as the only remedy.

Three rules across two axes:

| Rule | Catches |
| --- | --- |
| `commit_message_pattern` | `Co-Authored-By: Claude`, `Claude-Session:`, an Anthropic address in the body |
| `commit_author_email_pattern` | `noreply@anthropic.com` as author |
| `committer_email_pattern` | `noreply@anthropic.com` as committer |

The email rules matter independently: a commit with a clean message but a
machine author is still rejected.

### Deliberately narrow

The message pattern targets attribution *forms*, not the word "claude". A commit
like `feat: link claude-boxlite in the intro` is legitimate and must still pass.
Do not broaden this to a bare word match.

### Bypass list is empty on purpose

Automation in this repository (`readme-scribe`, `metrics`, Dependabot) writes
commit messages that match none of these patterns, so it is unaffected. No
bypass actors are needed — which is what makes a ruleset workable here where
branch protection would not be: those workflows push to `main` directly and a
pull-request requirement would break them.

## Availability

**These rules do not work on personal accounts.** GitHub gates commit-metadata
restrictions to repositories owned by an organization on Team or Enterprise.
Applying this ruleset to a user-owned repository returns:

```
422  Invalid rule 'commit_message_pattern':
422  Invalid rule 'commit_author_email_pattern':
```

Verified against this repository on both axes: the message rule with both the
`regex` and `contains` operators, and the author-email rule on its own. It is
the metadata rule *family* that is unavailable, not any particular pattern.
Rulesets themselves work on a personal account — non-metadata rules such as
linear history or deletion protection apply normally. A profile README
must live in a user repository named after the account, so there is no way
around it here — this repository falls back to `.github/workflows/commit-policy.yml`
for detection and `.githooks/commit-msg` for local prevention.

Keep this definition for **organization-owned** repositories, where it works and
is strictly better than the fallback: it rejects the push instead of reporting
the violation after the commit has landed.

## Applying to a repository

```sh
gh api --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/OWNER/REPO/rulesets \
  --input .github/rulesets/no-ai-attribution.json
```

Verify, and list what is already configured:

```sh
gh api /repos/OWNER/REPO/rulesets
```

To remove one:

```sh
gh api --method DELETE /repos/OWNER/REPO/rulesets/RULESET_ID
```

### Notes

- `"enforcement": "active"` blocks. Use `"disabled"` to stage one without effect.
- `"include": ["~ALL"]` applies to every branch, so a violation is caught on a
  feature branch rather than at merge time.
- The pattern spells out case variants instead of using an inline `(?i)` flag,
  which the ruleset regex engine may not accept.
- Metadata rules like these may not be available on every plan. The API returns
  a clear error if not — read it rather than assuming the ruleset applied, and
  confirm with the list command above.
