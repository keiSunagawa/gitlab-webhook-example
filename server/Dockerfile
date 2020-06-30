FROM elixir:latest

RUN mkdir /src

COPY ./request_logging /src/request_logging

RUN cd /src/request_logging && mix local.hex  --force && mix deps.get  --force && mix compile

ENTRYPOINT cd /src/request_logging && mix phx.server
