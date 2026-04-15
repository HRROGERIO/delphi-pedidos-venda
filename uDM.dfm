object DM: TDM
  OnCreate = DataModuleCreate
  Height = 368
  Width = 499
  object FDConnection: TFDConnection
    Left = 176
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 120
    Top = 112
  end
  object memItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 216
    Top = 208
  end
  object dsItens: TDataSource
    DataSet = memItens
    Left = 72
    Top = 184
  end
  object qryPedido: TFDQuery
    Connection = FDConnection
    Left = 344
    Top = 160
  end
  object qryPedidoProduto: TFDQuery
    Connection = FDConnection
    Left = 352
    Top = 232
  end
end
