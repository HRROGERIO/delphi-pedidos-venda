unit uFrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ComCtrls, FireDAC.Comp.Client,
  FireDAC.DApt,udm,uPedido,uPedidoProduto;

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
    edtPedidoNumero: TEdit;
    lblPedidoTituloData: TLabel;
    edtPedidoCodigo: TEdit;
    edtPedidoCliente: TEdit;
    SpeedButton1: TSpeedButton;
    pnlPedidoBotoes: TPanel;
    sbPedidoNovo: TSpeedButton;
    sbPedidoGravar: TSpeedButton;
    sbPedidoCarregar: TSpeedButton;
    sbPedidoExcluir: TSpeedButton;
    sbPedidoSair: TSpeedButton;
    pnlProdPedidoBotoes: TPanel;
    sbProdPedidoInseriAtualizar: TSpeedButton;
    sbProdPedidoRemover: TSpeedButton;
    lblProdProduto: TLabel;
    edtProdProduto: TEdit;
    lblProdDescricao: TLabel;
    edtProdDescricao: TEdit;
    lblProdQtde: TLabel;
    Label3: TLabel;
    edtProdVrUnitario: TEdit;
    Panel2: TPanel;
    dbItens: TDBGrid;
    lblDescricaoTotal: TLabel;
    lblTotalPedido: TLabel;
    edtProdQtde: TEdit;
    lblDataPedido: TLabel;
    spPedidoLocalizar: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure sbPedidoSairClick(Sender: TObject);
    procedure sbPedidoNovoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbProdPedidoInseriAtualizarClick(Sender: TObject);
    procedure BuscarProduto;
    procedure AtualizarGrid;
    procedure FormCreate(Sender: TObject);
    procedure sbProdPedidoRemoverClick(Sender: TObject);
    procedure LimparProduto;
    procedure SalvarPedido;
    procedure sbPedidoGravarClick(Sender: TObject);
    procedure sbPedidoExcluirClick(Sender: TObject);
    procedure ExcluirPedido(ANumeroPedido: Integer);
    procedure edtPedidoCodigoChange(Sender: TObject);
    function ValidarCamposPedido: Boolean;
    function ValidarCamposProduto: Boolean;
    procedure dbItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbItensColExit(Sender: TObject);
    procedure sbPedidoCarregarClick(Sender: TObject);
    procedure spPedidoLocalizarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
     FPedido: TPedido;
  public

  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

function TfrmPedido.ValidarCamposPedido: Boolean;
begin
  Result := True;

  if Trim(edtPedidoCodigo.Text) = '' then
  begin
    ShowMessage('Informe o código do cliente.');
    edtPedidoCodigo.SetFocus;
    Result := False;
    Exit;
  end;

  if FPedido.Itens.Count = 0 then
  begin
    ShowMessage('Adicione pelo menos um produto ao pedido.');
    Result := False;
    Exit;
  end;
end;

function TfrmPedido.ValidarCamposProduto: Boolean;
begin
  Result := True;

  if Trim(edtProdProduto.Text) = '' then
  begin
    ShowMessage('Informe o código do produto.');
    edtProdProduto.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(edtProdQtde.Text) = '' then
  begin
    ShowMessage('Informe a quantidade.');
    edtProdQtde.SetFocus;
    Result := False;
    Exit;
  end;

  if StrToFloatDef(edtProdQtde.Text, 0) <= 0 then
  begin
    ShowMessage('Quantidade deve ser maior que zero.');
    edtProdQtde.SetFocus;
    Result := False;
    Exit;
  end;

  if StrToFloatDef(edtProdVrUnitario.Text, 0) <= 0 then
  begin
    ShowMessage('Valor unitário inválido.');
    edtProdVrUnitario.SetFocus;
    Result := False;
    Exit;
  end;
end;



procedure TfrmPedido.BuscarProduto;
var
  Q: TFDQuery;
begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := dm.FDConnection;

    Q.SQL.Text :=
      'SELECT descricao, preco_venda '+
      'FROM produtos '+
      'WHERE codigo = :codigo';

    Q.ParamByName('codigo').AsInteger :=
      StrToIntDef(edtProdProduto.Text,0);

    Q.Open;

    if not Q.IsEmpty then
    begin

      edtProdDescricao.Text :=
        Q.FieldByName('descricao').AsString;

      edtProdVrUnitario.Text :=
        FloatToStr(
          Q.FieldByName('preco_venda').AsFloat
        );

    end
    else
      ShowMessage('Produto não encontrado');

  finally
    Q.Free;
  end;

end;

procedure TfrmPedido.dbItensColExit(Sender: TObject);
var
  Index: Integer;
begin
  Index := dm.memItens.RecNo - 1;

  if (Index >= 0) and (Index < FPedido.Itens.Count) then
  begin
    FPedido.Itens[Index].Quantidade :=
      dm.memItens.FieldByName('quantidade').AsFloat;

    FPedido.Itens[Index].ValorUnitario :=
      dm.memItens.FieldByName('valor_unitario').AsFloat;

    FPedido.Itens[Index].CalcularTotal;
    AtualizarGrid;
  end;
end;





procedure TfrmPedido.dbItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Index: Integer;
begin
  if Key = VK_RETURN then
  begin
    if dm.memItens.State in [dsEdit, dsInsert] then
      dm.memItens.Post;

    Index := dm.memItens.RecNo - 1;
    if (Index >= 0) and (Index < FPedido.Itens.Count) then
    begin
      FPedido.Itens[Index].Quantidade := dm.memItens.FieldByName('quantidade').AsFloat;
      FPedido.Itens[Index].ValorUnitario := dm.memItens.FieldByName('valor_unitario').AsFloat;
      FPedido.Itens[Index].CalcularTotal;
      AtualizarGrid;
    end;

    Key := 0;
  end;

  if Key = VK_DELETE then
  begin
    if not dm.memItens.IsEmpty then
    begin
      if MessageDlg('Deseja realmente excluir este item?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Index := dm.memItens.RecNo - 1;
        if (Index >= 0) and (Index < FPedido.Itens.Count) then
        begin
          FPedido.Itens.Delete(Index);
          AtualizarGrid;
        end;
      end;
    end;
    Key := 0;
  end;
end;

procedure TfrmPedido.edtPedidoCodigoChange(Sender: TObject);
begin
  if Trim(edtPedidoCodigo.Text) = '' then
  begin
    sbPedidoExcluir.Visible := True;
    sbPedidoCarregar.Visible := True;
  end
  else
  begin
    sbPedidoExcluir.Visible := False;
    sbPedidoCarregar.Visible := False;
  end;
end;

procedure TfrmPedido.AtualizarGrid;
var
  Item: TPedidoProduto;
begin

  if not dm.memItens.Active then
     dm.memItens.Open;

  dm.memItens.EmptyDataSet;

  for Item in FPedido.Itens do
  begin

    dm.memItens.Append;

    dm.memItens.FieldByName('codigo').AsInteger :=
      Item.CodigoProduto;

    dm.memItens.FieldByName('descricao').AsString :=
      Item.Descricao;

    dm.memItens.FieldByName('quantidade').AsFloat :=
      Item.Quantidade;

    dm.memItens.FieldByName('valor_unitario').AsFloat :=
      Item.ValorUnitario;

    dm.memItens.FieldByName('valor_total').AsFloat :=
      Item.ValorTotal;

    dm.memItens.Post;

  end;

  FPedido.CalcularTotal;

  lblTotalPedido.Caption :=
    FormatFloat('0.00', FPedido.ValorTotal);
end;

procedure TfrmPedido.LimparProduto;
begin
  edtProdProduto.Clear;
  edtProdDescricao.Clear;
  edtProdQtde.Clear;
  edtProdVrUnitario.Clear;
  edtProdProduto.SetFocus;
end;

procedure TfrmPedido.SalvarPedido;
var
  Item: TPedidoProduto;
begin

  dm.FDConnection.StartTransaction;

  try
    // Salvar pedido
    dm.qryPedido.Close;
    dm.qryPedido.SQL.Text :=
    'INSERT INTO pedidos (data_emissao, codigo_cliente, valor_total) '+
    'VALUES (:data, :cliente, :total)';

    dm.qryPedido.ParamByName('data').AsDate :=
      FPedido.DataEmissao;

    dm.qryPedido.ParamByName('cliente').AsInteger :=
      FPedido.CodigoCliente;

    dm.qryPedido.ParamByName('total').AsFloat :=
      FPedido.ValorTotal;

    dm.qryPedido.ExecSQL;

    // pegar id gerado
    dm.qryPedido.Close;
    dm.qryPedido.SQL.Text := 'SELECT LAST_INSERT_ID() AS ID';
    dm.qryPedido.Open;

    FPedido.NumeroPedido :=
      dm.qryPedido.FieldByName('ID').AsInteger;

    // gravar itens
    for Item in FPedido.Itens do
    begin

      dm.qryPedidoProduto.Close;

      dm.qryPedidoProduto.SQL.Text :=
      'INSERT INTO pedidos_produtos '+
      '(numero_pedido, codigo_produto, quantidade, vr_unitario, vr_total) '+
      'VALUES (:pedido, :produto, :qtde, :valor, :total)';

      dm.qryPedidoProduto.ParamByName('pedido').AsInteger :=
        FPedido.NumeroPedido;

      dm.qryPedidoProduto.ParamByName('produto').AsInteger :=
        Item.CodigoProduto;

      dm.qryPedidoProduto.ParamByName('qtde').AsFloat :=
        Item.Quantidade;

      dm.qryPedidoProduto.ParamByName('valor').AsFloat :=
        Item.ValorUnitario;

      dm.qryPedidoProduto.ParamByName('total').AsFloat :=
        Item.ValorTotal;

      dm.qryPedidoProduto.ExecSQL;

    end;

    dm.FDConnection.Commit;

  except
    on E: Exception do
    begin
      dm.FDConnection.Rollback;

      ShowMessage('Erro ao gravar pedido: ' + E.Message);

    end;
  end;

end;


procedure TfrmPedido.ExcluirPedido(ANumeroPedido: Integer);
begin

  if MessageDlg('Deseja realmente excluir este pedido?',
     mtConfirmation,[mbYes,mbNo],0) = mrNo then
     Exit;

  dm.FDConnection.StartTransaction;

  try
    // apagar itens
    dm.qryPedidoProduto.Close;
    dm.qryPedidoProduto.SQL.Text :=
      'DELETE FROM pedidos_produtos WHERE numero_pedido = :pedido';

    dm.qryPedidoProduto.ParamByName('pedido').AsInteger :=
      ANumeroPedido;

    dm.qryPedidoProduto.ExecSQL;

    // apagar pedido
    dm.qryPedido.Close;
    dm.qryPedido.SQL.Text :=
      'DELETE FROM pedidos WHERE numero_pedido = :pedido';

    dm.qryPedido.ParamByName('pedido').AsInteger :=
      ANumeroPedido;

    dm.qryPedido.ExecSQL;

    dm.FDConnection.Commit;

    ShowMessage('Pedido excluído com sucesso.');

  except
    on E: Exception do
    begin

      dm.FDConnection.Rollback;

      ShowMessage('Erro ao excluir pedido: ' + E.Message);

    end;
  end;

end;


procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  FreeAndNil(FPedido);
  FPedido := TPedido.Create;

  if dm.memItens.Active then
    dm.memItens.EmptyDataSet;

  FPedido.Itens.Clear;

  dbItens.Options := dbItens.Options + [dgEditing];
end;


procedure TfrmPedido.FormDestroy(Sender: TObject);
begin
   FreeAndNil(FPedido);
end;


procedure TfrmPedido.sbPedidoCarregarClick(Sender: TObject);
var
  NumeroPedido: string;
  Q: TFDQuery;
  Item: TPedidoProduto;
begin
  NumeroPedido := InputBox('Carregar Pedido', 'Informe o número do pedido:', '');
  if NumeroPedido = '' then Exit;

  FreeAndNil(FPedido);
  FPedido := TPedido.Create;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dm.FDConnection;

    // Carregar cabeçalho do pedido
    Q.SQL.Text := 'SELECT numero_pedido, data_emissao, codigo_cliente, valor_total ' +
                  'FROM pedidos WHERE numero_pedido = :pedido';
    Q.ParamByName('pedido').AsInteger := StrToInt(NumeroPedido);
    Q.Open;

    if Q.IsEmpty then
    begin
      ShowMessage('Pedido não encontrado.');
      Exit;
    end;

    FPedido.NumeroPedido  := Q.FieldByName('numero_pedido').AsInteger;
    FPedido.DataEmissao   := Q.FieldByName('data_emissao').AsDateTime;
    FPedido.CodigoCliente := Q.FieldByName('codigo_cliente').AsInteger;
    FPedido.ValorTotal    := Q.FieldByName('valor_total').AsFloat;

    edtPedidoNumero.Text  := NumeroPedido;
    edtPedidoCodigo.Text  := IntToStr(FPedido.CodigoCliente);
    lblDataPedido.Caption := DateToStr(FPedido.DataEmissao);

    edtPedidoCliente.Text := dm.FDConnection.ExecSQLScalar(
      'SELECT nome FROM clientes WHERE codigo = ' + edtPedidoCodigo.Text
    );

    Q.Close;
    Q.SQL.Text := 'SELECT codigo_produto, quantidade, vr_unitario, vr_total ' +
                  'FROM pedidos_produtos WHERE numero_pedido = :pedido';
    Q.ParamByName('pedido').AsInteger := FPedido.NumeroPedido;
    Q.Open;

    while not Q.Eof do
    begin
      Item := TPedidoProduto.Create;
      Item.CodigoProduto := Q.FieldByName('codigo_produto').AsInteger;
      Item.Quantidade    := Q.FieldByName('quantidade').AsFloat;
      Item.ValorUnitario := Q.FieldByName('vr_unitario').AsFloat;
      Item.ValorTotal    := Q.FieldByName('vr_total').AsFloat;

      Item.Descricao := dm.FDConnection.ExecSQLScalar(
        'SELECT descricao FROM produtos WHERE codigo = ' + IntToStr(Item.CodigoProduto)
      );

      FPedido.Itens.Add(Item);
      Q.Next;
    end;

    AtualizarGrid;
    ShowMessage('Pedido carregado com sucesso.');
  finally
    Q.Free;
  end;
end;


procedure TfrmPedido.sbPedidoExcluirClick(Sender: TObject);
var
  NumeroPedido: string;
begin
  NumeroPedido := InputBox(
    'Excluir Pedido',
    'Informe o número do pedido:',
    ''
  );

  if NumeroPedido = '' then
     Exit;

  ExcluirPedido(StrToInt(NumeroPedido));
end;

procedure TfrmPedido.sbPedidoGravarClick(Sender: TObject);
begin
  if not Assigned(FPedido) then
  begin
    ShowMessage('Nenhum pedido criado.');
    Exit;
  end;

  if not ValidarCamposPedido then
    Exit;

  FPedido.CodigoCliente := StrToInt(edtPedidoCodigo.Text);
  FPedido.DataEmissao   := Now;

  SalvarPedido;
  ShowMessage('Pedido gravado com sucesso.');
end;


procedure TfrmPedido.sbPedidoNovoClick(Sender: TObject);
begin

  FPedido.DataEmissao := Date;

  edtPedidoNumero.Clear;
  edtPedidoCodigo.Clear;
  edtPedidoCliente.Clear;

  edtProdProduto.Clear;
  edtProdDescricao.Clear;
  edtProdQtde.Clear;
  edtProdVrUnitario.Clear;

  lblTotalPedido.Caption := '0,00';

  dm.memItens.EmptyDataSet;

  edtPedidoCodigo.SetFocus;
end;

procedure TfrmPedido.sbPedidoSairClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmPedido.sbProdPedidoInseriAtualizarClick(Sender: TObject);
var
  Item: TPedidoProduto;
begin
  if not ValidarCamposProduto then
    Exit;

  Item := TPedidoProduto.Create;
  FPedido.Itens.Add(Item);

  Item.CodigoProduto := StrToInt(edtProdProduto.Text);
  Item.Descricao := edtProdDescricao.Text;
  Item.Quantidade := StrToFloat(edtProdQtde.Text);
  Item.ValorUnitario := StrToFloat(edtProdVrUnitario.Text);
  Item.CalcularTotal;

  AtualizarGrid;
  LimparProduto;
end;


procedure TfrmPedido.sbProdPedidoRemoverClick(Sender: TObject);
var
  Index: Integer;
begin
  if not Assigned(FPedido) then
    Exit;

  if dm.memItens.IsEmpty then
    Exit;

  Index := dm.memItens.RecNo - 1;

  if (Index >= 0) and (Index < FPedido.Itens.Count) then
  begin
    FPedido.Itens.Delete(Index);
  end;

  AtualizarGrid;
end;

procedure TfrmPedido.SpeedButton2Click(Sender: TObject);
begin
  BuscarProduto;
  edtProdQtde.Text := '1';
end;

procedure TfrmPedido.spPedidoLocalizarClick(Sender: TObject);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.FDConnection;

    Q.SQL.Text := 'SELECT nome FROM clientes WHERE codigo = :codigo';
    Q.ParamByName('codigo').AsInteger := StrToIntDef(edtPedidoCodigo.Text,0);

    Q.Open;

    if not Q.Eof then
      edtPedidoCliente.Text := Q.Fields[0].AsString
    else
      ShowMessage('Cliente não encontrado');

  finally
    Q.Free;
  end;
end;

end.
