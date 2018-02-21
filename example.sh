#!/bin/sh

echo ""
echo "docker run -p 9000:22 \\"
echo "  -v fastdock_ssh:/etc/ssh \\"
echo "  -v /var/run/docker.sock:/var/run/docker.sock \\"
echo "  -v /root/.ssh/authorized_keys:/keys/root:ro \\"
echo "  -d --name=fastdock pymet/fastdock"
echo ""
echo "docker service create -p 9000:22 \\"
echo "  --mount type=volume,src=fastdock_ssh,dst=/etc/ssh \\"
echo "  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \\"
echo "  --mount type=bind,src=/root/.ssh/authorized_keys,dst=/keys/root,ro \\"
echo "  --name=fastdock pymet/fastdock"
echo ""
