```
_____.___.___________        _________                                  .__                     
\__  |   |\__    ___/       /   _____/__ __  _____   _____ _____ _______|__|_______ ___________ 
 /   |   |  |    |  ______  \_____  \|  |  \/     \ /     \\__  \\_  __ \  \___   // __ \_  __ \
 \____   |  |    | /_____/  /        \  |  /  Y Y  \  Y Y  \/ __ \|  | \/  |/    /\  ___/|  | \/
 / ______|  |____|         /_______  /____/|__|_|  /__|_|  (____  /__|  |__/_____ \\___  >__|   
 \/                                \/            \/      \/     \/               \/    \/        

```

Ferramenta para transcrição e resumo inteligente de vídeos do YouTube usando IA.

---

## Índice

- [Introdução](#1-introdução)  
- [Objetivos](#2-objetivos)  
- [Arquitetura do Projeto](#3-arquitetura-do-projeto)  
- [Tecnologias Utilizadas](#4-tecnologias-utilizadas)  
- [Instalação e Execução](#5-instalação-e-execução)  
  - [Linux](#linux)  
  - [Windows](#windows)  
  - [macOS](#macos)  
  - [Android (Termux)](#android-termux)  
- [Funcionalidades](#6-funcionalidades)  
- [Considerações Finais](#7-considerações-finais)  
- [Referências](#8-referências)  

---

## 1. Introdução

Com o volume crescente de vídeos no YouTube, o **YT-Summarizer** facilita a compreensão rápida dos conteúdos, transformando fala em texto e resumindo os principais pontos.

---

## 2. Objetivos

### Geral

- Criar uma ferramenta confiável para transcrição e resumo de vídeos do YouTube.

### Específicos

- Automatizar instalação e execução.
- Suportar múltiplos sistemas.
- Fácil uso para usuários não técnicos.
- Usar modelos de IA modernos para qualidade.

---

## 3. Arquitetura do Projeto

```
YT-Summarizer/
├── src/
│ ├── main.py
│ └── ...
├── config.sh
├── config_macos.sh
├── config_termux.sh
├── README.md
└── requirements.txt
```

---

## 4. Tecnologias Utilizadas

- Python 3.11+
- yt_dlp, google-generativeai, openai-whisper
- python-dotenv, langchain, moviepy, requests, pytube
- BeautifulSoup4, tqdm, rich, flask, pyaudio

---

## 5. Instalação e Execução

### [Linux](#linux) | [Windows](#windows) | [macOS](#macos) | [Android (Termux)](#android-termux)

---

### Linux (Debian, Arch e derivados)

1. Instale Python 3.11+ e bash.
2. Clone o projeto:

```bash
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
# Permita execução e rode o script:
chmod +x config.sh
./config.sh
```

> O script cria ambiente virtual, instala dependências e executa o projeto.

### Windows

- Instale Python 3.11+ e Git Bash ou WSL.

```
# Clone o repositório:
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
# Liberacao de scripts:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
# Rodar o script
.\config.ps1

```

### macOS

```
# Clone o projeto:
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
# Permita execução e rode o script macOS:
chmod +x config_macos.sh
./config_macos.sh
```

- O script instala Homebrew, Python, cria ambiente virtual, instala dependências e executa.

### Android (Termux)

1. Instale Termux.
2. No Termux, atualize e instale git, python e ffmpeg:

```
pkg update && pkg upgrade
pkg install git python ffmpeg
```

3. Clone o projeto:

```
git clone https://github.com/sh1ftx/YT-Summarizer.git
cd YT-Summarizer
# Permita execução e execute o script Termux:
chmod +x config_termux.sh
./config_termux.sh
# O script cria ambiente virtual, instala dependências e executa o projeto.
```

## 6. Funcionalidades

- Download e transcrição de audio do YouTube.
- Resumo inteligente em tópicos claros.
- Suporte a múltiplos formatos.
- Logs detalhados.
- Interface simples via terminal.

## 7. Considerações Finais

Projeto em evolução, aberto a contribuições e melhorias.

## 8. Referências

### Repositório oficial:
1. https://github.com/sh1ftx/YT-Summarizer
2. Python Docs: https://docs.python.org/3/
3. yt-dlp: https://github.com/yt-dlp/yt-dlp
4. OpenAI Whisper: https://github.com/openai/whisper

Desenvolvido com 💡 por Kayki Ivan (sh1ft)
Contato: https://github.com/sh1ftx
