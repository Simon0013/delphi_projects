object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1044#1072#1085#1085#1099#1077' '#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1093
  ClientHeight = 399
  ClientWidth = 605
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
  object EmpTree: TTreeView
    Left = 8
    Top = 8
    Width = 585
    Height = 353
    Indent = 19
    TabOrder = 0
  end
  object RefreshButton: TButton
    Left = 248
    Top = 367
    Width = 113
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 1
    OnClick = RefreshButtonClick
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'scott'
    Server = 'localhost:1521/xepdb1'
    Connected = True
    Left = 384
    Top = 400
    EncryptedPassword = '9DFF90FF8DFFCDFFC6FF8CFFCFFFCEFF'
  end
  object OraQuery1: TOraQuery
    Session = OraSession1
    SQL.Strings = (
      
        'select empno, ename, job, hiredate, sal, comm, dname from emp in' +
        'ner join dept on dept.deptno=emp.deptno where mgr is null')
    Left = 280
    Top = 400
  end
  object OraQuery2: TOraQuery
    Session = OraSession1
    SQL.Strings = (
      
        'select empno, ename, job, hiredate, sal, comm, dname from emp in' +
        'ner join dept on dept.deptno=emp.deptno where mgr = :emp_id')
    Left = 328
    Top = 400
    ParamData = <
      item
        Name = 'emp_id'
        ParamType = ptInput
        Value = Null
        ExtDataType = 107
      end>
  end
end
