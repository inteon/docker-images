FROM mono:6.12.0.122

RUN apt-get update && \
    apt-get install -y --no-install-recommends jshon=20131010-3+b1 && \
    apt-get install -y --no-install-recommends time=1.7-25.1+b1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Make sure the students can't find our secret path, which is mounted in
# /mnt with a secure random name.
RUN ["chmod", "711", "/mnt"]

# Add the user which will run the student's code and the judge.
RUN ["useradd", "-m", "runner"]

# As the runner user
USER runner
RUN ["mkdir", "/home/runner/workdir"]

WORKDIR /home/runner/workdir

COPY main.sh /main.sh