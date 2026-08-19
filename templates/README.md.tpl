<!--
  This file is the SOURCE for README.md.
  Edit this template, NOT README.md — the "Update README ✍️" workflow
  regenerates README.md from here every hour and commits the result.
  Template syntax: Go text/template, rendered by muesli/readme-scribe.
-->
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:58a6ff,100:f778ba&height=200&section=header&text=the-mentor&fontColor=ffffff&fontSize=70&fontAlignY=38&animation=fadeIn" alt="header">
</p>
<p align="center">
  &nbsp;<a href="https://www.linkedin.com/in/YOUR-LINKEDIN/" target="_blank"><img alt="LinkedIn" src="https://img.shields.io/badge/LinkedIn-1667be?style=for-the-badge&logo=linkedin&logoColor=%23ffffff"></a>&nbsp;
  &nbsp;<a href="mailto:YOUR@EMAIL" target="_blank"><img alt="Email" src="https://img.shields.io/badge/Email-8b949e?style=for-the-badge&logo=maildotru&logoColor=%23ffffff"></a>&nbsp;
</p>

<a href="https://github.com/the-mentor" target="_blank"><img align="right" src="https://github-readme-stats.vercel.app/api?username=the-mentor&show_icons=true&show=reviews,discussions_started,discussions_answered,prs_merged&include_all_commits=true&bg_color=0E1117&title_color=f778ba&icon_color=58a6ff&text_color=c5c8c6&ring_color=39d353&border_radius=8" alt="GitHub Stats"></a>
<br />

Hello 👋 I'm Avri — TODO: write two or three lines about yourself here.

TODO: link the projects you want people to find, e.g. [a thing I built](https://github.com/the-mentor/something) 🧑‍💻

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
