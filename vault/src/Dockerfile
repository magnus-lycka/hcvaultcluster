FROM ubuntu:18.04

ENV VAULT_URL="https://releases.hashicorp.com/vault"
ENV VAULT_VERSION="1.4.0"

RUN apt-get update && apt-get install -y curl unzip openssl libcap2-bin

RUN curl \
      --silent \
      --remote-name \
     "${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"

RUN curl \
      --silent \
      --remote-name \
      "${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS"

RUN curl \
      --silent \
      --remote-name \
      "${VAULT_URL}/${VAULT_VERSION}/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig"

RUN unzip vault_${VAULT_VERSION}_linux_amd64.zip && \
    chown root:root vault && \
    mv vault /usr/local/bin/ 

RUN vault --version

# RUN setcap cap_ipc_lock=+ep /usr/local/bin/vault

RUN useradd --system --home /etc/vault.d --shell /bin/false vault

RUN mkdir --parents /etc/vault.d

COPY config/vault.hcl /etc/vault.d/vault.hcl

RUN cd /etc/vault.d/ && \
    sed -i "s/RANDFILE\s*=\s*\$ENV::HOME\/\.rnd/#/" /etc/ssl/openssl.cnf && \
    openssl req -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem \
    -subj "/C=SE/ST=VGR/L=Goteborg/O=Volvo Cars/OU=Org/CN=www.example.com" \
    -days 365

RUN chown --recursive vault:vault /etc/vault.d && chmod 640 /etc/vault.d/vault.hcl

RUN mkdir --parents /opt/raft && \
    chown -R vault:vault /opt/raft

