window.appKit = {
    create  : null,
    arbitrum: null,
    mainnet : null,
    optimism: null,
    polygon : null,
    sepolia : null
}

import { createAppKit } from '@reown/appkit';
import { EthersAdapter } from '@reown/appkit-adapter-ethers';
import { arbitrum, mainnet, optimism, polygon, sepolia } from '@reown/appkit/networks';

window.appKit.create = (networks, projectId, analytics) => {
    return createAppKit({
        adapters: [new EthersAdapter()],
        networks,
        projectId,
        features: {
            analytics,
        },
    })
}

window.appKit.arbitrum = arbitrum;
window.appKit.mainnet  = mainnet;
window.appKit.optimism = optimism;
window.appKit.polygon  = polygon;
window.appKit.sepolia  = sepolia;
