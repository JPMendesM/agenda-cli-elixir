defmodule AgendaCli.Store do
  @file_path "contacts.json"

  def load do
    case File.read(@file_path) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, contacts} -> contacts
          {:error, _} -> []
        end

      {:error, _} ->
        []
    end
  end

  def save(contacts) do
    json = Jason.encode!(contacts, pretty: true)
    File.write(@file_path, json)
  end
end
