unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.DApt;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    memItens: TFDMemTable;
    dsItens: TDataSource;
    qryPedido: TFDQuery;
    qryPedidoProduto: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Params.Clear;

  FDConnection.DriverName := 'MySQL';
  FDConnection.Params.Add('Server=localhost');
  FDConnection.Params.Add('Database=sistema_pedidos');
  FDConnection.Params.Add('User_Name=root');
  FDConnection.Params.Add('Password=123456');
  FDConnection.Params.Add('Port=3306');

  FDConnection.LoginPrompt := False;

  FDConnection.Connected := True;

  memItens.Close;

  memItens.FieldDefs.Clear;

  memItens.FieldDefs.Add('codigo', ftInteger);
  memItens.FieldDefs.Add('descricao', ftString, 100);
  memItens.FieldDefs.Add('quantidade', ftFloat);
  memItens.FieldDefs.Add('valor_unitario', ftFloat);
  memItens.FieldDefs.Add('valor_total', ftFloat);

  memItens.CreateDataSet;

end;

end.
