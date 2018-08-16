# Vim mode
bindkey -v

# Don't take 0.4s to change modes
export KEYTIMEOUT=1

# Save previous RPROMPT to restore when vim status not displayed
RPROMPT_PREVIOUS=$RPROMPT

# Default color settings
if [ -z "$VIMTO_COLOR_NORMAL_TEXT" ]; then VIMTO_COLOR_NORMAL_TEXT=black; fi
if [ -z "$VIMTO_COLOR_NORMAL_BACKGROUND" ]; then VIMTO_COLOR_NORMAL_BACKGROUND=white; fi

function zle-keymap-select zle-line-init {
	# If it's not tmux then can use normal sequences
	if [[ -z "${TMUX}" ]]; then
		local vicmd_seq="\e[2 q"
		local viins_seq="\e[0 q"
	else
		# In tmux, escape sequences to pass to terminal need to be
		# surrounded in a DSC sequence and double-escaped:
		# ESC P tmux; {text} ESC \
		# <http://linsam.homelinux.com/tmux/tmuxcodes.pdf>
		local vicmd_seq="\ePtmux;\e\e[2 q\e\\"
		local viins_seq="\ePtmux;\e\e[0 q\e\\"
	fi

	# Command mode
	if [ $KEYMAP = vicmd ]; then
		echo -ne $vicmd_seq
		RPROMPT_PREVIOUS=$RPROMPT
		RPROMPT=$'%K{$VIMTO_COLOR_NORMAL_BACKGROUND} %F{$VIMTO_COLOR_NORMAL_TEXT}NORMAL%f %k'
	# Insert mode
	else
		echo -ne $viins_seq
		RPROMPT=$RPROMPT_PREVIOUS
	fi
	zle reset-prompt
}

function accept-line-clear-rprompt {
    export RPROMPT=$RPROMPT_PREVIOUS
    zle reset-prompt
    zle accept-line
}

zle -N accept-line-clear-rprompt
# Hook enter being pressed whilst in cmd mode
bindkey -M vicmd "^M" accept-line-clear-rprompt

# Change appearance
zle -N zle-keymap-select  # When vi mode changes
zle -N zle-line-init      # When a new line starts

# Fix backspace not working after returning from cmd mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char 

# Re-enable incremental search from emacs mode (it's useful)
bindkey '^r' history-incremental-search-backward

# Need to initially clear RPROMPT for it to work on first prompt
export RPROMPT=$RPROMPT_PREVIOUS
