FROM ollama/ollama:latest

RUN set -eu; \
    ollama serve > /tmp/ollama.log 2>&1 & \
    pid=$!; \
    trap 'kill "$pid" 2>/dev/null || true' EXIT; \
    until ollama list > /dev/null 2>&1; do \
      kill -0 "$pid" 2>/dev/null || exit 1; \
      sleep 1; \
    done; \
    ollama pull qwen3:8b

EXPOSE 11434

ENTRYPOINT ["/bin/ollama"]
CMD ["serve"]