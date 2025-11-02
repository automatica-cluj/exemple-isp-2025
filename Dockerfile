FROM python:3.11-slim

# Set working directory
WORKDIR /docs

# Install MkDocs and Material theme
RUN pip install --no-cache-dir \
    mkdocs \
    mkdocs-material \
    mkdocs-minify-plugin \
    pymdown-extensions

# Expose port for MkDocs dev server
EXPOSE 8000

# Default command - serve the documentation
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
