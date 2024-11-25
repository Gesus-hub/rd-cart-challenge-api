RD Station - Desafio: Lógica do Carrinho de Compras
Este projeto é um desafio técnico da RD Station, com o objetivo de implementar a lógica que gerencia um carrinho de compras. Além disso, o projeto está configurado para rodar tanto em um ambiente local quanto via Docker.

Funcionalidades
Adicionar itens ao carrinho.
Remover itens do carrinho.
Atualizar a quantidade de itens no carrinho.
Calcular o total do carrinho com base nos itens adicionados.
Aplicar regras de desconto, se necessário.
Tecnologias Utilizadas
Ruby: Linguagem principal.
Rails: Framework para estruturação do projeto.
PostgreSQL: Banco de dados.
Redis: Utilizado para suporte ao processamento em background com Sidekiq.
Sidekiq: Gerenciador de jobs em background.
RSpec: Framework para testes.
Docker e Docker Compose: Para criar e gerenciar containers.
Pré-requisitos
Ruby 3.3.1 ou superior.
PostgreSQL 16 ou superior.
Redis 7.0.15 ou superior.
Node.js e Yarn (para dependências front-end do Rails, se necessário).
Docker e Docker Compose (caso escolha rodar via container).
Rodando o Projeto (Sem Docker)
Clone o repositório:

bash
Copiar código
git clone https://github.com/seu-usuario/rdstation-desafio-carrinho.git
cd rdstation-desafio-carrinho
Instale as dependências:

bash
Copiar código
bundle install
Configure o banco de dados:

Edite o arquivo config/database.yml com suas credenciais locais de banco de dados.
Crie e execute as migrações:
bash
Copiar código
rails db:create db:migrate
Inicie o Redis:

Certifique-se de que o Redis está instalado e inicie-o:
bash
Copiar código
redis-server
Inicie o servidor Rails:

bash
Copiar código
rails server
Opcional: Execute o Sidekiq para tarefas em background:

bash
Copiar código
bundle exec sidekiq
Execute os testes:

bash
Copiar código
bundle exec rspec
Rodando o Projeto (Com Docker)
Clone o repositório:

bash
Copiar código
git clone https://github.com/seu-usuario/rdstation-desafio-carrinho.git
cd rdstation-desafio-carrinho
Inicie os containers:

bash
Copiar código
docker-compose up --build
Acesse o aplicativo:

O servidor Rails estará disponível em http://localhost:3000.
Execute os testes (dentro do container):

Acesse o container web:
bash
Copiar código
docker-compose exec web bash
Execute os testes:
bash
Copiar código
bundle exec rspec
Comandos Úteis
Sem Docker
Iniciar o servidor Rails: rails server
Iniciar o Redis: redis-server
Executar testes: bundle exec rspec
Iniciar Sidekiq: bundle exec sidekiq
Com Docker
Iniciar containers: docker-compose up --build
Derrubar containers: docker-compose down
Acessar o container Rails: docker-compose exec web bash
Rodar Redis automaticamente no container redis via Docker Compose.
Estrutura do Projeto
app/models - Modelos do Rails, incluindo o modelo do carrinho.
app/controllers - Lógica dos endpoints para interagir com o carrinho.
spec/ - Testes automatizados utilizando RSpec.
Dockerfile - Configuração para criar a imagem Docker.
docker-compose.yml - Configuração para orquestrar os serviços do projeto.
