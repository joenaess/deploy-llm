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

You can install all of these dependencies on a clean ubuntu machine using `./install-script`.
Be careful running this command if you do not have a clean machine.
Reboot after installing for the changes to take effect.

## Running

Run everything with `docker compose up -d`
