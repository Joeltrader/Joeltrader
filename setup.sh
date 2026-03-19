#!/bin/bash
# setup.sh — Instalador del Diseñador Web Definitivo
# Instala y configura las 4 herramientas: UI/UX Pro Max, NanoBanana, Stitch, 21st Dev

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠ $1${NC}"; }
err()  { echo -e "${RED}✗ $1${NC}"; exit 1; }

echo ""
echo "======================================"
echo "  Diseñador Web Definitivo — Setup"
echo "======================================"
echo ""

# --- Verificar requisitos ---
echo "Verificando requisitos..."

command -v node >/dev/null 2>&1 || err "Node.js no encontrado. Instálalo desde https://nodejs.org"
NODE_VER=$(node -e "process.exit(parseInt(process.version.slice(1)) < 18 ? 1 : 0)" 2>&1) && ok "Node.js $(node --version)" || err "Node.js 18+ requerido"

command -v python3 >/dev/null 2>&1 || err "Python 3 no encontrado"
ok "Python $(python3 --version)"

command -v pip >/dev/null 2>&1 || command -v pip3 >/dev/null 2>&1 || err "pip no encontrado"
ok "pip disponible"

# --- Cargar .env si existe ---
if [ -f ".env" ]; then
  export $(grep -v '^#' .env | xargs)
  ok ".env cargado"
else
  warn ".env no encontrado — los MCPs se configurarán con placeholders"
  warn "Copia .env.example a .env y agrega tus API keys, luego vuelve a ejecutar"
fi

echo ""
echo "--- Paso 1: UI/UX Pro Max GO ---"
if command -v uipro >/dev/null 2>&1; then
  ok "uipro-cli ya instalado"
else
  npm install -g uipro-cli && ok "uipro-cli instalado"
fi
uipro init --ai claude && ok "UI/UX Pro Max configurado en .claude/skills/"

echo ""
echo "--- Paso 2: NanoBanana MCP ---"
pip install nanobanana-mcp-server -q && ok "nanobanana-mcp-server instalado"

echo ""
echo "--- Paso 3: Actualizar .mcp.json con tus API keys ---"

GEMINI_KEY="${GEMINI_API_KEY:-TU_GEMINI_API_KEY_AQUI}"
GCP_PROJECT="${GOOGLE_CLOUD_PROJECT:-TU_GOOGLE_CLOUD_PROJECT_ID_AQUI}"
DEV21_KEY="${DEV21ST_API_KEY:-TU_21ST_DEV_API_KEY_AQUI}"

cat > .mcp.json <<EOF
{
  "mcpServers": {
    "nanobanana": {
      "command": "uvx",
      "args": ["nanobanana-mcp-server@latest"],
      "env": {
        "GEMINI_API_KEY": "${GEMINI_KEY}"
      }
    },
    "stitch": {
      "command": "npx",
      "args": ["-y", "stitch-mcp"],
      "env": {
        "GOOGLE_CLOUD_PROJECT": "${GCP_PROJECT}"
      }
    },
    "21st-dev-magic": {
      "command": "npx",
      "args": ["-y", "@21st-dev/magic@latest"],
      "env": {
        "API_KEY": "${DEV21_KEY}"
      }
    }
  }
}
EOF
ok ".mcp.json actualizado"

echo ""
echo "--- Paso 4: 21st Dev Magic MCP ---"
if [ "${DEV21_KEY}" != "TU_21ST_DEV_API_KEY_AQUI" ]; then
  npx @21st-dev/cli@latest install claude --api-key "${DEV21_KEY}" --yes 2>/dev/null && ok "21st Dev Magic instalado" || warn "21st Dev Magic: configúralo manualmente si falló"
else
  warn "21st Dev Magic: agrega DEV21ST_API_KEY en .env y vuelve a ejecutar"
fi

echo ""
echo "======================================"
echo -e "${GREEN}  Instalación completada${NC}"
echo "======================================"
echo ""
echo "Pasos finales:"
echo "  1. Abre Claude Code en este directorio"
echo "  2. Ejecuta /mcp para verificar los servidores"
echo "  3. Si tienes API keys pendientes, agrégalas en .env y vuelve a ejecutar"
echo ""
