# web3modal.pas

Connects many crypto wallet providers to your Delphi-made Web app in seconds.

web3modal.pas is built upon the following tech stack:
1. [Embarcadero Delphi](https://www.embarcadero.com/products/delphi), an IDE and programming language.
1. [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp), a framework for creating modern web applications in Delphi.
1. [web3.pas](https://github.com/svanas/web3.pas), a SDK for creating decentralized Web apps with TMS Web Core in Delphi.

Under the hood, web3modal.pas is powered by [Reown's AppKit](https://reown.com/appkit) — a JavaScript toolkit to build a unified UX for decentralized Web apps.

Reown's AppKit gets downloaded at runtime and as such you don’t need to install it. But you do need [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter) and [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp#downloads).

## Installation

1. Clone this repo to a directory of your choosing, for example `C:\Projects\web3modal.pas`
1. Launch Delphi and start a new TMS Web Core project via _File > New > Other > TMS Web > TMS Web Application_
1. Save your application to a directory of your choosing
1. Click on: _Project > Add to Project_ and add `web3modal.pas` (the unit, not the directory) to your project

## Implementation

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
