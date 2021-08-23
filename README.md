# docker-ttrss

Tiny Tiny RSS, a powerful Dockerised all-in-one RSS solution.

## plugins

### mailer_smtp

邮件配置案例如下：

```conf
# Use this server (hostname:port). Empty value disables plugin.
- TTRSS_SMTP_SERVER=smtp.qq.com:587
# Login/password for SMTP auth, if needed.
- TTRSS_SMTP_LOGIN=xxxxxxxxx@qq.com
- TTRSS_SMTP_PASSWORD=xxxxxxxxxxxx
# Use secure connection. Allowed values: `ssl`, `tls`, or empty.
- TTRSS_SMTP_SECURE=tls
- TTRSS_SMTP_FROM_ADDRESS=xxxxxxxxx@qq.com
- TTRSS_SMTP_FROM_NAME=TTRSS
```