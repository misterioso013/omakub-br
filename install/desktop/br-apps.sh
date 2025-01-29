#!/bin/bash

# Cores para as mensagens
C_RESET='\033[0m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_CYAN='\033[1;36m'

echo -e "${C_CYAN}=== Apps para Devs e Gamers Brasileiros ===${C_RESET}\n"

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

# Mídia e Entretenimento
echo -e "${C_CYAN}=== Mídia e Entretenimento ===${C_RESET}"

# qBittorrent
if ask_yes_no "Deseja instalar o qBittorrent (cliente torrent)?"; then
    echo -e "\n${C_YELLOW}Instalando qBittorrent...${C_RESET}"
    sudo apt install -y qbittorrent
fi

# Stremio
if ask_yes_no "Deseja instalar o Stremio (streaming de mídia)?"; then
    echo -e "\n${C_YELLOW}Instalando Stremio...${C_RESET}"
    flatpak install -y flathub com.stremio.Stremio
fi

# Plex Media Player
if ask_yes_no "Deseja instalar o Plex Media Player?"; then
    echo -e "\n${C_YELLOW}Instalando Plex...${C_RESET}"
    flatpak install -y flathub tv.plex.PlexDesktop
fi

# Gaming
echo -e "\n${C_CYAN}=== Gaming ===${C_RESET}"

# Lutris (para jogos Windows)
if ask_yes_no "Deseja instalar o Lutris (para rodar jogos Windows)?"; then
    echo -e "\n${C_YELLOW}Instalando Lutris...${C_RESET}"
    sudo add-apt-repository -y ppa:lutris-team/lutris
    sudo apt update
    sudo apt install -y lutris
fi

# Heroic Games Launcher (Epic Games e GOG)
if ask_yes_no "Deseja instalar o Heroic Games Launcher (Epic Games e GOG)?"; then
    echo -e "\n${C_YELLOW}Instalando Heroic Games Launcher...${C_RESET}"
    flatpak install -y flathub com.heroicgameslauncher.hgl
fi

# MangoHud (monitoramento de performance em jogos)
if ask_yes_no "Deseja instalar o MangoHud (monitoramento de performance em jogos)?"; then
    echo -e "\n${C_YELLOW}Instalando MangoHud...${C_RESET}"
    sudo apt install -y mangohud
fi

# Discord
if ask_yes_no "Deseja instalar o Discord?"; then
    echo -e "\n${C_YELLOW}Instalando Discord...${C_RESET}"
    flatpak install -y flathub com.discordapp.Discord
fi

# Streaming
echo -e "\n${C_CYAN}=== Streaming ===${C_RESET}"

# OBS Studio
if ask_yes_no "Deseja instalar o OBS Studio (para streaming)?"; then
    echo -e "\n${C_YELLOW}Instalando OBS Studio...${C_RESET}"
    flatpak install -y flathub com.obsproject.Studio
fi

# Desenvolvimento
echo -e "\n${C_CYAN}=== Desenvolvimento ===${C_RESET}"

# Insomnia (alternativa ao Postman)
if ask_yes_no "Deseja instalar o Insomnia (cliente REST)?"; then
    echo -e "\n${C_YELLOW}Instalando Insomnia...${C_RESET}"
    flatpak install -y flathub rest.insomnia.Insomnia
fi

# DBeaver (gerenciador de banco de dados)
if ask_yes_no "Deseja instalar o DBeaver (gerenciador de BD)?"; then
    echo -e "\n${C_YELLOW}Instalando DBeaver...${C_RESET}"
    flatpak install -y flathub io.dbeaver.DBeaverCommunity
fi

echo -e "\n${C_GREEN}✓ Instalação dos aplicativos concluída!${C_RESET}"