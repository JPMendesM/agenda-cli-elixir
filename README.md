# Agenda CLI em Elixir

Aplicação de linha de comando (CLI) desenvolvida em Elixir para gerenciamento de contatos pessoais.

Projeto desenvolvido para a disciplina de Programação Funcional utilizando os conceitos de:

- Imutabilidade
- Pattern Matching
- Recursão de cauda
- Pipe Operator (`|>`)
- Serialização JSON
- Organização modular

---

# Funcionalidades

A aplicação permite:

- Adicionar contatos
- Editar contatos
- Remover contatos
- Listar contatos
- Buscar contatos
- Persistência em arquivo JSON

---

# Estrutura do Projeto

```txt
lib/
├── agenda_cli.ex
├── contacts.ex
└── store.ex
```

## Responsabilidades

### AgendaCli
Responsável pelo loop principal da aplicação, parsing de comandos e interação com o usuário.

### AgendaCli.Contacts
Responsável pelas operações puras de manipulação da lista de contatos.

### AgendaCli.Store
Responsável pela leitura e escrita do arquivo JSON.

---

# Modelo de Contato

Cada contato possui:

| Campo | Tipo |
|---|---|
| id | integer |
| name | string |
| company | string |
| phone | string |
| email | string |

---

# Dependências

- Elixir
- Jason

---

# Instalação

Clone o repositório:

```bash
git clone https://github.com/JPMendesM/agenda-cli-elixir.git
```

Entre na pasta:

```bash
cd agenda-cli-elixir
```

Instale as dependências:

```bash
mix deps.get
```

Crie o arquivo JSON:

```bash
echo [] > contacts.json
```

---

# Execução

Execute o projeto com:

```bash
mix run -e "AgendaCli.main()"
```

---

# Comandos

## Adicionar contato

```txt
add --name Ana Lima --company Acme --phone 85912345678 --email ana@gmail.com
```

## Listar contatos

```txt
list
```

## Exibir contato

```txt
show 123
```

## Buscar contato

### Buscar por nome

```txt
search --name ana
```

### Buscar por telefone

```txt
search --phone 85
```

### Buscar por email

```txt
search --email gmail
```

## Editar contato

```txt
edit 123 --phone 85999999999
```

## Remover contato

```txt
del 123
```

## Encerrar aplicação

```txt
exit
```

---

# Persistência de Dados

Os dados são armazenados no arquivo:

```txt
contacts.json
```

A leitura ocorre no início da aplicação e o salvamento é realizado automaticamente após operações de escrita.

---

# Conceitos Utilizados

## Recursão de Cauda

O loop principal da aplicação foi implementado utilizando recursão de cauda através da função:

```elixir
loop(contacts)
```

## Pattern Matching

O parsing dos comandos foi implementado utilizando pattern matching em cláusulas de função e `case`.

Exemplo:

```elixir
["list"] ->
```

## Imutabilidade

Nenhuma estrutura mutável ou variável global foi utilizada. O estado da aplicação é propagado através de parâmetros de função.

---

# Autor

João Pedro Mendes