# ~/.bashrc

[[ $- != *i* ]] && return

[ -f "/home/jk/.ghcup/env" ] && source "/home/jk/.ghcup/env" # ghcup-env

export PATH="$PATH:$(find ~/.local/bin -type d -printf %p:%%:)"

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export TERM="xterm-256color"
export BROWSER="firefox"
export PAGER='bat'

export TERMCMD='alacritty'
#export GH_TOKEN='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'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export XMONAD_CONFIG_DIR="$XDG_CONFIG_HOME/xmonad"
export XMONAD_CACHE_DIR="$XDG_CACHE_HOME/xmonad"
export XMONAD_DATA_DIR="$XDG_DATA_HOME/xmonad"

export SUDO_COMMAND='sudo -E'
export SUDO_ASKPASS='rofi-pass'
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}"/gtk/gtk2rc
export GTK_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}"/gtk/gtkrc
export LESSHISTFILE="-"
export HISTCONTROL=ignoredups:erasedups
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/histfile
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}"/shell/inputrc
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}"/gnupg
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/cargo
export NPM_CONFIG_USERCONFIG="${XDG_DATA_HOME:-$HOME/.local/share}"/npm/npmrc
export npm_config_prefix="${XDG_DATA_HOME:-$HOME/.local/share}"/npm
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}"/go
export GOMODCACHE="${XDG_DATA_HOME:-$HOME/.local/share}"/go/mod
export XAUTHORITY="${XDG_DATA_HOME:-$HOME/.local/share}"/Xauthority
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/rustup

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'

shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s histappend
shopt -s expand_aliases
shopt -s checkwinsize

complete -c man which
complete -cf sudo

alias ls='exa -al --color=always --group-directories-first'
alias lsf="fc-list | awk -F':' '{print \$2}' | sort -u"

alias pci='sudo pacman -S'
alias pcu='sudo pacman -Syu'
alias pcq='sudo pacman -Q'
alias pcs='sudo pacman -Ss'
alias pcr='sudo pacman -R'
alias pcrr='sudo pacman -Rns'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

alias xmr='~/.local/bin/xmonad --recompile'
alias xms='~/.local/bin/xmonad --restart'
alias xxx='$EDITOR ~/.config/xmonad/xmonad.hs'
alias xb='$EDITOR ~/.config/xmobar/xmobar.hs'
alias sss='$EDITOR ~/.config/spectrwm/spectrwm.conf'
alias ssb='$EDITOR ~/.config/spectrwm/baraction.sh'
alias sb='stack build'
alias si='stack install'
alias xbr='cd ~/.config/xmobar && stack install && cd && xms'

alias eb='$EDITOR ~/.bashrc'
alias bb='source ~/.bashrc'
alias ex='$EDITOR ~/.xinitrc'
alias xr='$EDITOR ~/.Xresources'
alias mrg='xrdb -merge ~/.Xresources'

alias sx='startx'
alias tmk='tmux kill-session'
alias etm='nvim ~/.config/tmux/tmux.conf'

alias r='ranger_cd'
alias sr='sudo ranger --confdir=/home/jk/.config/ranger'

ranger_cd() {
	temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
	ranger --choosedir="$temp_file" -- "${@:-$PWD}"
	if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
		cd -- "$chosen_dir"
	fi
	rm -f -- "$temp_file"
}

eval "$(starship init bash)"


function fzf-kill-process () {
    ps -ef | fzf --multi | awk '{ print $2 }' | xargs kill
    zle clear-screen
}

function sc() {
	choice="$(find ~/.config -mindepth 1 -printf '%P\n' | fzf)"
	[ -f "$HOME/.config/$choice" ] && $EDITOR "$HOME/.config/$choice"
}

function se() {
	choice="$(find ~/.local/bin -mindepth 1 -printf '%P\n' | fzf)"
	[ -f "$HOME/.local/bin/$choice" ] && $EDITOR "$HOME/.local/bin/$choice"
}

(cat ~/.cache/wal/sequences &)
