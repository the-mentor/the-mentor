# Repository guide

Profile repository for `the-mentor`. `README.md` here renders as the GitHub
profile page.

## Commit and PR conventions

**Never mention Claude, Anthropic, AI assistance, or any model name in anything
committed to this repository.** This applies to:

- Commit messages — including `Co-Authored-By:` trailers and session links
- Pull request titles and bodies
- Issue titles and bodies
- Code comments, documentation, and generated output

Write commit messages as the repository owner would: describe the change and
why it was made, nothing about how it was produced.

Conventional-commit prefixes are in use (`feat:`, `fix:`, `docs:`, `chore:`,
`style:`, `security:`).

## Architecture

`README.md` is **generated output**. The source is `templates/README.md.tpl`,
rendered hourly by `.github/workflows/readme-scribe.yml`, which commits the
result back to `main`.

**Edit the template, never `README.md`.** A direct edit to `README.md` looks
like it worked and is silently overwritten at the top of the next hour. When
changing static content, update both files in the same commit — the template so
the change persists, `README.md` so the repository is consistent between runs.

### Workflows

| Workflow | Cadence | Produces |
| --- | --- | --- |
| `readme-scribe.yml` | hourly | `README.md` from the template |
| `snake.yml` | daily | contribution-graph SVGs on the orphan `snake` branch |
| `metrics.yml` | 6-hourly | `github-metrics.svg` |

Every image on the profile is an SVG committed in this repository. Nothing is
fetched from a third-party image host at render time, apart from shields.io
badges. Keep it that way: hosted image services disappear (the original stats
card broke when its shared Vercel deployment was paused by its owner).

## Supply chain

- **Pin every action to a full commit SHA**, with the version tag in a trailing
  comment. Dependabot updates both together.
- **A SHA pin is not enough for actions that run containers.** `readme-scribe`
  and `lowlighter/metrics` both execute Docker images; each is pinned by image
  digest in its workflow, with the resolution command in a comment. Action SHA,
  version and digest must move together.
- **Keep `PERSONAL_GITHUB_TOKEN` at `read:user` only.** It is passed to
  third-party containers on every run. `public_repo` is not a read-only scope —
  it grants write access to every public repository on the account. It has been
  verified that `read:user` alone is sufficient for every template function in
  use.

## Palette

Phosphor terminal, used across the banner, headings, snake and metrics card:

| Role | Hex |
| --- | --- |
| Background | `#050A05` |
| Hot | `#39FF14` |
| Mid | `#1FD10F` |
| Dim | `#0E7A0E` |

GitHub strips CSS from READMEs, so coloured headings are SVGs in
`.github/headings/`. Their alt text carries the original wording.
