# github-history-editor


## Introduction
Anyone who looks at your github history will know that this is clearly fake,
however I thought it would be a fun script to write

This will add one to five commits to your branch each weekday from six months ago to now.

Make sure to enable `Include private contributions on my profile`
in your `Contributions on My Profile` section of your preferences
if this is run on a private repo.

This has to be run on the main/master branch!
```bash
./github-history-editor.sh
git push --force
```

