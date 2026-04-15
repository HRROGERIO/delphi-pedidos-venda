unit uConexao;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param;

type
  TConexao = class
  private
    FCon: TFDConnection;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Conectar;
    procedure Desconectar;
    function TestarConexao: Boolean;

    property Con: TFDConnection read FCon;
  end;

var
  Conexao: TConexao;

implementation

constructor TConexao.Create;
begin
  inherited;
  FCon := TFDConnection.Create(nil);
end;

destructor TConexao.Destroy;
begin
  if Assigned(FCon) then
    FreeAndNil(FCon);

  inherited;
end;

procedure TConexao.Conectar;
begin
  if not Assigned(FCon) then
    Exit;

  if not FCon.Connected then
  begin
    FCon.Params.Clear;

   // FCon.Params.DriverID := 'MySQL';

    FCon.DriverName := 'MySQL';
    FCon.Params.Add('Server=localhost');
    FCon.Params.Add('Database=sistema_pedidos');
    FCon.Params.Add('User_Name=root');
    FCon.Params.Add('Password=123456');
    FCon.Params.Add('Port=3306');
    FCon.Params.Add('CharacterSet=utf8');
    FCon.Params.Add('SSLMode=DISABLED');
    FCon.LoginPrompt := False;

    FCon.Connected := True;
  end;
end;

procedure TConexao.Desconectar;
begin
  if Assigned(FCon) then
    if FCon.Connected then
      FCon.Connected := False;
end;

function TConexao.TestarConexao: Boolean;
begin
  Result := False;

  try
    Conectar;
    Result := FCon.Connected;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar com banco: ' + E.Message);
  end;
end;

end.
