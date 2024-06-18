unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

    TfEdit = class(TForm)
    bCancel: TBitBtn;
    bSave: TBitBtn;
    eCountry: TEdit;
    Forma: TEdit;
    Vaiv: TEdit;
    Count: TEdit;
    eGod: TEdit;
    LForma: TLabel;
    LVaiv: TLabel;
    LCount: TLabel;
    LRegh1: TLabel;
    Regh: TEdit;
    eName: TEdit;
    Lname: TLabel;
    Lcountry: TLabel;
    Regh1: TEdit;
    YkGod: TLabel;
    LRegh: TLabel;
    procedure bSaveClick(Sender: TObject);
    procedure CBNoteChange(Sender: TObject);
    procedure CountKeyPress(Sender: TObject; var Key: char);
    procedure eCountryKeyPress(Sender: TObject; var Key: char);
    procedure eDlitChange(Sender: TObject);
    procedure eGodChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LnameClick(Sender: TObject);
    procedure LReghClick(Sender: TObject);
    procedure ReghChange(Sender: TObject);
    procedure eGodKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.bSaveClick(Sender: TObject);
begin

end;

procedure TfEdit.CBNoteChange(Sender: TObject);
begin

end;

procedure TfEdit.CountKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8]) then Key := #0;
end;

procedure TfEdit.eCountryKeyPress(Sender: TObject; var Key: char);
begin
   if not (Key in ['0'..'9', #8]) then Key := #0;
end;

procedure TfEdit.eDlitChange(Sender: TObject);
begin

end;

procedure TfEdit.eGodChange(Sender: TObject);
begin

end;

procedure TfEdit.FormShow(Sender: TObject);
begin
  eName.SetFocus;
end;

procedure TfEdit.LnameClick(Sender: TObject);
begin

end;

procedure TfEdit.LReghClick(Sender: TObject);
begin

end;

procedure TfEdit.ReghChange(Sender: TObject);
begin

end;

procedure TfEdit.eGodKeyPress(Sender: TObject; var Key:char);
begin
     if not (Key in ['0'..'9', #8]) then Key := #0;
end;


end.

