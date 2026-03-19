# Diseñador Web Definitivo

Combina 4 herramientas para que Claude diseñe páginas web increíbles — genera mockups con IA, crea componentes de alta calidad y construye landing pages completas desde cero.

## Las 4 herramientas

| Herramienta | Rol | Qué hace |
|---|---|---|
| **UI/UX Pro Max GO** | El cerebro | 67 estilos, 96 paletas, 57 fuentes, 99 reglas UX |
| **NanoBanana MCP** | El artista | Genera imágenes y mockups con Gemini |
| **Google Stitch MCP** | El diseñador UI | Genera interfaces y HTML/CSS con Gemini 2.5 Pro |
| **21st Dev Magic** | La tienda | Componentes premium React + Tailwind listos para usar |

---

## Requisitos

- [Claude Code](https://docs.anthropic.com/claude-code) instalado
- Node.js 18+ → `node --version`
- Python 3.x → `python3 --version`
- Cuenta de [Google Cloud](https://cloud.google.com) (gratis)
- Cuenta en [21st.dev](https://21st.dev)

---

## Instalación rápida

```bash
# 1. Clona este repositorio
git clone https://github.com/TU_USUARIO/Joeltrader.git
cd Joeltrader

# 2. Copia el archivo de variables de entorno
cp .env.example .env

# 3. Edita .env y agrega tus API keys
nano .env   # o el editor que prefieras

# 4. Ejecuta el script de instalación
chmod +x setup.sh && ./setup.sh
```

---

## Paso a paso manual

### Paso 1 — UI/UX Pro Max GO (el cerebro de diseño)

```bash
npm install -g uipro-cli
uipro init --ai claude
```

Esto instala el skill en `.claude/skills/ui-ux-pro-max/`. Claude ahora conoce 67 estilos visuales, elige paletas por industria y combina fuentes profesionales.

---

### Paso 2 — NanoBanana MCP (genera mockups con IA)

**Obtén tu API key de Gemini (gratis):**
1. Ve a [aistudio.google.com/apikey](https://aistudio.google.com/apikey)
2. Haz clic en **Create API Key**
3. Copia la key

**Agrega a `.mcp.json`:**

```json
"nanobanana": {
  "command": "uvx",
  "args": ["nanobanana-mcp-server@latest"],
  "env": {
    "GEMINI_API_KEY": "tu-api-key-aqui"
  }
}
```

O instala el servidor directamente:

```bash
pip install nanobanana-mcp-server
```

---

### Paso 3 — Google Stitch MCP (diseñador UI)

**Configura Google Cloud (una sola vez):**

```bash
# Instala Google Cloud CLI desde https://cloud.google.com/sdk si no lo tienes
gcloud auth login
gcloud config set project TU_PROJECT_ID
gcloud beta services enable stitch.googleapis.com
```

**Instala el MCP automáticamente:**

```bash
npx @_davideast/stitch-mcp init
```

O agrega manualmente a `.mcp.json`:

```json
"stitch": {
  "command": "npx",
  "args": ["-y", "stitch-mcp"],
  "env": {
    "GOOGLE_CLOUD_PROJECT": "tu-project-id"
  }
}
```

---

### Paso 4 — 21st Dev Magic (componentes premium)

**Obtén tu API key:**
1. Ve a [21st.dev](https://21st.dev) y crea una cuenta
2. Copia tu API key desde el dashboard

**Instala el MCP:**

```bash
npx @21st-dev/cli@latest install claude --api-key TU_API_KEY
```

O agrega manualmente a `.mcp.json`:

```json
"21st-dev-magic": {
  "command": "npx",
  "args": ["-y", "@21st-dev/magic@latest"],
  "env": {
    "API_KEY": "tu-api-key"
  }
}
```

---

### Paso 5 — Verificar instalación

Abre Claude Code y ejecuta:

```
/mcp
```

Deberías ver los 3 servidores conectados: `nanobanana`, `stitch`, `21st-dev-magic`.

---

## Cómo usarlo

### Flujo completo — Landing page desde cero

```
Necesito una landing page para una startup de IA educativa.
Primero genera un mockup con Stitch para tener una referencia visual del diseño.
Después usa el skill de UI/UX Pro Max para elegir la paleta de colores, tipografía
y estilo visual correcto para educación. Finalmente construye la página usando
componentes de 21st Dev Magic — necesito hero section, features grid, testimonios
y pricing. Todo con Next.js y Tailwind CSS.
```

### Mockup primero, código después

```
Genera un mockup con NanoBanana de una dashboard moderna para una app de finanzas
personales — colores oscuros, gráficas, sidebar con navegación. Guarda la imagen.
Ahora usa esa imagen como referencia y replica el diseño usando componentes de
21st Dev Magic y el skill de UI/UX Pro Max.
```

### Componentes sueltos de alta calidad

```
Usa /ui para crear un hero section moderno con gradiente, animación de texto
y un CTA prominente. Después crea una sección de pricing con 3 planes.
Asegúrate que todo sea responsive y siga las mejores prácticas de UX del skill.
```

---

## Tips

- **Empieza con un mockup** — pide un mockup con NanoBanana o Stitch antes de escribir código
- **Sé específico con el contexto** — "landing para startup de fitness con colores energéticos" > "hazme una landing"
- **Usa Plan Mode** — presiona `Shift+Tab` antes de diseñar para que Claude planee primero
- **Combina explícitamente** — dile a Claude qué herramienta usar: "usa Stitch para el mockup, 21st Dev para los componentes"

---

## Estructura del repositorio

```
.
├── .claude/
│   └── skills/
│       └── ui-ux-pro-max/     # Skill de diseño instalado por uipro-cli
├── .mcp.json                   # Configuración de los 3 servidores MCP
├── .env.example                # Plantilla de API keys
├── setup.sh                    # Script de instalación automática
└── README.md
```

---

## Recursos

- [UI/UX Pro Max GO](https://www.npmjs.com/package/uipro-cli)
- [NanoBanana MCP](https://pypi.org/project/nanobanana-mcp-server/)
- [Google Stitch MCP](https://github.com/davideast/stitch-mcp)
- [21st Dev Magic](https://21st.dev)
- [Gemini API Key](https://aistudio.google.com/apikey)
