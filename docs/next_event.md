# Próximo Evento
- Obtem dados do evento (nome do grupo, data do evento e uma lista de jogadores)
- Os jogadores que não confirmaram presença devem ser exibidos em ordem alfabética
- Os jogadores que confirmaram presença devem ser exibidos por ordem de confirmação
- Separar quem confirmou dentro e fora
- Separar quem confirmou dentro por posição (goleiros e jogadores de linha)

# Jogador
- Cada jogador tem: nome, foto, posição, status de confirmação e data de confirmação
- Caso o jogador não tenha foto exibir as iniciais dele no local da foto
- As iniciais em nomes com sobrenome devem sempre ser a primeira letra do primeiro e do último nome
- Caso não tenha sobrenome, mostrar as 2 primeiras letras do primeiro nome
- Se o nome tiver apenas 1 letra, mostrar essa letra na inicial
- Se o nome estiver vazio, mostrar um hífen (-) nas iniciais
- Ignorar espaços em branco, no final, no início ou entre os nomes
- Sempre mostrar as iniciais em maiúsculo

# API
- GET para a rota https://domain.com/api/groups/:groupId/next_event
- Enviar headers "content-type" e "accept", ambos com valor "application/json"
- Retornar Unexpected Error em caso de 400, 403, 404 e 500
- Retornar Session Expired Error em caso de 401
- Retornar dados do evento em caso de 200