unit control;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Param,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  VCL.Forms,
  Vcl.Dialogs;

type
  TDadosCidades = class
    private
      function GetConexao: TFDConnection;
    public
      function GetCidades(pUF: String):  TFDQuery;
  end;

implementation

{ TDadosCidades }

function TDadosCidades.GetCidades(pUF: String): TFDQuery;
var
  QRY : TFDQuery;
  vSql: String;
begin
  QRY :=  TFDQuery.Create(nil);

  QRY.Connection  :=  GetConexao;

  vSql := 'SELECT C.NOME'
       + #13 + ',C.COD_IBGE'
       + #13 + 'FROM CIDADES C'
       + #13 + 'INNER JOIN ESTADOS E ON E.COD_UF = C.COD_UF'
       + #13 + 'WHERE E.UF = '''+pUF+''''
       + #13 + 'ORDER BY C.NOME';

  QRY.Open(vSql);
  Result  :=  QRY;
end;

function TDadosCidades.GetConexao: TFDConnection;
var
  CON   : TFDConnection;
  LINK  : TFDPhysFBDriverLink;
begin
  CON   :=  TFDConnection.Create(nil);
  LINK  :=  TFDPhysFBDriverLink.Create(nil);
  LINK.VendorLib := ExtractFilePath(Application.ExeName)+'fbclient.dll';

  CON.Params.Text :=  'Database='+ExtractFilePath(Application.ExeName)+'BANCO.FDB'
      + #13 + 'User_Name=SYSDBA'
      + #13 + 'Password=masterkey'
      + #13 + 'DriverID=FB';

  CON.Connected  :=  True;
  Result := CON;
end;

end.
