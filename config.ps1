# ========================================================================
# CONFIG.PS1 - INSTALADOR AUTOMÁTICO E ROBUSTO DO PROJETO: YT-SUMMARIZER
# ========================================================================
# 📼 YT-Summarizer transcreve e resume vídeos do YouTube em tópicos claros
#     e detalhados com inteligência artificial de última geração.
# ========================================================================

$ErrorActionPreference = "Stop"
$LogDir = "logs"
$LogFile = "$LogDir\install.log"
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
Start-Transcript -Path $LogFile

function Show-Logo {
@"
_____.___.___________        _________                                  .__                     
\__  |   |\__    ___/       /   _____/__ __  _____   _____ _____ _______|__|_______ ___________ 
 /   |   |  |    |  ______  \_____  \|  |  \/     \ /     \\__  \\_  __ \  \___   // __ \_  __ \
 \____   |  |    | /_____/  /        \  |  /  Y Y  \  Y Y  \/ __ \|  | \/  |/    /\  ___/|  | \/
 / ______|  |____|         /_______  /____/|__|_|  /__|_|  (____  /__|  |__/_____ \\___  >__|   
 \/                                \/            \/      \/     \/               \/    \/        

📼 YT-Summarizer transcreve e resume vídeos do YouTube com inteligência artificial.

👤 Desenvolvido por: Kayki Ivan
🔧 Apelido (dev): Sh1ft
"@
}

function Print-Header($msg) {
    Write-Host "`n================================================================================" -ForegroundColor Cyan
    Write-Host "        $msg" -ForegroundColor Cyan
    Write-Host "================================================================================" -ForegroundColor Cyan
}

function Print-Step($msg) {
    Write-Host "[PASSO] $msg" -ForegroundColor Green
}

function Print-Warn($msg) {
    Write-Host "[AVISO] $msg" -ForegroundColor Yellow
}

function Print-Error($msg) {
    Write-Host "[ERRO] $msg" -ForegroundColor Red
    Stop-Transcript
    exit 1
}

function Ask-User($msg) {
    do {
        $response = Read-Host "$msg (s/n)"
    } while ($response -notmatch "^[sSnN]$")
    return $response -match "^[sS]$"
}

# -----------------------------
# Início
# -----------------------------
Show-Logo

Print-Header "Verificando Python..."

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Print-Warn "Python não encontrado."
    if (Ask-User "Deseja instalar o Python com Chocolatey agora?") {
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Print-Warn "Chocolatey não encontrado. Instalando Chocolatey..."
            Set-ExecutionPolicy Bypass -Scope Process -Force
            iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        }
        choco install python -y
        refreshenv
    } else {
        Print-Error "Instalação do Python cancelada."
    }
} else {
    Write-Host "Python já está instalado." -ForegroundColor Green
}

Print-Header "Criando ambiente virtual..."

if (-not (Test-Path "configs")) {
    python -m venv configs
    Write-Host "Ambiente virtual criado em 'configs'." -ForegroundColor Green
}

# Ativar ambiente virtual
$activateScript = "configs\Scripts\Activate.ps1"
if (Test-Path $activateScript) {
    & $activateScript
} else {
    Print-Error "Falha ao ativar ambiente virtual."
}

Print-Step "Atualizando pip..."
pip install --upgrade pip

Print-Step "Instalando bibliotecas principais..."
pip install yt_dlp google-generativeai python-dotenv langchain moviepy requests pytube transformers beautifulsoup4 tqdm rich flask pyaudio

Print-Step "Instalando openai-whisper com fallback..."
try {
    pip install --prefer-binary openai-whisper
} catch {
    Print-Warn "Instalação via pip falhou. Tentando via GitHub..."
    try {
        pip install git+https://github.com/openai/whisper.git
    } catch {
        Print-Error "Falha ao instalar openai-whisper. Abortando."
    }
}

Print-Header "Verificando estrutura de diretórios..."
New-Item -ItemType Directory -Force -Path "src\user" | Out-Null
New-Item -ItemType Directory -Force -Path "logs" | Out-Null

Print-Header "Executando o projeto YT-Summarizer..."

if (Test-Path "src\main.py") {
    Set-Location "src"
    python main.py
} else {
    Print-Error "Arquivo 'src/main.py' não encontrado. Verifique o projeto."
}
