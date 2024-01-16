# XDG compliant shell configuration, for a clean home dir
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR="$HOME/.local/run"
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

#export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials                       
#export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config 

# export HISTFILE="${XDG_STATE_HOME}"/bash/history

#export CARGO_HOME="$XDG_DATA_HOME"/cargo
#
#export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
#
#export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
#
#export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
#
#export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
#
#export NVM_DIR="$XDG_DATA_HOME"/nvm
#
export ZSH="$XDG_DATA_HOME"/oh-my-zsh

# export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME"/zsh/history

export ZDOTDIR="$HOME"/.config/zsh


# export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-interactive-cd tmux zsh-bat you-should-use colored-man-pages zsh-vi-mode fzf history-substring-search)

fpath=(~/.zsh.d/ $fpath)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

export ZVM_VI_EDITOR='nvim'
ZVM_INIT_MODE=sourcing

export PATH=$HOME/bin:/usr/local/bin:$PATH:
# export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true


export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR='nvim'
export DIFFPROG='nvim -d'

export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

export nvm_dir="$home/.nvm"
[ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh"  # this loads nvm
[ -s "$nvm_dir/bash_completion" ] && \. "$nvm_dir/bash_completion"  # this loads nvm bash_completion
source ~/.nvm/nvm.sh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

# THEME
eval "$(starship init zsh)"
# bindkey -v
# export keytimeout=1
#
# cursor_mode() {
#     # see https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
#     cursor_block='\e[2 q'
#     cursor_beam='\e[6 q'
#
#     function zle-keymap-select {
#         if [[ ${keymap} == vicmd ]] ||
#             [[ $1 = 'block' ]]; then
#             echo -ne $cursor_block
#         elif [[ ${keymap} == main ]] ||
#             [[ ${keymap} == viins ]] ||
#             [[ ${keymap} = '' ]] ||
#             [[ $1 = 'beam' ]]; then
#             echo -ne $cursor_beam
#         fi
#     }
#
#     zle-line-init() {
#         echo -ne $cursor_beam
#     }
#
#     zle -n zle-keymap-select
#     zle -n zle-line-init
# }
#
# cursor_mode
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

if [ -x "$(command -v lsd)" ]; then
    alias ls="lsd"
    alias la="lsd -al"
    alias lst="lsd --tree --depth=2 -I .venv -I __pycache__"
    alias lstt="lsd --tree -I .venv -I __pycache__"
    alias lat="lsd -al --tree --depth=2 -I .venv -I __pycache__"
    alias latt="lsd -al --tree -I .venv -I __pycache__"
fi

if [ -x "$(command -v bat)" ]; then
    alias cat="bat -p"
fi

if (( $+commands[tmux] )); then
  alias tn='tmux new-session -s "$(basename "$PWD")"'
  if ! tmux has-session -t terminal 2>/dev/null; then
    # Create a new session named 'terminal' detached (-d)
    tmux new-session -s terminal
  fi
fi

# if [ -x "$(command -v python3)" ]; then
    # alias python="python3"
    # alias pip="pip3"
# fi

# set PATH so it includes user's private bin if it exists
PATH="$HOME/.local/bin:$PATH"
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -x "$(command -v gh)" ]; then
    alias "?"="gh copilot suggest"
    alias "??"="gh copilot explain"
fi


if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
  
  zi_command() {
    zi
  }

  zle -N zi_command

  bindkey '^f' zi_command
  # function zi_shortcut() {
  #   local dir=$(zoxide query --interactive)
  #   if [ -n "$dir" ]; then
  #       cd "$dir"
  #   fi
    # cd "$(zoxide query --interactive)"
  # }
  # zi_shortcut () {
  #   "$(zoxide query --interactive)"
  # }
  # zle -N zi_shortcut
  # bindkey '^f' zi_shortcut
  # bindkey '^f' "$(zi)"
fi

bindkey '^ ' autosuggest-accept
bindkey '^H' backward-kill-word
# bindkey "\C-H" "\C-w" 


function fuzzy_sheets () {
  '/home/tholo/git/fuzzy-sheets/chtfzf.sh'
}
zle -N fuzzy_sheets
bindkey '^|' fuzzy_sheets
# bindkey '<right>' autosuggest-forward-word
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if []; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#export PATH="$path:/home/tholo/.local/bin"
export DENO_INSTALL="/home/tholo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# neofetch
