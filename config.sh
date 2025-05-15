#!/bin/bash

# ==============================================================================
# CONFIG.SH - INSTALADOR AUTOMÁTICO E ROBUSTO DO PROJETO: YT-SUMMARIZER
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

# Detectar sistema operacional
print_header "Detectando Sistema Operacional..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [ -f /etc/debian_version ]; then
    OS="debian"
    PM="sudo apt"
  elif [ -f /etc/arch-release ]; then
    OS="arch"
    PM="sudo pacman -Sy"
  else
    print_error "Distribuição Linux não suportada automaticamente."
    exit 1
  fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
  OS="windows"
  PM="choco"
else
  print_error "Sistema operacional não reconhecido: $OSTYPE"
  exit 1
fi

echo "Sistema detectado: $OS"

# -----------------------------
# Verificar Python
# -----------------------------
print_header "Verificando o Python..."

if ! command -v python3 &> /dev/null; then
  print_warn "Python3 não encontrado."
  if ask_user "Deseja instalar o Python3 agora?"; then
    if [ "$OS" = "debian" ]; then
      $PM update
      $PM install python3 python3-pip python3-venv -y
    elif [ "$OS" = "arch" ]; then
      $PM python python-pip python-virtualenv --noconfirm
    elif [ "$OS" = "windows" ]; then
      $PM install python -y
    fi
  else
    print_error "Instalação do Python cancelada."
    exit 1
  fi
else
  echo "Python já está instalado."
fi

# -----------------------------
# Criar e ativar ambiente virtual
# -----------------------------
print_header "Criando ambiente virtual 'configs'..."

if [ ! -d "configs" ]; then
  python3 -m venv configs
  echo "Ambiente virtual criado."
fi

source configs/bin/activate || source configs/Scripts/activate

# -----------------------------
# Atualizar pip
# -----------------------------
print_step "Atualizando pip..."
pip install --upgrade pip

# -----------------------------
# Instalar dependências do projeto
# -----------------------------
print_header "Instalando dependências..."

print_step "Instalando yt_dlp, google-generativeai, python-dotenv..."
pip install yt_dlp google-generativeai python-dotenv

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
