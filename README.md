# README

### Запуск в докере

сначала скопировать .env.sample в .env, настроить переменные

для разработки

```
docker-compose build
docker-compose run --service-ports web bash

```

запуск сервера

```
bin/rails s -b 0.0.0.0
```

запуск тестов

```
bin/rspec
```
