program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.Query,
  System.SysUtils,
  System.JSON,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  Data.DB,
  control in 'control.pas';

begin
  THorse.Use(Jhonson);
  THorse.Use(Query);

  THorse.Get('/Cidades/:UF',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      UF : String;
      DADOS : TDadosCidades;
    begin
      UF  :=  Req.Params['UF'];

      DADOS := TDadosCidades.Create;
      try
        Res.Send<TFDQuery>(DADOS.GetCidades(UF));
      finally
        DADOS.DisposeOf;
      end;

    end);

  THorse.Listen(9000);
end.
