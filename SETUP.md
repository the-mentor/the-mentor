# How this profile works

`README.md` is **generated**. Edit [`templates/README.md.tpl`](templates/README.md.tpl) instead —
a scheduled workflow renders it and commits the result back to `main`.

## Moving parts

| Piece | Where it comes from | Needs setup? |
| --- | --- | --- |
| Auto-updating activity lists (contributions, PRs, releases, stars) | [`muesli/readme-scribe`](https://github.com/muesli/readme-scribe) via `.github/workflows/readme-scribe.yml`, hourly | **Yes — a PAT** |
| Contribution-graph snake animation | [`Platane/snk`](https://github.com/Platane/snk) via `.github/workflows/snake.yml`, daily | No |
| Stats card | [github-readme-stats](https://github.com/anuraghazra/github-readme-stats) (hosted image URL) | No |
| Header banner | [capsule-render](https://github.com/kyechan99/capsule-render) (hosted image URL) | No |
| Social badges | [shields.io](https://shields.io) (hosted image URLs) | No |
| Blog / podcast lists | `rss` helper in the template (commented out) | Optional |

## Required one-time setup

1. **Create a classic Personal Access Token.**
   <https://github.com/settings/tokens> → *Generate new token (classic)* →
   scopes `public_repo` and `read:user` (add `read:org` if you want private-org
   activity counted). Copy the token.

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

- The scheduled runs only appear after this branch is merged to `main` —
  GitHub only schedules cron workflows from the default branch.
- Scheduled workflows are paused after 60 days of repo inactivity; the hourly
  commit from readme-scribe keeps the repo active, so this is self-sustaining.
- The three hosted image services (capsule-render, github-readme-stats,
  shields.io) are third-party. If you'd rather not depend on them, replace the
  banner with a PNG committed under `.github/` and drop the stats card.
- `.github/dependabot.yml` keeps the pinned action versions current.
