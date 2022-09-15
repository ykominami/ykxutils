#!/bin/bash
git_cmd="/usr/bin/git"
which git
ls ${git_cmd}
${git_cmd} diff-tree --name-only --format="" @{5}

