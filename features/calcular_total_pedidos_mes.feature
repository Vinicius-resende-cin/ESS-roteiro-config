Feature: Calcular Total de Pedidos no Mês
    As a Usuário registrado no sistema
    I want to ser capaz de acessar um cálculo mensal do total dos pedidos, valor total de pedidos e valor médio dos pedidos no mês

    Scenario: Cálculo bem sucedido de pedidos do último mês
        Given eu estou logado como “Usuário” com login “vrb” e senha “1234”
        And eu estou na página “Resumo mensal”
        And no período de “12/2022” até “12/2022” houveram “10” pedidos, de valor total igual a “R$500,00”
        When eu seleciono o período do cálculo de “12/2022” até “12/2022”
        Then eu posso ver o “quantidade total” dos pedidos igual a “10”
        And eu posso ver o “valor total” dos pedidos igual a “R$500,00” 
        And eu posso ver o “média do valor” dos pedidos igual a “R$50,00”
        And eu posso ver a lista de pedidos do período

    Scenario: Tentativa de cálculo quando não há nenhum pedido no período
        Given eu estou logado como “Usuário” com login “vrb” e senha “1234”
        And eu estou na página “Resumo mensal”
        And no período de “12/2022” até “12/2022” houveram “0” pedidos, de valor total igual a “R$0,00”
        When  eu seleciono o período do cálculo de “12/2022” até “12/2022”
        Then eu vejo uma mensagem de “falha por falta de pedidos”

    Scenario: Cálculo de todos os pedidos já feitos
        Given eu estou logado como “Usuário” com login “vrb” e senha “1234”
        And eu estou na página “Resumo mensal”
        And eu fiz o meu primeiro pedido em “05/2022”
        And no período de “05/2022” até “12/2022” houveram “32” pedidos, de valor total igual a “R$1472,00”
        When eu solicito o cálculo para todo o período
        Then eu posso ver o “quantidade total” dos pedidos igual a “32”
        And eu posso ver o “valor total” dos pedidos igual a “R$1472,00” 
        And eu posso ver o “média do valor” dos pedidos igual a “R$46,00”
        And eu posso ver a lista de pedidos do período

    Scenario: Filtrar apenas o valor total dos pedidos do período
        Given eu estou logado como “Usuário” com login “vrb” e senha “1234”
        And eu estou na página “Resumo mensal”
        And no período de “12/2022” até “12/2022” houveram “10” pedidos, de valor total igual a “R$500,00”
        When eu seleciono o período do cálculo de “12/2022” até “12/2022”
        And eu filtro apenas por “valor total” dos pedidos
        Then eu posso ver o “valor total” dos pedidos igual a “R$500,00”
        And eu não posso ver o “quantidade total” dos pedidos
        And eu não posso ver o “média do valor” dos pedidos
        And eu posso ver a lista de pedidos do período

    Scenario: Tentativa de cálculo de pedidos por um usuário que não está logado no sistema
        Given eu não estou logado no sistema
        When eu tento acessar a página "Resumo Mensal"
        Then eu vejo uma mensagem de “falha de autenticação"
        And eu sou redirecionado para a página "Login"

    # Este cenário equivale ao cenário "Tentativa de cálculo quando não há nenhum pedido no período"
    @ignore
    Scenario: Tentativa de filtrar valores quando não há nenhum pedido
        Given eu estou logado como “Usuário” com login “vrb” e senha “1234”
        And eu estou na página “Resumo mensal”
        And no período de “12/2022” até “12/2022” houveram “0” pedidos, de valor total igual a “R$,00”
        When eu seleciono o período do cálculo de “12/2022” até “12/2022”
        And eu filtro apenas por “valor total” dos pedidos
        Then eu vejo uma mensagem de “falha por falta de pedidos”
