if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U ANDROID_HOME $HOME/Library/Android/sdk


#fish_add_path $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
source /opt/homebrew/opt/asdf/libexec/asdf.fish
fish_add_path "/Users/bo/Library/Application Support/JetBrains/Toolbox/scripts"
fish_add_path ./node_modules/.bin

abbr -a fd "fd -H"
abbr -a pa pnpm add $argv
abbr -a pn pnpm
abbr -a pi pnpm i
alias vim nvim
alias v nvim
alias ccat bat
alias awk gawk
zoxide init --cmd cd fish | source
#mcfly init fish | source

alias vimfish "vim ~/.config/fish/config.fish && source ~/.config/fish/config.fish && echo '✨fish config reloaded ✨'"
alias ip "curl -s ipinfo.io | jq -r '\"\(.ip) — \(.city), \(.country) — \(.org)\"'"
alias hassio "ssh hassio@homeassistant.local"
alias tower "ssh root@192.168.0.118"

alias y yazi
#alias l yazi

alias ls='lsd'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


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

