unit NEZZViewBase;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxSkinsCore,
  dxSkinsDefaultPainters,
  cxTextEdit;

type
  TNEZZViewsBase = class(TForm)
  procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    procedure DefinirCamposObrigatorios;
  public
    procedure CampoObrigatorio(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  end;

var
  NEZZViewsBase: TNEZZViewsBase;

implementation


{$R *.dfm}

procedure TNEZZViewsBase.CampoObrigatorio(
  Sender: TObject;
  var DisplayValue: Variant;
  var ErrorText: TCaption;
  var Error: Boolean
);
begin
  inherited;
  Error := DisplayValue = '';
  ErrorText := 'O campo � obrigat�rio';
end;

procedure TNEZZViewsBase.DefinirCamposObrigatorios;
var
  i: Integer;
  LComponent: TcxTextEdit;
begin
  for i := 0 to Pred(ComponentCount) do
  begin
    if Components[i] is TcxTextEdit then
    begin
      LComponent := TcxTextEdit(Components[i]);
      if LComponent.Tag = 1 then
      begin
        LComponent.Properties.ValidateOnEnter := True;
        LComponent.Properties.ValidationOptions := [
          evoShowErrorIcon,
          evoRaiseException
        ];

        LComponent.Properties.OnValidate := CampoObrigatorio;
      end;
    end;
  end;
end;

procedure TNEZZViewsBase.FormCreate(Sender: TObject);
begin
  DefinirCamposObrigatorios;
end;

procedure TNEZZViewsBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
