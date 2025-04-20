FROM nginx:alpine
COPY build /usr/share/ngnix/html
EXPOSE 80
CMD ["ngnix", "-g", "daemon off;"]