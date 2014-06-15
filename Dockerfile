RUN echo 'we are running some # of cool things'
RUN -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
