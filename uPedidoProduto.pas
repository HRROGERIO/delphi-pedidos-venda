unit uPedidoProduto;

interface

type
  TPedidoProduto = class
  private
    FCodigoProduto: Integer;
    FDescricao: string;
    FQuantidade: Double;
    FValorUnitario: Double;
    FValorTotal: Double;

  public
    procedure CalcularTotal;

    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

procedure TPedidoProduto.CalcularTotal;
begin
  FValorTotal := FQuantidade * FValorUnitario;
end;

end.
