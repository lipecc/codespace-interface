#!/bin/bash

set -e

echo "[1/7] Atualizando pacotes..."
sudo apt update -y
sudo apt install -y software-properties-common

echo "[2/7] Instalando ambiente gráfico leve (Openbox)..."
sudo apt install -y openbox obconf tint2 lxterminal

echo "[3/7] Instalando TigerVNC + Xvfb..."
sudo apt install -y tigervnc-standalone-server tigervnc-common xvfb

echo "[4/7] Criando senha do VNC..."
mkdir -p ~/.vnc
echo "123456" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

echo "[5/7] Instalando navegador leve (Links2 GUI)..."
sudo apt install -y links2

echo "[6/7] Criando script para iniciar ambiente gráfico..."
cat << 'EOF' > ~/start-desktop.sh
#!/bin/bash
export DISPLAY=:1

# Inicia servidor gráfico virtual
Xvfb :1 -screen 0 1280x720x16 &

sleep 2

# Inicia Openbox
openbox-session &

# Inicia TigerVNC
tigervncserver :1
EOF

chmod +x ~/start-desktop.sh

echo "[7/7] Pronto!"
echo "Execute com:"
echo "    ./start-desktop.sh"
echo "Conectar ao VNC usando porta 5901, senha 123456"
