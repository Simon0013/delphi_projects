object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1058#1072#1073#1083#1080#1094#1072' SCOTT.OBJECTS'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 55
    Height = 13
    Caption = #1048#1089#1082#1072#1090#1100' '#1087#1086':'
  end
  object Label2: TLabel
    Left = 632
    Top = 8
    Width = 137
    Height = 13
    Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1073#1098#1077#1082#1090#1099' '#1090#1080#1087#1072
  end
  object RefreshButton: TButton
    Left = 8
    Top = 378
    Width = 121
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 0
    OnClick = RefreshButtonClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 50
    Width = 836
    Height = 322
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ObjectIdBox: TCheckBox
    Left = 8
    Top = 27
    Width = 55
    Height = 17
    Caption = 'ID:'
    TabOrder = 2
    OnClick = ObjectIdBoxClick
  end
  object ObjectIdEdit: TEdit
    Left = 69
    Top = 25
    Width = 89
    Height = 21
    TabOrder = 3
  end
  object ObjectNameBox: TCheckBox
    Left = 208
    Top = 27
    Width = 57
    Height = 17
    Caption = #1048#1084#1103':'
    TabOrder = 4
    OnClick = ObjectNameBoxClick
  end
  object ObjectNameEdit: TEdit
    Left = 271
    Top = 25
    Width = 226
    Height = 21
    TabOrder = 5
  end
  object SearchButton: TButton
    Left = 520
    Top = 23
    Width = 57
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = SearchButtonClick
  end
  object ObjectTypesBox: TComboBox
    Left = 632
    Top = 27
    Width = 161
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    TabOrder = 7
    OnChange = ObjectTypesBoxChange
  end
  object Edit1: TEdit
    Left = 144
    Top = 382
    Width = 700
    Height = 21
    TabOrder = 8
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'scott'
    Server = 'localhost:1521/xepdb1'
    Connected = True
    Left = 520
    Top = 392
    EncryptedPassword = '9DFF90FF8DFFCDFFC6FF8CFFCFFFCEFF'
  end
  object OraQuery1: TOraQuery
    Session = OraSession1
    SQL.Strings = (
      
        'select object_id as ID, owner as '#1042#1083#1072#1076#1077#1083#1077#1094', object_name as '#1048#1084#1103', o' +
        'bject_type as '#1058#1080#1087', created as '#1057#1086#1079#1076#1072#1085' from objects')
    Left = 664
    Top = 392
  end
  object DataSource1: TDataSource
    DataSet = OraQuery1
    Left = 736
    Top = 392
  end
  object OraQuery2: TOraQuery
    Session = OraSession1
    SQL.Strings = (
      'select distinct object_type from objects order by object_type')
    Left = 592
    Top = 400
  end
end
