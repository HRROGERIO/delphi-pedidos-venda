Sistema de Pedidos de Venda (Delphi + MySQL)

Projeto desenvolvido como teste técnico para vaga de Programador Delphi.

Tecnologias Utilizadas
Delphi (VCL)
MySQL
SQL (ênfase em queries)
Programação Orientada a Objetos (POO)

Funcionalidades
Seleção de cliente
Inserção de produtos no pedido
Grid com:
Código do produto
Descrição
Quantidade
Valor Unitário
Valor Total
Alteração de itens (ENTER)
Exclusão de itens (DEL com confirmação)
Cálculo automático do total do pedido
Gravação com transação
Carregamento de pedidos existentes
Exclusão de pedidos

Estrutura do Banco de Dados
Tabela: clientes
codigo (PK)
nome
cidade
uf

Tabela: pedidos
numero_pedido (PK)
data_emissao
codigo_cliente (FK)
valor_total

Tabela: pedidos_produtos
id (PK - autoincremento)
numero_pedido (FK)
codigo_produto (FK)
quantidade
valor_unitario
valor_total

Regras Implementadas
Uso de transações para gravação
Integridade com PK e FK
Índices para performance
Número de pedido sequencial
Permite repetição de produtos no pedido
Validação antes de exclusão

Controle de Transação
A gravação do pedido utiliza transação para garantir integridade:

- Inicia transação
- Grava pedido
- Grava itens
- Commit em caso de sucesso
- Rollback em caso de erro
