object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'PEDIDO DE VENDA'
  ClientHeight = 628
  ClientWidth = 997
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 25
  object pnlPedidoDados: TPanel
    Left = 0
    Top = 0
    Width = 997
    Height = 258
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object lblPedido: TLabel
      Left = 9
      Top = 104
      Width = 49
      Height = 20
      Caption = 'Pedido:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 9
      Top = 140
      Width = 49
      Height = 20
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 9
      Top = 178
      Width = 44
      Height = 20
      Caption = 'Nome:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblPedidoTituloData: TLabel
      Left = 288
      Top = 104
      Width = 35
      Height = 20
      Caption = 'Data:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblPedidoData: TLabel
      Left = 328
      Top = 104
      Width = 76
      Height = 20
      Caption = '01/01/2026'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 995
      Height = 27
      Align = alTop
      Color = clBtnShadow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 768
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 124
        Height = 25
        Align = alLeft
        Caption = '<< Pedido >>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object edtPedidoCodigo: TEdit
      Left = 107
      Top = 96
      Width = 121
      Height = 28
      TabOrder = 1
    end
    object Edit1: TEdit
      Left = 107
      Top = 132
      Width = 121
      Height = 28
      TabOrder = 2
    end
    object edtPedidoCliente: TEdit
      Left = 107
      Top = 175
      Width = 404
      Height = 28
      ReadOnly = True
      TabOrder = 3
    end
    object pnlPedidoBotoes: TPanel
      Left = 1
      Top = 28
      Width = 995
      Height = 98
      Align = alTop
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      ExplicitLeft = 2
      object sbnovo: TSpeedButton
        Left = 24
        Top = 21
        Width = 76
        Height = 41
        Caption = '&Novo'
        Flat = True
        Layout = blGlyphTop
      end
    end
  end
  object pnlProdutosPedido: TPanel
    Left = 0
    Top = 258
    Width = 997
    Height = 225
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 216
    object SpeedButton1: TSpeedButton
      Left = 488
      Top = 104
      Width = 23
      Height = 22
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 995
      Height = 27
      Align = alTop
      Color = clBtnShadow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 241
        Height = 25
        Align = alLeft
        Caption = '<< Produtos do Pedido >>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
