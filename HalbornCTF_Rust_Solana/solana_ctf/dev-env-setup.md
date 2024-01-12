1. Update the Package Manager (make sure all your system packages are up to date):

```sh
sudo apt update && sudo apt upgrade -y
```

2. Install Required Dependencies (such as libssl-dev, pkg-config, etc.):

```sh
sudo apt-get install -y pkg-config build-essential libssl-dev libudev-dev
```

3. Install Rust and Cargo (Cargo comes with Rust):

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

4. Configure the Current Shell (so you can use Rust and Cargo without restarting the terminal):

```sh
source $HOME/.cargo/env
```

5. Install Solana CLI Tools:

```sh
sh -c "$(curl -sSfL https://release.solana.com/v1.10.0/install)"
```

6. Set Solana CLI Config to Use Local Network (default for testing):

```sh
solana config set --url http://127.0.0.1:8899
```

7. Install Solana's BPF-SDK (required for compiling Solana programs):

```sh
solana-install init
```

8. Start the Local Solana Test Validator:

```sh
solana-test-validator
```

After these steps, you should have a functional Solana development environment. You can then proceed to compile your Solana program and deploy it to the local test validator using Cargo and Solana CLI tools.

Please ensure to run solana-test-validator in a separate terminal or background process since it will occupy the terminal with log outputs.

In case you're using a specific version of Rust or Solana, make sure to install the versions compatible with your project requirements.
