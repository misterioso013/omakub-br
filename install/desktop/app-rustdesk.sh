#!/bin/bash

echo "Instalando RustDesk..."

# Instalação via Flatpak
flatpak install -y flathub com.rustdesk.RustDesk

# Verificando se o sistema está usando Wayland e ajustando configurações se necessário
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    echo "Detectado ambiente Wayland..."

    # Verificando e ajustando a configuração do GDM para X11 (necessário para acesso à tela de login)
    if [ -f "/etc/gdm3/custom.conf" ]; then
        CONFIG_FILE="/etc/gdm3/custom.conf"
    elif [ -f "/etc/gdm/custom.conf" ]; then
        CONFIG_FILE="/etc/gdm/custom.conf"
    fi

    if [ ! -z "$CONFIG_FILE" ]; then
        echo "Configurando GDM para suportar acesso à tela de login..."
        # Faz backup do arquivo de configuração
        sudo cp "$CONFIG_FILE" "$CONFIG_FILE.backup"
        # Habilita X11 para a tela de login
        sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/' "$CONFIG_FILE"
        echo "Configuração do GDM atualizada. Recomenda-se reiniciar o sistema para aplicar as alterações."
    fi
fi

echo "RustDesk instalado com sucesso!"
echo "Você pode encontrá-lo no menu de aplicativos ou executar 'flatpak run com.rustdesk.RustDesk'"