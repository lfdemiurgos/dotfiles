alias ls='lsd'
alias cat='bat'
alias tree='ls --tree --depth 3'
alias py='python'
alias hx='helix'
alias gs='git status'
alias get-token='echo $GIT_TOKEN | wl-copy'
alias fetch='pfetch'

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        command rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        command rm -f "$cmd_file"
        return "$code"
    fi
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}

zstyle ':completion:*:*:git:*' script ~/.config/shell/completion/git-completion.bash
fpath=(~/.config/shell/completion $fpath)

autoload -Uz add-zsh-hook compinit
add-zsh-hook -Uz chpwd chpwd-osc7-pwd
compinit
