defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.User
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{id: id_usuario}, data_completa, cidade_origem, cidade_destino)
      when is_bitstring(cidade_origem) and is_bitstring(cidade_destino) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id_usuario
     }}
  end

  def build({:error, _reason} = user_error, _data_completa, _cidade_origem, _cidade_destino),
    do: user_error

  def build(_user, _data_completa, _cidade_origem, _cidade_destino),
    do: {:error, "Invalid parameters"}
end
