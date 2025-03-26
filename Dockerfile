FROM ubuntu:latest
 
RUN apt update && apt install stress-ng -y
 
COPY tarea1.sh /usr/local/bin/tarea1.sh
 
RUN chmod +x /usr/local/bin/tarea1.sh
 
ENTRYPOINT ["/usr/local/bin/tarea1.sh"]