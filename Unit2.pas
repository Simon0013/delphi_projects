unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, OraCall, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    RefreshButton: TButton;
    OraSession1: TOraSession;
    OraQuery1: TOraQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ObjectIdBox: TCheckBox;
    ObjectIdEdit: TEdit;
    ObjectNameBox: TCheckBox;
    ObjectNameEdit: TEdit;
    SearchButton: TButton;
    Label2: TLabel;
    ObjectTypesBox: TComboBox;
    OraQuery2: TOraQuery;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure FillTypesBox();
    procedure ObjectTypesBoxChange(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ObjectIdBoxClick(Sender: TObject);
    procedure ObjectNameBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  OraQuery1.Execute;
  DBGrid1.Columns[0].Width := 50;
  DBGrid1.Columns[1].Width := 100;
  DBGrid1.Columns[2].Width := 400;
  FillTypesBox;
end;

procedure TForm2.ObjectIdBoxClick(Sender: TObject);
begin
  SearchButtonClick(nil);
end;

procedure TForm2.ObjectNameBoxClick(Sender: TObject);
begin
  SearchButtonClick(nil);
end;

procedure TForm2.ObjectTypesBoxChange(Sender: TObject);
var s, filter: string; indx: Integer;
begin
  indx := OraQuery1.Filter.IndexOf('Тип');
  if ObjectTypesBox.ItemIndex = 0 then
    filter := ''
  else if (OraQuery1.Filter = '') or (indx >= 0) then
    filter := 'Тип = ''' + ObjectTypesBox.Items[ObjectTypesBox.ItemIndex] + ''''
  else
    filter := ' and Тип = ''' + ObjectTypesBox.Items[ObjectTypesBox.ItemIndex] + '''';
  if indx >= 0 then
    s := OraQuery1.Filter.Substring(0, indx)
  else s := OraQuery1.Filter;
  if s.EndsWith(' and ') and (filter = '') then
     s := s.Remove(s.Length-5);
  Edit1.Text := s + filter;
  OraQuery1.Filter := s + filter;
  OraQuery1.Filtered := True;
end;

procedure TForm2.RefreshButtonClick(Sender: TObject);
begin
  OraQuery1.Refresh;
  FillTypesBox;
end;

procedure TForm2.SearchButtonClick(Sender: TObject);
var s, t: string; indx: Integer;
begin
  indx := OraQuery1.Filter.IndexOf('Тип');
  if (indx >= 0) then
    s := OraQuery1.Filter.Substring(indx);
  if (ObjectIdEdit.Text <> '') and ObjectIdBox.Checked then
    t := 'ID = ' + ObjectIdEdit.Text;
  if (ObjectNameEdit.Text <> '') and ObjectNameBox.Checked then
    t := t + ' and Имя = ''' + ObjectNameEdit.Text + '''';
  if s <> '' then
    t := t + ' and ' + s;
  if t.IndexOf(' and ') = 0 then
    t := t.Substring(5);
  Edit1.Text := t;
  OraQuery1.Filter := t;
  OraQuery1.Filtered := True;
end;

procedure TForm2.FillTypesBox;
var I: Integer;
begin
  with ObjectTypesBox.Items do begin
    Clear;
    Add('Все');
    OraQuery2.Execute;
    if OraQuery2.RecordCount > 0 then
      while True do begin
        I:=OraQuery2.RecNo;
        Add(OraQuery2.Fields[0].AsString);
        OraQuery2.Next;
        if I = OraQuery2.RecNo then break;
      end;
  end;
end;

end.
