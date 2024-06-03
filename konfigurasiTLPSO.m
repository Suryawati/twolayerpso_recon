  %STEPHAN
  %2209201012
  %Rekonfigurasi Jaring Distribusi untuk Meminimalkan Kerugian Daya
  %Menggunakan Two Layer PSO
  %========================================================================
  clc;
  clear all;
  close all;
  tic
  %------------------------------------------------------------------------
  %inisialisasi parameter PSO
    iter_max=24;
    iter=1;
    c1=1.4;
    c2=1.4;
    swarm=8;
    jum_switch=9;
    group=5;
  %------------------------------------------------------------------------
for i=1:group
    %inisialisasi swarm posisi switch
    a(:,:,i)=round(28-(rand(swarm,1)*(28-24)));
    b(:,:,i)=round(34-(rand(swarm,1)*(34-29)));
    c(:,:,i)=round(66-(rand(swarm,1)*(66-62)));
    d(:,:,i)=round(61-(rand(swarm,1)*(61-57)));
    e(:,:,i)=round(54-(rand(swarm,1)*(54-51)));
    f(:,:,i)=round(45-(rand(swarm,1)*(45-41)));
    g(:,:,i)=round(15-(rand(swarm,1)*(15-9)));
    h(:,:,i)=round(47-(rand(swarm,1)*(47-46)));
    j(:,:,i)=round(56-(rand(swarm,1)*(56-55)));
    Switch(:,:,i)=[a(:,:,i) b(:,:,i) c(:,:,i) d(:,:,i) e(:,:,i) f(:,:,i) g(:,:,i) h(:,:,i) j(:,:,i)];
end

Xmin=[24 29 62 57 51 41 9  46 55]; %batas minimum linedata
Xmax=[28 34 66 61 54 45 15 47 56]; %batas maximum linedata

for i=1:group
%inisialisasi swarm velocity switch
    a(:,:,i)=round(28-(rand(swarm,1)*(28-24)));
    b(:,:,i)=round(34-(rand(swarm,1)*(34-29)));
    c(:,:,i)=round(66-(rand(swarm,1)*(66-62)));
    d(:,:,i)=round(61-(rand(swarm,1)*(61-57)));
    e(:,:,i)=round(54-(rand(swarm,1)*(54-51)));
    f(:,:,i)=round(45-(rand(swarm,1)*(45-41)));
    g(:,:,i)=round(15-(rand(swarm,1)*(15-9)));
    h(:,:,i)=round(47-(rand(swarm,1)*(47-46)));
    j(:,:,i)=round(56-(rand(swarm,1)*(56-55)));
    V(:,:,i)=[a(:,:,i) b(:,:,i) c(:,:,i) d(:,:,i) e(:,:,i) f(:,:,i) g(:,:,i) h(:,:,i) j(:,:,i)]*0;
end    

    w=zeros(group,jum_switch);          %pembentukan velocity untuk Y
    Rugi =zeros(swarm,group);           %pembentukan tabel rugi dalam satu kolom       
  
    
      for i=1:group
        %masuk ke load flow untuk menghitung rugi-rugi daya
        Switch(:,:,i)=round(Switch(:,:,i)+V(:,:,i));
      end
      
      for i=1:group 
       for k=1:swarm;
          [RugiRugi]=LoadFlow(Switch,k,i);    %perhitungan rugi2 dengan memasukan konfigurasi switch
          Rugi(k,i)=RugiRugi;                 %rugi daya di setiap particle
       end
      end
    %----------------------------------------------------------------------   
    
     for i=1:group
         [Fxbest(1,i,1),C(i)]=min(Rugi(:,i));
          Y(i,:)=Switch(C(i),:,i); 
          Pxbest(:,:,i)=Switch(:,:,i);
          Ybest(i,:)=Y(i,:);
     end
     
       [Fgbest,Groupbest]=min(Fxbest);
       GlobalBest=Y(Groupbest,:,1); 
       FglobalBest=Fgbest;
       Losses(1)=FglobalBest;
       
   %---Buat Grafik---------------------------------------------------------
hfig = figure;
hold on
title('Grafik Optimisasi Load flow dengan Two LayerPSO');
set(hfig, 'position', [50,40,600,300]);
set(hfig, 'DoubleBuffer', 'on');
hbestplot = plot(1:(iter_max),zeros(1,(iter_max)));
htext1 = text(0.6*iter_max,30,sprintf('Rugi daya : %f', 0.0));
xlabel('Iterasi');
ylabel('Fungsi Objektif');
hold off
drawnow;
   %-----------------------------------------------------------------------
   
  while iter<=iter_max
       
       %update velocity
    for i=1:group
        for a=1:swarm
            V(a,:,i)=V(a,:,i)+ (c1*rand*(Pxbest(a,:,i)-Switch(a,:,i)))+ (c2*rand*(Y(i,:)-Switch(a,:,i)));
        end
    end
    
      %update Switch
    for i=1:group
    Switch(:,:,i)= floor(Switch(:,:,i)+V(:,:,i));
    end
    
    %-----------------------------------------------------------------------
   for i=1:group
      for k=1:swarm
        if Switch(k,1,i)<23  
            Switch(k,1,i)=23;
        elseif Switch(k,1,i)>28
            Switch(k,1,i)=23;
        else
            Switch(k,1,i)=Switch(k,1,i);
        end
        
        if Switch(k,2,i)<29
            Switch(k,2,i)=29;
        elseif Switch(k,2,i)>34
            Switch(k,2,i)=29;    
        else
            Switch(k,2,i)=Switch(k,2,i);
        end
        
        if Switch(k,3,i)<62 
            Switch(k,3,i)=62; 
        elseif Switch(k,3,i)>66
            Switch(k,3,i)=62;
        else
            Switch(k,3,i)=Switch(k,3,i);
        end
        
        if Switch(k,4,i)<57 
            Switch(k,4,i)=57; 
        elseif Switch(k,4,i)>61
            Switch(k,4,i)=57;
        else
            Switch(k,4,i)=Switch(k,4,i);
        end
        
        if Switch(k,5,i)<51 
            Switch(k,5,i)=51; 
        elseif Switch(k,5,i)>54
            Switch(k,5,i)=51;
        else
            Switch(k,5,i)=Switch(k,5,i);
        end
        
        if Switch(k,6,i)<41 
            Switch(k,6,i)=41; 
        elseif Switch(k,6,i)>45
            Switch(k,6,i)=41;
        else
            Switch(k,6,i)=Switch(k,6,i);
        end
        
        if Switch(k,7,i)<9 
            Switch(k,7,i)=9; 
        elseif Switch(k,7,i)>15
            Switch(k,7,i)=9;
        else
            Switch(k,7,i)=Switch(k,7,i);
        end
        
        if Switch(k,8,i)<46 
            Switch(k,8,i)=46; 
        elseif Switch(k,8,i)>47
            Switch(k,8,i)=46;
        else
            Switch(k,8,i)=Switch(k,8,i);
        end
        
        if Switch(k,9,i)<55 
            Switch(k,9,i)=55; 
        elseif Switch(k,9,i)>56
            Switch(k,9,i)=55;
        else
            Switch(k,9,i)=Switch(k,9,i);
        end
      end
    end
    
    %---------------------------------------------------------------------
    %mutasi
    for i=1:group
        p=rand();
        %d=floor(10*rand()+0.5);
        if p<0.1
            for a=1:swarm
                d=round(9*rand()+0.5);
                Switch(a,d,i)=Xmax(:,d)-(Switch(a,d,i)-Xmin(:,d));
            end
        end
    end
   
   %---------------------------------------------------------------
    Rugi2 =zeros(swarm,group);            %pembentukan tabel rugi dalam satu kolom     
    for i=1:group 
     for k=1:swarm;
      [RugiRugi]=LoadFlow(Switch,k,i);    %perhitungan rugi2 dengan memasukan konfigurasi switch
      Rugi2(k,i)=RugiRugi;        
     end
    end
    
    for i=1:group
     [Fxbest2(1,i),C2(i)]=min(Rugi(:,i));
     Y2(i,:)=Switch(C2(i),:,i); 
     Pxbest2(:,:,i)=Switch(:,:,i);
    end

    for i=1:group
        for a=1:swarm
            if Rugi2(k,i)<Rugi(k,i)
                Rugi(k,i)=Rugi2(k,i);
                Pxbest(a,:,i)=Pxbest2(a,:,i);
            else
                Rugi(k,i)=Rugi(k,i);
                Pxbest(a,:,i)=Pxbest(a,:,i);
            end
        end
    end
   %----------------------------------------------------------------------- 
    for i=1:group
        if Fxbest2(1,i)<Fxbest(1,i)
            Y(i,:)=Y2(i,:);
        else
            Y(i,:)=Y(i,:);
        end
    end
    %----------------------------------------------------------------------
    %update w
    
    for i=1:group
        w(i,:)=w(i,:)+(c1*rand()*(Ybest(i,:)-Y(i,:)))+(c2*rand()*(GlobalBest-Y(i,:)));        
    end
    
    %update Y
    for i=1:group
        Y(i,:)=round(Y(i,:)+w(i,:));
    end

    %----------------------------------------------------------------------
    for k=1:group
        if Y(k,1)<23  
            Y(k,1)=23;
        elseif Y(k,1)>28
            Y(k,1)=23;
        else
            Y(k,1)=Y(k,1);
        end
        
        if Y(k,2)<29
            Y(k,2)=29;
        elseif Y(k,2)>34
            Y(k,2)=29;    
        else
            Y(k,2)=Y(k,2);
        end
        
        if Y(k,3)<62 
            Y(k,3)=62; 
        elseif Y(k,3)>66
            Y(k,3)=62;
        else
            Y(k,3)=Y(k,3);
        end
        
        if Y(k,4)<57 
            Y(k,4)=57; 
        elseif Y(k,4)>61
            Y(k,4)=57;
        else
            Y(k,4)=Y(k,4);
        end
        
        if Y(k,5)<51 
            Y(k,5)=51; 
        elseif Y(k,5)>54
            Y(k,5)=51;
        else
            Y(k,5)=Y(k,5);
        end
        
        if Y(k,6)<41 
            Y(k,6)=41; 
        elseif Y(k,6)>45
            Y(k,6)=41;
        else
            Y(k,6)=Y(k,6);
        end
        
        if Y(k,7)<9 
            Y(k,7)=9; 
        elseif Y(k,7)>15
            Y(k,7)=9;
        else
            Y(k,7)=Y(k,7);
        end
        
        if Y(k,8)<46 
            Y(k,8)=46; 
        elseif Y(k,8)>47
            Y(k,8)=46;
        else
            Y(k,8)=Y(k,8);
        end
        
        if Y(k,9)<55 
            Y(k,9)=55; 
        elseif Y(k,9)>56
            Y(k,9)=55;
        else
            Y(k,9)=Y(k,9);
        end
    end
    %----------------------------------------------------------------------
    
    for i=1:group 
      [RugiRugi]=LoadFlow_Y(Y,i);    %perhitungan rugi2 dengan memasukan konfigurasi switch
      Rugi3(i)=RugiRugi;             %rugi daya di setiap particle
    end
           
    [F_GLOBAL,K]=min(Rugi3);
    Ygb=Y(K,:);
    
     for i=1:group
         if Rugi3(i)<Fxbest2(1,i)
             Fxbest2(1,i)=Rugi3(i);
             Ybest(i,:)=Y(i,:);
         else
             Fxbest2(1,:)=Fxbest2(1,:);
             Ybest(i,:)=Ybest(i,:);
         end
     end
     
     if F_GLOBAL < FglobalBest
         FglobalBest=F_GLOBAL;
         GlobalBest=Ygb;
     else
         FglobalBest=FglobalBest;
         GlobalBest=GlobalBest;
     end

     %---------------------------------------------------------------------
        
                         Losses(iter+1)=FglobalBest;
        
     %-----------------------decrease V and w------------------------------
     r=rand();
     if r>0.1
         r=r*(0.1);
     else
         r=0.1;
     end
     
     for i=1:group
         w(i,:)=w(i,:)*r;
         for j=1:swarm
             V(j,:,i)=V(j,:,i)*r;
         end
     end
     
    %----------------------------------------------------------------------
    plotvector = get(hbestplot,'YData');
    plotvector(iter) = Losses(iter);
    set(hbestplot,'YData',plotvector);
    set(htext1,'String',sprintf('Rugi daya optimal: %f', Losses(iter)));
    hold on;
    drawnow
    %----------------------------------------------------------------------
     iter=iter+1;    
    
  end
  
 clc;
 SW=GlobalBest;
 [RugiRugi]=LF(SW);
 fprintf('Rugi daya minimum hasil optimasi(dalam MW) adalah : %f \n',Losses);
toc