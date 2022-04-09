zmodload zsh/mapfile

# Check to make sure OS is supported by this .zshrc
# =================================================
if [[ "$OSTYPE" != "linux-gnu" ]]; then
	echo "Unsupported environment..."
	exit 1
fi

# Add user bin to path if it exists
# =================================================
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# Initialise brew if exists or install
# =================================================
BREW_HOME=${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}
if [ ! -d "$BREW_HOME" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$($BREW_HOME/bin/brew shellenv)"

# Update environment if necesary
# =================================================
last_update_file="$HOME/.zsh/last_update_time"

function update {
	echo "Apt..."
	sudo apt update && sudo apt upgrade
	if [ -f "$HOME/.zsh/apt_packages" ]; then
		apt_packages=("${(f)$(< $HOME/.zsh/apt_packages)}")
		for package in ${apt_packages[@]}; do
			echo "Checking $package..."
			dpkg -S $package &> /dev/null || sudo apt install "$package"
		done
	fi

	echo "Brew..."
	brew update && brew upgrade
	if [ -f "$HOME/.zsh/brew_packages" ]; then
		echo "Brew packages..."
		brew_packages=("${(f)$(< $HOME/.zsh/brew_packages)}")
		for package in ${brew_packages[@]}; do
			echo "Checking $package..."
			$(brew list | grep "fzf" > /dev/null) || brew install "$package"
		done
	fi
}

function update_if_outdated {
	outdated_date=$(date --date "7 days ago" +'%s')
	last_check_time=$outdated_date
	if test -f "$last_update_file"; then
		last_check_time=$(head -n 1 $last_update_file)
	fi
	[ $last_check_time -le $outdated_date ] && (
		echo "Updating environment..."
		update
	)
}

function create_update_file {
	echo $(date +%s) >"$last_update_file"
}

update_if_outdated && create_update_file

# =========================
export STARSHIP_CONFIG=~"$HOME/.zsh/starship.toml" # Terminal
eval "$(starship init zsh)"

# Plugin Manager
# =========================
source $BREW_HOME/share/antigen/antigen.zsh
antigen use oh-my-zsh

## Plugins
## ========================
antigen bundle git                               # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
antigen bundle command-not-found                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
antigen bundle common-aliases                    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
antigen bundle docker                            # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
antigen bundle autojump                          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/autojump
antigen bundle vscode                            # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
antigen bundle 1password                         # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/1password
antigen bundle fzf                               # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
antigen bundle zsh-users/zsh-autosuggestions     # https://github.com/zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions         # https://github.com/zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
antigen apply
