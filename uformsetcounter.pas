unit uFormSetCounter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons,
  DateTimePicker, DateUtils;

type

  { TFormSetCounter }

  TFormSetCounter = class(TForm)
    BitBtn1: TBitBtn;
    DtpCounter: TDateTimePicker;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormSetCounter: TFormSetCounter;

implementation

{$R *.lfm}

{ TFormSetCounter }

procedure TFormSetCounter.FormShow(Sender: TObject);
begin
  DtpCounter.DateTime := EncodeDateTime(1982, 1, 1, 0, 0, 0, 0);
end;

end.

