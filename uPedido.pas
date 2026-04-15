unit uPedido;

interface

uses
  System.Generics.Collections, uPedidoProduto;

type
  TPedido = class
  private
    FNumeroPedido: Integer;
    FDataEmissao: TDate;
    FCodigoCliente: Integer;
    FValorTotal: Double;
    FItens: TObjectList<TPedidoProduto>;

  public
    constructor Create;
    destructor Destroy; override;

    procedure CalcularTotal;

    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: TDate read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Itens: TObjectList<TPedidoProduto> read FItens;
  end;

implementation

constructor TPedido.Create;
begin
  FItens := TObjectList<TPedidoProduto>.Create;
end;

destructor TPedido.Destroy;
begin
  FItens.Free;
  inherited;
end;

procedure TPedido.CalcularTotal;
var
  Item: TPedidoProduto;
begin
  FValorTotal := 0;

  for Item in FItens do
    FValorTotal := FValorTotal + Item.ValorTotal;
end;

end.
