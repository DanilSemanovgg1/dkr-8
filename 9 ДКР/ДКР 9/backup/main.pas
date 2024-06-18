unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, edit, Grids;

type
  Contacts = record
    Name: string[100];
    Country: integer;
    Genre: integer;
    Year: string[100];
    Watched: string[100];
    Forma: string[100];
    Vaiv: string[100];
    Count: integer;
  end; //record


type

  { TfMain }

  TfMain = class(TForm)
    bAdd: TSpeedButton;
    bEdit: TSpeedButton;
    bDel: TSpeedButton;
    bSort: TSpeedButton;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  adres: string; //адрес, откуда запущена программа

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bAddClick(Sender: TObject);
begin
  //очищаем поля, если там что-то есть:
  fEdit.eName.Text:= '';
  fEdit.eCountry.Text:= '';
  fEdit.eGod.Text := '';
  fEdit.Regh.Text := '';
  fEdit.Forma.Text:= '';
  fEdit.Vaiv.Text := '';
  fEdit.Count.Text := '';
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //если пользователь ничего не ввел - выходим:
  if (fEdit.eName.Text= '') or (fEdit.eCountry.Text= '') then exit;
  //если пользователь не нажал "Сохранить" - выходим:
  if fEdit.ModalResult <> mrOk then exit;
  //иначе добавляем в сетку строку, и заполняем её:
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1]:= fEdit.eName.Text;
  SG.Cells[1, SG.RowCount-1]:= fEdit.eCountry.Text;
  SG.Cells[2, SG.RowCount-1]:= fEdit.eGod.Text;
  SG.Cells[3, SG.RowCount-1]:= fEdit.Regh.Text;
  SG.Cells[4, SG.RowCount-1]:= fEdit.Regh1.Text;
  SG.Cells[5, SG.RowCount-1]:= fEdit.Forma.Text;
  SG.Cells[6, SG.RowCount-1]:= fEdit.Vaiv.Text;
  SG.Cells[7, SG.RowCount-1]:= fEdit.Count.Text;
end;

procedure TfMain.bDelClick(Sender: TObject);
begin
  //если данных нет - выходим:
  if SG.RowCount = 1 then exit;
  //иначе выводим запрос на подтверждение:
  if MessageDlg('Требуется подтверждение',
                'Вы действительно хотите удалить мультфильм "' +
                SG.Cells[0, SG.Row] + '"?',
      mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
         SG.DeleteRow(SG.Row);
end;

procedure TfMain.bEditClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе записываем данные в форму редактора:
  fEdit.eName.Text:= SG.Cells[0, SG.Row];
  fEdit.eCountry.Text:= SG.Cells[1, SG.Row];
  fEdit.eGod.Text:= SG.Cells[2, SG.Row];
  fEdit.Regh.Text := SG.Cells[3, SG.Row];
  fEdit.Regh1.Text := SG.Cells[4, SG.Row];
  fEdit.Forma.Text:= SG.Cells[5, SG.Row];
  fEdit.Vaiv.Text := SG.Cells[6, SG.Row];
  fEdit.Count.Text := SG.Cells[7, SG.Row];
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //сохраняем в сетку возможные изменения,
  //если пользователь нажал "Сохранить":
  if fEdit.ModalResult = mrOk then begin
    SG.Cells[0, SG.RowCount]:= fEdit.eName.Text;
    SG.Cells[1, SG.RowCount]:= fEdit.eCountry.Text;
    SG.Cells[2, SG.RowCount]:= fEdit.eGod.Text;
    SG.Cells[3, SG.RowCount]:= fEdit.Regh.Text;
    SG.Cells[4, SG.RowCount]:= fEdit.Regh1.Text;
    SG.Cells[5, SG.RowCount]:= fEdit.Forma.Text;
    SG.Cells[6, SG.RowCount]:= fEdit.Vaiv.Text;
    SG.Cells[7, SG.RowCount]:= fEdit.Count.Text;
  end;
end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе сортируем список:
  SG.SortColRow(true, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Contacts; //для очередной записи
  f: file of Contacts; //файл данных
  i: integer; //счетчик цикла
begin
  //если строки данных пусты, просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе открываем файл для записи:
  try
    AssignFile(f, adres + 'telephones.dat');
    Rewrite(f);
    //теперь цикл - от первой до последней записи сетки:
    for i:= 1 to SG.RowCount-1 do begin
      //получаем данные текущей записи:
      MyCont.Name:= SG.Cells[0, i];
      MyCont.Country:= StrToInt(SG.Cells[1, i]);
      MyCont.Genre:= StrToInt(SG.Cells[2, i]);
      MyCont.Year := SG.Cells[3, i];
      MyCont.Watched := SG.Cells[4, i];
      MyCont.Forma := SG.Cells[5, i];
      MyCont.Vaiv := SG.Cells[6, i];
      MyCont.Count:= StrToInt(SG.Cells[7, i]);
      //записываем их:
      Write(f, MyCont);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Contacts; //для очередной записи
  f: file of Contacts; //файл данных
  i: integer; //счетчик цикла
begin
  //сначала получим адрес программы:
  adres:= ExtractFilePath(ParamStr(0));
  //настроим сетку:
  SG.Cells[0, 0]:= 'Марка мотоцикла';
  SG.Cells[1, 0]:='КОЛ-ВО ЛС';
  SG.Cells[2, 0]:= 'Диаметр колёс';
  SG.Cells[3, 0]:= 'Цена';
  SG.Cells[4, 0]:= 'Максимальная скорость';
  SG.Cells[5, 0]:= 'цвет';
  SG.Cells[6, 0]:= 'Бак';
  SG.Cells[7, 0]:= 'Количество';
  SG.ColWidths[0]:= 100;
  SG.ColWidths[1]:= 100;
  SG.ColWidths[2]:= 220;
  SG.ColWidths[3]:= 150;
  SG.ColWidths[4]:= 100;
  SG.ColWidths[5]:= 125;
  SG.ColWidths[6]:= 125;
  SG.ColWidths[7]:= 50;
  //если файла данных нет, просто выходим:
  if not FileExists(adres + 'Multik.dat') then exit;
  //иначе файл есть, открываем его для чтения и
  //считываем данные в сетку:
  try
    AssignFile(f, adres + 'telephones.dat');
    Reset(f);
    //теперь цикл - от первой до последней записи сетки:
    while not Eof(f) do begin
      //считываем новую запись:
      Read(f, MyCont);
      //добавляем в сетку новую строку, и заполняем её:
        SG.RowCount:= SG.RowCount + 1;
        SG.Cells[0, SG.RowCount-1]:= MyCont.Name;
        SG.Cells[1, SG.RowCount-1]:= IntToStr(MyCont.Country);
        SG.Cells[2, SG.RowCount-1]:= IntToStr(MyCont.Genre);
        SG.Cells[3, SG.RowCount-1]:= MyCont.Year;
        SG.Cells[4, SG.RowCount-1]:= MyCont.Watched;
        SG.Cells[5, SG.RowCount-1]:= MyCont.Forma;
        SG.Cells[6, SG.RowCount-1]:= MyCont.Vaiv;
        SG.Cells[7, SG.RowCount-1]:= IntToStr(MyCont.Count);
    end;
  finally
    CloseFile(f);
  end;
end;

end.

