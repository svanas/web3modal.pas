window.appKit = {
  create  : null,
  arbitrum: null,
  base    : null,
  mainnet : null,
  optimism: null,
  polygon : null,
  sepolia : null
}

import { createAppKit } from '@reown/appkit';
import { EthersAdapter } from '@reown/appkit-adapter-ethers';
import { arbitrum, base, mainnet, optimism, polygon, sepolia } from '@reown/appkit/networks';

window.appKit.create = (networks, projectId, darkMode, analytics) => {
  return createAppKit({
    adapters: [new EthersAdapter()],
    networks,
    projectId,
    themeMode: darkMode ? 'dark' : 'light',
    features: {
      analytics,
    },
  })
}

window.appKit.arbitrum = arbitrum;
window.appKit.base     = base;
window.appKit.mainnet  = mainnet;
window.appKit.optimism = optimism;
window.appKit.polygon  = polygon;
window.appKit.sepolia  = sepolia;
