#!/usr/bin/env bash

# Indicar al script que se detenga inmediatamente si ocurre algún error
set -euo pipefail

echo "========================================="
echo "   Iniciando personalización de NextFoxOS   "
echo "========================================="

# --- Ejemplo 1: Habilitar servicios del sistema por defecto ---
# Puedes asegurarte de que ciertos servicios de red o del sistema estén activos
echo "Configurando servicios del sistema..."
systemctl enable podman.socket # Por ejemplo, para desarrollo con contenedores

# --- Ejemplo 2: Configurar alias globales para la terminal ---
# Todo lo que se ponga en /etc/bashrc afecta a todos los usuarios del SO
echo "Configurando alias globales en la terminal..."
cat << 'EOF' >> /etc/bashrc

# Alias personalizados para NextFoxOS
alias ll='ls -lah --color=auto'
alias update-sys='rpm-ostree upgrade'
alias clean-flat='flatpak uninstall --unused'
EOF

# --- Ejemplo 3: Modificar configuraciones profundas del sistema ---
# Por ejemplo, optimizar el comportamiento de la memoria de intercambio (swappiness)
echo "Optimizando parámetros del sistema..."
echo "vm.swappiness=10" > /etc/sysctl.d/99-nextfoxos-performance.conf

echo "========================================="
echo "  ¡Personalización finalizada con éxito! "
echo "========================================="
