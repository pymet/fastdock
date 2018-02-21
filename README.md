# fastdock

Deploy anywhere with a single command.

## How does it work?

**pymet/fastdock** is a docker image that can be run on any server with docker installed. On the client side one can create tar archives and send it through SSH to **pymet/fastdock**. On the server side the archive is unpacked and **docker-compose** is called.

**Client side example**

First create a script called `srv` as follows:

```sh
ssh -i ~/.ssh/id_rsa -p 9000 root@xx.xx.xx.xx $@
```

On windows, create a batch file called `srv.bat`:

```cmd
ssh -i %USERPROFILE%\.ssh\id_rsa -p 9000 root@xx.xx.xx.xx %*
```

Run the examples on the client side:

```sh
# docker access
srv docker --version
srv docker-compoose --version
srv docker ps

# deploy folder
tar -c * | srv dock

# deploy from git
git archive HEAD --format=tar | srv dock

# undo deploy
srv undock
srv undock -v # beware volumes will be destoyed too
```

## Usage

### Running as a service

```sh
docker service create -p 9000:22 \
  --mount type=volume,src=fastdock_ssh,dst=/etc/ssh \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=/root/.ssh/authorized_keys,dst=/keys/root,ro \
  --name=fastdock pymet/fastdock
```

**Stopping**

```sh
docker service rm fastdock
```

### Running without a swarm

```sh
docker run -p 9000:22 \
  -v fastdock_ssh:/etc/ssh \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /root/.ssh/authorized_keys:/keys/root:ro \
  -d --name=fastdock pymet/fastdock
```

**Stopping**

```sh
docker rm fastdock
```

### Examples from the terminal

```sh
docker run pymet/fastdock example
```

**Output**

```sh
docker run -p 9000:22 \
  -v fastdock_ssh:/etc/ssh \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /root/.ssh/authorized_keys:/keys/root:ro \
  -d --name=fastdock pymet/fastdock

docker service create -p 9000:22 \
  --mount type=volume,src=fastdock_ssh,dst=/etc/ssh \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=/root/.ssh/authorized_keys,dst=/keys/root,ro \
  --name=fastdock pymet/fastdock
```

## Customizing

1. Fork
2. Edit or Add script files
3. Build with: `docker build . -t yourname/fastdock`
4. Use the examples from the [Usage](#Usage) section
