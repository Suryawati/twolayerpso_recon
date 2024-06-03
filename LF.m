function [RugiRugi]=LF(SW)
% ===========load flow ==============================%
basemva = 1100;  accuracy = 0.001; maxiter = 100; accel = 1.8;
%        Bus Bus  Voltage Angle   ---Load---  -----Generator-----   Shunt
%        No  code Mag.    Degree  MW    Mvar   MW   Mvar Qmin Qmax   Mvar
busdata=[70  1    1.0     0.0     0.0   0.0    0.0  0.0    0   0       0  
         1   1    1.0     0.0     0.0   0.0    0.0  0.0     0   0       0
         2   0    1.0     0.0    100.0  90.0    0.0  0.0    0   0       0
         3   0    1.0     0.0    60.0  40.0    0.0  0.0     0   0       0
         4   0    1.0     0.0    150.0 130.0    0.0  0.0    0   0       0
         5   0    1.0     0.0    75.0  50.0    0.0  0.0     0   0       0
         6   0    1.0     0.0    15.0   9.0    0.0  0.0     0   0       0
         7   0    1.0     0.0    18.0  14.0    0.0  0.0     0   0       0
         8   0    1.0     0.0    13.0  10.0    0.0  0.0     0   0       0
         9   0    1.0     0.0    16.0  11.0    0.0  0.0     0   0       0
        10   0    1.0     0.0    20.0  10.0    0.0  0.0     0   0       0
        11   0    1.0     0.0    16.0   9.0    0.0  0.0     0   0       0
        12   0    1.0     0.0    50.0  40.0    0.0  0.0     0   0       0
        13   0    1.0     0.0   105.0  90.0    0.0  0.0     0   0       0
        14   0    1.0     0.0    25.0  15.0    0.0  0.0     0   0       0
        15   0    1.0     0.0    40.0  25.0    0.0  0.0     0   0       0
        16   0    1.0     0.0   100.0  60.0    0.0  0.0     0   0       0
        17   0    1.0     0.0    40.0  30.0    0.0  0.0     0   0       0
        18   0    1.0     0.0    60.0  30.0    0.0  0.0     0   0       0
        19   0    1.0     0.0    40.0  25.0    0.0  0.0     0   0       0
        20   0    1.0     0.0    15.0   9.0    0.0  0.0     0   0       0
        21   0    1.0     0.0    13.0   7.0    0.0  0.0     0   0       0
        22   0    1.0     0.0    30.0  20.0    0.0  0.0     0   0       0
        23   0    1.0     0.0    90.0  50.0    0.0  0.0     0   0       0
        24   0    1.0     0.0    50.0  30.0    0.0  0.0     0   0       0
        25   0    1.0     0.0    60.0  40.0    0.0  0.0     0   0       0
        26   0    1.0     0.0   100.0  80.0    0.0  0.0     0   0       0
        27   0    1.0     0.0    80.0  65.0    0.0  0.0     0   0       0
        28   0    1.0     0.0   100.0  60.0    0.0  0.0     0   0       0
        29   0    1.0     0.0   100.0  55.0    0.0  0.0     0   0       0
        30   0    1.0     0.0   120.0  70.0    0.0  0.0     0   0       0
        31   0    1.0     0.0   105.0  70.0    0.0  0.0     0   0       0
        32   0    1.0     0.0    80.0  50.0    0.0  0.0     0   0       0
        33   0    1.0     0.0    60.0  40.0    0.0  0.0     0   0       0
        34   0    1.0     0.0    13.0   8.0    0.0  0.0     0   0       0
        35   0    1.0     0.0    16.0   9.0    0.0  0.0     0   0       0
        36   0    1.0     0.0    50.0  30.0    0.0  0.0     0   0       0
        37   0    1.0     0.0    40.0  28.0    0.0  0.0     0   0       0
        38   0    1.0     0.0    60.0  40.0    0.0  0.0     0   0       0
        39   0    1.0     0.0    40.0  30.0    0.0  0.0     0   0       0
        40   0    1.0     0.0    30.0  25.0    0.0  0.0     0   0       0
        41   0    1.0     0.0   150.0 100.0    0.0  0.0     0   0       0
        42   0    1.0     0.0    60.0  35.0    0.0  0.0     0   0       0
        43   0    1.0     0.0   120.0  70.0    0.0  0.0     0   0       0
        44   0    1.0     0.0    90.0  60.0    0.0  0.0     0   0       0
        45   0    1.0     0.0    18.0  10.0    0.0  0.0     0   0       0
        46   0    1.0     0.0    16.0  10.0    0.0  0.0     0   0       0
        47   0    1.0     0.0   100.0  50.0    0.0  0.0     0   0       0
        48   0    1.0     0.0    60.0  40.0    0.0  0.0     0   0       0
        49   0    1.0     0.0    90.0  70.0    0.0  0.0     0   0       0
        50   0    1.0     0.0    85.0  55.0    0.0  0.0     0   0       0
        51   0    1.0     0.0   100.0  70.0    0.0  0.0     0   0       0
        52   0    1.0     0.0   140.0  90.0    0.0  0.0     0   0       0
        53   0    1.0     0.0    60.0  40.0    0.0  0.0     0   0       0
        54   0    1.0     0.0    20.0  11.0    0.0  0.0     0   0       0
        55   0    1.0     0.0    40.0  30.0    0.0  0.0     0   0       0
        56   0    1.0     0.0    36.0  24.0    0.0  0.0     0   0       0
        57   0    1.0     0.0    30.0  20.0    0.0  0.0     0   0       0
        58   0    1.0     0.0    43.0  30.0    0.0  0.0     0   0       0
        59   0    1.0     0.0    80.0  50.0    0.0  0.0     0   0       0
        60   0    1.0     0.0   240.0 120.0    0.0  0.0     0   0       0
        61   0    1.0     0.0   125.0 110.0    0.0  0.0     0   0       0
        62   0    1.0     0.0    25.0  10.0    0.0  0.0     0   0       0
        63   0    1.0     0.0    10.0   5.0    0.0  0.0     0   0       0
        64   0    1.0     0.0   150.0 130.0    0.0  0.0     0   0       0
        65   0    1.0     0.0    50.0  30.0    0.0  0.0     0   0       0
        66   0    1.0     0.0    30.0  20.0    0.0  0.0     0   0       0
        67   0    1.0     0.0   130.0 120.0    0.0  0.0     0   0       0
        68   0    1.0     0.0   150.0 130.0    0.0  0.0     0   0       0
        69   0    1.0     0.0    25.0  15.0    0.0  0.0     0   0       0
        ];
        

      %                          Line code
%         Bus bus    R         X     1/2 B   = 1 for lines
%         nl  nr    p.u.      p.u.    p.u.     > 1 or < 1 tr. tap at bus nl 
linedata=[1   2   .01097    .01074    0.0        1 %1
          2   3   .01463    .01432    0.0        1 %2
          3   4   .00731    .00716    0.0        1 %3
          4   5   .00366    .00358    0.0        1 %4
          5   6   .01828    .01790    0.0        1 %5
          6   7   .01097    .01074    0.0        1 %6
          7   8   .00731    .00716    0.0        1 %7
          8   9   .00731    .00716    0.0        1 %8
          15  9   .00681    .00544    0.0        1 %9   switch 9 dipilih
          4   10  .01080    .00734    0.0        1 %10
          10  11  .01620    .01101    0.0        1 %11
          11  12  .01080    .00734    0.0        1 %12
          12  13  .01350    .00917    0.0        1 %13 
          13  14  .00810    .00550    0.0        1 %14
          14  15  .01944    .01321    0.0        1 %15  ------------
          7   68  .01080    .00734    0.0        1 %16
          68  69  .01620    .01101    0.0        1 %17
          1   16  .01097    .01074    0.0        1 %18
          16  17  .00366    .00358    0.0        1 %19
          17  18  .01463    .01432    0.0        1 %20
          18  19  .00914    .00895    0.0        1 %21
          19  20  .00804    .00787    0.0        1 %22
          20  21  .01133    .01110    0.0        1 %23
          22  67  .00254    .00203    0.0        1 %24 Switch 1
          21  22  .00475    .00465    0.0        1 %25
          62  65  .01080    .00734    0.0        1 %26
          65  66  .00540    .00367    0.0        1 %27 dipilih
          66  67  .01080    .00734    0.0        1 %28 --------
          21  27  .00454    .00363    0.0        1 %29 Switch 3
          17  23  .02214    .01505    0.0        1 %30
          23  24  .01620    .01110    0.0        1 %31
          24  25  .01080    .00734    0.0        1 %32
          25  26  .00540    .00367    0.0        1 %33
          26  27  .00540    .00367    0.0        1 %34 -------- dipilih
          70  30  .00366    .00358    0.0        1 %35       
          30  31  .00731    .00716    0.0        1 %36
          31  32  .00731    .00716    0.0        1 %37
          32  33  .00804    .00787    0.0        1 %38
          33  34  .01170    .01145    0.0        1 %39
          34  35  .00768    .00752    0.0        1 %40
          43  38  .00454    .00363    0.0        1 %41 Switch 8
          35  36  .00731    .00716    0.0        1 %42 dipilih
          36  37  .01097    .01074    0.0        1 %43
          37  38  .01463    .01432    0.0        1 %44
          42  43  .01296    .00881    0.0        1 %45 ------
          39  59  .00454    .00363    0.0        1 %46 Switch 10 dipilih
          32  39  .01080    .00734    0.0        1 %47 ------
          39  40  .00540    .00367    0.0        1 %48       
          40  41  .01080    .00734    0.0        1 %49
          41  42  .01836    .01248    0.0        1 %50
          45  60  .00254    .00203    0.0        1 %51 Switch 7
          40  44  .01188    .00807    0.0        1 %52 
          44  45  .00540    .00367    0.0        1 %53 dipilih
          59  60  .01296    .00881    0.0        1 %54 --------
          15  46  .00681    .00544    0.0        1 %55 Switch 11
          42  46  .01080    .00734    0.0        1 %56 --------  dipilih
          29  64  .00254    .00203    0.0        1 %57 Switch 5
          27  28  .01080    .00734    0.0        1 %58
          28  29  .01080    .00734    0.0        1 %59
          62  63  .00810    .00550    0.0        1 %60
          63  64  .01620    .01101    0.0        1 %61 ------ dipilih
          9   50  .00908    .00726    0.0        1 %62 Switch 4 dipilih
          35  47  .00540    .00367    0.0        1 %63 
          47  48  .01080    .00734    0.0        1 %64          
          48  49  .01080    .00734    0.0        1 %65
          49  50  .01080    .00734    0.0        1 %66 --------     
          70  51  .00366    .00358    0.0        1 %67
          51  52  .01463    .01432    0.0        1 %68
          52  53  .01463    .01432    0.0        1 %69
          53  54  .00914    .00895    0.0        1 %70
          54  55  .01097    .01074    0.0        1 %71
          55  56  .01097    .01074    0.0        1 %72
          52  57  .00270    .00183    0.0        1 %73
          57  58  .00270    .00183    0.0        1 %74
          58  59  .00810    .00550    0.0        1 %75               
          55  61  .01188    .00807    0.0        1 %76
          61  62  .01188    .00807    0.0        1 %77                       
           9  38  .00381    .00244    0.0        1 %78  Switch 6       
          67  15  .00454    .00363    0.0        1]; %79 Switch 2
     
      %Tabu=[27 79 34 62 61 78 53 42 9 46 56]
      %Tabu=[78]
     Tabu=[78 79];
     linedata(Tabu,:)=[];
     linedata(SW,:)=[];

%---------------------------------------------------------------------------Pembentukan Matrix Ybus
%j=sqrt(-1); i = sqrt(-1);
nl = linedata(:,1);nr = linedata(:,2); R = linedata(:,3);
X = linedata(:,4); Bc = j*linedata(:,5); a = linedata(:, 6);
nbr=length(linedata(:,1));nbus = max(max(nl), max(nr));   
Z = R + j*X; y= ones(nbr,1)./Z; % admitansi cabang     
for n = 1:nbr
if a(n) <= 0,  a(n) = 1; else end
Ybus=zeros(nbus,nbus);     % inisialisasi Ybus  

% pembentukan elemen off diagonal 
for k=1:nbr;
       Ybus(nl(k),nr(k))=Ybus(nl(k),nr(k))-y(k)/a(k);
       Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
    end
end
% pembentukan elemen diagonal
for  n=1:nbus
     for k=1:nbr
         if nl(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k)/(a(k)^2) + Bc(k);
         elseif nr(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k) +Bc(k);
         else, end
     end
end
Ybus;

%-------------------------------------------------------------------Load Flow dengan Newton-Raphson

ns=0; ng=0; Vm=0; delta=0; yload=0; deltad=0;
nbus = length(busdata(:,1));
for k=1:nbus
n=busdata(k,1);
kb(n)=busdata(k,2);Vm(n)=busdata(k,3);delta(n)=busdata(k, 4);
Pd(n)=busdata(k,5); Qd(n)=busdata(k,6); Pg(n)=busdata(k,7); Qg(n) = busdata(k,8);
Qmin(n)=busdata(k, 9); Qmax(n)=busdata(k, 10);
Qsh(n)=busdata(k, 11);
    if Vm(n) <= 0  Vm(n) = 1.0; V(n) = 1 + j*0;
    else delta(n) = pi/180*delta(n);
         V(n) = Vm(n)*(cos(delta(n)) + j*sin(delta(n)));
         P(n)=(Pg(n)-Pd(n))/basemva;
         Q(n)=(Qg(n)-Qd(n)+ Qsh(n))/basemva;
         S(n) = P(n) + j*Q(n);
    end
end
for k=1:nbus
if kb(k) == 1, ns = ns+1; else, end
if kb(k) == 2 ng = ng+1; else, end
ngs(k) = ng;
nss(k) = ns;
end
Ym=abs(Ybus); t = angle(Ybus);
m=2*nbus-ng-2*ns;
maxerror = 1; converge=1;
iter = 0;
% Mulai Iterasi
clear A  DC   J  DX
while maxerror >= accuracy & iter <= maxiter % Tes untuk Maks. Daya yang Tidak Sesuai
for i=1:m
for k=1:m
   A(i,k)=0;      %Inisialisasi Matrix Jacobian
end, end
iter = iter+1;
for n=1:nbus
nn=n-nss(n);
lm=nbus+n-ngs(n)-nss(n)-ns;
J11=0; J22=0; J33=0; J44=0;
   for i=1:nbr
     if nl(i) == n | nr(i) == n
        if nl(i) == n,  l = nr(i); end
        if nr(i) == n,  l = nl(i); end
        J11=J11+ Vm(n)*Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
        J33=J33+ Vm(n)*Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
        if kb(n)~=1
        J22=J22+ Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
        J44=J44+ Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
        else, end
        if kb(n) ~= 1  & kb(l) ~=1
        lk = nbus+l-ngs(l)-nss(l)-ns;
        ll = l -nss(l);
      % element off diagonal J1
        A(nn, ll) =-Vm(n)*Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
              if kb(l) == 0  % element off diagonal J2
              A(nn, lk) =Vm(n)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));end
              if kb(n) == 0  % element off diagonal J3
              A(lm, ll) =-Vm(n)*Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n)+delta(l)); end
              if kb(n) == 0 & kb(l) == 0  % element off diagonal J4
              A(lm, lk) =-Vm(n)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));end
        else end
     else , end
   end
   Pk = Vm(n)^2*Ym(n,n)*cos(t(n,n))+J33;
   Qk = -Vm(n)^2*Ym(n,n)*sin(t(n,n))-J11;
   if kb(n) == 1 P(n)=Pk; Q(n) = Qk; end   % Swing bus P
     if kb(n) == 2  Q(n)=Qk;
         if Qmax(n) ~= 0
           Qgc = Q(n)*basemva + Qd(n) - Qsh(n);
           if iter <= 7                  % Antara Iterasi Ke-2 dan Ke-6
              if iter > 2                % MVAR Bus-Bus Generator dites.
                if Qgc  < Qmin(n),       % Jika tidak dalam batas Vm(n)
                Vm(n) = Vm(n) + 0.01;    % Maka Dirubah ke Langkah 0.01pu
                elseif Qgc  > Qmax(n),   % untuk Memberi MVAR dengan Batas 
                Vm(n) = Vm(n) - 0.01;end % yang telah Ditentukan
              else, end
           else,end
         else,end
     end
   if kb(n) ~= 1
     A(nn,nn) = J11;  %element diagonal J1
     DC(nn) = P(n)-Pk;
   end
   if kb(n) == 0
     A(nn,lm) = 2*Vm(n)*Ym(n,n)*cos(t(n,n))+J22;  %element diagonal J2
     A(lm,nn)= J33;        %element diagonal J3
     A(lm,lm) =-2*Vm(n)*Ym(n,n)*sin(t(n,n))-J44;  %element diagonal J4
     DC(lm) = Q(n)-Qk;
   end
end
DX=A\DC';
for n=1:nbus
  nn=n-nss(n);
  lm=nbus+n-ngs(n)-nss(n)-ns;
    if kb(n) ~= 1
    delta(n) = delta(n)+DX(nn); end
    if kb(n) == 0
    Vm(n)=Vm(n)+DX(lm); end
 end
  maxerror=max(abs(DC));
     if iter == maxiter & maxerror > accuracy 
   fprintf('\nPERINGATAN : Solusi Iteratif tidak Konvergen Setelah')
   fprintf('%g', iter), fprintf(' iterasi.\n\n')
   fprintf('Tekan Enter untuk Mengakhiri Iterasi dan Cetak Hasil Komputasi\n')
   converge = 0; pause, else, end
   
end

if converge ~= 1
   tech= ('                      SOLUSI ITERATIF TIDAK KONVERGEN'); else, 
   tech=('                   Solusi Aliran Daya dengan Metode Newton-Raphson');
end   
V = Vm.*cos(delta)+j*Vm.*sin(delta);
deltad=180/pi*delta;
i=sqrt(-1);
k=0;
for n = 1:nbus
     if kb(n) == 1
     k=k+1;
     S(n)= P(n)+j*Q(n);
     Pg(n) = P(n)*basemva + Pd(n);
     Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
     Pgg(k)=Pg(n);
     Qgg(k)=Qg(n);     %june 97
     elseif  kb(n) ==2
     k=k+1;
     S(n)=P(n)+j*Q(n);
     Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
     Pgg(k)=Pg(n);
     Qgg(k)=Qg(n);  % June 1997
  end
yload(n) = (Pd(n)- j*Qd(n)+j*Qsh(n))/(basemva*Vm(n)^2);
end
busdata(:,3)=Vm'; busdata(:,4)=deltad';
Pgt = sum(Pg);  Qgt = sum(Qg); Pdt = sum(Pd); Qdt = sum(Qd); Qsht = sum(Qsh);

%clear A DC DX  J11 J22 J33 J44 Qk delta lk ll lm
%clear A DC DX  J11 J22 J33  Qk delta lk ll lm


%---------------------------------------------------------------------------------------Data BusOut
disp(tech)
fprintf('                      Maksimum Daya Tidak Sesuai = %g \n', maxerror)
fprintf('                             Nomor Iterasi = %g \n\n', iter)
head =['    Bus  Voltage  Angle    ------Load------    ---Generation---   Injected'
       '    No.  Mag.     Degree     MW       Mvar       MW       Mvar       Mvar '
       '                                                                          '];
disp(head)
for n=1:nbus
     fprintf(' %5g', n), fprintf(' %7.3f', Vm(n)),
     fprintf(' %8.3f', deltad(n)), fprintf(' %9.3f', Pd(n)),
     fprintf(' %9.3f', Qd(n)),  fprintf(' %9.3f', Pg(n)),
     fprintf(' %9.3f ', Qg(n)), fprintf(' %8.3f\n', Qsh(n))
end
    fprintf('      \n'), fprintf('    Total              ')
    fprintf(' %9.3f', Pdt), fprintf(' %9.3f', Qdt),
    fprintf(' %9.3f', Pgt), fprintf(' %9.3f', Qgt), fprintf(' %9.3f\n\n', Qsht)
    
%----------------------------------------------------------------Line Flow

SLT = 0;
fprintf('\n')
fprintf('                           Line Flow and Losses \n\n')
fprintf('     --Line--  Power at bus & line flow    --Line loss--  Transformer\n')
fprintf('     from  to    MW      Mvar     MVA       MW      Mvar      tap\n')
for n = 1:nbus
busprt = 0;
   for L = 1:nbr;
       if busprt == 0
       P(n)*basemva;fprintf('   \n'), fprintf('%6g', n), fprintf('      %9.3f', P(n)*basemva)
       Q(n)*basemva;abs(S(n)*basemva);fprintf('%9.3f', Q(n)*basemva), fprintf('%9.3f\n', abs(S(n)*basemva))

       busprt = 1;
       else, end
       if nl(L)==n      k = nr(L);
       In = (V(n) - a(L)*V(k))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(n);
       Ik = (V(k) - V(n)/a(L))*y(L) + Bc(L)*V(k);
       Snk = V(n)*conj(In)*basemva;
       Skn = V(k)*conj(Ik)*basemva;
       SL  = Snk + Skn;
       SLT = SLT + SL;
       elseif nr(L)==n  k = nl(L);
       In = (V(n) - V(k)/a(L))*y(L) + Bc(L)*V(n);
       Ik = (V(k) - a(L)*V(n))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(k);
       Snk = V(n)*conj(In)*basemva;
       Skn = V(k)*conj(Ik)*basemva;
       SL  = Snk + Skn;
       SLT = SLT + SL;
       else, end
         if nl(L)==n | nr(L)==n
         fprintf('%12g', k),
         real(Snk);imag(Snk);fprintf('%9.3f', real(Snk)), fprintf('%9.3f', imag(Snk))
         abs(Snk);fprintf('%9.3f', abs(Snk)),
         real(SL);fprintf('%9.3f', real(SL)),
             if nl(L) ==n & a(L) ~= 1
             imag(SL);a(L);fprintf('%9.3f', imag(SL)), fprintf('%9.3f\n', a(L))
             else,imag(SL); fprintf('%9.3f\n', imag(SL))
             end
         else, end
  end
end
SLT = SLT/2;
fprintf('   \n'), fprintf('    Total loss                         ')
real(SLT);imag(SLT);fprintf('%9.4f', real(SLT)), fprintf('%9.4f\n', imag(SLT))
RugiRugi=real(SLT);
% %clear Ik In SL SLT Skn Snk
linedata=[1   2   .01097    .01074    0.0        1 %1
          2   3   .01463    .01432    0.0        1 %2
          3   4   .00731    .00716    0.0        1 %3
          4   5   .00366    .00358    0.0        1 %4
          5   6   .01828    .01790    0.0        1 %5
          6   7   .01097    .01074    0.0        1 %6
          7   8   .00731    .00716    0.0        1 %7
          8   9   .00731    .00716    0.0        1 %8
          15  9   .00681    .00544    0.0        1 %9   switch 9 dipilih
          4   10  .01080    .00734    0.0        1 %10
          10  11  .01620    .01101    0.0        1 %11
          11  12  .01080    .00734    0.0        1 %12
          12  13  .01350    .00917    0.0        1 %13 
          13  14  .00810    .00550    0.0        1 %14
          14  15  .01944    .01321    0.0        1 %15  ------------
          7   68  .01080    .00734    0.0        1 %16
          68  69  .01620    .01101    0.0        1 %17
          1   16  .01097    .01074    0.0        1 %18
          16  17  .00366    .00358    0.0        1 %19
          17  18  .01463    .01432    0.0        1 %20
          18  19  .00914    .00895    0.0        1 %21
          19  20  .00804    .00787    0.0        1 %22
          20  21  .01133    .01110    0.0        1 %23
          22  67  .00254    .00203    0.0        1 %24 Switch 1
          21  22  .00475    .00465    0.0        1 %25
          62  65  .01080    .00734    0.0        1 %26
          65  66  .00540    .00367    0.0        1 %27 dipilih
          66  67  .01080    .00734    0.0        1 %28 --------
          21  27  .00454    .00363    0.0        1 %29 Switch 3
          17  23  .02214    .01505    0.0        1 %30
          23  24  .01620    .01110    0.0        1 %31
          24  25  .01080    .00734    0.0        1 %32
          25  26  .00540    .00367    0.0        1 %33
          26  27  .00540    .00367    0.0        1 %34 -------- dipilih
          70  30  .00366    .00358    0.0        1 %35       
          30  31  .00731    .00716    0.0        1 %36
          31  32  .00731    .00716    0.0        1 %37
          32  33  .00804    .00787    0.0        1 %38
          33  34  .01170    .01145    0.0        1 %39
          34  35  .00768    .00752    0.0        1 %40
          43  38  .00454    .00363    0.0        1 %41 Switch 8
          35  36  .00731    .00716    0.0        1 %42 dipilih
          36  37  .01097    .01074    0.0        1 %43
          37  38  .01463    .01432    0.0        1 %44
          42  43  .01296    .00881    0.0        1 %45 ------
          39  59  .00454    .00363    0.0        1 %46 Switch 10 dipilih
          32  39  .01080    .00734    0.0        1 %47 ------
          39  40  .00540    .00367    0.0        1 %48       
          40  41  .01080    .00734    0.0        1 %49
          41  42  .01836    .01248    0.0        1 %50
          45  60  .00254    .00203    0.0        1 %51 Switch 7
          40  44  .01188    .00807    0.0        1 %52 
          44  45  .00540    .00367    0.0        1 %53 dipilih
          59  60  .01296    .00881    0.0        1 %54 --------
          15  46  .00681    .00544    0.0        1 %55 Switch 11
          42  46  .01080    .00734    0.0        1 %56 --------  dipilih
          29  64  .00254    .00203    0.0        1 %57 Switch 5
          27  28  .01080    .00734    0.0        1 %58
          28  29  .01080    .00734    0.0        1 %59
          62  63  .00810    .00550    0.0        1 %60
          63  64  .01620    .01101    0.0        1 %61 ------ dipilih
          9   50  .00908    .00726    0.0        1 %62 Switch 4 dipilih
          35  47  .00540    .00367    0.0        1 %63 
          47  48  .01080    .00734    0.0        1 %64          
          48  49  .01080    .00734    0.0        1 %65
          49  50  .01080    .00734    0.0        1 %66 --------     
          70  51  .00366    .00358    0.0        1 %67
          51  52  .01463    .01432    0.0        1 %68
          52  53  .01463    .01432    0.0        1 %69
          53  54  .00914    .00895    0.0        1 %70
          54  55  .01097    .01074    0.0        1 %71
          55  56  .01097    .01074    0.0        1 %72
          52  57  .00270    .00183    0.0        1 %73
          57  58  .00270    .00183    0.0        1 %74
          58  59  .00810    .00550    0.0        1 %75               
          55  61  .01188    .00807    0.0        1 %76
          61  62  .01188    .00807    0.0        1 %77                       
           9  38  .00381    .00244    0.0        1 %78  Switch 6       
          67  15  .00454    .00363    0.0        1]; %79 Switch 2
     
      saklar=linedata(SW,1:2)