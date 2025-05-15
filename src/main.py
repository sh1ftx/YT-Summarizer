from ui.banner import show_banner
from ui.terminal_ui import print_status, print_success
from ui.login import autenticar_usuario
from core.audio import baixar_audio_youtube
from core.transcriber import transcrever_audio
from core.summarizer import resumir_em_topicos
from rich.console import Console

console = Console()

def main():
    show_banner()
    user_data = autenticar_usuario()

    print_status("Pronto para processar seu vídeo!")
    url = console.input("\n[bold white]🎥 Insira a URL do vídeo:[/] ").strip()

    print_status("Baixando áudio...")
    audio_path = baixar_audio_youtube(url)

    print_status("Transcrevendo áudio...")
    texto = transcrever_audio(audio_path)

    print_status("Gerando resumo com IA Gemini...")
    resumo = resumir_em_topicos(texto, user_data["api_key"])

    print_success("\n✅ RESUMO GERADO:\n")
    console.print(resumo)

if __name__ == "__main__":
    main()
