defmodule HTTPGetter do
  def get_headers(macaroon_filename) do
    [
      {'MACAROON_HEADER', 'Grpc-Metadata-macaroon: #{read_macaroon(macaroon_filename)}'}
    ]
  end

  def die(msg) do
    IO.puts(:stderr, msg)
    exit({:shutdown, 1})
  end

  def get(macaroon_filename, cert_filename, url) do
    headers = get_headers(macaroon_filename)
    request = {String.to_charlist(url), headers}
    options = get_options(cert_filename)

    case :httpc.request(:get, request, options, []) do
      {:ok, {{_v, 200, _m}, _h, body}} -> :erlang.list_to_binary(body)
      {:error, e} -> die("Error: #{inspect(e)}")
    end
  end

  def main([cert, macaroon, url]) do
    :ssl.start()
    :inets.start()
    get(cert, macaroon, url) |> IO.write()
  end

  def main(_), do: die("Usage: call_secure_api.exs <cert filename> <macaroon filename> <url>")

  defp read_macaroon(macaroon_filename) do
    File.read!(macaroon_filename) |> Base.encode16()
  end

  defp get_options(cert_filename) do
    [ssl: [cacertfile: cert_filename]]
  end
end

HTTPGetter.main(System.argv())
