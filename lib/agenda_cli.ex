defmodule AgendaCli do
  alias AgendaCli.Store
  alias AgendaCli.Contacts

  def main(_args \\ []) do
    contacts = Store.load()

    IO.puts("""
    =========================
       AGENDA DE CONTATOS
    =========================
    """)

    loop(contacts)
  end

  def loop(contacts) do
    input =
      IO.gets("agenda> ")
      |> to_string()
      |> String.trim()

    case String.split(input) do
      ["add" | rest] ->
        data = parse_flags(rest)

        updated_contacts =
          Contacts.add(contacts, data)

        Store.save(updated_contacts)

        IO.puts("Contato adicionado com sucesso!")

        loop(updated_contacts)

      ["list"] ->
        list_contacts(contacts)
        loop(contacts)

      ["show", id] ->
        show_contact(contacts, String.to_integer(id))
        loop(contacts)

      ["del", id] ->
        updated_contacts =
          Contacts.delete(contacts, String.to_integer(id))

        Store.save(updated_contacts)

        IO.puts("Contato removido!")

        loop(updated_contacts)

      ["search" | rest] ->
        {field, value} = parse_search(rest)

        results =
          Contacts.search(contacts, field, value)

        list_contacts(results)

        loop(contacts)

      ["edit", id | rest] ->
        updates = parse_flags(rest)

        updated_contacts =
          Contacts.edit(
            contacts,
            String.to_integer(id),
            updates
          )

        Store.save(updated_contacts)

        IO.puts("Contato atualizado!")

        loop(updated_contacts)

      ["exit"] ->
        IO.puts("Encerrando aplicação...")

      _ ->
        IO.puts("Comando inválido!")
        loop(contacts)
    end
  end

  def parse_flags(flags) do
    parse_flags(flags, %{})
  end

  def parse_flags([], acc), do: acc

  def parse_flags(["--name" | rest], acc) do
    {value, remaining} = extract_value(rest)

    parse_flags(
      remaining,
      Map.put(acc, "name", value)
    )
  end

  def parse_flags(["--company" | rest], acc) do
    {value, remaining} = extract_value(rest)

    parse_flags(
      remaining,
      Map.put(acc, "company", value)
    )
  end

  def parse_flags(["--phone" | rest], acc) do
    {value, remaining} = extract_value(rest)

    parse_flags(
      remaining,
      Map.put(acc, "phone", value)
    )
  end

  def parse_flags(["--email" | rest], acc) do
    {value, remaining} = extract_value(rest)

    parse_flags(
      remaining,
      Map.put(acc, "email", value)
    )
  end

  def extract_value(list) do
    {value, remaining} =
      Enum.split_while(list, fn item ->
        not String.starts_with?(item, "--")
      end)

    {Enum.join(value, " "), remaining}
  end

  def parse_search(["--name" | rest]) do
    {"name", Enum.join(rest, " ")}
  end

  def parse_search(["--phone" | rest]) do
    {"phone", Enum.join(rest, " ")}
  end

  def parse_search(["--email" | rest]) do
    {"email", Enum.join(rest, " ")}
  end

  def list_contacts([]) do
    IO.puts("Nenhum contato encontrado.")
  end

  def list_contacts(contacts) do
    Enum.each(contacts, fn contact ->
      IO.puts("""
      -------------------------
      ID: #{contact["id"]}
      Nome: #{contact["name"]}
      Empresa: #{contact["company"]}
      Telefone: #{contact["phone"]}
      Email: #{contact["email"]}
      """)
    end)
  end

  def show_contact(contacts, id) do
    case Contacts.find_by_id(contacts, id) do
      nil ->
        IO.puts("Contato não encontrado.")

      contact ->
        IO.puts("""
        -------------------------
        ID: #{contact["id"]}
        Nome: #{contact["name"]}
        Empresa: #{contact["company"]}
        Telefone: #{contact["phone"]}
        Email: #{contact["email"]}
        """)
    end
  end
end
