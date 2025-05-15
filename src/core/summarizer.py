from rich.console import Console
from rich.text import Text
import google.generativeai as genai

console = Console()

def resumir_em_topicos(transcricao, api_key):
    genai.configure(api_key=api_key)

    prompt = f"""
Você é um especialista em resumos de vídeos do YouTube e os faz de forma genial.

Transforme a transcrição a seguir em um resumo fiel, claro e detalhado, organizado em tópicos e subtópicos, com listas ordenadas e não ordenadas. Faça algo bem detalhado e bem elaborado, de um jeito que até um idiota acéfalo consiga entender perfeitamente. O objetivo é que qualquer pessoa consiga entender tudo o que foi falado apenas lendo o resumo.

Retorne apenas o texto sem formatação Markdown exatamente, claro que precisa organizar ele de alguma forma pra ficar bonitinho. Separe as seções com títulos em maiúsculas, subtítulos e tópicos com espaçamento e indentação.

Transcrição:
\"\"\"{transcricao}\"\"\"
"""
    model = genai.GenerativeModel("gemini-1.5-flash")
    response = model.generate_content(prompt)
    resumo_bruto = response.text

    exibir_resumo_formatado(resumo_bruto)

def exibir_resumo_formatado(resumo: str):
    lines = resumo.splitlines()

    for line in lines:
        line = line.strip()
        if not line:
            console.print("")  # linha em branco
            continue

        # TÍTULOS (tudo em maiúsculas e linha curta)
        if line.isupper() and len(line.split()) < 10:
            console.rule(Text(line, style="bold blue"))

        # SUBTÍTULOS (começam com "-" ou "*")
        elif line.startswith(("-", "*")):
            subtitulo = line[1:].strip()
            console.print(Text(f"• {subtitulo}", style="bold yellow"))

        # TÓPICOS INDENTADOS
        elif line.startswith(("  ", "\t")):
            console.print(Text(line.strip(), style="white"))

        # PARÁGRAFOS NORMAIS
        else:
            console.print(Text(line, style="cyan"))
