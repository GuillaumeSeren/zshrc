# ---------------------------------------------
# @author Guillaume Seren
# source  https://github.com/GuillaumeSeren/zshrc
# file    ~/.zshrc
# Licence GPLv3
#
# Global Zsh configuration file
# ---------------------------------------------

# ANTIGEN {{{1
# AutoCheck Antigen {{{2
if [ ! -f ~/.zsh/antigen/antigen.zsh ]; then
    echo " ** Antigen not found **"
    echo "Making ~/.zsh if it doesn't exist..."
    mkdir -p ~/.zsh/antigen/
    echo "Downloading antigen..."
    curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh \
        > ~/.zsh/antigen.zsh
fi

# Load antigen {{{2
source /home/gseren/.zsh/antigen/antigen.zsh
# Load the oh-my-zsh's library {{{2
antigen use oh-my-zsh

# Antigen bundle {{{2
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src
antigen bundle command-not-found
antigen bundle debian
antigen bundle git
antigen bundle git-extras
antigen bundle sudo
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle nmap
antigen bundle npm
antigen bundle bower
antigen bundle rsync

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Antigen Theme {{{2
# Load the theme.
# antigen theme robbyrussell
antigen theme agnoster

# Antigen Apply {{{2
# Tell antigen that you're done.
antigen apply

# Custom Aliases {{{1
source ~/.bashrc.alias
# Custom functions {{{1
source ~/.bashrc.function
# Dir_Colors {{{1
[ -f ~/.dir_colors ] && eval "$(dircolors ~/.dir_colors)"
# ZSH history {{{1
# export EDITOR='vim'

#@FIXME: Clean path management for nix {{{2
# User configuration
export PATH="/home/gseren/.nix-profile/bin:/home/gseren/.nix-profile/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

# Completion {{{2
autoload -U compinit
compinit
# Add bash completion support
autoload -U bashcompinit
bashcompinit
source /etc/bash_completion.d/git-extras

# zsh history {{{2
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY           # append rather than overwrite history file.
setopt EXTENDED_HISTORY         # save timestamp and runtime information
setopt HIST_EXPIRE_DUPS_FIRST   # allow dups, but expire old ones when I hit HISTSIZE
setopt HIST_FIND_NO_DUPS        # don't find duplicates in history
setopt HIST_IGNORE_ALL_DUPS     # ignore duplicate commands regardless of commands in between
setopt HIST_IGNORE_DUPS         # ignore duplicate commands
setopt HIST_REDUCE_BLANKS       # leave blanks out
setopt HIST_SAVE_NO_DUPS        # don't save duplicates
setopt INC_APPEND_HISTORY       # write after each command
setopt SHARE_HISTORY            # share history between sessions

# zsh super globs {{{2
setopt NO_CASE_GLOB             # case insensitive globbing
setopt NUMERIC_GLOB_SORT        # numeric glob sort
setopt extendedglob
unsetopt caseglob

# FZF {{{1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AutoStart Commands {{{1
# Let's throw a fortune to the user
fortune -a | cowsay
