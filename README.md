**RD Station - Desafio: Lógica do Carrinho de Compras**
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Este projeto é um desafio técnico da RD Station, com o objetivo de implementar a lógica que gerencia um carrinho de compras. Além disso, o projeto está configurado para rodar tanto em um ambiente local quanto via Docker.

Funcionalidades
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- Adicionar itens ao carrinho.
- Remover itens do carrinho.
- Atualizar a quantidade de itens no carrinho.
- Calcular o total do carrinho com base nos itens adicionados.
- Marcar carrinho como abandonado, caso esteja sem alteração a 3 horas.
- Descartar quando abandonado por 7 dias.

Tecnologias Utilizadas
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

- Ruby: Linguagem principal.
- Rails: Framework para estruturação do projeto.
- PostgreSQL: Banco de dados.
- Redis: Utilizado para suporte ao processamento em background com Sidekiq.
- Sidekiq: Gerenciador de jobs em background.
- RSpec: Framework para testes.
- Docker e Docker Compose: Para criar e gerenciar containers.

Pré-requisitos
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

- Ruby 3.3.1.
- PostgreSQL.
- Redis 7.0.15 ou superior.
- Docker e Docker Compose (caso escolha rodar via container).

Rodando o Projeto (Sem Docker)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Clone o repositório:
```
git clone https://github.com/seu-usuario/rdstation-desafio-carrinho.git
```
```
cd rdstation-desafio-carrinho
```

Instale as dependências:
```
bundle install
```

Crie e execute as migrações:
```
rails db:create db:migrate
```
Inicie o Redis:
```
redis-server
```

Inicie o servidor Rails:
```
rails server
```
Opcional - Execute o Sidekiq para tarefas em background:
```
bundle exec sidekiq
```

Execute os testes:
```
bundle exec rspec
```

Rodando o Projeto (Com Docker)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Inicie os containers:
```
docker-compose up --build
```

Acesse o aplicativo:

O servidor Rails estará disponível em ``http://localhost:3000.``

Execute os testes (dentro do container):

Acesse o container web:
```
docker-compose exec web bash
```

Execute os testes:
```
bundle exec rspec
```

Comandos Úteis
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Sem Docker
- Iniciar o servidor Rails: bin/rails s
- Iniciar o Redis: redis-server
- Executar testes: bin/rspec
- Iniciar Sidekiq: bundle exec sidekiq

Com Docker
- Iniciar containers: docker-compose up --build
- Derrubar containers: docker-compose down
- Acessar o container Rails: docker-compose exec web bash
- Rodar Redis automaticamente no container redis via Docker Compose.

