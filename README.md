# web3modal.pas

Connects 500+ crypto wallet providers to your Delphi-made Web app in seconds.

web3modal.pas is built upon the following tech stack:
1. [Embarcadero Delphi](https://www.embarcadero.com/products/delphi), an IDE and programming language.
1. [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp), a framework for creating modern web applications in Delphi.
1. [web3.pas](https://github.com/svanas/web3.pas), a SDK for creating decentralized Web apps with TMS Web Core in Delphi.

Under the hood, web3modal.pas is powered by [Reown's AppKit](https://reown.com/appkit) — a JavaScript toolkit to build a unified UX for decentralized Web apps.

Before you proceed with the below steps, please make sure you have at least [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter) and [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp#downloads). We will guide you though the rest you need.

## Installation

1. Clone this repo to a directory of your choosing, for example `C:\Projects\web3modal.pas`
2. Launch Delphi and start a new TMS Web Core project via _File > New > Other > TMS Web > TMS Web Application_
3. Save your application to a directory of your choosing
4. Click on: _Project > Add to Project_ and add `web3modal.pas` (the unit, not the directory) to your project
5. Open a PowerShell window and navigate to the directory where your TMS Web Core project is
6. Enter the following command:
   ```
   node --version
   ```
7. If this gives a "not recognized" error, node.js isn't installed and you need to proceed with the next step. Otherwise, you are good to go and ready to proceed with step 9 (below)
8. Download and install node.js from the official website: https://nodejs.org. This will install both node.js and npm.
9. Enter the following command:
   ```
   npm install @reown/appkit @reown/appkit-adapter-ethers
   ```

## Implementation

## Dependencies

Because [Reown's AppKit](https://reown.com/appkit) is a so-called ES module, and because Reown's AppKit depends on other ES modules, you need to bundle these dependencies before you can run your application.

For this purpose, we will be using [esbuild](https://esbuild.github.io), a JavaScript module bundler. It will not bundle dead code and as such it creates a very efficient single JavaScript file.

1. Open a PowerShell window and navigate to the directory where your TMS Web Core project is
2. Enter the following command:
   ```
   esbuild --version
   ```
3. If this gives a "not recognized" error, esbuild isn't installed and you need to proceed with the next step. Otherwise, you are good to go and ready to proceed with step 5 (below)
4. Enter the following command:
   ```
   npm install --global esbuild
   ```
5. Enter the following command:
   ```
   npx esbuild src/main.js --bundle --outfile=dist/bundle.js --format=esm
   ```
6. Switch to Delphi and open your TMS Web Core project
7. Click on: _Project > Add to Project_ and add `dist/bundle.js` to your project

You are now ready to run your application in de IDE (F9).

## Production

When you are ready to release your Web app in the wild, you should create a new project on [Reown Cloud](https://cloud.reown.com) and obtain a new project ID.

## Learn more

The following docs cover many of the most common operations that developers require:
1. https://docs.ethers.org/v6
2. https://docs.reown.com/appkit/overview

## License

Distributed under the [GPL-3.0](https://github.com/svanas/web3modal.pas/blob/master/LICENSE) license.

## Commercial support and training

Commercial support and training is available from [Stefan](https://svanas.github.io/).
