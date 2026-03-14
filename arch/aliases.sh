# obsidian
alias tedit="open obsidian://open?vault=.ted &"
alias tomtom="open obsidian://open?vault=TomtomsVault &"

#fzf
alias hf='eval "$(history | fzf --tac | cut -d" " -f4-)"'
alias zfd='eval "xdg-open $(fzf | xargs -0 dirname)s"'
alias rmvpkg='eval "sudo pacman -R $(pacman -Q | cut -d " " -f1 | fzf)"'

#general
alias install="sudo pacman -S"
alias update="sudo pacman -Syu"
alias remove="sudo pacman -R"
alias listpkgs="pacman -Q"

#ted
fted() {
    local selected
    selected=$(find $HOME/.ted/todos/ -name "*.md" | sed "s|^$HOME/.ted/||" | fzf --preview="bat --color=always $HOME/.ted/{}")

    
    if [[ -n "$selected" ]]; then
        echo "$HOME/.ted/$selected"
    fi
}

#tedtui
alias tedt='eval "tedtui $(fted)"' 
alias tt=tedtui

#zit
fzitls () {
find $HOME/.zit/ -type f -name "*.csv" ! -name "*subtask*" | xargs -I {} basename -s .csv {} | sort -r | fzf --preview="zit list -d {}" --preview-window=right:80% --border
}
fzitst () {
find $HOME/.zit/ -type f -name "*.csv" ! -name "*subtask*" | xargs -I {} basename -s .csv {} | sort -r | fzf --preview="zit status -d {}" --preview-window=right:80% --border
}
alias zitls="zit list"
alias zitst="zit status"
alias zlunch="zit lunch"
alias zstop="zit stop"
alias zstart="zit start"
alias zrm="zit remove"
alias zch="zit change"