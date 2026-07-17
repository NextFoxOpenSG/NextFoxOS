#!/usr/bin/env bash

set -euo pipefail

echo "========================================="
echo "   Iniciando personalización de NextFoxOS   "
echo "========================================="

echo "Configurando servicios del sistema..."
systemctl enable podman.socket

echo "Configurando alias globales en la terminal..."
cat << 'EOF' >> /etc/bashrc

alias ll='ls -lah --color=auto'
alias update-sys='rpm-ostree upgrade'
alias clean-flat='flatpak uninstall --unused'
EOF

echo "Optimizando parámetros del sistema..."
echo "vm.swappiness=10" > /etc/sysctl.d/99-nextfoxos-performance.conf

echo "========================================="
echo "  ¡Personalización finalizada con éxito! "
echo "Instalando banner de bienvenida de NextFoxOS..."
cat << 'EOF' > /etc/profile.d/nextfoxos-welcome.sh
#!/usr/bin/env bash

[[ $- != *i* ]] && return

CYAN='\033[0;36m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}"
echo "  _   _           _   _____            ____   ____ "
echo " | \ | | ___  ___| |_|  ___|____  __  / __ \ / ___|"
echo " |  \| |/ _ \/ __| __| |_ / _ \ \/ / | |  | |\___ \ "
echo " | |\  |  __/\__ \ |_|  _| (_) >  <  | |__| | ___) |"
echo " |_| \_|\___||___/\__|_|  \___/_/\_\  \____/ |____/ "
echo -e "${NC}"
echo -e " ¡Bienvenido a ${CYAN}NextFoxOS${NC}! Tu entorno de desarrollo y gaming personalizado."
echo -e " Basado en Fedora Atomic de forma inmutable y segura."
echo " ------------------------------------------------------------------"
echo -e " ${ORANGE}Comandos rápidos útiles:${NC}"
echo -e "   ${GREEN}update-sys${NC}  -> Actualizar todo el sistema base"
echo -e "   ${GREEN}clean-flat${NC}  -> Limpiar paquetes Flatpak residuales"
echo " ------------------------------------------------------------------"
echo ""
EOF
chmod +x /etc/profile.d/nextfoxos-welcome.sh
echo "========================================="
