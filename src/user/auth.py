import google.generativeai as genai

def validar_api_key():
    while True:
        print("\n🔑 Insira sua API KEY do Google Gemini")
        print("👉 Disponível em: https://ai.google.dev/gemini-api/docs/api-key?hl=pt-br")
        api_key = input("-> ").strip()

        if not api_key:
            print("❌ Nenhuma chave foi inserida. Tente novamente.\n")
            continue

        try:
            genai.configure(api_key=api_key)
            genai.list_models()
            return api_key
        except Exception as e:
            print(f"❌ Chave inválida ou erro de conexão: {e}\n🔁 Tente novamente.\n")
