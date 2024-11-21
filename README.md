# Deploy LLM

This is a repository for a production-ready LLM deployment (in time)

## Components

- LLM serving with vLLM
- Extracting and serving statistics with Prometheus
- Exposing GPU metrics with dcgm-exporter
- Displaying statistics with Grafana dashboard

## Installation

To install all the requirements you need the following dependencies on your machine

- Cuda
- Nvidia drivers
- Docker
- Nvidia container toolkit

You can install all of these dependencies on a fresh ubuntu machine using `./install-script`.
Be careful running this command if you do not have a clean machine.
Reboot after installing for the changes to take effect.

## Configuration of secrets

You will want to change some settings before using this configuration in production,
like changing the VLLM secret key and the grafana password. Configuration of secrets is
handled in an `.env` file in the repository root. This file is ignored by git to ensure
secrets are not accidentally committed. You can initalize a `.env` from our provided
example by running

```sh
cp .env.example .env
```

## Running

Start the deployment with `docker compose up -d`
