# Deploy LLM

This repository provides a production-ready deployment for a multimodal Large Language Model, including a backend API, monitoring stack, and a web-based chat frontend.

## Components

- LLM serving with vLLM
- Web Frontend: A simple, modern chat interface built with HTML and Tailwind CSS, served by Nginx.
- Reverse Proxy: Traefik handles routing, automatic HTTPS via Let's Encrypt, and basic authentication.

- Metrics & Monitoring:

  - Prometheus: Scrapes and stores metrics from the LLM server and GPU.
  - DCGM Exporter: Exposes detailed GPU metrics for Prometheus.
  - Grafana: Provides a pre-configured dashboard for visualizing all metrics.

## Installation

Prerequisites:
To install all the requirements on a fresh Ubuntu machine, you need the following dependencies:

- NVIDIA GPU with CUDA support

- NVIDIA Drivers

- Docker

- NVIDIA Container Toolkit

```sh
# Grant execute permissions to the script
chmod +x ./install-script

# Run the script
./install-script
```

**Warning**: Be careful running this command if you do not have a clean machine, as it will install system-level packages and configure the firewall. A reboot is required after the script finishes for all changes to take effect.

## Configuration

### DNS Setup

This deployment uses a single domain with different services accessed via subdirectories (e.g., /chat, /llm, /stats).

You need a domain name pointed to your server's IP address.

- Go to your DNS provider.

- Create an A Record that points your chosen domain (e.g., deployllm.yourdomain.com) to your server's public IP address.

### Environment Variables

Configuration of secrets and domain settings is handled in an .env file. Copy the example first.

```sh
cp .env.example .env
```

Open the .env file and fill in the following values:

- DOMAIN: Set this to the full domain you configured in the DNS setup (e.g., deployllm.yourdomain.com).

- HF_TOKEN: Your Hugging Face token, required for downloading gated models.

- BASIC_AUTH_USERS: Your htpasswd-generated credentials. Important: You must escape all $ characters by doubling them (e.g., $$).

- GRAFANA_ADMIN_USER / GRAFANA_ADMIN_PASSWORD: Credentials for the Grafana dashboard.

- ACME_EMAIL: A valid email address. This is required by Let's Encrypt for issuing production SSL certificates.

- CERTIFICATE_SERVER: For production, ensure the acme-v02.api.letsencrypt.org/directory line is uncommented.

### Firewall Configuration

The install-script attempts to configure ufw (Uncomplicated Firewall) to work with Docker. If you encounter issues, you may need to install the ufw-docker utility manually to ensure the firewall rules are applied correctly.

```sh
# Download the utility
sudo wget -O /usr/local/bin/ufw-docker [https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker](https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker)

# Make it executable
sudo chmod +x /usr/local/bin/ufw-docker

# Install the necessary firewall rules
sudo ufw-docker install

# Reload the firewall
sudo ufw reload
```

## Running the deployment

Once everything is configured, start the entire stack with Docker Compose.

```sh
# Build the frontend image and start all services in the background
docker compose up -d --build
```

## Accessing Services

- Chat Frontend: https://[your-domain]/chat/

- LLM API Endpoint: https://[your-domain]/llm/

- Grafana Dashboard: https://[your-domain]/stats/

## Troubleshooting

- 502 Bad Gateway: This usually means a backend service (like vllm) has crashed. Check the logs with docker logs <container_name> to diagnose the issue. Common causes include GPU errors or problems loading the model.

- 404 Not Found: This is a routing issue. Ensure your Traefik labels in docker-compose.yaml match the paths you are trying to access. For subdirectory setups, make sure the StripPrefix middleware is configured correctly.

- SSL Certificate Errors: If you see certificate warnings, make sure you have set a valid ACME_EMAIL and are using the production CERTIFICATE_SERVER in your .env file. You may need to stop the services (docker compose down), delete the ./letsencrypt directory, and start them again to force a new certificate request.
