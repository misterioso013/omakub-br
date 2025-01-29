#!/bin/bash

echo "Instalando JetBrains Toolbox..."

TMP_DIR="/tmp"
INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
SYMLINK_DIR="$HOME/.local/bin"

echo "Buscando a URL da última versão..."
ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')
ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

echo "Baixando $ARCHIVE_FILENAME..."
rm "$TMP_DIR/$ARCHIVE_FILENAME" 2>/dev/null || true
wget -q --progress=bar:force 2>&1 -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

echo "Extraindo para $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
rm "$INSTALL_DIR/jetbrains-toolbox" 2>/dev/null || true
tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
rm "$TMP_DIR/$ARCHIVE_FILENAME"
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

echo "Criando link simbólico em $SYMLINK_DIR/jetbrains-toolbox..."
mkdir -p $SYMLINK_DIR
rm "$SYMLINK_DIR/jetbrains-toolbox" 2>/dev/null || true
ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

if [ -z "$CI" ]; then
    echo "Iniciando pela primeira vez para configuração..."
    ( "$INSTALL_DIR/jetbrains-toolbox" & )
    echo -e "\nPronto! O JetBrains Toolbox está em execução e disponível na sua lista de aplicativos."
    echo "Você também pode executá-lo no terminal usando o comando 'jetbrains-toolbox'"
else
    echo -e "\nInstalação concluída! Executando em um ambiente CI - pulando a inicialização do AppImage."
fi