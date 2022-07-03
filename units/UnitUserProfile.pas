unit UnitUserProfile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, Vcl.Imaging.jpeg, uniImage, uniGUIBaseClasses,
  uniPanel, uniButton, uniFileUpload, uniBitBtn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client,
  Data.DB, FireDAC.DApt, FireDAC.Comp.DataSet, uniEdit, uniDateTimePicker,
  uniMemo, uniBasicGrid, uniDBGrid, uniPageControl;

type
  TfrUserProfile = class(TUniFrame)
    pnlFoto: TUniContainerPanel;
    imUser: TUniImage;
    UniButton1: TUniButton;
    UniFileUpload1: TUniFileUpload;
    QImage: TFDQuery;
    spImage: TFDStoredProc;
    UniContainerPanel3: TUniContainerPanel;
    pcProfil: TUniPageControl;
    tsData: TUniTabSheet;
    pnlData: TUniContainerPanel;
    edEmail: TUniEdit;
    edFullName: TUniEdit;
    UniEdit3: TUniEdit;
    UniEdit4: TUniEdit;
    UniDateTimePicker1: TUniDateTimePicker;
    UniMemo1: TUniMemo;
    UniEdit5: TUniEdit;
    UniEdit6: TUniEdit;
    UniEdit7: TUniEdit;
    UniEdit8: TUniEdit;
    UniButton2: TUniButton;
    UniContainerPanel2: TUniContainerPanel;
    tsAuditlog: TUniTabSheet;
    QDataProfil: TFDQuery;
    pnlUserProfile: TUniPanel;
    procedure UniButton1Click(Sender: TObject);
    procedure UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrUserProfile.UniButton1Click(Sender: TObject);
begin
  UniFileUpload1.Execute;
end;

procedure TfrUserProfile.UniFileUpload1Completed(Sender: TObject;
  AStream: TFileStream);
var
  BS: TStream;
begin
  imUser.Picture.LoadFromFile(AStream.FileName);

  if spImage.Active then
    spImage.Active := False;
  spImage.ParamByName('p_user_id').Value := UniApplication.Cookies.GetCookie
    ('UserId');
  spImage.ParamByName('p_picture').LoadFromFile(AStream.FileName, ftBlob);
  spImage.ExecProc;

end;

procedure TfrUserProfile.UniFrameCreate(Sender: TObject);
var
  Bmp: TBitmap;
  blob: TStream;
  Jpg: TJPEGImage;
begin
  if QImage.Active then
    QImage.Active := False;
  QImage.ParamByName('id').Value := UniApplication.Cookies.GetCookie('UserId');
  QImage.Active := True;

  if QImage.RecordCount > 0 then
  begin
    Bmp := TBitmap.Create;
    blob := QImage.CreateBlobStream(QImage.FieldByName('picture'), bmRead);
    try
      Jpg := TJPEGImage.Create;
      try
        Jpg.LoadFromStream(blob);
        Bmp.Assign(Jpg);
        imUser.Assign(Bmp);
      finally
        Jpg.Free;
      end;
    finally
      blob.Free;
    end;
    Bmp.Free;
  end;

  if QDataProfil.Active then
    QDataProfil.Active := False;
  QDataProfil.ParamByName('id').Value := UniApplication.Cookies.GetCookie
    ('UserId');
  QDataProfil.Open();

  edEmail.Text := QDataProfil.FieldByName('email').AsString;
  edFullName.Text := QDataProfil.FieldByName('full_name').AsString;
  pnlUserProfile.Caption := QDataProfil.FieldByName('user_profile').AsString;

  pcProfil.ActivePage := tsData;

end;

initialization

RegisterClass(TfrUserProfile);

end.
