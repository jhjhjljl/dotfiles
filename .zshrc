alias website='ssh root@68.183.193.100'
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jihoonlee/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
PROMPT='%~ %% '
if [ -z "$TMUX" ]; then
    tmux attach || tmux
fi
