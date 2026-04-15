program PedidoVenda;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCliente in 'uCliente.pas',
  uProduto in 'uProduto.pas',
  uPedidoProduto in 'uPedidoProduto.pas',
  uPedido in 'uPedido.pas',
//  uConexao in 'uConexao.pas',
  uFrmPedido in 'uFrmPedido.pas' {frmPedido},
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

//  Conexao := TConexao.Create;   // cria a conexão
  try
    Application.CreateForm(TDM, DM);
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.CreateForm(TfrmPedido, frmPedido);
  //  Application.CreateForm(TDM, DM);
    Application.Run;
  finally
   // Conexao.Free;
  end;






end.
