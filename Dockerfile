FROM python:3.13-slim

WORKDIR /app

# Install uv for dependency management
RUN pip install uv

COPY . ./

RUN uv pip install --system -e .
RUN chmod +x entrypoint.py

ENV PYTHONPATH=/app/src:$PYTHONPATH

# Copia lo script di avvio personalizzato per Cloud Run
COPY cloudrun-start.sh /app/cloudrun-start.sh
RUN chmod +x /app/cloudrun-start.sh

# Forza MCP a usare streamable-http
ENV MCP_TRANSPORT=streamable-http

CMD ["/bin/sh", "/app/cloudrun-start.sh"]
