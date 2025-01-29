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

# Função para perguntar sim/não
ask_yes_no() {
    while true; do
        read -p "$1 (s/n): " yn
        case $yn in
            [Ss]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Por favor, responda com 's' ou 'n'.";;
        esac
    done
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

# Oferecer instalação do ProtonVPN
echo -e "${C_RED}=== Recomendação de Segurança ===${C_RESET}"
echo -e "Devido às restrições de acesso em alguns países, incluindo o Brasil,"
echo -e "é recomendado utilizar uma VPN para garantir acesso livre e seguro.\n"

if ask_yes_no "Deseja instalar o ProtonVPN agora?"; then
    show_spinner "Instalando ProtonVPN" &
    SPINNER_PID=$!

    # Download e instalação do ProtonVPN
    wget -q https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.6_all.deb
    sudo dpkg -i ./protonvpn-stable-release_1.0.6_all.deb >/dev/null 2>&1
    sudo apt update >/dev/null 2>&1
    sudo apt install -y proton-vpn-gnome-desktop >/dev/null 2>&1
    sudo apt install -y libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator >/dev/null 2>&1
    rm ./protonvpn-stable-release_1.0.6_all.deb

    kill_spinner $SPINNER_PID
    echo -e "${C_GREEN}✓${C_RESET}"

    echo -e "\n${C_YELLOW}⚠️  Configure o ProtonVPN antes de continuar:${C_RESET}"
    echo -e "1. Abra o ProtonVPN no menu de aplicativos"
    echo -e "2. Faça login ou crie uma conta gratuita em https://protonvpn.com"
    echo -e "3. Conecte-se a um servidor VPN"
    read -p "Pressione ENTER após configurar e conectar o ProtonVPN para continuar..."
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

# Verificando branch (usando master como padrão)
if [[ $OMAKUB_REF != "master" && ! -z "$OMAKUB_REF" ]]; then
    cd ~/.local/share/omakub
    show_spinner "Configurando versão ${OMAKUB_REF}" &
    SPINNER_PID=$!
    git fetch origin "${OMAKUB_REF}" && git checkout "${OMAKUB_REF}" >/dev/null 2>&1
    kill_spinner $SPINNER_PID
    echo -e "${C_GREEN}✓${C_RESET}"
    cd - > /dev/null
fi

echo -e "\n${C_GREEN}🚀 Tudo pronto! Iniciando instalação...${C_RESET}\n"
source ~/.local/share/omakub/install.sh
