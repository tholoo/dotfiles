if status is-interactive
    # Commands to run in interactive sessions can go here
    # ### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block
    function fish_user_key_bindings
        # fish_default_key_bindings
        # # Execute this once per mode that emacs bindings should be used in
        fish_default_key_bindings -M insert
        # Then execute the vi-bindings so they take precedence when there's a conflict.
        # Without --no-erase fish_vi_key_bindings will default to
        # resetting all bindings.
        # The argument specifies the initial mode (insert, "default" or visual).
        fish_vi_key_bindings --no-erase insert
    end
    set -g fish_vi_force_cursor 1


    if not set -q TMUX
        if tmux has-session -t terminal
            # exec tmux attach-session -t terminal
            exec tmux attach-session
        else
            tmux new-session -s terminal
        end
    end

    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source

    function fish_user_key_bindings
        bind -M insert \cn down-or-search
        bind -M insert \cp up-or-search
        bind -M insert -k nul accept-autosuggestion
    end
end

# System
set -x XDG_DATA_DIRS /usr/share /usr/local/share
set -x XDG_CONFIG_DIRS /etc/xdg

# User
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_DESKTOP_DIR $HOME/Desktop
set -x XDG_DOWNLOAD_DIR $HOME/Downloads
set -x XDG_DOCUMENTS_DIR $HOME/Documents
set -x XDG_MUSIC_DIR $HOME/Music
set -x XDG_PICTURES_DIR $HOME/Pictures
set -x XDG_VIDEOS_DIR $HOME/Videos

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/.local/share/cargo/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

### EXPORT ###
set fish_greeting # Suppresses fish's intro message
set TERM tmux-256color # Sets the terminal type
# set TERM xterm-256color
set EDITOR nvim # $EDITOR use Emacs in terminal
set SUDO_EDITOR nvim
set VISUAL nvim
set DIFFPROG "nvim -d"

### SET MANPAGER

### "nvim" as manpager
set -x MANPAGER "nvim +Man!"

### "less" as manpager
# set -x MANPAGER "less"



### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###

# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

# Function for org-agenda
function org-search -d "send a search string to org-mode"
    set -l output (/usr/bin/emacsclient -a "" -e "(message \"%s\" (mapconcat #'substring-no-properties \
        (mapcar #'org-link-display-format \
        (org-ql-query \
        :select #'org-get-heading \
        :from  (org-agenda-files) \
        :where (org-ql--query-string-to-sexp \"$argv\"))) \
        \"
    \"))")
    printf $output
end

### END OF FUNCTIONS ###


### abbrES ###
# navigation
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# abbr em '/usr/bin/emacs -nw'
# abbr emacs "emacsclient -c -a 'emacs'"
# abbr rem "killall emacs || echo 'Emacs server not running'; /usr/bin/emacs --daemon"

# Changing "ls" to "eza"
alias l='eza --color=auto --group-directories-first --git'
alias la='eza -la --color=auto --group-directories-first --git --git-ignore -I .venv -I __pycache__ -I .git'
alias ls=la
alias laa='eza -la --color=auto --group-directories-first'
alias ll='eza -l --color=auto --group-directories-first --git -I .venv -I __pycache__ -I .git'
alias lt='eza -l --tree --level=2 --color=auto --group-directories-first -I .venv -I __pycache__ -I .git'
alias ltt='eza -l --tree --color=auto --group-directories-first -I .venv -I __pycache__ -I .git'
alias lat='eza -la --tree --level=2 --color=auto --group-directories-first -I .venv -I __pycache__ -I .git'
alias latt='eza -la --tree --color=auto --group-directories-first -I .venv -I __pycache__ -I .git'
alias l.='eza -la | egrep "^\."'

# pacman and yay
# abbr pacsyu 'sudo pacman -Syu' # update only standard pkgs
# abbr pacsyyu 'sudo pacman -Syyu' # Refresh pkglist & update standard pkgs
# abbr parsua 'paru -Sua --noconfirm' # update only AUR pkgs (paru)
# abbr parsyu 'paru -Syu --noconfirm' # update standard pkgs and AUR pkgs (paru)
# abbr unlock 'sudo rm /var/lib/pacman/db.lck' # remove pacman lock
# abbr cleanup 'sudo pacman -Rns (pacman -Qtdq)' # remove orphaned packages (DANGEROUS!)

# get fastest mirrors
# abbr mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
# abbr mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
# abbr mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
# abbr mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

# adding flags
abbr df 'df -h' # human-readable sizes
abbr free 'free -m' # show sizes in MB

# ps
abbr psa "ps auxf"
abbr psgrep "ps aux | grep -v grep | grep -i -e VSZ -e"
abbr psmem 'ps auxf | sort -nr -k 4'
abbr pscpu 'ps auxf | sort -nr -k 3'

# Merge Xresources
abbr merge 'xrdb -merge ~/.Xresources'

# git
# abbr ga 'git add'
abbr gaa 'git add .'
abbr gb 'git branch'
abbr gco 'git checkout'
abbr gcl 'git clone'
abbr gc 'git commit -m'
abbr gf 'git fetch'
abbr pull 'git pull origin'
abbr push 'git push origin'
abbr gtag 'git tag'
abbr gnewtag 'git tag -a'
abbr gss 'git status -s'

# get error messages from journalctl
abbr jctl "journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
abbr gpg-check "gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
abbr gpg-retrieve "gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Play audio files in current dir by type
abbr playwav 'vlc *.wav'
abbr playogg 'vlc *.ogg'
abbr playmp3 'vlc *.mp3'

# Play video files in current dir by type
abbr playavi 'vlc *.avi'
abbr playmov 'vlc *.mov'
abbr playmp4 'vlc *.mp4'

# switch between shells
abbr tobash "sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
abbr tozsh "sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
abbr tofish "sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

function ask
    gh copilot suggest "$(read -l)"
end

function exp
    gh copilot explain "$(read -l)"
end

abbr reload source ~/.config/fish/config.fish
abbr fishr source ~/.config/fish/config.fish
abbr fishc nvim ~/.config/fish/config.fish

abbr restow "stow --restow --verbose --target ~"

abbr glog "git log --oneline --graph --decorate --all --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
abbr gcb "git checkout -b"

function dot
    set -l query (fdfind . ~/git/dotfiles/ -t f -H -E .git | fzf --layout reverse --preview "head {}")
    nvim "$query"
end

function mkcd
    mkdir $argv
    and cd $argv
end

function cheat.sh
    curl cheat.sh/$argv
end

# register completions (on-the-fly, non-cached, because the actual command won't be cached anyway
complete -c cheat.sh -xa '(curl -s cheat.sh/:list)'

# bare git repo alias for dotfiles
# alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# termbin
# alias tb="nc termbin.com 9999"

# the terminal rickroll
# alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
# colorscript random

fzf_configure_bindings --directory=\ct --variables=\e\cv

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

zoxide init fish | source
