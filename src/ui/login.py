from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from user.auth import validar_api_key
import json, os

console = Console()
USER_FILE = "user/config.json"

def autenticar_usuario():
    if os.path.exists(USER_FILE):
        try:
            with open(USER_FILE, "r") as f:
                content = f.read().strip()
                if not content:
                    raise ValueError("Arquivo vazio")
                data = json.loads(content)
                if data.get("username") and data.get("api_key"):
                    return data
                else:
                    console.print("⚠️ [bold yellow]Dados incompletos.[/] Reconfigurando...\n")
        except Exception as e:
            console.print(f"[bold red]Erro ao ler config.json[/]: {e}\nReconfigurando...\n")

    console.rule("[bold cyan]Primeiro Acesso[/]")
    username = Prompt.ask("👤 Nome de usuário")
    senha = Prompt.ask("🔒 Senha (simulada)", password=True)

    api_key = validar_api_key(console)

    os.makedirs("user", exist_ok=True)
    with open(USER_FILE, "w") as f:
        json.dump({
            "username": username,
            "senha": senha,
            "api_key": api_key
        }, f, indent=2)

    return {"username": username, "api_key": api_key}
