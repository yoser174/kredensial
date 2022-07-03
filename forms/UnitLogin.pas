unit UnitLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniEdit,
  uniButton, uniWidgets, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniLabel, uniPanel;

type
  TfrmLogin = class(TUniLoginForm)
    UniButton1: TUniButton;
    btnLogin: TUniButton;
    UniPanel1: TUniPanel;
    edEmail: TUniEdit;
    UniLabel1: TUniLabel;
    edPassword: TUniEdit;
    UniLabel2: TUniLabel;
    qLogin: TFDQuery;
    procedure UniButton1Click(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, UnitRegister;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(UniMainModule.GetFormInstance(TfrmLogin));
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin

  if edEmail.Text = '' then
  begin
    MessageDlg('Email masih kosong.', mtError, [mbOk]);
    edEmail.SetFocus;
    exit;
  end;

  if edPassword.Text = '' then
  begin
    MessageDlg('Password masih kosong.', mtError, [mbOk]);
    edPassword.SetFocus;
    exit;
  end;

  ShowMask('Loading');
  UniSession.Synchronize();

  if qLogin.Active then
    qLogin.Active := False;
  qLogin.ParamByName('email').Value := edEmail.Text;
  qLogin.ParamByName('password').Value := edPassword.Text;
  qLogin.Open();

  if qLogin.RecordCount > 0 then
  begin
    ModalResult := mrOK;
    UniApplication.Cookies.SetCookie('UserId', qLogin.FieldByName('id')
      .AsString);
    UniApplication.Cookies.SetCookie('UserEmail', qLogin.FieldByName('email')
      .AsString);
  end
  else
    MessageDlg('Invalid email dan/atau password.', mtError, [mbOk]);

  HideMask;
end;

procedure TfrmLogin.UniButton1Click(Sender: TObject);
begin
  frmRegisters.Showmodal;
end;

initialization

RegisterAppFormClass(TfrmLogin);

end.
