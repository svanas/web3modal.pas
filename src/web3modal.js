window.appKit = {
  create    : null,
  arbitrum  : null,
  avalanche : null,
  base      : null,
  bsc       : null,
  gnosis    : null,
  holesky   : null,
  mainnet   : null,
  optimism  : null,
  polygon   : null,
  pulsechain: null,
  sepolia   : null,
  sonic     : null
}

import { ethers } from 'ethers';
import { createAppKit } from '@reown/appkit';
import { EthersAdapter } from '@reown/appkit-adapter-ethers';
import { arbitrum, avalanche, base, bsc, gnosis, holesky, mainnet, optimism, polygon, pulsechain, sepolia, sonic } from '@reown/appkit/networks';

window.appKit.create = (networks, projectId, darkMode, email, socials, analytics, swaps, onramp) => {
  return createAppKit({
    adapters: [new EthersAdapter()],
    networks,
    projectId,
    themeMode: darkMode ? 'dark' : 'light',
    features: {
      email,
      analytics,
      swaps,
      onramp,
      ...(socials ? {} : { socials: false }),
    },
  })
}

window.ethers            = ethers;
window.appKit.arbitrum   = arbitrum;
window.appKit.avalanche  = avalanche;
window.appKit.base       = base;
window.appKit.bsc        = bsc;
window.appKit.gnosis     = gnosis;
window.appKit.holesky    = holesky;
window.appKit.mainnet    = mainnet;
window.appKit.optimism   = optimism;
window.appKit.polygon    = polygon;
window.appKit.pulsechain = pulsechain;
window.appKit.sepolia    = sepolia;
window.appKit.sonic      = sonic;
