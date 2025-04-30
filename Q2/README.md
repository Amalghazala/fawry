##  Step 1: Confirm DNS Resolution Fails via Public DNS

```bash
dig internal.example.com @8.8.8.8
```
![Image](https://github.com/user-attachments/assets/61f8a205-faf6-4b66-800e-bbad76785d48)

![Image](https://github.com/user-attachments/assets/13d39578-3641-43e0-82a3-4a0f63117efe)

Result:
DNS query returns NXDOMAIN — name not found.

##  Step 2: Add Local Host Entry to Bypass DNS

```bash
cat /etc/hosts
```
![Image](https://github.com/user-attachments/assets/8071155c-196e-4da6-9992-877f7c303b4b)

## Step 3: Confirm Success with curl

```bash
curl http://internal.example.com
```
![Image](https://github.com/user-attachments/assets/675a1131-3605-437f-986d-ebaf4ea231a7)

## Step 4: Confirm nginx is Running

To ensure that the Nginx web server is reachable via HTTP, I allowed TCP traffic on port 80 using UFW:
```bash
sudo ufw allow 80/tcp
```
![Image](https://github.com/user-attachments/assets/7c95b03a-a0bc-4fc4-97f4-f1c452b229bd)

```bash
sudo systemctl status nginx
```
![Image](https://github.com/user-attachments/assets/d607972d-ecd2-4c8c-9297-d90f3c54d2aa)

## Step 5: Confirm Internal IP is Correct

```bash
ip a | grep inet
```
![Image](https://github.com/user-attachments/assets/636085e0-cabb-45c9-8d89-d0c3f0e788c0)

## Bonus - Persistent DNS Settings

To persist DNS settings using `systemd-resolved`, I used the following commands:

```bash
sudo resolvectl dns enp0s3 8.8.8.8
sudo resolvectl domain enp0s3 "~."
```
![Image](https://github.com/user-attachments/assets/0ecce86e-f332-424d-8bb4-9ef0bf77e511)

