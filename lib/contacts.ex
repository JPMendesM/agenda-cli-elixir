defmodule AgendaCli.Contacts do
  def add(contacts, data) do
    contact =
      %{
        "id" => System.system_time(:millisecond),
        "name" => Map.get(data, "name", ""),
        "company" => Map.get(data, "company", ""),
        "phone" => Map.get(data, "phone", ""),
        "email" => Map.get(data, "email", "")
      }

      contacts ++ [contact]
  end

  def delete(contacts, id) do
    Enum.reject(contacts, fn contact ->
      contact["id"] == id
    end)
  end

  def find_by_id(contact, id) do
    Enum.find(contact, fn contact ->
      contact["id"] == id
    end)
  end

  def edit(contacts, id, updates) do
    Enum.map(contacts, fn contact ->
      if contact["id"] == id do
        Map.merge(contact, updates)
    else
      contact
      end

    end)
  end

  def search(contacts, field, value) do
    Enum.filter(contacts, fn contact ->
      contact
      |> Map.get(field, "")
      |> String.downcase()
      |> String.contains?(String.downcase(value))
    end)
  end
end
