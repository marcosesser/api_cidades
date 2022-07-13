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
  VCL.Forms,
  Winapi.Windows,
  control in 'control.pas';

  function GetConsoleWindow: HWND; stdcall; external kernel32;

begin

  //Deixar rodando em segundo plano
//  ShowWindow(GetConsoleWindow, SW_HIDE);


  THorse.Use(Jhonson);
  THorse.Use(Query);

  THorse.Get('/:UF',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      UF : String;
      DADOS : TDadosCidades;
    begin
      UF  :=  UpperCase(Req.Params['UF']);

      //LOG de consulta
      Writeln(FormatDateTime('DD/MM/YYYY HH:MM:SS', now)+' - Consulta: '+UF);

      DADOS := TDadosCidades.Create;
      try
        Res.Send<TFDQuery>(DADOS.GetCidades(UF));
      finally
        DADOS.DisposeOf;
      end;
    end);

  THorse.Listen(9000);
end.
