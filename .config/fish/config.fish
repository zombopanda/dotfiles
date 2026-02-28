if status is-interactive
    # sesh — tmux session picker (Ctrl+T from shell)
    function _sesh_connect
        set session (
            sesh list --icons | fzf --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
                --header '  ^a all  ^t tmux  ^g configs  ^x zoxide  ^d kill  ^f find' \
                --bind 'tab:down,btab:up' \
                --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
                --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
                --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
                --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
                --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
                --bind 'ctrl-d:execute(tmux kill-session -t {2..})+reload(sesh list --icons)' \
                --preview 'sesh preview {}'
        )
        if test -n "$session"
            sesh connect $session
        end
        commandline -f repaint
    end
    bind \ct _sesh_connect
end

set -gx CLAUDE_CODE_DISABLE_AUTO_MEMORY 0

set -gx ANDROID_HOME $HOME/Library/Android/sdk

#fish_add_path $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
source /opt/homebrew/opt/asdf/libexec/asdf.fish
fish_add_path "/Users/bo/Library/Application Support/JetBrains/Toolbox/scripts"


abbr -a fd "fd -H"
abbr -a pa "pnpm add"
abbr -a pn pnpm
abbr -a pi "pnpm i"
alias vim nvim
alias v nvim
alias ccat bat
alias awk gawk

function a
    if test (count $argv) -eq 0
        command agent-deck
    else
        command agent-deck session attach $argv[1]
    end
end

zoxide init --cmd cd fish | source

alias vimfish "vim ~/.config/fish/config.fish; source ~/.config/fish/config.fish; echo '✨fish config reloaded ✨'"
alias vimbrew "vim ~/.config/brewfile/Brewfile"
alias ip "curl -s ipinfo.io | jq -r '\"\(.ip) — \(.city), \(.country) — \(.org)\"'"
alias hassio "ssh hassio@homeassistant.local"
alias tower "ssh root@192.168.0.118"

alias y yazi

alias ls lsd
alias l 'ls -l'
alias ll 'ls -l'
alias la 'ls -a'
alias lla 'ls -la'
alias lt 'ls --tree'


# tools to see who's using the port
function port
    if test (count $argv) -eq 0
        echo "Usage: port [PORT]"
        return 1
    end
    lsof -i :$argv[1]
end

function killport
    if test (count $argv) -eq 0
        echo "Usage: killport [PORT]"
        return 1
    end
    set pid (lsof -t -i :$argv[1])
    if test -n "$pid"
        echo "Killing PID $pid on port $argv[1]"
        kill -9 $pid
    else
        echo "No process found on port $argv[1]"
    end
end

thefuck --alias | source

# pnpm
set -gx PNPM_HOME "/Users/bo/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by Antigravity
fish_add_path /Users/bo/.antigravity/antigravity/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/bo/.lmstudio/bin
# End of LM Studio CLI section

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
