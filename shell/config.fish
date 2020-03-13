abbr -a l 'ls -la'
abbr -a ll 'ls -la'

# Git-specific abbreviations
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gc 'git checkout'

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/bin /bin

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

