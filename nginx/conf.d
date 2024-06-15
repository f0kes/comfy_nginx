upstream comfyui {
    server comfyui:8188;
}

upstream jupyter {
    server jupyter:8888;
}

server {
    listen 80 default_server;
    server_name _;

    location /comfyui/ {
        proxy_pass http://comfyui;
        rewrite ^/comfyui(.*) $1 break;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /jupyter/ {
        proxy_pass http://jupyter;
        rewrite ^/jupyter(.*) $1 break;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    auth_basic "Restricted Content";
    auth_basic_user_file /etc/nginx/.htpasswd;
}
