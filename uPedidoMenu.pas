unit uFrmPedido;

//  unit   uPedidoMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmPedido = class(TForm)
    pnlPedidoDados: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    pnlProdutosPedido: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    lblPedido: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtPedidoCodigo: TEdit;
    lblPedidoTituloData: TLabel;
    lblPedidoData: TLabel;
    Edit1: TEdit;
    edtPedidoCliente: TEdit;
    SpeedButton1: TSpeedButton;
    pnlPedidoBotoes: TPanel;
    sbnovo: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

end.
