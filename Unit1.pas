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
    if ErrorReport <> '' then chyba;                                //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
     y2:=calc(Edit_Y2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
     x2:=calc(Edit_X2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
     y1:=calc(Edit_Y1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�


Draw2D.Scale(x1,x2,y1,y2);           //Nakresl� sou�adn� osy
XScale(x1,x2,0,0,0,0);               //ud�l� m���tko na ose x od kraje x1 po kraj x2
YScale(y1,y2,0,0,0,0);
 try
 max:=StrToFloat(Edit_TolD.Text);
 min:=StrToFloat(Edit_TolO.Text);
 r:=StrToInt(Edit_Start.Text);
 except
 ShowMessage('Rozhran� tolerance mus� b�t celo��seln�.Za�ni od je ��slo');
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
              if (h1 > min+r)and (h1 < max+r)then    //je t�eba zadat rozumn� rozmez�
               begin                                //aby se dob�e vykreslila jedna
              L[1]:=xx;L[2]:=yy;  //1.kvadrant  +
              PutPoint(L,0,0,255);          //konkr�tn� vrstevnice
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







function h(i,x2,y2:double):double;                            //Funkce pro v�po�et funkce z
begin                                                          //R*R do R*R*R
   try                                                         //body, jen� jsou dosazov�ny
  h:=sin(x2)*y2;
   //h:=(y2*y2/x2)+ x2*x2;                                       //le�� na vazb� F
   //h:=x2*x2+y2*y2;
   except
    ;// Edit1.Text:= 'Funkce nen� v bod� [',x2,',',y2,'] definov�na';
   end;
end;

function f(x:integer):double;                          //Funkce na v�po�et
begin                                                  //y-ov�ch sou�adnic vazeb F
    try
    //f:=-1*x*x*x*x+x*x*x+15*x*x-7*x;                  //N�kolik
    //f:=x*x/200;                                            //mo�n�ch
    //f:=x*x*x+10*x*x+x;                               //vazeb pro
   // f:=5;                                            //otestov�n� algoritmu
    except
     ;// Writeln('Vazba nen� v bod� ',x,' definov�na');
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
with Draw2D do begin
 opak:=StrToInt(Edit3_Pocet.Text);       //u�ivatel ur�� kolikr�t se cyklus zopakuje zopakuje

       x1:=calc(Edit_X1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
     y2:=calc(Edit_Y2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
     x2:=calc(Edit_X2.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
     y1:=calc(Edit_Y1.Text,ErrorReport);
    if ErrorReport <> '' then chyba;                                //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�

{x1:=-100;
x2:=100;
y1:=-100;
y2:=100; }

Draw2D.Scale(x1,x2,y1,y2);           //Nakresl� sou�adn� osy
XScale(x1,x2,0,0,0,0);               //ud�l� m���tko na ose x od kraje x1 po kraj x2
YScale(y1,y2,0,0,0,0);

krok:= StrToFloat(Edit3_Krok.Text);
s:=StrToInt(Edit3_Zacni.Text);//-5;                        //1. bod jen� je dosazen do funkce f, z kter� z�sk�me
y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//y-ovou sou�adnici vazby. V�sledkem jsou sou�adnice [x,y] le��c� na vazb� F
if draw2d.ErrorReport <> '' then chyba;

Px[i]:=s;                     //Px[i] je 1. x-ov� sou�adnice vazby F
Py[i]:=round(y);              //Py[i] je 1. y-ov� sou�adnice vazby F
x2:=Px[i];                    //x2 je 1. x-ov� sou�adnice vazby F, jen� dosazujem do funkce h
y2:=Py[i];                    //y2 je 1. y-ov� sou�adnice vazby F, jen� dosazujem do funkce h
Pz[i]:= round(h(i,x2,y2));    //Pz[i] je 1. z-ov� sou�adnice funkce f. Vznikne zobrazen�m bodu [x2,y2]
zmax:= Pz[i];         //Nastav� maxim�ln� hodnotu vazby, jen� je pou�it� k porovn�v�n� s dal��mi hodnotami

for i := 0 to opak do                                //Cyklus na dosazov�n� hodnot od -5 do 5
  begin
   x:=s+krok*i;                //Nastav� x a s ka�d�m pr�chodem cyklu se zv�t�� o 1 tj.-5,-4,-3
   y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                //Vypo�te y, jen� je pozd�ji pou�it� jako y-ov� sou�adnice vazby n�le�c� bodu x
   if draw2d.ErrorReport <> '' then chyba;

   Px[i]:=x;               //Do 0. �lenu pole Px se nahraje bod se sou�adnic� x
   Py[i]:=round(y);        //viz. ��dek 50
   A[1]:=Px[i];A[2]:=Py[i];
   PutPoint(A,0,0,0);;
   x2:=Px[i];              //Px[i] resp. Py[i] se nahraje do x2 resp. y2
   y2:=Py[i];
   Pz[i]:=round(h(i,x2,y2));//1. sou�adnice funkce f, jen� vznikne zobrazen�m bodu vazby o sou�adnici[x2,y2]
   if Pz[i]>zmax then       //Jeslti se v pr�b�hu cyklu najde v�t�� hodnota ne� dosavadn�
    begin                   //tj. zmax, pak je zmax p�eps�no touto hodnotou
      zmax:=Pz[i];
    end;
  end;

StringGrid1.RowCount:=opak;      //Nastav� po�et ��dk� ve stringgridu
StringGrid1.ColCount:=2;        //Nastav� po�et sloupc� ve stringgridu
krok:= StrToFloat(Edit3_Krok.Text);
s:=StrToInt(Edit3_Zacni.Text);
m:=0;
e:=0;
for i := 0 to opak do             //Cyklus pro zji�t�n�, kolik bod� z Df se zobraz� na stejnou
  begin                         //maxim�ln� funk�n� hodnotu
    x:=s+krok*i;                    //Nastav� x a s ka�d�m pr�chodem cyklu se zv�t�� o 1 tj.-5,-4,-3
    y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                    //Vypo�te jeho funk�n� hodnotu tj. y-ovou sou�adnici vazby n�le��c� bodu x
    if Draw2D.ErrorReport <> '' then chyba;
    Px[i]:=x;                   //viz. ��dky
    Py[i]:=round(y);            //��dky
    x2:=Px[i];                  //51
    y2:=Py[i];                  //a�
    Pz[i]:=round(h(i,x2,y2));   //55
    if Pz[i]=zmax then          //Poud se funk�n� hodnota rovn� zmax z 59. ��dku k�du, pak
    begin                       //a se zv�t�� o 1. Tato hodnota ud�v� po�et bod� v Df,
      e:=e+1;                   //jen� nab�vaj� v�zan�ho extr�mu
      m:=e-1;
      Px[i]:=x;                 //Px[i] a Py[i] je pole, do kter�ho se nahraje x-ov� a y-ov� sou�adnice bodu,
      Py[i]:=round(y);          //jen� nab�v� v�zan�ho extr�mu, index a se s ka�d�m takov�m nalezen�m bodem zv�t�� o +1
      A[1]:=Px[i];A[2]:=Py[i];
      Cross(A,5,255,0,0);
      Bx[i]:= round(Px[i]);
      By[i]:=round(Py[i]);
      StringGrid1.Cells [0,m]:= IntToStr(Bx[i])+','+IntToStr(By[i]);    //Ur�� bu�ku do n� je naps�na sou�adnice vazby, v n� je nabyto v�z. maxima
      Edit2.Text:= 'Maxim�ln� hodnotu nab�v� funkce v bod� ['+ IntToStr(Bx[i])+','+ IntToStr(By[i])+'] a jej� hodnota se rovn� ' + IntTostr((round(zmax))) ;
    end;
    zmax2:=round(zmax);
   for m:= 0 to e-1 do begin StringGrid1.Cells[1,m]:=IntToStr(round(zmax2));end; //Ur�� bu�ku do n� je naps�na maxim�ln� hodnota vaz. extr.
   end;
Edit1.Text:='Po�et ��sel, jejich� hodnoty jsou maxim�ln� na Df a vz�jemn� se rovnaj� je '+ IntToStr(e);
end;
end;

end.
{
procedure TForm1.Image1Click(Sender: TObject);
begin
with Draw2D do begin
  Draw2D.Scale(-1,1,10,-1);           //Nakresl� sou�adn� osy
    XScale(x1,x2,0,0,0,0);                            //ud�l� m���tko na ose x od kraje x1 po kraj x2
    YScale(y1,y2,0,0,0,0);
end;
x:=-5;                        //1. bod jen� je dosazen do funkce f, z kter� z�sk�me
y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                      //y-ovou sou�adnici vazby. V�sledkem jsou sou�adnice [x,y] le��c� na vazb� F
if draw2d.ErrorReport <> '' then begin
                             ShowMessage(draw2d.ErrorReport);
                             exit;
                             end;
Px[i]:=x;                     //Px[i] je 1. x-ov� sou�adnice vazby F
Py[i]:=round(y);              //Py[i] je 1. y-ov� sou�adnice vazby F
x2:=Px[i];                    //x2 je 1. x-ov� sou�adnice vazby F, jen� dosazujem do funkce h
y2:=Py[i];                    //y2 je 1. y-ov� sou�adnice vazby F, jen� dosazujem do funkce h
Pz[i]:= round(h(i,x2,y2));    //Pz[i] je 1. z-ov� sou�adnice funkce f. Vznikne zobrazen�m bodu [x2,y2]
zmax:= Pz[i];         //Nastav� maxim�ln� hodnotu vazby, jen� je pou�it� k porovn�v�n� s dal��mi hodnotami

for i := 0 to 1000 do                                //Cyklus na dosazov�n� hodnot od -5 do 5
  begin
   x:=-5+i;                //Nastav� x a s ka�d�m pr�chodem cyklu se zv�t�� o 1 tj.-5,-4,-3
   y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                //Vypo�te y, jen� je pozd�ji pou�it� jako y-ov� sou�adnice vazby n�le�c� bodu x
   if draw2d.ErrorReport <> '' then begin
                             ShowMessage(draw2d.ErrorReport);
                             exit;
                             end;

   Px[i]:=x;               //Do 0. �lenu pole Px se nahraje bod se sou�adnic� x
   Py[i]:=round(y);        //viz. ��dek 50
   Canvas.Pixels[Px[i],Py[i]]:=clred;
   x2:=Px[i];              //Px[i] resp. Py[i] se nahraje do x2 resp. y2
   y2:=Py[i];
   Pz[i]:=round(h(i,x2,y2));//1. sou�adnice funkce f, jen� vznikne zobrazen�m bodu vazby o sou�adnici[x2,y2]
   if Pz[i]>zmax then       //Jeslti se v pr�b�hu cyklu najde v�t�� hodnota ne� dosavadn�
    begin                   //tj. zmax, pak je zmax p�eps�no touto hodnotou
      zmax:=Pz[i];
    end;
  //end;
  end;

StringGrid1.RowCount:=1000;      //Nastav� po�et ��dk� ve stringgridu
StringGrid1.ColCount:=2;        //Nastav� po�et sloupc� ve stringgridu

t:=0;
a:=0;
for i := 0 to 1000 do             //Cyklus pro zji�t�n�, kolik bod� z Df se zobraz� na stejnou
  begin                         //maxim�ln� funk�n� hodnotu
    x:=-5+i;                    //Nastav� x a s ka�d�m pr�chodem cyklu se zv�t�� o 1 tj.-5,-4,-3
    y:=draw2D.calc(Edit3_vazba.Text,draw2d.ErrorReport);//f(x);                    //Vypo�te jeho funk�n� hodnotu tj. y-ovou sou�adnici vazby n�le��c� bodu x
    if Draw2D.ErrorReport <> '' then begin
                                     ShowMessage(Draw2D.ErrorReport);
                                     exit;
                                     end;
    Px[i]:=x;                   //viz. ��dky
    Py[i]:=round(y);            //��dky
    x2:=Px[i];                  //51
    y2:=Py[i];                  //a�
    Pz[i]:=round(h(i,x2,y2));   //55
    if Pz[i]=zmax then          //Poud se funk�n� hodnota rovn� zmax z 59. ��dku k�du, pak
    begin                       //a se zv�t�� o 1. Tato hodnota ud�v� po�et bod� v Df,
      a:=a+1;                   //jen� nab�vaj� v�zan�ho extr�mu
      t:=a-1;
      Px[i]:=x;                 //Px[i] a Py[i] je pole, do kter�ho se nahraje x-ov� a y-ov� sou�adnice bodu,
      Py[i]:=round(y);          //jen� nab�v� v�zan�ho extr�mu, index a se s ka�d�m takov�m nalezen�m bodem zv�t�� o +1
      Canvas.Pixels[Px[i],Py[i]]:=clblue;
      StringGrid1.Cells [0,t]:= IntToStr(Px[i])+','+IntToStr(Py[i]);    //Ur�� bu�ku do n� je naps�na sou�adnice vazby, v n� je nabyto v�z. maxima
      Edit2.Text:= 'Maxim�ln� hodnotu nab�v� funkce v bod� ['+ IntToStr(Px[i])+','+ IntToStr( Py[i])+'] a jej� hodnota se rovn� ' + IntTostr((round(zmax))) ;
    end;
   for t := 0 to a-1 do StringGrid1.Cells[1,t]:=IntToStr(round(zmax)); //Ur�� bu�ku do n� je naps�na maxim�ln� hodnota vaz. extr.
   end;
Edit1.Text:='Po�et ��sel, jejich� hodnoty jsou maxim�ln� na Df a vz�jemn� se rovnaj� je '+ IntToStr(a);
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
//vyma�
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
    if ErrorReport <> '' then                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    y2:=calc(Edit_Y2.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    x2:=calc(Edit_X2.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    y1:=calc(Edit_Y1.Text,ErrorReport);
    if ErrorReport <> '' then                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
                            begin
                             ShowMessage(ErrorReport);
                             exit;
                            end;
    Draw2D.Scale(x1,x2,y1,y2);           //Nakresl� sou�adn� osy
    XScale(x1,x2,0,0,0,0);                            //ud�l� m���tko na ose x od kraje x1 po kraj x2
    YScale(y1,y2,0,0,0,0);
    x:=0;
    hx:=2*pi/100;
    A[1]:=1;A[2]:=1;        //ud�l�
    B[1]:=2;B[2]:=1;        //jen
    PutPoint(A,0,0,0);      //te�ku
    Cross(B,5,0,0,0);        //ud�l� k��ek jako v geometrii ��slo 5 ud�v� velikost k��ku na ka�dou stranu
      repeat
      A[1]:=x;
      A[2]:=calc(Edit_fx.Text,ErrorReport);
      if ErrorReport <> '' then                                 //v p��pad� chyby vyp�e hl�ku ve vyskakovac�m okn�
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



