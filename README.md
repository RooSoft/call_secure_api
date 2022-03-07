# Call Secure API

This mostly is a proof of concept to call a LND REST API on a Umbrel... still, it's written in an abstract way to enable calling any secure REST endpoint.

## Example

Get Umbrel's LND state, passing the cert and the macaroon to get the service's state

Parameters:

1. TLS Certificate
1. Macaroon
1. URL
1. Output filename

```bash
elixir call_secure_api.exs ~/.lnd/lnd.cert ~/.lnd/readonly.macaroon https://umbrel:8080/v1/graph graph.json
```
