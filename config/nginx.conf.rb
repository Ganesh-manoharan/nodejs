daemon off;

worker_processes <%= ENV['NGINX_WORKERS'] || 4 %>;

events {
    use epoll;
    accept_mutex on;
    worker_connections 1024;
}

http {
    # Buffers
    client_body_buffer_size 10K;
    client_header_buffer_size 1k;
    client_max_body_size 8m;
    large_client_header_buffers 2 1k;

    # Timeouts
    client_body_timeout 12;
    client_header_timeout 12;
    keepalive_timeout 15;
    send_timeout 10;

    # Gzip
    gzip on;
    gzip_comp_level 2;
    gzip_min_length 1000;
    gzip_proxied expired no-cache no-store private auth;
    gzip_types text/plain application/x-javascript text/xml text/css application/xml;

    # Logging
    log_format l2met 'measure#nginx.service=$request_time request_id=$http_x_request_id';
    access_log off;
    error_log off;

    # Other
    server_tokens off;
    include mime.types;
    sendfile on;
    
server {
        listen 80;

        server_name cn-node-app.herokuapp.com;


location / {
                proxy_pass http://127.0.0.1:5000;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
           }

location /api {
                proxy_pass http://cn-node-prod-app.herokuapp.com;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}
