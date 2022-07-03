object frmRegisters: TfrmRegisters
  Left = 0
  Top = 0
  ClientHeight = 282
  ClientWidth = 544
  Caption = 'Registers'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Font.Height = -13
  Font.Name = 'Roboto'
  PixelsPerInch = 96
  TextHeight = 15
  object edEmail: TUniEdit
    Left = 32
    Top = 24
    Width = 488
    Hint = 'Enter email address'
    Text = ''
    TabOrder = 0
    FieldLabel = 'Email address'
  end
  object edPassword: TUniEdit
    Left = 32
    Top = 84
    Width = 488
    Hint = 'Enter password'
    PasswordChar = '*'
    Text = ''
    TabOrder = 1
    FieldLabel = 'Password'
  end
  object edPassKonf: TUniEdit
    Left = 32
    Top = 136
    Width = 488
    Hint = 'Enter password confirmations'
    PasswordChar = '*'
    Text = ''
    TabOrder = 2
    FieldLabel = 'Confirm password'
  end
  object btnReg: TUniButton
    Left = 32
    Top = 216
    Width = 488
    Height = 33
    Hint = ''
    Caption = 'Register'
    TabOrder = 3
    OnClick = btnRegClick
  end
  object QCheckUser: TFDQuery
    Connection = UniServerModule.FDConnection1
    SQL.Strings = (
      'select count(*) jum from users where email = :email')
    Left = 32
    Top = 160
    ParamData = <
      item
        Name = 'EMAIL'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
  end
  object cmdInsert: TFDCommand
    Connection = UniServerModule.FDConnection1
    CommandText.Strings = (
      
        'insert into users (email,password) values (:email,md5(:password ' +
        ') );')
    ParamData = <
      item
        Name = 'EMAIL'
        DataType = ftString
        ParamType = ptInput
        Value = 'gasdfas'
      end
      item
        Name = 'PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Value = '1234'
      end>
    Left = 96
    Top = 160
  end
end
