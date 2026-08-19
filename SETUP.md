# How this profile works

`README.md` is **generated**. Edit [`templates/README.md.tpl`](templates/README.md.tpl) instead —
a scheduled workflow renders it and commits the result back to `main`.

## Moving parts

| Piece | Where it comes from | Needs setup? |
| --- | --- | --- |
| Auto-updating activity lists (contributions, PRs, releases, stars) | [`muesli/readme-scribe`](https://github.com/muesli/readme-scribe) via `.github/workflows/readme-scribe.yml`, hourly | **Yes — a PAT** |
| Contribution-graph snake animation | [`Platane/snk`](https://github.com/Platane/snk) via `.github/workflows/snake.yml`, daily | No |
| Stats card | [`lowlighter/metrics`](https://github.com/lowlighter/metrics) via `.github/workflows/metrics.yml`, 6-hourly — renders `github-metrics.svg` into this repo | Reuses the same PAT |
| Header banner | [capsule-render](https://github.com/kyechan99/capsule-render) (hosted image URL) | No |
| Social badges | [shields.io](https://shields.io) (hosted image URLs) | No |
| Blog / podcast lists | `rss` helper in the template (commented out) | Optional |

## Required one-time setup

1. **Create a classic Personal Access Token.**
   <https://github.com/settings/tokens> → *Generate new token (classic)* →
   tick **`read:user` only**. Copy the token. Use a **classic** token — these
   are classic scope names, and markscribe reads the GraphQL API.

   markscribe's own docs ask for `repo:status` and `public_repo` as well, but
   those were verified unnecessary here: every function in use
   (`recentContributions`, `recentPullRequests`, `recentReleases`,
   `recentStars`) reads public data, which GraphQL serves to any authenticated
   token. Do not grant them. `public_repo` is **not** a read-only scope — it
   confers read/write on every public repository you own, and this token is
   handed to a third-party container on every hourly run.

   Add `read:org` only if you uncomment the `sponsors` block or want
   private-org activity counted.

   > The default `GITHUB_TOKEN` will **not** work here. The activity lists come
   > from the GitHub GraphQL API, which `GITHUB_TOKEN` is not permitted to read.

2. **Save it as a repo secret** named `PERSONAL_GITHUB_TOKEN`:
   Settings → Secrets and variables → Actions → *New repository secret*.

3. **Allow Actions to push.** Settings → Actions → General → Workflow permissions
   → *Read and write permissions*.

4. **Run both workflows once by hand** from the Actions tab (*Run workflow*) so
   you don't wait for the schedule.
   - `Generate snake animation 🐍` creates the orphan `snake` branch that holds
     the SVGs. Until it has run once, the snake image in the README is a broken
     link — that's expected.
   - `Update README ✍️` fills in the four activity sections.

5. **Fill in the `TODO:` lines and social links** in `templates/README.md.tpl`.

## Notes

- Cron workflows are only scheduled from the default branch, so keep this on
  `main`.
- Scheduled workflows are paused after 60 days of repo inactivity; the hourly
  commit from readme-scribe keeps the repo active, so this is self-sustaining.
- The remaining hosted image services (capsule-render, shields.io) are third-party. If you'd rather not depend on them, replace the
  banner with a PNG committed under `.github/` and drop the stats card.
- All actions are pinned to full commit SHAs, with the human-readable tag
  kept in a trailing comment. A tag like `v6` is mutable and can be repointed
  at new code by whoever owns the action; a SHA cannot. `.github/dependabot.yml`
  bumps both the SHA and the comment when a new release lands.
- The README step calls `markscribe` via `docker run` at a **pinned digest**
  rather than through the `muesli/readme-scribe` action. That action runs
  `docker://fribbledom/markscribe` untagged (`:latest`), so pinning its SHA
  would pin the wrapper while leaving the image that actually executes with
  your PAT mutable. `fribbledom/markscribe` has exactly one tag, last pushed
  2021-06-22, so there is no version stream to follow — the digest is the only
  stable reference. Dependabot cannot bump it; to move deliberately, run
  `curl -s https://hub.docker.com/v2/repositories/fribbledom/markscribe/tags/latest`
  and compare.
