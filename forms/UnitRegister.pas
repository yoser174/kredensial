unit UnitRegister;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniEdit, uniFieldSet, uniGUIBaseClasses, uniPanel,
  uniButton, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TfrmRegisters = class(TUniForm)
    edEmail: TUniEdit;
    edPassword: TUniEdit;
    edPassKonf: TUniEdit;
    btnReg: TUniButton;
    QCheckUser: TFDQuery;
    cmdInsert: TFDCommand;
    procedure btnRegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRegisters: TfrmRegisters;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, UnitLogin;

function frmRegisters: TfrmRegisters;
begin
  Result := TfrmRegisters(UniMainModule.GetFormInstance(TfrmRegisters));
end;

procedure TfrmRegisters.btnRegClick(Sender: TObject);
begin
  if edEmail.Text = '' then
  begin
    MessageDlg('Masukan alamat email.', mtError, [mbOK]);
    edEmail.SetFocus;
    exit;
  end;

  if edPassword.Text = '' then
  begin
    MessageDlg('Masukan password.', mtError, [mbOK]);
    edPassword.SetFocus;
    exit;
  end;

  if edPassKonf.Text = '' then
  begin
    MessageDlg('Masukan konfirmasi password.', mtError, [mbOK]);
    edPassKonf.SetFocus;
    exit;
  end;

  if QCheckUser.Active then
    QCheckUser.Active := False;
  QCheckUser.ParamByName('email').Value := edEmail.Text;
  QCheckUser.Open();

  if QCheckUser.FieldByName('jum').AsInteger > 0 then
  begin
    MessageDlg('Alamat email [' + edEmail.Text +
      '] sudah digunakan, jika lupa password klik lupa password pada halaman login',
      mtError, [mbOK]);
    edEmail.SetFocus;
    exit;
  end;

  if cmdInsert.Active then
    cmdInsert.Active := False;
  cmdInsert.ParamByName('email').Value := edEmail.Text;
  cmdInsert.ParamByName('password').Value := edPassword.Text;
  cmdInsert.Execute();

//  frmLogin.edEmail.Text := edEmail.Text;
//  frmLogin.edPassword.Text := edPassword.Text;

  MessageDlg('akun email [' + edEmail.Text +
    '] berhasil dibuat. silahkan login.', mtInformation, [mbOK]);

  Close;

end;

end.
