CONFIG_FILES=("clang-format" "tmux.conf" "aliases" "bash_profile" "bash_prompt" "bashrc" "bash_completion" "exports" "functions" "inputrc" "gitconfig" "gitignore" "gitmsg" "proxy" )
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function create_soft_link() {
    destfile=$1
    dotfile=$2

    # if symbolic file exists, delete it first
    if [ -L "$dotfile" ]; then
        rm -f "$dotfile"
    fi

    # if real file exists, backup it
    if [ -f "$dotfile" ]; then
        mv "$dotfile" "$dotfile"_bak
    fi

    ln -s "${destfile}" "${dotfile}"
}

function main() {
    for f in ${CONFIG_FILES[*]}; do
        dst_file="${SCRIPT_DIR}/${f}"
        dot_file="${HOME}/.${f}"
        create_soft_link "${dst_file}" "${dot_file}"
    done

    if [[ $(uname -a) == *"microsoft"* ]]; then
        username=$(cmd.exe /c echo %username% | sed -e "s/\r//g")
        echo "WSL environment, user is ${username}"

        user_home="/mnt/c/Users/${username}"
        terminal_path="${user_home}/AppData/Roaming/alacritty/"
        ssh_path="${user_home}/.ssh"

        if [ ! -d "${ssh_path}" ]; then
            echo "Start to copy ssh configs to ${ssh_path}"
            cp -fr "${HOME}/.ssh" "${ssh_path}"
        fi

        echo "Start to copy terminal configs to ${terminal_path}"
        cp -f alacritty.toml "${terminal_path}"
    fi

    source ~/.bash_profile
}

main
