# DuckDNS Systemd Service & Timer Management

## Introdução
Este documento fornece instruções detalhadas para gerenciar o serviço DuckDNS utilizando `systemd`. Aqui estão incluídos comandos para iniciar, parar, habilitar, desabilitar e verificar o status do serviço e do timer.

---

## Listando Timers e Serviços

### Listar todos os timers ativos (incluindo os agendados)
Exibe todos os timers programados no `systemd`.
```bash
systemctl list-timers --all
```

### Verificar o status do serviço DuckDNS
Mostra o status atual do serviço, incluindo logs recentes e última execução.
```bash
systemctl status duckdns.service
```

### Verificar o status do timer DuckDNS
Verifica se o timer está ativo e quando ele será executado novamente.
```bash
systemctl status duckdns.timer
```

---

## Iniciando e Testando o Serviço Manualmente

### Executar o serviço imediatamente (para testes)
Executa a atualização do DuckDNS manualmente sem esperar pelo timer.
```bash
sudo systemctl start duckdns.service
```

### Executar o timer imediatamente
Força a execução do timer, disparando o serviço associado.
```bash
sudo systemctl start duckdns.timer
```

---

## Habilitando no Boot

### Habilitar o serviço DuckDNS
Ativa o serviço para iniciar automaticamente no boot (geralmente não necessário se o timer estiver configurado corretamente).
```bash
sudo systemctl enable duckdns.service
```

### Habilitar o timer para rodar automaticamente no boot
Ativa o timer para garantir que o serviço seja executado em intervalos regulares após a inicialização do sistema.
```bash
sudo systemctl enable duckdns.timer
```

---

## Parando e Desabilitando o Serviço/Timer

### Parar o serviço manualmente
Interrompe a execução do serviço, caso esteja rodando no momento.
```bash
sudo systemctl stop duckdns.service
```

### Desabilitar o serviço
Impede que o serviço seja iniciado automaticamente no boot.
```bash
sudo systemctl disable duckdns.service
```

### Parar o timer manualmente
Interrompe a execução do timer até que seja reiniciado.
```bash
sudo systemctl stop duckdns.timer
```

### Desabilitar o timer
Impede que o timer seja ativado automaticamente após a inicialização do sistema.
```bash
sudo systemctl disable duckdns.timer
```

---

## Removendo o Serviço e o Timer

### Remover completamente o serviço e o timer
Exclui os arquivos de configuração do serviço e do timer e recarrega o `systemd`.
```bash
sudo rm /etc/systemd/system/duckdns.service
sudo rm /etc/systemd/system/duckdns.timer
sudo systemctl daemon-reload
```

---

## Aplicando Mudanças no `systemd`

### Recarregar o `systemd` após alterações
Sempre que modificar os arquivos `duckdns.service` ou `duckdns.timer`, rode o comando abaixo para garantir que o `systemd` reconheça as mudanças.
```bash
sudo systemctl daemon-reload
```

---

## Dicas e Solução de Problemas

- **Se o serviço não iniciar corretamente**, verifique os logs com:
  ```bash
  journalctl -u duckdns.service --no-pager --since "10 minutes ago"
  ```
- **Se o timer não estiver rodando corretamente**, confirme sua programação com:
  ```bash
  systemctl list-timers | grep duckdns
  ```
- **Se o caminho do script estiver incorreto**, corrija em `/etc/systemd/system/duckdns.service` e execute `daemon-reload`.

---

✅ Com este guia, você pode operar e manter seu serviço DuckDNS de forma eficiente! 🚀

