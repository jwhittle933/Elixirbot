# Elixirbot

_For testing basic Elixir execution and sharing code samples with team members._

### Description
Elixir integration for Slack. This bot is privately deployed (and will stay that way for the foreseeable future, unless someone wants to host this publically :) ). To integrate into your slack channel, clone the repo (or fork it and make it better), build the docker image, and deploy to your favorite cloud. The Makefile at the root can be configured to meet your needs and do some heavy lifting. 

### Configuration and Deployment
To configure this bot (or any bot) you need to register it with your Slack channel. One registered, you need to associate a 'slash' command (`/helix` was my choice) and configure permissions. For this bot, you need to ensure the it has `chat:write:bot`, `chat:write:user`, and `channels:read`. The bot as is doesn't use webhooks to respond (not directly), but just responds to the `post` request as it would any other request, seemingly agnostic to where the request came from. In other words, Elixir bot is an API, nothing more. My choice of deployment is AWS EC2, but GCP and Heroku are also good options (although they need to be configured differently). 

### Example Uses
`/helix 10 + 10`
```
Elixirbot> 20
```

`/helix Enum.map([1, 2, 3], fn x -> x * 2 end)`
```
Elixirbot> [2, 4, 6]
```

`/helix x = fn x -> x / 2 end \n x.(6)`
> the newline here is for reference. In Slack, hold SHFT + ENTER to create newline
```
Elixirbot> 3
```

### Unsupported
No `def*` methods are supported, as this bot is not inteded to be `iex` in Slack. 

