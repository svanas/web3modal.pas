{******************************************************************************}
{                                                                              }
{                                web3modal.pas                                 }
{                                                                              }
{             Copyright(c) 2025 Stefan van As <svanas@runbox.com>              }
{         Github Repository <https://github.com/svanas/web3modal.pas>          }
{                                                                              }
{                        Distributed under GNU GPL v3.0                        }
{                                                                              }
{******************************************************************************}

unit web3modal;

{$MODESWITCH EXTERNALCLASS}

interface

uses
  // Delphi
  System.SysUtils,
  // pas2js
  JS;

const
  ProjectId = 'b56e18d47c72ab683b10814fe9495694'; // this is a public projectId only to use on localhost

type
  TAccount = class external name 'Object'(TJSObject)
  strict private
    FAddress  : string;  external name 'address';
    FConnected: Boolean; external name 'isConnected';
    FStatus   : string;  external name 'status';
  public
    property Address  : string  read FAddress;
    property Connected: Boolean read FConnected;
    property Status   : string  read FStatus;
  end;

  TCurrency = class external name 'Object'(TJSObject)
  strict private
    FName    : string; external name 'name';
    FSymbol  : string; external name 'symbol';
    FDecimals: UInt8;  external name 'decimals';
  public
    property Name    : string read FName;
    property Symbol  : string read FSymbol;
    property Decimals: UInt8  read FDecimals;
  end;

  TChain = class external name 'Object'(TJSObject)
  strict private
    FId            : UInt64;    external name 'id';
    FName          : string;    external name 'name';
    FTestnet       : Boolean;   external name 'testnet';
    FNativeCurrency: TCurrency; external name 'nativeCurrency';
  public
    property Id            : UInt64    read FId;
    property Name          : string    read FName;
    property Testnet       : Boolean   read FTestnet;
    property NativeCurrency: TCurrency read FNativeCurrency;
  end;

  TNetwork = class external name 'Object'(TJSObject)
  strict private
    FChainId      : UInt64; external name 'chainId';
    FCaipNetwork  : TChain; external name 'caipNetwork';
    FCaipNetworkId: string; external name 'caipNetworkId';
  public
    property ChainId      : UInt64 read FChainId;
    property CaipNetwork  : TChain read FCaipNetwork;
    property CaipNetworkId: string read FCaipNetworkId;
  end;

  TState = class external name 'Object'(TJSObject)
  strict private
    FLoading          : Boolean; external name 'loading';
    FOpen             : Boolean; external name 'open';
    FSelectedNetworkId: string;  external name 'selectedNetworkId';
    FActiveChain      : string;  external name 'activeChain';
    FInitialized      : Boolean; external name 'initialized';
  public
    property Loading          : Boolean read FLoading;
    property Open             : Boolean read FOpen;
    property SelectedNetworkId: string  read FSelectedNetworkId;
    property ActiveChain      : string  read FActiveChain;
    property Initialized      : Boolean read FInitialized;
  end;

  TAppKit = class external name 'Object'(TJSObject)
  public
    function  Connected: Boolean;                                  external name 'getIsConnectedState';
    procedure Open; async;                                         external name 'open'; overload;
    procedure Open(const options: TJSObject); async;               external name 'open'; overload;
    procedure Disconnect; async;                                   external name 'disconnect';
    procedure SwitchNetwork(const chain: TChain); async;           external name 'switchNetwork';
    procedure SubscribeAccount(const callback: TProc<TAccount>);   external name 'subscribeAccount';
    procedure SubscribeProvider(const callback: TProc<TJSObject>); external name 'subscribeProviders';
    procedure SubscribeNetwork(const callback: TProc<TNetwork>);   external name 'subscribeNetwork';
    procedure SubscribeState(const callback: TProc<TState>);       external name 'subscribeState';
  end;

const
  Arbitrum : TChain; external name 'window.appKit.arbitrum';
  Avalanche: TChain; external name 'window.appKit.avalanche';
  Base     : TChain; external name 'window.appKit.base';
  BSC      : TChain; external name 'window.appKit.bsc';
  Holesky  : TChain; external name 'window.appKit.holesky';
  Mainnet  : TChain; external name 'window.appKit.mainnet';
  Optimism : TChain; external name 'window.appKit.optimism';
  Polygon  : TChain; external name 'window.appKit.polygon';
  Sepolia  : TChain; external name 'window.appKit.sepolia';
  Sonic    : TChain; external name 'window.appKit.sonic';

type
  TView    = (Connect, Networks, Account);
  TOption  = (Analytics, DarkMode);
  TOptions = set of TOption;

  TWeb3Modal = class(TObject)
  strict private
    FAccount : TAccount;
    FAppKit  : TAppKit;
    FNetwork : TNetwork;
    FProvider: JSValue;
    FOnAccountChange : TProc<TAccount>;
    FOnProviderChange: TProc<JSValue>;
    FOnNetworkChange : TProc<TNetwork>;
    FOnStateChange   : TProc<TState>;
  public
    constructor Create(const networks: TArray<TChain>; const options: TOptions; const projectId: string);
    procedure Open; async; overload;
    procedure Open(const view: TView); async; overload;
    procedure Disconnect; async;
    procedure SwitchNetwork(const chain: TChain); async;
    function  Connected: Boolean;
    property  CurrentAccount: TAccount read FAccount;
    property  CurrentNetwork: TNetwork read FNetWork;
    property  CurrentProvider: JSValue read FProvider;
    property  OnAccountChange : TProc<TAccount> read FOnAccountChange  write FOnAccountChange;
    property  OnProviderChange: TProc<JSValue>  read FOnProviderChange write FOnProviderChange;
    property  OnNetworkChange : TProc<TNetwork> read FOnNetworkChange  write FOnNetworkChange;
    property  OnStateChange   : TProc<TState>   read FOnStateChange    write FOnStateChange;
  end;

implementation

{------------------------------- @reown/appkit --------------------------------}

function GetOptions(const view: TView): TJSObject;
begin
  Result := TJSObject.New;
  case view of
    Connect : Result['view'] := 'Connect';
    Networks: Result['view'] := 'Networks';
    Account : Result['view'] := 'Account';
  end;
end;

function CreateAppKit(
  const networks : TArray<TChain>;
  const projectId: string;
  const darkMode : Boolean;
  const analytics: Boolean): TAppKit; external name 'window.appKit.create';

{--------------------------------- TWeb3Modal ---------------------------------}

constructor TWeb3Modal.Create(const networks: TArray<TChain>; const options: TOptions; const projectId: string);
begin
  inherited Create;
  FAppKit := CreateAppKit(networks, projectId, DarkMode in options, Analytics in options);
  FAppKit.SubscribeState(procedure(arg: TState)
  begin
    if Assigned(FOnStateChange) then FOnStateChange(arg);
  end);
  FAppKit.SubscribeAccount(procedure(arg: TAccount)
  begin
    FAccount := arg;
    if Assigned(FOnAccountChange) then FOnAccountChange(FAccount);
  end);
  FAppKit.SubscribeProvider(procedure(arg: TJSObject)
  begin
    if Assigned(arg) then FProvider := arg['eip155'] else FProvider := nil;
    if Assigned(FOnProviderChange) then FOnProviderChange(FProvider);
  end);
  FAppKit.SubscribeNetwork(procedure(arg: TNetwork)
  begin
    FNetwork := arg;
    if Assigned(FOnNetworkChange) then FOnNetworkChange(FNetwork);
  end);
end;

procedure TWeb3Modal.Open;
begin
  await(FAppKit.Open);
end;

procedure TWeb3Modal.Open(const view: TView);
begin
  await(FAppKit.Open(GetOptions(view)));
end;

procedure TWeb3Modal.Disconnect;
begin
  await(FAppKit.Disconnect);
end;

procedure TWeb3Modal.SwitchNetwork(const chain: TChain);
begin
  await(FAppKit.SwitchNetwork(chain));
end;

function TWeb3Modal.Connected: Boolean;
begin
  Result := FAppKit.Connected;
end;

end.
