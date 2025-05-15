import google.generativeai as genai

def resumir_em_topicos(transcricao, api_key):
    genai.configure(api_key=api_key)

    prompt = f"""
Você é um assistente especialista em resumos de vídeos do YouTube.

Transforme a transcrição a seguir em um resumo fiel, claro e detalhado, organizado em tópicos e subtópicos. O objetivo é que alguém consiga entender tudo o que foi falado apenas lendo o resumo.

Transcrição:
\"\"\"{transcricao}\"\"\"
"""
    model = genai.GenerativeModel("gemini-1.5-flash")
    response = model.generate_content(prompt)
    return response.text
