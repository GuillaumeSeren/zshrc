# ---------------------------------------------
# @author Guillaume Seren
# source  https://github.com/GuillaumeSeren/zshrc
# file    ~/.zshrc
# Licence GPLv3
#
# Zsh configuration file
# antigen is the package manager.
# oh-my-zsh is a nice toolbox to look for ideas.
# I try to keep configuration simple and efficient.
# ---------------------------------------------

# ANTIGEN {{{1
# AutoCheck Antigen {{{2
if [ ! -f ~/.zsh/antigen/antigen.zsh ]; then
    echo " ** Antigen not found **"
    echo "Making ~/.zsh if it doesn't exist..."
    mkdir -p ~/.zsh/antigen/
    echo "Downloading antigen..."
    curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh \
        > ~/.zsh/antigen/antigen.zsh
fi

# Load antigen {{{2
#@FIXME: Maybe use some globals to store file names
[ -f ~/.zsh/antigen/antigen.zsh ] && source ~/.zsh/antigen/antigen.zsh

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

# Bindings {{{1
# Prevent ^S and ^Q doing XON/XOFF (mostly for Vim) {{{2
stty -ixon

# Custom Aliases {{{1
[ -f ~/.bashrc.alias ] && source ~/.bashrc.alias

# Custom functions {{{1
[ -f ~/.bashrc.function ] && source ~/.bashrc.function

# Dir_Colors {{{1
[ -f ~/.dir_colors ] && eval "$(dircolors ~/.dir_colors)"

# ZSH {{{1
# export EDITOR='vim'

# ZSH Completion {{{2
# autoload compinit && compinit
# You should load bashcompinit with -Uz, see:
# https://github.com/ndbroadbent/scm_breeze/issues/21
# autoload -Uz bashcompinit
# bashcompinit -i
autoload -U +X compinit && compinit
# autoload -U +X bashcompinit && bashcompinit

# BASH completion
# zstyle ':completion:*:*:git:*' script /etc/bash_completion.d/git-prompt
# zstyle ':completion:*:*:git:*' script /etc/bash_completion.d/git-extras

# config {{{2
# caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fuzzy (1-char tolerant)
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Custom auto-completion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Command specific tweaks 
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                               /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Quick change directories. "cd ..." => "cd ../.."; "cd ../..." => "cd ../../.."
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# Ignore the case
setopt no_case_glob


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
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY            # share history between sessions

# zsh super globs {{{2
setopt NO_CASE_GLOB             # case insensitive globbing
setopt NUMERIC_GLOB_SORT        # numeric glob sort
setopt extendedglob
unsetopt caseglob

# NixOs {{{1
#@FIXME: Clean path management for nix
# User configuration
export PATH="/home/gseren/.nix-profile/bin:/home/gseren/.nix-profile/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

# FZF {{{1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AutoStart Commands {{{1
# Let's throw a fortune to the user
fortune -a | cowsay
