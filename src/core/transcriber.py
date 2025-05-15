from whisper import load_model

def transcrever_audio(path):
    model = load_model("base")
    result = model.transcribe(path)
    return result["text"]
