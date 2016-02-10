---
title: Update all outdated packages in NPM
date: 2016-02-07
template: post.hbt
---

I wanted to install all outdated packages in an npm package and then save that specific version to the package.json. So I created a quick bash command to run to do it.

```bash
npm outdated | sed '1d;$d' | awk '{print $5"@"$4}' | xargs npm install --save
```
