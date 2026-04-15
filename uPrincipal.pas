unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, uDM,
  //uConexao,
  uFrmPedido, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuCadastros: TMenuItem;
    mnuPedidos: TMenuItem;
    mnuSair: TMenuItem;
    pnlMenu: TPanel;
    sbMenu: TSpeedButton;
    procedure mnuPedidosClick(Sender: TObject);
    procedure mnuSairClick(Sender: TObject);
    procedure sbMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}




procedure TfrmPrincipal.mnuPedidosClick(Sender: TObject);
begin
  frmPedido := TfrmPedido.Create(Self);
  try
    frmPedido.ShowModal;
  finally
    frmPedido.Free;
  end;
end;

procedure TfrmPrincipal.mnuSairClick(Sender: TObject);
begin
   Close;
end;




procedure TfrmPrincipal.sbMenuClick(Sender: TObject);
begin
  frmPedido := TfrmPedido.Create(Self);
  try
    frmPedido.ShowModal;
  finally
    frmPedido.Free;
  end;
end;

end.
