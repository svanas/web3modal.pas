window.appKit = {
  create    : null,
  arbitrum  : null,
  avalanche : null,
  base      : null,
  bsc       : null,
  gnosis    : null,
  mainnet   : null,
  optimism  : null,
  polygon   : null,
  sepolia   : null,
  sonic     : null
}

import { ethers } from 'ethers';
import { createAppKit } from '@reown/appkit';
import { EthersAdapter } from '@reown/appkit-adapter-ethers';
import { arbitrum, avalanche, base, bsc, gnosis, mainnet, optimism, polygon, sepolia, sonic } from '@reown/appkit/networks';

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
window.appKit.mainnet    = mainnet;
window.appKit.optimism   = optimism;
window.appKit.polygon    = polygon;
window.appKit.sepolia    = sepolia;
window.appKit.sonic      = sonic;
