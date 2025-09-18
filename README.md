```
_____.___.___________        _________                                  .__                     
\__  |   |\__    ___/       /   _____/__ __  _____   _____ _____ _______|__|_______ ___________ 
 /   |   |  |    |  ______  \_____  \|  |  \/     \ /     \\__  \\_  __ \  \___   // __ \_  __ \
 \____   |  |    | /_____/  /        \  |  /  Y Y  \  Y Y  \/ __ \|  | \/  |/    /\  ___/|  | \/
 / ______|  |____|         /_______  /____/|__|_|  /__|_|  (____  /__|  |__/_____ \\___  >__|   
 \/                                \/            \/      \/     \/               \/    \/        
```

# YT-Summarizer

[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)  
[![Python](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/)  
[![Status](https://img.shields.io/badge/status-active-success.svg)]()  
[![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)]()  

Ferramenta de linha de comando para **transcrição** e **resumo inteligente** de vídeos do YouTube usando IA.  
Livre. Aberta. Feita para rodar localmente.

---

## O que faz
- Baixa e transcreve áudio de vídeos do YouTube (Whisper)  
- Gera resumos objetivos em tópicos  
- Suporte a Linux, Windows, macOS e Termux  
- Interface simples via terminal  

---

## Tecnologias
- Python 3.11+  
- yt-dlp, Whisper, Google Generative AI  
- dotenv, MoviePy, Tqdm, Rich  

---

## Instalação

### Linux
```bash
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
chmod +x config.sh
./config.sh
```

### Windows
```powershell
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\config.ps1
```

### macOS
```bash
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
chmod +x config_macos.sh
./config_macos.sh
```

### Termux (Android)
```bash
pkg update && pkg upgrade
pkg install git python ffmpeg
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
chmod +x config_termux.sh
./config_termux.sh
```

---

## Filosofia
Código aberto. Simples. Portátil.  
Criado dentro da cultura hacker: aprender, criar e compartilhar.

---

## Licença
Este projeto é **livre**.  
Use, modifique, compartilhe sob os termos da licença [MIT](LICENSE).

---

## Autor
Desenvolvido por **Kayki Ivan (sh1ft)**  
🔗 [github.com/sh1ftx](https://github.com/sh1ftx)
