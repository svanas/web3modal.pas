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
  strict protected
    FAddress  : string;  external name 'address';
    FConnected: Boolean; external name 'isConnected';
    FStatus   : string;  external name 'status';
  public
    property Address  : string  read FAddress;
    property Connected: Boolean read FConnected;
    property Status   : string  read FStatus;
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
    function  Connected: Boolean;                                external name 'getIsConnectedState';
    procedure Open; async;                                       external name 'open'; overload;
    procedure Open(const options: TOptions); async;              external name 'open'; overload;
    procedure Disconnect; async;                                 external name 'disconnect';
    procedure SubscribeAccount(const callback: TProc<TAccount>); external name 'subscribeAccount';
    procedure SubscribeState(const callback: TProc<TState>);     external name 'subscribeState';
  end;

  TNetwork = class external name 'Object'(TJSObject)
  strict private
    FId  : UInt64; external name 'id';
    FName: string; external name 'name';
  public
    property Id  : UInt64 read FId;
    property Name: string read FName;
  end;

function CreateAppKit(
  const networks : TArray<TNetwork>;
  const projectId: string;
  const darkMode : Boolean;
  const analytics: Boolean): TAppKit; external name 'window.appKit.create';

const
  Arbitrum: TNetwork; external name 'window.appKit.arbitrum';
  Base    : TNetwork; external name 'window.appKit.base';
  Mainnet : TNetwork; external name 'window.appKit.mainnet';
  Optimism: TNetwork; external name 'window.appKit.optimism';
  Polygon : TNetwork; external name 'window.appKit.polygon';
  Sepolia : TNetwork; external name 'window.appKit.sepolia';

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
