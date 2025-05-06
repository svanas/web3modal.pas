# web3modal.pas

Connects 500+ crypto wallet providers to your Delphi-made web app in seconds.

web3modal.pas is built upon the following tech stack:
1. [Embarcadero Delphi](https://www.embarcadero.com/products/delphi), an IDE and programming language.
1. [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp), a framework for creating modern web applications in Delphi.
1. [web3.pas](https://github.com/svanas/web3.pas), a SDK for creating decentralized web apps with TMS Web Core in Delphi.

Under the hood, web3modal.pas is powered by [Reown's AppKit](https://reown.com/appkit), a JavaScript toolkit to build a unified UX for decentralized web apps. You can see Reown's AppKit in action [here](https://demo.reown.com).

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

Before you can trigger the modal, you'll need to create a TWeb3Modal instance:
```delphi
var
  modal: TWeb3Modal;
begin
  modal := TWeb3Modal.Create([Mainnet, Polygon], [], web3modal.ProjectId);
  ...
end;
```
Ideally, TWeb3Modal should be a singleton in your project. There is no need to have more than one instance in your application.

### Trigger the modal

You can trigger the modal by calling the `Open()` function from a modal instance returned by `TWeb3Modal.Create`:
```delphi
[async] procedure TForm1.WebButton1Click(Sender: TObject);
begin
  await(modal.Open);
end;
```
If you want to open the Networks or Account view (not the Wallet Connect view), you can pass a parameter to `Open()`:
```delphi
[async] procedure TForm1.WebButton1Click(Sender: TObject);
begin
  await(modal.Open(Networks));
end;
```
If you want to know if your web application is connected to your crypto wallet, you can do this:
```delphi
if modal.Connected then ... else ...
```
### Disconnect
```delphi
[async] procedure TForm1.WebButton1Click(Sender: TObject);
begin
  await(modal.Disconnect);
end;
```

### Switch network
```delphi
[async] procedure TForm1.WebButton1Click(Sender: TObject);
begin
  if modal.CurrentNetwork.ChainId = Mainnet.Id then
    await(modal.SwitchNetwork(Polygon))
  else
    await(modal.SwitchNetwork(Mainnet));
end;
```

### Blockchain interaction

1. Clone [this other repo](https://github.com/svanas/web3.pas) to a directory of your choosing, for example `C:\Projects\web3.pas`
1. Click on: _Project > Add to Project_ and add `web3.pas` (the unit, not the directory) to your project

Once `modal.Connected` is `True` and you have a `modal.CurrentProvider`, you have a read-only connection to the data on the blockchain. This can be used to query the current account state, fetch historic logs, look up contract code and so on.
```delphi
[async] procedure TForm1.WebButton1Click(Sender: TObject);
var
  provider: TJsonRpcProvider;
  balance : TWei;
begin
  provider := Ethers.BrowserProvider.New(modal.CurrentProvider);
  if Assigned(provider) then
  begin
    // Get the current balance of an account (by address or ENS name)
    balance := await(TWei, provider.GetBalance('vitalik.eth'));
    // Since the balance is in wei, you may wish to display it in ether instead.
    console.log(Ethers.FormatEther(balance));
  end;
end;
```

### Sending transactions

To write to the blockchain you need access to a private key. In most cases, those private keys are not accessible directly to your code, and instead you make requests via a [Signer](https://docs.ethers.org/v6/api/providers/#Signer), which dispatches the request to your crypto wallet which provides strictly gated access and requires feedback to the user to approve or reject operations:
```delphi
[async] procedure TForm1.WebButton1Click(Sender: TObject);
var
  provider: TJsonRpcProvider;
  signer  : TJsonRpcSigner;
  tx      : TJSObject;
  response: TTransactionResponse;
  receipt : TTransactionReceipt;
begin
  // Connect to the EIP-1193 object. This is a standard protocol that allows for read-only requests through your crypto wallet.
  provider := Ethers.BrowserProvider.New(modal.CurrentProvider);
  if Assigned(provider) then
  begin
    // Request access to write operations, which will be performed by the private key that your crypto wallet manages for you.
    signer := await(TJsonRpcSigner, provider.GetSigner);
    if Assigned(signer) then
    begin
      // Once you have a Signer, you can have your crypto wallet sign your transaction and broadcast it to the network.
      tx := Transaction(
        modal.CurrentAccount.Address,                 // From your account
        '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045', // To: vitalik.eth
        Ethers.ParseEther('1.0')                      // Value
      );
      // Send tx to the network
      response := await(TTransactionResponse, signer.SendTransaction(tx));
      console.log(response.Hash); // the transaction hash
      // Often you may wish to wait until the transaction is mined
      receipt := await(TTransactionReceipt, response.Wait);
      console.log(receipt.Status); // 1 for success, 0 for failure
    end;
  end;
end;
```

## Production

When you are ready to release your web app in the wild, you should create a new project on [Reown Cloud](https://cloud.reown.com) and obtain a new project ID.

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
