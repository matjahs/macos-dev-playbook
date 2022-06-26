#!/usr/bin/env bash

if xcode-select --install > /dev/null 2>&1; then
    sleep 1
    osascript <<EOD
tell application "System Events"
    tell process "Install Command Line Developer Tools"
        keystroke return
        click button "Agree" of window "License Agreement"
    end tell
end tell
EOD
fi

if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v git &>/dev/null; then
    brew install git &>/dev/null
fi

if ! command -v ansible &>/dev/null; then
    brew install ansible  &>/dev/null
fi

git clone https://github.com/matjahs/dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles" || exit 1
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml --ask-become-pass

# printf "\tinstalling ansible-lint...\t\t\t"
# if ! command -v ansible-lint &>/dev/null; then
#     brew install ansible-lint
# fi
# printf "%s\n" "$(ansible-lint --version)"
# brew_install ansible-lint

# printf "\tinstalling pyenv...\t\t\t"
# if ! command -v pyenv &>/dev/null; then
#     brew install pyenv
#     # shellcheck disable=SC2016
#     {
#         echo 'export PYENV_ROOT="$HOME/.pyenv"'
#         echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'
#         echo 'eval "$(pyenv init -)"'
#     } >>"$HOME/.zshrc"
#     # shellcheck source=/Users/matjah/.zshrc
#     . "$HOME/.zshrc"
# fi
# printf "%s\n" "$(pyenv --version)"

# printf "\tinstalling pyenv-virtualenv...\t\t"
# if ! command -v pyenv-virtualenv &>/dev/null; then
#     brew install pyenv-virtualenv
#     # shellcheck disable=SC2016
#     echo 'eval "$(pyenv virtualenv-init -)"' >>"$HOME/.zshrc"
#     # shellcheck source=/Users/matjah/.zshrc
#     . "$HOME/.zshrc"
# fi

# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# printf "\tinstalling python 3.10.4...\t\t"
# pyenv install "$PY_VERSION" --skip-existing >/dev/null
# pyenv global "$PY_VERSION" >/dev/null
# printf "done\n"

# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# printf "%s\n" "$(pyenv virtualenv --version)"
# if [ ! -d "$HOME/.pyenv/versions/default_env" ]; then
#     pyenv virtualenv "$PY_VERSION" default_env
# fi
# pyenv activate default_env >/dev/null

# printf "\tinstalling pipx...\t\t\t"
# if ! command -v pipx &>/dev/null; then
#     brew install pipx
#     pipx ensurepath
# fi
# printf "%s\n" "$(pipx --version)"
# export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/shims/python3"

# # printf "\tinstalling poetry...\t\t\t"
# # if [ ! -d "$HOME/.poetry" ]; then
# #     curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# # fi
# # export PATH="$PATH:$HOME/.poetry/bin"
# # printf "%s\n" "$(poetry --version)"

# # printf "\tcloning xxenv-latest...\t\t\t"
# # if [ ! -d "$(pyenv root)"/plugins/pyenv-install-latest ]; then
# #     git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest
# # fi
# # printf "done\n"



# pyenv activate default_env
# printf "\tinstalling ansible...\t\t\t"
# if ! command -v ansible &>/dev/null; then
#     pipx install ansible --pip-args=--quiet >/dev/null
# fi
# printf "%s\n" "$(ansible --version)"

# # printf "\tupdating brew...\t\t\t"
# # brew update >/dev/null
# # printf "done\n"

# # printf "\tupdating poetry...\t\t\t"
# # # shellcheck disable=SC1091
# # source "$HOME/.poetry/env"
# # poetry self update &>/dev/null
# # printf "done\n"

echo -e "done"
