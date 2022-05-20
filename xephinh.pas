program choi_game_nao;
uses crt;
const bl=#32;
x=2;y=3;dx=2;dy=3;
Len=200;
Xuong=208;
Phai=205;
Trai=203;
var
        a,b:array[1..10,1..10]of byte;
        xx,yy:byte;
        v:longint;
        dd:integer;
function getkey:integer;
var c:char;
begin
        c:=readkey;
        if c<> #0 then getkey:=Ord(c)
        else begin
                c:=ReadKey;
                GetKey:=ord(c)+128;
        end;
end;
procedure den(i,j:byte);
begin
        gotoxy(y+(j-1)*dy,x+(i-1)*dx);
end;
procedure viet(i,j:byte);
begin
        den(i,j);
        if a[i,j] = 0 then
                begin

                        write(bl:2);

                end
                else write(a[i,j]:2);
end;
procedure init;
var i,j,k:byte;
begin k:=0;

        gotoxy(1,1);
        for i:=1 to dx*dd+1 do
        begin
                for j:=1 to dy*dd+3 do write(bl);
                writeln;
        end;

        for i:=1 to dd do
                for j:=1 to dd do
                        begin
                                inc(k);
                                a[i,j]:=k;
                                b[i,j]:=k;
                                viet(i,j);
                        end;
        a[dd,dd]:=0;
        b[dd,dd]:=0;
        viet(dd,dd);
        den(dd,dd);
        xx:=dd;
        yy:=dd;
end;
procedure chuyen(k:integer);
begin
        case k of
                0:if xx<dd then
                        begin
                                a[xx,yy]:=a[xx+1,yy];
                                viet(xx,yy);
                                inc(xx);a[xx,yy]:=0;
                                viet(xx,yy);
                        end;
                1:if xx>1 then begin
                        a[xx,yy]:=a[xx-1,yy];
                        viet(xx,yy);
                        dec(xx);a[xx,yy]:=0;
                        viet(xx,yy);
                end;
                2: if yy>1 then begin
                        a[xx,yy]:=a[xx,yy-1];
                        viet(xx,yy);
                        dec(yy);
                        a[xx,yy]:=0;
                        viet(xx,yy);
                end;
                3:if yy<dd then
                begin
                        a[xx,yy]:=a[xx,yy+1];
                        viet(xx,yy);
                        inc(yy);a[xx,yy]:=0;
                        viet(xx,yy);
                end;
        end;
end;
procedure dao;
var c,i:integer;
begin
        repeat
                i:=random(4);
                chuyen(i);
                delay(50);
                until KeyPressed;
                c:=GetKey ;
        end;
function dung:boolean;
var i,j:byte;
begin
        dung:=false;
        for i:=1 to dd do
                for j:=1 to dd do
                        if (a[i,j]<>b[i,j])then exit;
        dung:=true;
end;procedure game15;
var k:integer;
d:longint;
sx,sy,ex,ey:byte;
begin
        randomize;
        clrscr;
        d:=0;v:=1;

        init;
        gotoxy(5,25);clreol; writeln('press to continue');
        write(' van: ');
        sx:=wherex;sy:=wherey;
        write(v); write('          tong so buoc');
        ex:=wherex;ey:=wherey;
        dao;

        repeat
                gotoxy(sx,sy);write(bl:10);
                gotoxy(sx,sy);write(v);
                gotoxy(ex,ey);clreol;
                gotoxy(ex,ey);write(d);
                den(xx,yy);
                k:=GetKey;
                case k of
                        LEN:k:=0;
                        XUONG:k:=1;
                        PHAI:k:=2;
                        TRAI:k:=3;
                end;
                chuyen(k);inc(d);
                if dung then
                        begin
                                dao;
                                inc(v);d:=0;
                                gotoxy(sx,sy);write(bl:10);
                                gotoxy(sx,sy);write(v);
                        end;
                until UpCase(chr(k)) in [#27,'Q'];
                Textattr := 7;clrscr;
        end;
begin
        writeln('nhap so hang: ');
        readln(dd);
        clrscr;
        game15;
end.
