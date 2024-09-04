# Backup do Banco de Dados PostgreSQL para Storage via Docker

## Apresentação

Este projeto demonstra como configurar um ambiente Docker para realizar o backup de um banco de dados PostgreSQL diretamente em um storage remoto via CIFS/SMB. O projeto simula um ambiente utilizando contêineres Docker e inclui um script bash que automatiza o processo de backup, desde a montagem do storage até a limpeza de backups antigos.

## Artigo no LinkedIn

Para uma explicação detalhada do processo e um passo a passo completo, confira o artigo publicado no LinkedIn:

[Realizando Backup do Banco de Dados PostgreSQL para um Storage](https://www.linkedin.com/pulse/realizando-backup-do-banco-de-dados-postgresql-para-daniel-pgyje/)

## Como Rodar o Container

### Pré-requisitos

Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

### Passos para Rodar o Ambiente

1.  **Clone o repositório:**

    ```bash
    git clone https://github.com/danbackeres/backup-postgres-storage.git
    cd backup-postgres-storage
    ```

2.  **Suba os Contêineres**:

    ```bash
    docker-compose up -d
    ```

    Isso irá iniciar o contêiner do PostgreSQL e o contêiner que simula o storage.

3.  **Configure o script de backup:**
    Navegue até o contêiner do PostgreSQL e configure o script de backup conforme detalhado no artigo:
    ```bash
    docker exec -it postgres-db bash
    cd /scripts
    nano backup.sh
    ```

## Contribuições

Sinta-se à vontade para fazer fork do projeto, abrir issues ou enviar pull requests. Toda contribuição é bem-vinda!
