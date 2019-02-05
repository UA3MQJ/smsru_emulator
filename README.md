# SmsruEmulator

Эмулятор сервера sms.ru для отладки отправки сообщений, например, каким-нибудь самодельным сервисом рассылки. Отвечает всегда одно и то же (sms_id, balance). Можно посмотреть, что отправляли по номерам.

# Отправка сообщения

```
curl 'http://127.0.0.1:8080/sms/send?api_id=0&to=79998887766&from=companyname&msg=hello+world&json=1'
curl 'http://127.0.0.1:8080/sms/send?api_id=0&to=79998887766&from=companyname&msg=hello+world2&json=1'
curl 'http://127.0.0.1:8080/sms/send?api_id=0&to=79998887700&from=companyname&msg=hello+world3&json=1'
```

# Просмотр

[<img src="img1.png">]

[<img src="img2.png">]
