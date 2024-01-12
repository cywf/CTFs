If you're using an M1 Mac and have Docker installed with the Visual Studio Code Docker extension, you can set up an x86 architecture container to simulate an Intel-based environment. Here's how to proceed:

1. Open the Terminal in Visual Studio Code or your preferred terminal if you're not using VSCode.

2. Pull an Ubuntu Image with x86 architecture:

```sh
docker pull --platform linux/amd64 ubuntu
```
3. Run the Container with the x86 architecture:

```sh
docker run --platform linux/amd64 -it --name solana-dev ubuntu
```
This command will create a new container named `solana-dev` based on the Ubuntu image and open an interactive terminal session inside it. The `--platform linux/amd64` ensures that Docker emulates the `x86_64` architecture.

4. Install Required Dependencies inside the container:

```sh
apt update && apt install -y curl build-essential pkg-config libssl-dev libudev-dev
```
5. Install Rust and Cargo inside the container:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```
6. Install Solana Tools inside the container:

```sh
sh -c "$(curl -sSfL https://release.solana.com/v1.10.0/install)"
```
7. Add Solana to PATH inside the container (if it's not automatically added):

```sh
export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"
```
8. Run the Solana Test Validator inside the container:

```sh
solana-test-validator
```
Since you're operating within a Docker container, your local files won't be accessible directly. To work on your Solana project inside the container, you have two options:

Mount a Volume: When running the container, use the `-v` flag to mount a local directory to a directory inside the container.

Copy Files: Use `docker cp` to copy files between your local filesystem and the container.

Here's how to run the container with a mounted volume:

```sh
docker run --platform linux/amd64 -it -v /path/to/local/solana/project:/solana-project --name solana-dev ubuntu
```
Replace `/path/to/local/solana/project` with the actual path to your Solana project directory on your Mac. Inside the container, the project will be available at `/solana-project`.

---

# Troubleshooting Docker

1. Remove the Current Docker Repository (if added):

```bash
sudo add-apt-repository --remove "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
```

2. Update the Repository Information:

```bash
sudo apt-get update
```

3. Add the Docker Repository for Debian:

Ensure you have the necessary packages for apt to use a repository over HTTPS:

```bash
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
  gnupg \
  lsb-release
```

4. Add the Docker GPG key for Debian:

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

5. Then, add the Docker repository for Debian:

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

6. Install Docker:

Update your package database again:

```bash
sudo apt-get update
```

7. Install Docker Engine, CLI, and Containerd:

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

8. Verify Docker Installation:

Test Docker to make sure it's installed correctly:

```bash
sudo docker run hello-world
```

9. Set Up Docker to Run Without Sudo (optional):

Add your user to the docker group:

```bash
sudo usermod -aG docker $USER
```
Make sure you're running these commands on your Debian virtual machine and not on the host macOS system. If lsb_release -cs does not return the correct version or if bookworm is not yet officially supported by Docker, you may need to manually specify a supported Debian version in the repository URL, such as buster or bullseye
