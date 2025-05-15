import os
import google.generativeai as genai
from whisper import load_model
from yt_dlp import YoutubeDL

# Função para validar a API key
def validar_api_key():
    while True:
        print("🔑 Insira sua API KEY do Google Gemini")
        print("👉 Disponível em: https://ai.google.dev/gemini-api/docs/api-key?hl=pt-br")
        api_key = input("-> ").strip()

        if not api_key:
            print("❌ Nenhuma chave foi inserida. Tente novamente.\n")
            continue

        try:
            genai.configure(api_key=api_key)
            # Teste rápido: tenta listar modelos disponíveis
            genai.list_models()
            return  # Se passou, sai do loop
        except Exception as e:
            print(f"❌ Chave inválida ou erro de conexão: {e}\n🔁 Tente novamente.\n")

# Chamada de validação (bloqueia até ser válido)
validar_api_key()

# Função para baixar áudio do YouTube
def baixar_audio_youtube(url, filename="audio"):
    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': f'{filename}.%(ext)s',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'quiet': True,
    }

    with YoutubeDL(ydl_opts) as ydl:
        ydl.download([url])

    if os.path.exists("audio.mp3"):
        return "audio.mp3"
    else:
        raise FileNotFoundError("❌ O arquivo de áudio não foi encontrado.")

# Função para transcrever áudio com Whisper
def transcrever_audio(path):
    model = load_model("base")
    result = model.transcribe(path)
    return result["text"]

# Função para gerar resumo usando o Gemini
def resumir_em_topicos(transcricao):
    prompt = f"""
Você é um assistente especialista em resumos de vídeos do YouTube.

Transforme a transcrição a seguir em um resumo fiel, claro e detalhado, organizado em tópicos e subtópicos. O objetivo é que alguém consiga entender tudo o que foi falado apenas lendo o resumo.

Transcrição:
\"\"\"{transcricao}\"\"\"
"""
    model = genai.GenerativeModel("gemini-1.5-flash")
    response = model.generate_content(prompt)
    return response.text

# Fluxo completo de geração do resumo
def gerar_resumo_do_video(url):
    audio_path = baixar_audio_youtube(url)
    texto = transcrever_audio(audio_path)
    resumo = resumir_em_topicos(texto)
    return resumo

# Execução principal
if __name__ == "__main__":
    url = input("\n🎥 Insira a URL do vídeo: ").strip()
    print("\n⏳ Gerando resumo...\n")
    resumo = gerar_resumo_do_video(url)
    print("\n✅ RESUMO GERADO:\n")
    print(resumo)

