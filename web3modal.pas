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
  TView    = (Connect, Networks, Account);
  TOptions = TJSObject;

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
    procedure Open(const options: TOptions); async;                external name 'open'; overload;
    procedure Disconnect; async;                                   external name 'disconnect';
    procedure SubscribeAccount(const callback: TProc<TAccount>);   external name 'subscribeAccount';
    procedure SubscribeProvider(const callback: TProc<TJSObject>); external name 'subscribeProviders';
    procedure SubscribeNetwork(const callback: TProc<TNetwork>);   external name 'subscribeNetwork';
    procedure SubscribeState(const callback: TProc<TState>);       external name 'subscribeState';
  end;

function CreateAppKit(
  const networks : TArray<TChain>;
  const projectId: string;
  const darkMode : Boolean;
  const analytics: Boolean): TAppKit; external name 'window.appKit.create';

const
  Arbitrum : TChain; external name 'window.appKit.arbitrum';
  Avalanche: TChain; external name 'window.appKit.avalanche';
  Base     : TChain; external name 'window.appKit.base';
  BSC      : TChain; external name 'window.appKit.bsc';
  Ganache  : TChain; external name 'window.appKit.localhost';
  Holesky  : TChain; external name 'window.appKit.holesky';
  Mainnet  : TChain; external name 'window.appKit.mainnet';
  Optimism : TChain; external name 'window.appKit.optimism';
  Polygon  : TChain; external name 'window.appKit.polygon';
  Sepolia  : TChain; external name 'window.appKit.sepolia';
  Sonic    : TChain; external name 'window.appKit.sonic';

function Options(const view: TView): TOptions;

implementation

function Options(const view: TView): TOptions;
begin
  Result := TOptions.New;
  case view of
    Connect : Result['view'] := 'Connect';
    Networks: Result['view'] := 'Networks';
    Account : Result['view'] := 'Account';
  end;
end;

end.
