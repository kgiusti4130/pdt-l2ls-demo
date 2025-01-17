# Clone the git repository

```sh
git clone https://github.com/kgiusti4130/avd-cvaas-ceos-l2ls-demo.git
```

## Once cEOS image is downloaded import it

```sh
docker import cEOS-lab-4.31.1F.tar.xz ceos:4.31.1F
```

## Pull the Docker image is you haven't already

```sh
docker pull ghcr.io/srl-labs/clab
```

## Run docker from workspace folder on CLAB host

```sh
cd /workspace/
docker run --rm -it --privileged \
    --network host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/run/netns:/var/run/netns \
    -v /etc/hosts:/etc/hosts \
    -v /var/lib/docker/containers:/var/lib/docker/containers \
    --pid="host" \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    ghcr.io/srl-labs/clab bash
```

## From the same container that you started run the containerlab topology

```sh
cd cd /workspace/clab/
containerlab deploy -t l2ls.yaml
```

## Console into EOS boxes

```sh
docker exec -it PDT_SPINE1 Cli
docker exec -it PDT_SPINE2 Cli
docker exec -it PDT_LEAF1 Cli
docker exec -it PDT_LEAF2 Cli
docker exec -it PDT_LEAF3 Cli
docker exec -it PDT_LEAF4 Cli
```

## Console into host1 or 2

```sh
docker exec -it host1 bash
docker exec -it host2 bash
```

## Once done, shutdown and maintain configurations

```sh
containerlab destroy -t l2ls.yaml
```

## Link to host linux boxes

<https://hub.docker.com/r/mitchv85/ohv-host>

## Lab Diagram

![Figure: 1](images/topology.png)

## ANTA commands

```sh
cd /workspace/anta
anta nrfu -u test -p 'test' -i clab_anta_inventory.yml -c clab_anta_tests.yml
```

### Run a particular test

```sh
anta nrfu -u test -p 'test' -i clab_anta_inventory.yml -c clab_anta_tests.yml -t  VerifyLLDPNeighbors
```

### Run tests on particular host

```sh
anta nrfu -u test -p 'test' -i clab_anta_inventory.yml -c clab_anta_tests.yml -d PDT_SPINE1
```

### Show output as text

```sh
anta nrfu -u test -p 'test' -i clab_anta_inventory.yml -c clab_anta_tests.yml text
```

### Show output as text and omit skipped and succesful tests

```sh
anta nrfu -u test -p 'test' -i clab_anta_inventory.yml -c clab_anta_tests.yml text | grep -v 'SUCCESS\|SKIPPED'
```

### Collect tech-supports

```sh
anta exec collect-tech-support -u test -p 'test' -i clab_anta_inventory.yml --insecure
```

## Ansible playbook descriptions

- **anta_validate.yml** - Run AVD role eos_validate_state.
- **build.yml** - Compile and build configs.
- **check.yml** - Check the difference between AVD intended configs and the running configs on EOS devices.
- **deploy.yml** - Push generated configs directly to EOS devices.
- **eos_facts.yml** - Test connection to EOS devices.
- **eos_snapshot.yml** - Log into EOS devices, grap output from "commands_list" and save output.
