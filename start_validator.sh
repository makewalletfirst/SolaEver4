#!/bin/bash
./target/release/agave-validator \
  --identity identity.json \
  --ledger ledger-mainnet \
  --rpc-port 8899 \
  --entrypoint entrypoint.mainnet-beta.solana.com:8001 \
  --entrypoint entrypoint2.mainnet-beta.solana.com:8001 \
  --entrypoint entrypoint3.mainnet-beta.solana.com:8001 \
  --known-validator 7Np41oeYqPefeNQEHSv1UDhYrehY65QibuLldOzXRfUd \
  --known-validator CakcnaRDHka2gXyFBEdSqBr9INboKKvr26jzti97g8s \
  --expected-genesis-hash 5eykt4UsFv8P8NJdTREpY1vzqKqZKvdpKuc147dw2N9d \
  --wal-recovery-mode skip_any_corrupted_record \
  --limit-ledger-size 50000000 \
  --dynamic-port-range 8000-8025 \
  --log -
