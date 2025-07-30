# Start from the base vLLM image
FROM vllm/vllm-openai:v0.6.4

# Install the specific version of transformers that supports Gemma 3
RUN pip install "git+https://github.com/huggingface/transformers@v4.49.0-Gemma-3"