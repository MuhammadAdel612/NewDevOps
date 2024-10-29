from alpine:latest
 run apk add nginx ; mkdir /tmp/folder
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
