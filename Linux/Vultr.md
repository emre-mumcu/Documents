1. Deploy a Server: Shared CPU / High Frequency $6/mo Ubuntu Server

2. Create SSH Key

ssh-keygen -t ed25519 -C "Key-Name"

ssh-keygen -t ed25519 -f ~/.ssh/server1_ed25519 -C "server1"
ssh-keygen -t ed25519 -f ~/.ssh/server2_ed25519 -C "server2"

3. Public key'i sunucuya ekle

mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys

type $env:USERPROFILE\.ssh\id_ed25519.pub komutunun çıktısını sunucudaki 

~/.ssh/authorized_keys

dosyasına ekle.

# Paste the key at the bootom:

chmod 600 ~/.ssh/authorized_keys
chown -R $USER:$USER ~/.ssh
sudo systemctl restart ssh

4. SSH portu değiştir

sudo nano /etc/ssh/sshd_config
#Port 22 >> Port 12211

sudo ufw status
sudo ufw allow 12211/tcp
sudo ufw delete allow 22/tcp
sudo systemctl restart ssh

5. Disabling Password Authentication on your Server

sudo nano /etc/ssh/sshd_config
PasswordAuthentication no
sudo systemctl restart ssh

6. DOTNET Yükleme

45.76.87.223


sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-10.0


sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-10.0


sudo apt-get install -y dotnet-runtime-10.0

7. nginx yükleme


# install nginx
sudo apt install nginx

# enable nginx service
sudo systemctl enable nginx

# start nginx
sudo service nginx status
sudo service nginx start


8. put zip to server

add files to server

ssh root@45.76.87.223 -p 12211

scp -P 12211 C:\Users\Emre\Desktop\nordeviaweb.zip root@45.76.87.223:/shared/


systemctl stop kestrel-nordeviaweb.service

unzip nordeviaweb.zip -d /inetpub/


8. kestrel service


useradd -s /bin/false -r kestrel

nano /etc/systemd/system/kestrel-nordevia.service


***************************
[Unit]
Description=Nordevia Web Application
After=network.target

[Service]
WorkingDirectory=/inetpub/nordeviaweb
ExecStart=/usr/bin/dotnet /inetpub/nordeviaweb/NordeviaWeb.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=nordeviaweb
User=kestrel
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false
 
[Install]
WantedBy=multi-user.target
***************************


systemctl enable kestrel-nordevia.service
systemctl start kestrel-nordevia
systemctl status kestrel-nordevia


9. nginx config


nano /etc/nginx/sites-available/nordeviaweb


***************************
server {
    listen 80;
    server_name nordevia.de www.nordevia.de;
    location / {
        proxy_pass         http://127.0.0.1:5555/;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection keep-alive;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
***************************
server {
    listen 80 default_server;
    server_name nordevia.de www.nordevia.de _;
    location / {
        proxy_pass         http://127.0.0.1:5555/;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection keep-alive;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
**************************************

Buradaki önemli kısım:

listen 80 default_server;
server_name ... _;

_ herhangi bir domain/IP isteğini yakalar.


Bunu kaldır: /etc/nginx/sites-enabled/default 

Gerekiyorsa: sudo ln -s /etc/nginx/sites-available/nordeviaweb /etc/nginx/sites-enabled/

sudo nginx -t

Ubuntu/Debian Nginx kurulumlarında bu yapı aktif/pasif site yönetimi için kullanılır.

Kısaca:

/etc/nginx/sites-available/ → Mevcut tüm site konfigürasyonlarının bulunduğu yer
/etc/nginx/sites-enabled/ → Nginx'in gerçekten yüklediği aktif siteler

Yani Nginx normalde sadece sites-enabled içindekileri okur.

Aktif etmek için sembolik link oluşturulur: sudo ln -s /etc/nginx/sites-available/nordeviaweb /etc/nginx/sites-enabled/


Siteyi kapatmak için: Dosyayı silmezsin: sudo rm /etc/nginx/sites-enabled/mysite Site kapanır ama konfigürasyonun durur:

Tekrar açmak:sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/

**************************************
Nginx bunu nasıl biliyor?

Ana config dosyası: /etc/nginx/nginx.conf

içinde genelde şu satır vardır: include /etc/nginx/sites-enabled/*;

**************************************
sudo nginx -t
sudo systemctl restart nginx

sudo ufw allow 'Nginx Full'


curl -4 serverip $ curl -4 icanhazip.com





Dosya ve Klasör İzinleri
------------------------
ls -l /inetpub/nordeviaweb/nordevia.db

sudo chown kestrel:kestrel /inetpub/nordeviaweb/nordevia.db
sudo chmod 664 /inetpub/nordeviaweb/nordevia.db


ls -ld /inetpub/nordeviaweb

sudo chown -R kestrel:kestrel /inetpub/nordeviaweb
sudo chmod 755 /inetpub/nordeviaweb





sudo certbot --nginx -d nordevia.de -d www.nordevia.de




~/.ssh/config dosyasını oluştur
-------------------------------

Host server1
    HostName 192.168.1.10
    User ubuntu
    IdentityFile ~/.ssh/server1_ed25519

Host server2
    HostName 10.10.10.20
    User root
    IdentityFile ~/.ssh/server2_ed25519

Host production
    HostName prod.example.com
    User deploy
    IdentityFile ~/.ssh/server3_ed25519


> ssh server1


Config kullanmadan da bağlanabilirsin
-------------------------------------
> ssh -i ~/.ssh/server2_ed25519 root@10.10.10.20









curl -H "Host: nordevia.de" http://127.0.0.1

curl -H "Host: nordevia.de" http://localhost:5555

Bu, Nginx'in gönderdiği Host bilgisini taklit eder ve ASP.NET Core tarafında host kontrolü (AllowedHosts vb.) varsa onu da test etmiş olur.


nslookup -type=ns nordevia.de 8.8.8.8

nslookup -type=ns nordevia.de 8.8.8.8

nslookup nordevia.de ns1.vultr.com
nslookup nordevia.de ns2.vultr.com













sudo apt install dnsutils
dig nordevia.de NS

sudo apt install whois
whois nordevia.de




-- ip ile de çalışır
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name nordevia.de www.nordevia.de 45.76.87.223 _;

    location / {
        proxy_pass http://127.0.0.1:5555;

        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}





ls -la /etc/nginx/sites-available/
ls -la /etc/nginx/sites-enabled/

sudo ln -s /etc/nginx/sites-available/nordeviaweb /etc/nginx/sites-enabled/nordeviaweb




dig nordevia.de +trace




SSL


sudo apt update

sudo apt install certbot python3-certbot-nginx

certbot --version

sudo nginx -T | grep -n "server_name"


server_name nordevia.de www.nordevia.de;



curl -H "Host: nordevia.de" http://127.0.0.1



sudo certbot --nginx -d nordevia.de -d www.nordevia.de


Email address:


http://nordevia.de


https://nordevia.de


sudo systemctl reload nginx


Certificate Name: nordevia.de
Domains: nordevia.de www.nordevia.de
Expiry Date: ...


systemctl status certbot.timer


sudo certbot renew --dry-run



using Microsoft.AspNetCore.HttpOverrides;

app.UseForwardedHeaders(new ForwardedHeadersOptions
{
    ForwardedHeaders =
        ForwardedHeaders.XForwardedFor |
        ForwardedHeaders.XForwardedProto
});

























sudo apt update
sudo apt install open-vm-tools open-vm-tools-desktop -y
sudo reboot
vmtoolsd --version


sudo poweroff
sudo shutdown -h now

sudo shutdown -h +10
sudo shutdown -h 23:30

sudo reboot

sudo shutdown -r +5

*********************************************

docker volume create portainer_data

docker run -d \
  --name portainer \
  --restart unless-stopped \
  -p 9000:9000 \
  -p 9443:9443 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

https://Ubuntu_IP:9443









Eğer Docker Compose kullanıyorsan Dockge çok başarılı.



Yacht
Image yükleme
Container oluşturma




/usr/local/bin ✅ (Kendi yüklediğin programlar için önerilen)
/usr/bin (Paket yöneticisinin kullandığı, elle dosya koyman önerilmez)
/bin (Temel sistem komutları)


Tüm kullanıcılar için: /usr/local/bin
Sadece kendi kullanıcın için: ~/.local/bin
PATH'te olmayan herhangi bir klasöre koyarsan, PATH'e eklemeden her yerden çalıştıramazsın.



Klasör yoksa?

Bazı sistemlerde başlangıçta oluşturulmaz. İsterseniz kendiniz oluşturabilirsiniz:

mkdir -p ~/.local/bin

Bash kullanıyorsanız

~/.bashrc dosyasına şu satırı ekleyin:

export PATH="$HOME/.local/bin:$PATH"

Ardından değişikliği yükleyin:

source ~/.bashrc


sudo apt update
sudo apt install open-vm-tools open-vm-tools-desktop -y
sudo reboot

systemctl status open-vm-tools








nano ~/.ssh/authorized_keys

cat ~/.ssh/authorized_keys

... ssh-rsa ..... mail.com


ufw status
ufw reload

ufw allow 1111/tcp
ufw allow 1111/udp

ufw delete allow 1111/tcp
ufw delete allow 1111/udp

nano /etc/ssh/sshd_config

... Port 1111

systemctl restart sshd.service

dotnet
------

sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-10.0


nginx
-----
sudo apt update
sudo apt install nginx
curl localhost
sudo ufw allow http
sudo ufw allow https

unzip nordeviaweb.zip -d /inetpub/


conf
----

nano /etc/nginx/sites-available/myapp

server {
    listen 80;
    server_name mumcu.net www.mumcu.net;
    location / {
        proxy_pass         http://127.0.0.1:5000/;
        proxy_http_version 1.1;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection keep-alive;
        proxy_set_header   Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}

sudo nginx -t
sudo systemctl restart nginx


sudo nginx -T | grep -n "server_name _"
sudo nginx -T



systemctl list-units kestrel-* --all
systemctl list-unit-files kestrel-*
systemctl status kestrel-*
systemctl reset-failed
systemctl daemon-reload

systemctl enable myapp.service
systemctl start myapp
systemctl status myapp



