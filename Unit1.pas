unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  point2=array[1..1000] of integer;
  point=array[1..1000]of double;
  TForm1 = class(TForm)
    Image1: TImage;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    StaticText1: TStaticText;
    Edit3_vazba: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit3_Pocet: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit3_Krok: TEdit;
    StaticText2: TStaticText;
    Edit3_Zacni: TEdit;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    Edit_X2: TEdit;
    Edit_X1: TEdit;
    Edit_Y1: TEdit;
    Edit_Y2: TEdit;
    Button3: TButton;
    Button4: TButton;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    Edit_vrstevnice: TEdit;
    Edit_Pocet: TEdit;
    StaticText10: TStaticText;
    Edit_Start: TEdit;
    Edit_fxy: TEdit;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    Edit_TolO: TEdit;
    Edit_TolD: TEdit;
  //  procedure Image1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Py,Px,Pz,P:point;
  Bx,By:point2;
  s,y2,i,q,a,r,m,x,opak,e,zmax2:integer;
  y,ymax,xmax,zmax,x2,krok:double;

implementation

{$R *.dfm}

uses Graph2d;

procedure chyba;
begin
   ShowMessage(draw2d.ErrorReport); exit;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    with draw2D do
begin
  ClearImage(255,255,255);
  XScale(x1,x2,0,0,0,0);
  YScale(y1,y2,0,0,0,0);
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
close;
end;

function u(x,y:Double):double;
begin
  try
  //u:=(x*x+y*y)/x;
  u:=(x*x/y)+(y*y/x);
  except
   ;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var L:Tpoint;
    xx,yy,yy2k,r,w,xx2,yy2:integer;
    h1,h2,h3,h4,max,min:double;
begin
 with draw2d do begin
  x1:=calc(Edit_X1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
     y2:=calc(Edit_Y2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
     x2:=calc(Edit_X2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
     y1:=calc(Edit_Y1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì


Draw2D.Scale(x1,x2,y1,y2);           //Nakreslí souøadné osy
XScale(x1,x2,0,0,0,0);               //udìlá mìøítko na ose x od kraje x1 po kraj x2
YScale(y1,y2,0,0,0,0);
 try
 max:=StrToFloat(Edit_TolD.Text);
 min:=StrToFloat(Edit_TolO.Text);
 r:=StrToInt(Edit_Start.Text);
 except
 ShowMessage('Rozhraní tolerance musí být celoèíselné.Zaèni od je èíslo');
 end;
 for w := 0 to StrToInt(Edit_pocet.Text) do
 begin
 r:=r+StrToInt(Edit_vrstevnice.Text);
  for xx := 1 to 1000 do
    begin ;
      for yy := 1 to 1000 do
          begin
              xx2:=1-xx;
              yy2:=1-yy;
              h4:=u(xx,yy2);  //4. kvadrnat +
              h2:=u(xx2,yy);  //2. kvadrant -
              h1:=u(xx,yy);  //1.kvadrant +
              h3:= u(xx2,yy2); //3. kvadrant -
              if (h1 > min+r)and (h1 < max+r)then    //je tøeba zadat rozumné rozmezí
               begin                                //aby se dobøe vykreslila jedna
              L[1]:=xx;L[2]:=yy;  //1.kvadrant  +
              PutPoint(L,0,0,255);          //konkrétní vrstevnice
               end;
              if (h3 > min+r)and (h3 < max+r)then
               begin
              L[1]:=xx2;L[2]:=yy2;  //3. kvadrant -
              PutPoint(L,0,0,255);
               end;
              if (h2 > min+r)and (h2 < max+r)then
               begin
              L[1]:=xx2;L[2]:=yy; // 2.kvadrant -
              PutPoint(L,0,0,255);
               end;
              if (h4 > min+r)and (h4 < max+r)then
               begin
              L[1]:=xx;L[2]:=yy2; //4.kvadrant +
              PutPoint(L,0,0,255);
               end;
          end;
    end;
  end;
 end;
end;







function h(i,x2,y2:double):double;                            //Funkce pro výpoèet funkce z
begin                                                          //R*R do R*R*R
   try                                                         //body, jenž jsou dosazovány
  h:=sin(x2)*y2;
   //h:=(y2*y2/x2)+ x2*x2;                                       //leží na vazbì F
   //h:=x2*x2+y2*y2;
   except
    ;// Edit1.Text:= 'Funkce není v bodì [',x2,',',y2,'] definována';
   end;
end;

function f(x:integer):double;                          //Funkce na výpoèet
begin                                                  //y-ových souøadnic vazeb F
    try
    //f:=-1*x*x*x*x+x*x*x+15*x*x-7*x;                  //Nìkolik
    //f:=x*x/200;                                            //možných
    //f:=x*x*x+10*x*x+x;                               //vazeb pro
   // f:=5;                                            //otestování algoritmu
    except
     ;// Writeln('Vazba není v bodì ',x,' definována');
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
with Draw2D do begin
 opak:=StrToInt(Edit3_Pocet.Text);       //uživatel urèí kolikrát se cyklus zopakuje zopakuje

       x1:=calc(Edit_X1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
     y2:=calc(Edit_Y2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
     x2:=calc(Edit_X2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
     y1:=calc(Edit_Y1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì

{x1:=-100;
x2:=100;
y1:=-100;
y2:=100; }

Draw2D.Scale(x1,x2,y1,y2);           //Nakreslí souøadné osy
XScale(x1,x2,0,0,0,0);               //udìlá mìøítko na ose x od kraje x1 po kraj x2
YScale(y1,y2,0,0,0,0);

krok:= StrToFloat(Edit3_Krok.Text);
s:=StrToInt(Edit3_Zacni.Text);//-5;                        //1. bod jenž je dosazen do funkce f, z které získáme
y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//y-ovou souøadnici vazby. Výsledkem jsou souøadnice [x,y] ležící na vazbì F
if draw2d.ErrorReport <> '' then chyba;

Px[i]:=s;                     //Px[i] je 1. x-ová souøadnice vazby F
Py[i]:=round(y);              //Py[i] je 1. y-ová souøadnice vazby F
x2:=Px[i];                    //x2 je 1. x-ová souøadnice vazby F, jenž dosazujem do funkce h
y2:=Py[i];                    //y2 je 1. y-ová souøadnice vazby F, jenž dosazujem do funkce h
Pz[i]:= round(h(i,x2,y2));    //Pz[i] je 1. z-ová souøadnice funkce f. Vznikne zobrazením bodu [x2,y2]
zmax:= Pz[i];         //Nastaví maximální hodnotu vazby, jenž je použitá k porovnávání s dalšími hodnotami

for i := 0 to opak do                                //Cyklus na dosazování hodnot od -5 do 5
  begin
   x:=s+krok*i;                //Nastaví x a s každým prùchodem cyklu se zvìtší o 1 tj.-5,-4,-3
   y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                //Vypoète y, jenž je pozdìji použitá jako y-ová souøadnice vazby náleící bodu x
   if draw2d.ErrorReport <> '' then chyba;

   Px[i]:=x;               //Do 0. èlenu pole Px se nahraje bod se souøadnicí x
   Py[i]:=round(y);        //viz. øádek 50
   A[1]:=Px[i];A[2]:=Py[i];
   PutPoint(A,0,0,0);;
   x2:=Px[i];              //Px[i] resp. Py[i] se nahraje do x2 resp. y2
   y2:=Py[i];
   Pz[i]:=round(h(i,x2,y2));//1. souøadnice funkce f, jenž vznikne zobrazením bodu vazby o souøadnici[x2,y2]
   if Pz[i]>zmax then       //Jeslti se v prùbìhu cyklu najde vìtší hodnota než dosavadní
    begin                   //tj. zmax, pak je zmax pøepsáno touto hodnotou
      zmax:=Pz[i];
    end;
  end;

StringGrid1.RowCount:=opak;      //Nastaví poèet øádkù ve stringgridu
StringGrid1.ColCount:=2;        //Nastaví poèet sloupcù ve stringgridu
krok:= StrToFloat(Edit3_Krok.Text);
s:=StrToInt(Edit3_Zacni.Text);
m:=0;
e:=0;
for i := 0 to opak do             //Cyklus pro zjištìní, kolik bodù z Df se zobrazí na stejnou
  begin                         //maximální funkèní hodnotu
    x:=s+krok*i;                    //Nastaví x a s každým prùchodem cyklu se zvìtší o 1 tj.-5,-4,-3
    y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                    //Vypoète jeho funkèní hodnotu tj. y-ovou souøadnici vazby náležící bodu x
    if Draw2D.ErrorReport <> '' then chyba;
    Px[i]:=x;                   //viz. øádky
    Py[i]:=round(y);            //øádky
    x2:=Px[i];                  //51
    y2:=Py[i];                  //až
    Pz[i]:=round(h(i,x2,y2));   //55
    if Pz[i]=zmax then          //Poud se funkèní hodnota rovná zmax z 59. øádku kódu, pak
    begin                       //a se zvìtší o 1. Tato hodnota udává poèet bodù v Df,
      e:=e+1;                   //jenž nabývají vázaného extrému
      m:=e-1;
      Px[i]:=x;                 //Px[i] a Py[i] je pole, do kterého se nahraje x-ová a y-ová souøadnice bodu,
      Py[i]:=round(y);          //jenž nabývá vázaného extrému, index a se s každým takovým nalezeným bodem zvìtší o +1
      A[1]:=Px[i];A[2]:=Py[i];
      Cross(A,5,255,0,0);
      Bx[i]:= round(Px[i]);
      By[i]:=round(Py[i]);
      StringGrid1.Cells [0,m]:= IntToStr(Bx[i])+','+IntToStr(By[i]);    //Urèí buòku do níž je napsána souøadnice vazby, v níž je nabyto váz. maxima
      Edit2.Text:= 'Maximální hodnotu nabývá funkce v bodì ['+ IntToStr(Bx[i])+','+ IntToStr(By[i])+'] a její hodnota se rovná ' + IntTostr((round(zmax))) ;
    end;
    zmax2:=round(zmax);
   for m:= 0 to e-1 do begin StringGrid1.Cells[1,m]:=IntToStr(round(zmax2));end; //Urèí buòku do níž je napsána maximální hodnota vaz. extr.
   end;
Edit1.Text:='Poèet èísel, jejichž hodnoty jsou maximální na Df a vzájemnì se rovnají je '+ IntToStr(e);
end;
end;

end.
{
procedure TForm1.Image1Click(Sender: TObject);
begin
with Draw2D do begin
  Draw2D.Scale(-1,1,10,-1);           //Nakreslí souøadné osy
    XScale(x1,x2,0,0,0,0);                            //udìlá mìøítko na ose x od kraje x1 po kraj x2
    YScale(y1,y2,0,0,0,0);
end;
x:=-5;                        //1. bod jenž je dosazen do funkce f, z které získáme
y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                      //y-ovou souøadnici vazby. Výsledkem jsou souøadnice [x,y] ležící na vazbì F
if draw2d.ErrorReport <> '' then begin
                             ShowMessage(draw2d.ErrorReport);
                             exit;
                             end;
Px[i]:=x;                     //Px[i] je 1. x-ová souøadnice vazby F
Py[i]:=round(y);              //Py[i] je 1. y-ová souøadnice vazby F
x2:=Px[i];                    //x2 je 1. x-ová souøadnice vazby F, jenž dosazujem do funkce h
y2:=Py[i];                    //y2 je 1. y-ová souøadnice vazby F, jenž dosazujem do funkce h
Pz[i]:= round(h(i,x2,y2));    //Pz[i] je 1. z-ová souøadnice funkce f. Vznikne zobrazením bodu [x2,y2]
zmax:= Pz[i];         //Nastaví maximální hodnotu vazby, jenž je použitá k porovnávání s dalšími hodnotami

for i := 0 to 1000 do                                //Cyklus na dosazování hodnot od -5 do 5
  begin
   x:=-5+i;                //Nastaví x a s každým prùchodem cyklu se zvìtší o 1 tj.-5,-4,-3
   y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                //Vypoète y, jenž je pozdìji použitá jako y-ová souøadnice vazby náleící bodu x
   if draw2d.ErrorReport <> '' then begin
                             ShowMessage(draw2d.ErrorReport);
                             exit;
                             end;

   Px[i]:=x;               //Do 0. èlenu pole Px se nahraje bod se souøadnicí x
   Py[i]:=round(y);        //viz. øádek 50
   Canvas.Pixels[Px[i],Py[i]]:=clred;
   x2:=Px[i];              //Px[i] resp. Py[i] se nahraje do x2 resp. y2
   y2:=Py[i];
   Pz[i]:=round(h(i,x2,y2));//1. souøadnice funkce f, jenž vznikne zobrazením bodu vazby o souøadnici[x2,y2]
   if Pz[i]>zmax then       //Jeslti se v prùbìhu cyklu najde vìtší hodnota než dosavadní
    begin                   //tj. zmax, pak je zmax pøepsáno touto hodnotou
      zmax:=Pz[i];
    end;
  //end;
  end;

StringGrid1.RowCount:=1000;      //Nastaví poèet øádkù ve stringgridu
StringGrid1.ColCount:=2;        //Nastaví poèet sloupcù ve stringgridu

t:=0;
a:=0;
for i := 0 to 1000 do             //Cyklus pro zjištìní, kolik bodù z Df se zobrazí na stejnou
  begin                         //maximální funkèní hodnotu
    x:=-5+i;                    //Nastaví x a s každým prùchodem cyklu se zvìtší o 1 tj.-5,-4,-3
    y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                    //Vypoète jeho funkèní hodnotu tj. y-ovou souøadnici vazby náležící bodu x
    if Draw2D.ErrorReport <> '' then begin
                                     ShowMessage(Draw2D.ErrorReport);
                                     exit;
                                     end;
    Px[i]:=x;                   //viz. øádky
    Py[i]:=round(y);            //øádky
    x2:=Px[i];                  //51
    y2:=Py[i];                  //až
    Pz[i]:=round(h(i,x2,y2));   //55
    if Pz[i]=zmax then          //Poud se funkèní hodnota rovná zmax z 59. øádku kódu, pak
    begin                       //a se zvìtší o 1. Tato hodnota udává poèet bodù v Df,
      a:=a+1;                   //jenž nabývají vázaného extrému
      t:=a-1;
      Px[i]:=x;                 //Px[i] a Py[i] je pole, do kterého se nahraje x-ová a y-ová souøadnice bodu,
      Py[i]:=round(y);          //jenž nabývá vázaného extrému, index a se s každým takovým nalezeným bodem zvìtší o +1
      Canvas.Pixels[Px[i],Py[i]]:=clblue;
      StringGrid1.Cells [0,t]:= IntToStr(Px[i])+','+IntToStr(Py[i]);    //Urèí buòku do níž je napsána souøadnice vazby, v níž je nabyto váz. maxima
      Edit2.Text:= 'Maximální hodnotu nabývá funkce v bodì ['+ IntToStr(Px[i])+','+ IntToStr( Py[i])+'] a její hodnota se rovná ' + IntTostr((round(zmax))) ;
    end;
   for t := 0 to a-1 do StringGrid1.Cells[1,t]:=IntToStr(round(zmax)); //Urèí buòku do níž je napsána maximální hodnota vaz. extr.
   end;
Edit1.Text:='Poèet èísel, jejichž hodnoty jsou maximální na Df a vzájemnì se rovnají je '+ IntToStr(a);
end;

end.      }
           /////////////////////////////
           ////////////////////////////
           /////////////////////////////
           ////////////////////////////
           /////////////////////////////
           ////////////////////////////
            /////////////////////////////
           ////////////////////////////


           /////////////////////////////
{
function f(x:double):double;
begin
    f:=cos(x);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
//vymaž
with draw2D do
begin
  ClearImage(255,255,255);
  XScale(x1,x2,0,0,0,0);
  YScale(y1,y2,0,0,0,0);
end;
end;

procedure TForm1.Graf_Funkce(Sender: TObject);
var
  i: integer;

begin
  with draw2D do
    begin
    x1:=calc(Edit_X1.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    y2:=calc(Edit_Y2.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    x2:=calc(Edit_X2.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    y1:=calc(Edit_Y1.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    Draw2D.Scale(x1,x2,y1,y2);           //Nakreslí souøadné osy
    XScale(x1,x2,0,0,0,0);                            //udìlá mìøítko na ose x od kraje x1 po kraj x2
    YScale(y1,y2,0,0,0,0);
    x:=0;
    hx:=2*pi/100;
    A[1]:=1;A[2]:=1;        //udìlá
    B[1]:=2;B[2]:=1;        //jen
    PutPoint(A,0,0,0);      //teèku
    Cross(B,5,0,0,0);        //udìlá køížek jako v geometrii èíslo 5 udává velikost køížku na každou stranu
      repeat
      A[1]:=x;
      A[2]:=calc(Edit_fx.Text,ErrorReport);
      if ErrorReport <> '' then                                 //v pøípadì chyby vypíše hlášku ve vyskakovacím oknì
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
      x:=x+hx;
      B[1]:=x;
      B[2]:=calc(Edit_fx.Text,ErrorReport);
      if ErrorReport <> '' then
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
      Line(A,B,Red,Green,Blue)
      until x>2*pi;
    end;
end;


procedure TForm1.Zmena_Barvy(Sender: TObject);
begin
with draw2D do begin
if ColorDialog1.Execute then
   begin

      Red:=GetRValue(colorDialog1.Color);
      Green:=GetGValue(colorDialog1.Color);
      Blue:=GetBValue(colorDialog1.Color);
      Shape1.Brush.Color:=ColorDialog1.Color;
   end;
end;
end;

end.

    }



