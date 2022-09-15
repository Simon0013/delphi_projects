unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  OraCall, MemDS, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    EmpTree: TTreeView;
    OraSession1: TOraSession;
    OraQuery1: TOraQuery;
    OraQuery2: TOraQuery;
    RefreshButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure addChildrenInItem(TreeItem: Integer; Mgr: string);
    procedure RefreshButtonClick(Sender: TObject);
  private
    dataEmp: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.addChildrenInItem(TreeItem: Integer; Mgr: string);
var Query: TOraQuery; k, l, n: Integer; NewNode: TTreeNode;
begin
  Query:=TOraQuery.Create(nil);
  Query.Assign(OraQuery2);
  Query.Params[0].AsString:=Mgr;
  Query.Execute;
  if Query.RecordCount > 0 then
    for k := 0 to Query.RecordCount-1 do begin
      dataEmp:='';
      for l := 1 to Query.Fields.Count-1 do
        dataEmp:=dataEmp+Query.Fields[l].AsString + ' ';
      NewNode:=EmpTree.Items.AddChild(EmpTree.Items[TreeItem], dataEmp);
      n:=NewNode.AbsoluteIndex;
      addChildrenInItem(n, Query.Fields[0].AsString);
      Query.Next;
    end;
  Query.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I, J: Integer; EmpId: string;
begin
  OraSession1.Open;
  OraQuery1.Execute;
  dataEmp:='';
  for I := 1 to OraQuery1.Fields.Count-1 do
    dataEmp:=dataEmp+OraQuery1.Fields[I].AsString + ' ';
  EmpTree.Items.Add(NIL, dataEmp);
  EmpId:=OraQuery1.Fields[0].AsString;
  OraQuery1.Close;
  addChildrenInItem(0, EmpId);
  OraSession1.Close;
end;

procedure TForm1.RefreshButtonClick(Sender: TObject);
begin
  EmpTree.Items.Clear;
  FormCreate(nil);
end;

end.
