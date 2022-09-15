#!/binbash
git_cmd=/usr/bin/git
${git_cmd} diff-tree --name-only --format="" @{0}