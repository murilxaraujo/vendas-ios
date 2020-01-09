# Aplicativo de vendas

O aplicativo Vendas fornece aos vendedores externos uma forma mais prática, rápida e segura de realizar pedidos.
A aplicação foi desenvolvida em Swift e se conecta ao Protheus através de APIs REST.

## Instalação
Clone o repositório usando o comando
`git clone` ou baixando o arquivo zip diretamente.
Após baixar o repositório use o comando 
`pod install` para instalar as dependências e bibliotecas.

* A aplicação já está conectada à uma API de testes

## Funcionalidades
* Banco de dados local para funcionamento offline: A aplicação salva os dados localmente usando o banco de dados Realm, similar à biblioteca CoreData, salvando os objetos permitindo um query rápido e preciso.
* Assinatura digital do cliente: A fim de envitar a burocracia de enviar um pdf do pedido, pedir para que ele assine, escaneie e retorne o pedido, a aplicação colherá a assinatura do cliente no final do pedido de forma digital que entrará como anexo junto ao pedido.
* Atualização automática de dados: Toda vez que o usuário entra na aplicação, enquanto conectado à uma rede Wi-Fi a aplicação atualizará os dados de clientes e produtos no background, assim economizando dados móveis e garantindo que o vendedor sempre tenha em mãos informações atualizadas.

<img src="https://i.imgur.com/JXRY25x.png" width="100px">
