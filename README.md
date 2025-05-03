# web3modal.pas

Connects 500+ crypto wallet providers to your Delphi-made Web app in seconds.

web3modal.pas is built upon the following tech stack:
1. [Embarcadero Delphi](https://www.embarcadero.com/products/delphi), an IDE and programming language.
1. [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp), a framework for creating modern web applications in Delphi.
1. [web3.pas](https://github.com/svanas/web3.pas), a SDK for creating decentralized Web apps with TMS Web Core in Delphi.

Under the hood, web3modal.pas is powered by [Reown's AppKit](https://reown.com/appkit), a JavaScript toolkit to build a unified UX for decentralized Web apps.

Before you proceed with the below steps, please make sure you have at least [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter) and [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp#downloads). We will guide you though the rest you need.

## Installation

1. Clone this repo to a directory of your choosing, for example `C:\Projects\web3modal.pas`
1. Launch Delphi and start a new TMS Web Core project via _File > New > Other > TMS Web > TMS Web Application_
1. Save your application to a directory of your choosing
1. Click on: _Project > Add to Project_ and add `web3modal.pas` (the unit, not the directory) to your project
1. Run your application (F9)
1. Navigate to https://metamask.io/
1. Click on: Get MetaMask
1. Follow the instructions and install MetaMask into your web browser

## Configuration

Before you can use web3modal.pas in your TMS Web Core project, you will need to manually add the following snippet to the `<head>` section of your project's HTML document:

```html
<script type="module" src="https://raw.githubusercontent.com/svanas/web3modal.pas/main/dist/web3modal.js"></script>
```

## Implementation

## Production

When you are ready to release your Web app in the wild, you should create a new project on [Reown Cloud](https://cloud.reown.com) and obtain a new project ID.

## Learn more

The following docs cover many of the most common operations that developers require:
1. https://docs.ethers.org/v6
1. https://docs.reown.com/appkit/overview

## License

Distributed under the [GPL-3.0](https://github.com/svanas/web3modal.pas/blob/master/LICENSE) license.

## Commercial support and training

Commercial support and training is available from [Stefan](https://svanas.github.io/).

## Building from source (optional)

Because [Reown's AppKit](https://reown.com/appkit) is a so-called [ES module](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules), and because Reown's AppKit depends on other ES modules, you need to bundle these dependencies before you can run your application.

For your convenience, Reown’s AppKit has been built and bundled into [dist/web3modal.js](https://github.com/svanas/web3modal.pas/blob/main/dist/web3modal.js) and there is no need for you yourself to build it.

However, if you really really want to build Reown’s AppKit, here is how to do it. First, you’ll need to install node.js:

1. Open a PowerShell window.
1. Enter the following command:
   ```
   node --version
   ```
1. If this gives a "not recognized" error, node.js isn't installed and you need to proceed with the next step. Otherwise, you are good to go and ready to proceed with the Vite installation (below)
1. Download and install node.js from the official website: https://nodejs.org. This will install both node.js and npm.

Next up, you’ll need to install [Vite](https://vite.dev), a JavaScript module bundler. Vite will not bundle dead code and as such it creates a very efficient single JavaScript file.

1. Open a PowerShell window and navigate to the directory where you cloned this repo into.
1. Enter the following command:
   ```
   npm install --save-dev vite
   ```

Last but not least, you’ll need to install Reown’s AppKit, a JavaScript module that powers web3modal.pas:

1. Open a PowerShell window and navigate to the directory where you cloned this repo into.
1. Enter the following command:
   ```
   npm install @reown/appkit @reown/appkit-adapter-ethers
   ```

Now that everything is installed, here is how to build [dist/web3modal.js](https://github.com/svanas/web3modal.pas/blob/main/dist/web3modal.js) from source:

1. Open a PowerShell window and navigate to the directory where you cloned this repo into.
1. Enter the following command:
   ```
   npx vite build
   ```
