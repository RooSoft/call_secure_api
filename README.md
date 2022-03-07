# Call Secure API

## Example calling LND on an umbrel, passing the cert and the macaroon

```bash
elixir call_secure_api.exs ~/.lnd/lnd.cert ~/.lnd/readonly.macaroon https://umbrel:8080/v1/state
```