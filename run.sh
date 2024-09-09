CONFIG_FILES=("clang-format" "tmux.conf" "aliases" "bash_profile" "bash_prompt" "bashrc" "exports" "functions" "inputrc" "gitconfig" "gitignore" "gitmsg" "proxy")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

function create_soft_link() {
  realfile=$1
  symlink=$2

  # if symbolic file exists, skip
  if [ -L "$symlink" ]; then
    return 0
  fi

  # if a real file exists, backup it first
  if [ -f "$symlink" ]; then
    mv "$symlink" "$symlink"_bak
  fi

  ln -s "${symlink}" "${realfile}"
  echo "Symlink: $symlink created"
}

function main() {
  for f in ${CONFIG_FILES[*]}; do
    files="${SCRIPT_DIR}/${f}"
    syms="${HOME}/.${f}"
    create_soft_link "${files}" "${syms}"
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

  # Ipython file configs
  create_soft_link "${SCRIPT_DIR}/ipython_config.py" "${HOME}/.ipython/profile_default/ipython_config.py"

  source ~/.bash_profile
}

main
