#!/bin/bash

echo "Instalando ProtonVPN..."

# Download do pacote de repositório
wget -q https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.6_all.deb

# Instalação do repositório e atualização
sudo dpkg -i ./protonvpn-stable-release_1.0.6_all.deb
sudo apt update

# Instalação do ProtonVPN
sudo apt install -y proton-vpn-gnome-desktop

# Instalação do suporte a ícone de bandeja do sistema
sudo apt install -y libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator

# Limpeza do arquivo .deb
rm ./protonvpn-stable-release_1.0.6_all.deb

echo "ProtonVPN instalado com sucesso!"
echo "Você pode encontrá-lo no menu de aplicativos ou executar 'protonvpn' no terminal."