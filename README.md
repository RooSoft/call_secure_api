# Call Secure API

This mostly is a proof of concept to call a LND REST API on a Umbrel... still, it's written in an abstract way to enable calling any secure REST endpoint.

## Example

Get Umbrel's LND state, passing the cert and the macaroon to get the service's state

```bash
elixir call_secure_api.exs ~/.lnd/lnd.cert ~/.lnd/readonly.macaroon https://umbrel:8080/v1/state
```
