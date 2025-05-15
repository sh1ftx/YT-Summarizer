#!/bin/bash

# ==============================================================================
# CONFIG_TERMUX.SH - INSTALADOR AUTOMÁTICO E ROBUSTO DO PROJETO: YT-SUMMARIZER
# ==============================================================================
# 📼 YT-Summarizer transcreve e resume vídeos do YouTube em tópicos claros e
#     detalhados com inteligência artificial de última geração.
# ==============================================================================

set -e

# Criar pasta de logs
LOG_DIR="logs"
mkdir -p "$LOG_DIR"
LOGFILE="$LOG_DIR/install.log"
exec > >(tee -i "$LOGFILE")
exec 2>&1

# -----------------------------
# Funções utilitárias
# -----------------------------

function show_logo() {
cat << "EOF"
_____.___.___________        _________                                  .__                     
\__  |   |\__    ___/       /   _____/__ __  _____   _____ _____ _______|__|_______ ___________ 
 /   |   |  |    |  ______  \_____  \|  |  \/     \ /     \\__  \\_  __ \  \___   // __ \_  __ \
 \____   |  |    | /_____/  /        \  |  /  Y Y  \  Y Y  \/ __ \|  | \/  |/    /\  ___/|  | \/
 / ______|  |____|         /_______  /____/|__|_|  /__|_|  (____  /__|  |__/_____ \\___  >__|   
 \/                                \/            \/      \/     \/               \/    \/        

📼 YT-Summarizer transcreve e resume vídeos do YouTube com inteligência artificial.

👤 Desenvolvido por: Kayki Ivan
🔧 Apelido (dev): Sh1ft
EOF
}

function print_header() {
  echo -e "\n\033[1;34m================================================================================"
  echo -e "        $1"
  echo -e "================================================================================\033[0m"
}

function print_step() {
  echo -e "\033[1;32m[PASSO] $1\033[0m"
}

function print_warn() {
  echo -e "\033[1;33m[AVISO] $1\033[0m"
}

function print_error() {
  echo -e "\033[1;31m[ERRO] $1\033[0m"
}

function ask_user() {
  read -p "$1 (s/n): " choice
  case "$choice" in
    s|S ) return 0 ;;
    n|N ) return 1 ;;
    * ) echo "Opção inválida." && ask_user "$1" ;;
  esac
}

# -----------------------------
# Início
# -----------------------------
show_logo

print_header "Detectando ambiente Termux..."

# Detecta Termux via ambiente ou nome do shell
if [ -n "$PREFIX" ] && [[ "$PREFIX" == *"/data/data/com.termux/files/usr"* ]]; then
  OS="termux"
  print_step "Ambiente detectado: Termux (Android)"
else
  print_error "Este script é somente para Termux (Android). Abortando."
  exit 1
fi

# -----------------------------
# Atualizar repositórios e instalar pacotes essenciais
# -----------------------------
print_header "Atualizando repositórios e instalando pacotes essenciais..."

pkg update -y
pkg upgrade -y

# Instalar python, git, curl, ffmpeg e build essentials para compilar dependências
ESSENTIALS="python git curl ffmpeg clang make openssl pkg-config"

for pkg_name in $ESSENTIALS; do
  if ! command -v $pkg_name &>/dev/null; then
    print_step "Instalando pacote: $pkg_name"
    pkg install -y $pkg_name
  else
    print_step "Pacote já instalado: $pkg_name"
  fi
done

# -----------------------------
# Criar e ativar ambiente virtual
# -----------------------------
print_header "Criando ambiente virtual 'configs'..."

if [ ! -d "configs" ]; then
  python3 -m venv configs
  print_step "Ambiente virtual criado."
fi

# Ativação do ambiente virtual
source configs/bin/activate

# -----------------------------
# Atualizar pip
# -----------------------------
print_step "Atualizando pip..."
pip install --upgrade pip

# -----------------------------
# Instalar dependências do projeto
# -----------------------------
print_step "Instalando bibliotecas principais do projeto..."

pip install yt_dlp google-generativeai python-dotenv langchain moviepy requests pytube transformers beautifulsoup4 tqdm rich flask pyaudio

print_step "Instalando openai-whisper com fallback..."

if ! pip install --prefer-binary openai-whisper; then
  print_warn "Instalação via pip falhou. Tentando via GitHub..."
  if ! pip install git+https://github.com/openai/whisper.git; then
    print_error "Falha ao instalar openai-whisper. Abortando."
    exit 1
  fi
fi

# -----------------------------
# Garantir estrutura mínima de diretórios
# -----------------------------
print_header "Verificando estrutura de diretórios..."

mkdir -p src/user
mkdir -p logs

# -----------------------------
# Executar o projeto
# -----------------------------
print_header "Executando o projeto YT-Summarizer..."

if [ -f "src/main.py" ]; then
  cd src
  python main.py
else
  print_error "Arquivo 'src/main.py' não encontrado. Verifique o projeto."
  exit 1
fi
