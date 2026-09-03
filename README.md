# SolaEver (SLE)

> *"솔라나의 속도를 체험하라, 블록체인 3세대 생태계를 경험하라"*  
> *"Experience Solana's speed — explore the 3rd generation blockchain ecosystem firsthand."*

SolaEver (SLE) is an independent high-performance blockchain built on **Agave (Solana v4.0)** architecture, inheriting Solana mainnet's genesis rules 100% while providing a free, low-cost environment for DApp deployment and blockchain education.

[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?logo=discord)](https://discord.com/invite/dfSF58pzZB)
[![Block Explorer](https://img.shields.io/badge/Explorer-solaever.ever--chain.xyz-blue)](https://solaever.ever-chain.xyz)
[![YouTube](https://img.shields.io/badge/YouTube-@지만쫌-red?logo=youtube)](http://www.youtube.com/@지만쫌)

---

## What is SolaEver?

SolaEver is more than a testnet. It is a **live, independent Solana-equivalent chain** where developers and users can experience Solana's full technical stack — Tower BFT, Gulf Stream, Sealevel, PoH, and more — without mainnet cost barriers.

| Property | Value |
|---|---|
| Ticker | **SLE** |
| Base Unit | 1 SLE = 10⁹ Lamports |
| Architecture | Agave (Solana v4.0) |
| Slot Time | ~400ms |
| Genesis Policy | Solana Mainnet rules inherited 100% |
| Fee Burn | 50% of transaction fees burned (deflationary) |
| Inflation | Starts at 8%, decreasing annually (Solana standard) |
| Rent | Account storage rent system identical to Solana |

---

## Features

### Block Explorer
- **SolaEver Explorer** — [solaever.ever-chain.xyz](https://solaever.ever-chain.xyz)  
  Forked from the official Solana Explorer. Real-time slot progress, transaction details, and program logs.  
  *(Note: Server resources are limited — initial load may take a moment.)*  
  Source: [makewalletfirst/SolaEver-Explorer3](https://github.com/makewalletfirst/SolaEver-Explorer3)

### Performance
- Capable of thousands of TPS
- Latest security patches and performance optimizations via Agave engine

### Developer Environment
- **Solana Playground compatible** — deploy and call programs directly from your browser  
  → Set custom RPC to `https://solaever-rpc.ever-chain.xyz` in Solana Playground
- SPL Token program available on-chain
- Full program deployment, transaction simulation, and account inspection supported

### Wallet
- **SolaEver Wallet** — dedicated mobile wallet for SolaEver  
  Source: [makewalletfirst/solaever-wallet4](https://github.com/makewalletfirst/solaever-wallet4)

- **SolaEver Wallet Extension** — Chrome extension wallet for browser-based DApp interaction  
  Source: [makewalletfirst/solaever-wallet-extension](https://github.com/makewalletfirst/solaever-wallet-extension)

- For key management and transfers via CLI, point the Solana CLI at the SolaEver RPC

### Community
- Discord: [discord.com/invite/dfSF58pzZB](https://discord.com/invite/dfSF58pzZB)
- YouTube: [@지만쫌](http://www.youtube.com/@지만쫌)

---

## Deploying a Program via Solana Playground

No wallet app needed. Use [Solana Playground](https://beta.solpg.io) directly:

1. Open [beta.solpg.io](https://beta.solpg.io)
2. Click the connection icon (bottom left) → select **Custom**
3. Enter RPC URL: `https://solaever-rpc.ever-chain.xyz`
4. Write or import your program → click **Build & Deploy**
5. Confirm deployment via the [SolaEver Explorer](https://solaever.ever-chain.xyz)

> Program calls are fully functional. Transaction signatures and on-chain state are verifiable through the explorer.

---

## Running a Validator Node

### Prerequisites
- CPU with **AVX instruction set support** (required by Agave)
- Sufficient disk space — ledger grows at ~4 slots/second

### Install Agave (Solana v4.0)

```bash
sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
solana --version
```

### Configure & Run

```bash
# Set RPC target
solana config set --url https://solaever-rpc.ever-chain.xyz

# Check connection
solana cluster-version

# Run validator (basic)
agave-validator \
  --identity ~/validator-keypair.json \
  --vote-account ~/vote-account-keypair.json \
  --rpc-port 8899 \
  --entrypoint solaever-rpc.ever-chain.xyz:8001 \
  --log ~/validator.log
```

### How to Join as an Additional Validator

To join the SolaEver network as a validator and actively participate in block production and consensus voting, follow this comprehensive step-by-step guide.

#### 1. Open Required Ports
Ensure the following ports are open on your host firewall (e.g., `ufw`) and cloud security group (VPC):
* **Gossip Port**: `8101` (TCP & UDP)
* **Dynamic Range**: `8100-8125` (TCP & UDP) for TPU, TVU, and other consensus functions.

#### 2. Generate Validator Keypairs
Create the four essential keypairs needed for identity, voting, withdrawal, and staking:
```bash
# Create directories for keys
mkdir -p ~/solaever-keys

# 1. Validator Identity Keypair
solana-keygen new --no-passphrase -o ~/solaever-keys/validator-keypair.json

# 2. Vote Account Keypair
solana-keygen new --no-passphrase -o ~/solaever-keys/vote-keypair.json

# 3. Withdrawer Authority Keypair
solana-keygen new --no-passphrase -o ~/solaever-keys/withdrawer-keypair.json

# 4. Stake Account Keypair
solana-keygen new --no-passphrase -o ~/solaever-keys/stake-keypair.json
```

#### 3. Fund Your Validator Identity
You need some **SLE** to cover transaction fees and to create the vote account. You can request an airdrop via CLI or use the faucet:
```bash
solana airdrop 1000 ~/solaever-keys/validator-keypair.json --url https://solaever-rpc.ever-chain.xyz
```

#### 4. Create and Register Your Vote Account
Register your vote account on the network. This links your validator identity with your vote keypair:
```bash
solana create-vote-account \
  ~/solaever-keys/vote-keypair.json \
  ~/solaever-keys/validator-keypair.json \
  ~/solaever-keys/withdrawer-keypair.json \
  --commission 10 \
  --url https://solaever-rpc.ever-chain.xyz
```

#### 5. Launch the Validator Node
Run the validator node pointing to SolaEver's entrypoint. SolaEver uses `gossip-sola.ever-chain.xyz:8101` as its main gossip entrypoint:

```bash
agave-validator \
  --identity ~/solaever-keys/validator-keypair.json \
  --vote-account ~/solaever-keys/vote-keypair.json \
  --ledger ~/solaever-ledger \
  --rpc-port 8899 \
  --rpc-bind-address 0.0.0.0 \
  --gossip-port 8101 \
  --gossip-host <YOUR_PUBLIC_IP> \
  --dynamic-port-range 8100-8125 \
  --entrypoint gossip-sola.ever-chain.xyz:8101 \
  --full-rpc-api \
  --enable-rpc-transaction-history \
  --enable-extended-tx-metadata-storage \
  --allow-private-addr \
  --log ~/solaever-keys/solaever.log
```
*Note: Replace `<YOUR_PUBLIC_IP>` with your actual public IP address. SolaEver supports VPN/private configurations using `--allow-private-addr`.*

#### 6. Verify Your Node Status
Once launched, you can verify your validator's active status and reachability:
```bash
# Check if your node is visible in the gossip network
solana gossip --url http://127.0.0.1:8899

# Monitor your validator status and block height
solana validators --url http://127.0.0.1:8899
```

> Node operators who run validators stably are welcome to join the network. Contact via Discord.

---

## Tokenomics

SolaEver inherits Solana's economic model directly:

- **Fee Burn**: 50% of all transaction fees are permanently burned → deflationary pressure
- **Inflation**: Starts at 8% annually, decreasing each year toward a long-term floor
- **Rent**: Accounts storing on-chain data pay rent proportional to their size; closed accounts reclaim lamports
- **Initial Supply**: Distributed via genesis block for ecosystem bootstrapping

---

## Vision

- **High-performance playground**: Real 400ms slot time, real Solana tech stack, zero mainnet cost
- **DApp ecosystem**: Port open-source programs (DEX, DeFi) from Solana mainnet for research and education
- **Decentralized**: Anyone can run a validator and participate in voting — no central control
- **Long-term**: Expand real use cases for SLE as the community grows

---

## Links

| Resource | URL | Source |
|---|---|---|
| Block Explorer | https://solaever.ever-chain.xyz | [GitHub](https://github.com/makewalletfirst/SolaEver-Explorer3) |
| RPC Endpoint | https://solaever-rpc.ever-chain.xyz | — |
| Wallet App | [Download](https://ever-chain.xyz/solaeverwallet.html) | [GitHub](https://github.com/makewalletfirst/solaever-wallet4) |
| Wallet Extension | [Download](https://ever-chain.xyz/solaeverwallet.html) | [GitHub](https://github.com/makewalletfirst/solaever-wallet-extension) |
| Discord | https://discord.com/invite/dfSF58pzZB | — |
| YouTube | http://www.youtube.com/@지만쫌 | — |
| GitHub | https://github.com/makewalletfirst | — |

---

## License

Apache-2.0 — See [LICENSE](./LICENSE) for details.  
Based on [Agave / Solana Labs](https://github.com/anza-xyz/agave).
