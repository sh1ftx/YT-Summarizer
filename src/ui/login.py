from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from rich.text import Text
import json, os

console = Console()
USER_FILE = "user/config.json"

def validar_api_key(console: Console) -> str:
    console.print(
        Panel(
            Text(
                "🔑 Por favor, insira sua API Key válida para o Gemini.\n"
                "👉 Caso não tenha, crie uma no portal do Google Cloud aqui:\n"
                "https://aistudio.google.com/app/apikey?hl=pt-br",
                style="bold white",
                justify="center"
            ),
            border_style="bright_blue",
            title="[bold bright_cyan]API Key Gemini[/]"
        )
    )
    while True:
        api_key = Prompt.ask("[bright_magenta]> [/]", password=True)
        if api_key.strip():
            return api_key
        else:
            console.print("[bold red]API Key não pode ser vazia. Tente novamente.[/]\n")

def autenticar_usuario():
    console.rule("[bold cyan] Bem-vindo ao YT-Summarizer [/]", style="cyan")

    if os.path.exists(USER_FILE):
        try:
            with open(USER_FILE, "r") as f:
                content = f.read().strip()
                if not content:
                    raise ValueError("Arquivo vazio")
                data = json.loads(content)
                if data.get("username") and data.get("api_key"):
                    console.print(Panel(f"👤 Usuário logado: [bold green]{data['username']}[/]", style="green"))
                    return data
                else:
                    console.print("[bold yellow]⚠️ Dados incompletos encontrados. Reconfigurando...[/]")
        except Exception as e:
            console.print(f"[bold red]Erro ao ler config.json:[/] {e}\n[bold yellow]Reconfigurando...[/]")

    console.rule("[bold blue] Primeiro Acesso ou Cadastro [/]", style="blue")
    console.print(Panel("Nenhum usuário encontrado. Vamos configurar seu acesso.", style="blue"))

    username = Prompt.ask("[bold bright_cyan]👤 Nome de usuário[/]")
    console.print("[italic dim]🔒 Sua senha será oculta enquanto digita.[/]")
    senha = Prompt.ask("[bold bright_yellow]🔒 Senha (simulada)[/]", password=True)

    console.print("[italic dim]🔑 Sua API Key será oculta enquanto digita.[/]")
    api_key = validar_api_key(console)

    os.makedirs("user", exist_ok=True)
    with open(USER_FILE, "w") as f:
        json.dump({
            "username": username,
            "senha": senha,
            "api_key": api_key
        }, f, indent=2)

    console.print(Panel(f"✅ Cadastro concluído para [bold green]{username}[/]", style="green"))
    return {"username": username, "api_key": api_key}
