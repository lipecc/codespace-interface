#!/bin/bash

set -e

echo "[1/7] Atualizando pacotes..."
sudo apt update -y
sudo apt upgrade -y

echo "[2/7] Instalando LXDE + utilitários..."
sudo apt install -y lxde-core lxterminal leafpad

echo "[3/7] Instalando Xvfb e x11vnc..."
sudo apt install -y xvfb x11vnc xdotool

echo "[4/7] Criando senha do VNC..."
mkdir -p ~/.vnc
x11vnc -storepasswd "123456" ~/.vnc/passwd

echo "[5/7] Instalando navegador CLI (w3m)..."
sudo apt install -y w3m

echo "[6/7] Instalando Chromium headless (sem interface)..."
sudo apt install -y chromium-browser || sudo apt install -y chromium

echo "[7/7] Criando script para iniciar ambiente gráfico..."

cat << 'EOF' > ~/start-desktop.sh
#!/bin/bash
export DISPLAY=:1

# Inicia servidor gráfico virtual
Xvfb :1 -screen 0 1280x720x16 &

# Pequena pausa para o X carregar
sleep 2

# Inicia LXDE
startlxde &

# Inicia VNC
x11vnc -display :1 -usepw -forever -ncache 10
EOF

chmod +x ~/start-desktop.sh

echo "Instalação completa!"
echo "Para iniciar o desktop via VNC:"
echo "    ./start-desktop.sh"
echo "Conectar VNC em: porta 5900, senha 123456"
