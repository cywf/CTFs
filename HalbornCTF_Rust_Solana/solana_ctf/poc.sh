# PoC: Testing the build with `ahash v0.8.7`

#!/bin/bash
# Check if the `ahash` library with version `0.8.7` compiles successfully

# Update to the nightly Rust toolchain to use unstable features
rustup default nightly

# Attempt to build a project that depends on `ahash v0.8.7`
# The Cargo.toml should specify `ahash = "0.8.7"`
echo "Building project with ahash v0.8.7..."
if cargo build; then
    echo "Build succeeded. No issues with ahash v0.8.7 on the nightly channel."
else
    echo "Build failed. There may be unstable features in ahash v0.8.7."
fi

# Revert to the stable toolchain
rustup default stable

# Try to build again on the stable toolchain
echo "Building project with ahash v0.8.7 on stable Rust..."
if cargo build; then
    echo "Build succeeded. No issues with ahash v0.8.7 on the stable channel."
else
    echo "Build failed on stable. Unstable features in ahash v0.8.7 are likely the cause."
fi

# Run `cargo build` and observe if there are errors related to `ahash`
