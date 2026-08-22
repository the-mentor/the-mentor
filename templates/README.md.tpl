<!--
  This file is the SOURCE for README.md.
  Edit this template, NOT README.md — the "Update README ✍️" workflow
  regenerates README.md from here every hour and commits the result.
  Template syntax: Go text/template, rendered by muesli/readme-scribe.
-->
<p align="center">
  <img src="https://raw.githubusercontent.com/the-mentor/the-mentor/main/.github/banner.svg" alt="Avri Chen-Roth — architect, tech lead, DevOps engineer" width="100%">
</p>
<p align="center">
  &nbsp;<a href="https://www.linkedin.com/in/avrichenroth/" target="_blank"><img alt="LinkedIn" src="https://img.shields.io/badge/LinkedIn-050A05?style=for-the-badge&logo=linkedin&logoColor=%2339FF14"></a>&nbsp;
  &nbsp;<a href="mailto:avri@avritech.com" target="_blank"><img alt="Email" src="https://img.shields.io/badge/Email-050A05?style=for-the-badge&logo=maildotru&logoColor=%2339FF14"></a>&nbsp;
</p>

<a href="https://github.com/the-mentor" target="_blank"><img align="right" width="420" src="https://raw.githubusercontent.com/the-mentor/the-mentor/main/github-metrics.svg" alt="GitHub Metrics"></a>
<br />

Hello 👋 I'm Avri — architect, tech lead and DevOps engineer. Yesterday's clever architecture is today's on-call rotation, so I plan accordingly 📟

<div align="center">
  <img align="center" alt="GitHub Contribution Snake" src="https://raw.githubusercontent.com/the-mentor/the-mentor/snake/github-contribution-grid-snake-dark.svg">
</div>

### Recent project contributions 🏗️

{{range recentContributions 5}}
- [{{.Repo.Name}}]({{.Repo.URL}}) ({{humanize .OccurredAt}})
  - {{.Repo.Description}}
{{- end}}

### Recent pull requests 🛠️

{{range recentPullRequests 5}}
- [{{.Title}}]({{.URL}}) on [{{.Repo.Name}}]({{.Repo.URL}}) ({{humanize .CreatedAt}})
{{- end}}

### Recent releases 📦️

{{range recentReleases 5}}
- [{{.Name}}]({{.URL}}) ([{{.LastRelease.TagName}}]({{.LastRelease.URL}}), {{humanize .LastRelease.PublishedAt}})
  - {{.Description}}
{{- end}}

### Recent starred projects ⭐️

{{range recentStars 5}}
- [{{.Repo.Name}}]({{.Repo.URL}}) ({{.Repo.Stargazers}})
  - {{.Repo.Description}}
{{- end}}

{{/*
  OPTIONAL SECTIONS — everything between these markers is a Go template comment,
  so it is completely inert until you delete the wrapper. Any RSS/Atom feed works.

  ### ✍️ Blog
  {{range rss "https://your-blog.example/index.xml" 5}}
  - [{{.Title}}]({{.URL}}) ({{humanize .PublishedAt}})
  {{- end}}

  ### 💖 Sponsors
  These awesome people sponsor me: {{range sponsors 5}}[{{.User.Login}}]({{.User.URL}}) {{end}}Thank you! ❤️
*/}}
