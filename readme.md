# Litecoin docker

Данный контейнер позволяет изолированно быстро развертывать litecoind демона на сервере.

## Команды

Если запускать вне состава composer, то можно следующими командами:

Для запуска тестовой среды:
```bash
docker run -d --name litecoind-test \
-v /litecoin-test:/data \
-p 23391:23391 \
-e TESTNET=1 \
-e RPCUSER=ltcuser \
-e RPCPASSWORD=saintpetersburg \
-e RPCPORT=23391 \
repositoryName/litecoind
```
Где `/litecoin` - путь на хост машине, `/data` - путь в docker. В этих папках находятся конфигурации, блоки, wallet.dat и прочее

Порты 9333 и 19333 для связи с другими нодами, а вот rpc - для апишки. Для api мы используем 2339 и 23391 (testnet).

Чтобы протестировать работу, можно из хост машины сделать вот такой запрос:

```bash
curl --user ltcuser --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:23391/
```


Если `litecoin.conf` не существует, он будет автоматически сгенерирован:

| name | default value |
| ---- | ------- |
| RPCUSER | ltcuser |
| RPCPASSWORD | saintpetersburg |
| RPCPORT | 2339 |
| TESTNET | 0 |
| printtoconsole |  1 |
| rpcallowip  | ::/0 |

Однако, если он существует, то перезаписываться он не будет.

При использовании режима `testnet`, не забудьте указать порт 23391
