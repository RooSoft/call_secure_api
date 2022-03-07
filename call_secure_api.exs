defmodule HTTPGetter do
  def main([cert, macaroon, url]) do
    :ssl.start()
    :inets.start()
    get(cert, macaroon, url) |> IO.write()
  end

  def main(_), do: die("Usage: call_secure_api.exs <cert filename> <macaroon filename> <url>")

  defp die(msg) do
    IO.puts(:stderr, msg)
    exit({:shutdown, 1})
  end

  defp get_headers(macaroon_filename) do
    [
      {'Grpc-Metadata-macaroon', macaroon_filename |> read_macaroon |> to_charlist}
    ]
  end

  defp read_macaroon(macaroon_filename) do
    File.read!(macaroon_filename) |> Base.encode16()
  end

  defp get_options(cert_filename) do
    [ssl: [cacertfile: cert_filename]]
  end

  defp get(cert_filename, macaroon_filename, url) do
    headers = get_headers(macaroon_filename)
    request = {String.to_charlist(url), headers}
    options = get_options(cert_filename)

    case :httpc.request(:get, request, options, []) do
      {:ok, {{_v, 200, _m}, _h, body}} -> :erlang.list_to_binary(body)
      {:error, e} -> die("Error: #{inspect(e)}")
    end
  end
end

HTTPGetter.main(System.argv())
