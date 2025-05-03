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
  JS;

const
  ProjectId = 'b56e18d47c72ab683b10814fe9495694'; // this is a public projectId only to use on localhost

type
  TAppKit = class external name 'Object'(TJSObject)
  public
    function Connected: Boolean; external name 'getIsConnectedState';
  end;

  TNetwork = class external name 'Object'(TJSObject)
  strict private
    FName: string; external name 'name';
    FId  : UInt64; external name 'id';
  public
    property Name: string read FName;
    property Id  : UInt64 read FId;
  end;

function CreateAppKit(
  const networks : TArray<TNetwork>;
  const projectId: string;
  const analytics: Boolean): TAppKit; external name 'window.appKit.create';

const
  Arbitrum: TNetwork; external name 'window.appKit.arbitrum';
  Mainnet : TNetwork; external name 'window.appKit.mainnet';
  Optimism: TNetwork; external name 'window.appKit.optimism';
  Polygon : TNetwork; external name 'window.appKit.polygon';
  Sepolia : TNetwork; external name 'window.appKit.sepolia';

implementation

end.
