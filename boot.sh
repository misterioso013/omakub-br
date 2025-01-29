#!/bin/bash

# Cores
C_RESET='\033[0m'
C_BLUE='\033[1;34m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_RED='\033[1;31m'
C_CYAN='\033[1;36m'

# Arte ASCII colorida
ascii_art="${C_BLUE}
________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__  \ |  |/ /  |  \ __ \\
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \\
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/${C_RESET}"

# Função para exibir mensagem com spinner
show_spinner() {
    local message="$1"
    local delay=0.1
    local spinstr='|/-\'
    printf "${C_CYAN}%s...${C_RESET} " "$message"
    while true; do
        local temp=${spinstr#?}
        printf "[%c]" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b"
    done
}

# Função para matar o spinner
kill_spinner() {
    kill $1 > /dev/null 2>&1
}

clear
echo -e "$ascii_art"
echo -e "\n${C_YELLOW}=> Omakub-BR: Personalize seu Ubuntu 24.04 com estilo!${C_RESET}"
echo -e "${C_GREEN}=> Baseado no Omakub da Basecamp e adaptado para a comunidade brasileira${C_RESET}"
echo -e "\n${C_CYAN}Iniciando instalação...${C_RESET}\n"

# Verificações iniciais
if [ "$(id -u)" = 0 ]; then
    echo -e "${C_RED}⚠️  Não execute este script como root/sudo!${C_RESET}"
    exit 1
fi

if ! command -v git &> /dev/null; then
    show_spinner "Instalando dependências necessárias" &
    SPINNER_PID=$!
    sudo apt-get update >/dev/null 2>&1
    sudo apt-get install -y git >/dev/null 2>&1
    kill_spinner $SPINNER_PID
    echo -e "${C_GREEN}✓${C_RESET}"
fi

# Clonando o repositório
echo -e "\n${C_CYAN}Preparando ambiente...${C_RESET}"
rm -rf ~/.local/share/omakub
show_spinner "Clonando repositório" &
SPINNER_PID=$!
git clone https://github.com/misterioso013/omakub-br.git ~/.local/share/omakub >/dev/null 2>&1
kill_spinner $SPINNER_PID
echo -e "${C_GREEN}✓${C_RESET}"

# Verificando branch
if [[ $OMAKUB_REF != "master" ]]; then
    cd ~/.local/share/omakub
    show_spinner "Configurando versão ${OMAKUB_REF:-stable}" &
    SPINNER_PID=$!
    git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}" >/dev/null 2>&1
    kill_spinner $SPINNER_PID
    echo -e "${C_GREEN}✓${C_RESET}"
    cd - > /dev/null
fi

echo -e "\n${C_GREEN}🚀 Tudo pronto! Iniciando instalação...${C_RESET}\n"
source ~/.local/share/omakub/install.sh
