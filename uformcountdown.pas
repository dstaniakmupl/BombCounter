unit uFormCountdown;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  LedNumber, DateUtils, uFormSetCounter;

type

  { TFormCountdown }

  TFormCountdown = class(TForm)
    DlgColor: TColorDialog;
    LnrCounter: TLEDNumber;
    MnuResetColors: TMenuItem;
    MnuOffLedColor: TMenuItem;
    MnuCounterValue: TMenuItem;
    MnuOnLedColor: TMenuItem;
    MnuBackColor: TMenuItem;
    PnlCounter: TPanel;
    MnuCounter: TPopupMenu;
    TmrCounter: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HandleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MnuBackColorClick(Sender: TObject);
    procedure MnuCounterValueClick(Sender: TObject);
    procedure MnuOffLedColorClick(Sender: TObject);
    procedure MnuOnLedColorClick(Sender: TObject);
    procedure MnuResetColorsClick(Sender: TObject);
    procedure TmrCounterTimer(Sender: TObject);
  private
    CounterValue : TTime;

    procedure ResetCounter(H, M, S : Integer);
  public

  end;

var
  FormCountdown: TFormCountdown;

implementation

{$R *.lfm}

{ TFormCountdown }

procedure TFormCountdown.FormResize(Sender: TObject);
begin
  while (LnrCounter.Width < Width)
  and (LnrCounter.Height < Height) do
    LnrCounter.Size := LnrCounter.Size + 1;
  if (LnrCounter.Width > Width) or (LnrCounter.Height > Height) then
    LnrCounter.Size := LnrCounter.Size - 1;
end;

procedure TFormCountdown.FormCreate(Sender: TObject);
begin
  ResetCounter(0, 0, 0);
end;

procedure TFormCountdown.HandleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then MnuCounter.PopUp;
end;

procedure TFormCountdown.MnuBackColorClick(Sender: TObject);
begin
  DlgColor.Color := Color;
  if DlgColor.Execute then begin
    LnrCounter.BgColor := DlgColor.Color;
    Color := DlgColor.Color;
  end;
end;

procedure TFormCountdown.MnuCounterValueClick(Sender: TObject);
var
  T : TTime;
begin
  Application.CreateForm(TFormSetCounter, FormSetCounter);
  if FormSetCounter.ShowModal = mrOk then begin
    T := FormSetCounter.DtpCounter.Time;
    ResetCounter(HourOf(T), MinuteOf(T), SecondOf(T));
  end;
end;

procedure TFormCountdown.MnuOffLedColorClick(Sender: TObject);
begin
  DlgColor.Color := LnrCounter.OffColor;
  if DlgColor.Execute then LnrCounter.OffColor := DlgColor.Color;
end;

procedure TFormCountdown.MnuOnLedColorClick(Sender: TObject);
begin
  DlgColor.Color := LnrCounter.OnColor;
  if DlgColor.Execute then LnrCounter.OnColor := DlgColor.Color;
end;

procedure TFormCountdown.MnuResetColorsClick(Sender: TObject);
begin
  Color := clBlack;
  LnrCounter.BgColor := clBlack;
  LnrCounter.OnColor := clLime;
  LnrCounter.OffColor := $000E3432;
end;

procedure TFormCountdown.TmrCounterTimer(Sender: TObject);
begin
  if (YearOf(CounterValue) >= 1982)
  and (
    (HourOf(CounterValue) > 0)
    or (MinuteOf(CounterValue) > 0)
    or (SecondOf(CounterValue) > 0)) then begin
    CounterValue := IncSecond(CounterValue, -1);
    LnrCounter.Caption := FormatDateTime('hh:nn:ss', CounterValue);
  end;
end;

procedure TFormCountdown.ResetCounter(H, M, S: Integer);
begin
  CounterValue := EncodeDateTime(1982, 1, 1, H, M, S, 0);
end;

end.

