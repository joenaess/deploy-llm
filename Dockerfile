# Start from the base vLLM image
FROM vllm/vllm-openai:latest

# Install the specific version of transformers that supports Gemma 3
RUN pip install -U transformers
