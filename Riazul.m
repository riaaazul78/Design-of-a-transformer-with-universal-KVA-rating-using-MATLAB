clc;
clear all;
close all;
 
f=50;
phase=3;
HV=6600;
LV=220;
k=1/40;
ki=0.88;
ks=0.92;
Bm=1.7;
delta=5;
u0=4*3.14*10^-7;
 
fprintf(' Enter the KVA of the transformer : ');
KVA=input(' ');
s=(KVA*10^3)/phase;
Et=k*sqrt(s);
fprintf(' Voltage per turn,Et = %0.3f volts/turn\n',Et);
fprintf(' Choosing, Et=3.95 volts/n');
Et=3.95; 
Ai=(Et*10^6)/(4.44*Bm*f);
Ai=round(Ai*1e2)/1e2;
 
d=sqrt((4*Ai)/(3.14*ki*ks));
if (d<120 && d>115)
    d=120;
elseif (d<125 && d>120)
    d=125;
elseif (d<130 && d>125)
    d=130;
else
    d=round(d);
end
fprintf(' Diameter of the circumscribing circle for the core,d = %0.3f mm\n',d);
Ai=(3.1416*d^2*ki*ks)/4;
Ai=round(Ai);
fprintf(' Cross sectional area of the core,Ai = %0.2f mm^2\n',Ai);
Bm=(Et*10^6)/(4.44*f*Ai);
Bm=round(Bm*1e2)/1e2;
fprintf(' Maximum flux density,Bm= %0.2f Wb/m^2\n',Bm);
 
kw=10/(30+(HV*1e-3));
kw=round(kw*1e2)/1e2;
fprintf(' Window space factor,kw= %0.3f\n',kw);
Aw=(KVA*10^3*10^6)/(3.33*Ai*kw*delta*Bm*f);
Aw=round(Aw);
fprintf(' Input the value of window width about the dia of the core in percent = ');
Ww=input(' ');
Ww=(Ww/100)*d;
Ww=round(Ww);
fprintf(' Window width= %0.2f mm\n',Ww);
Hw=Aw/Ww;
fprintf(' Height of the window= %0.2f mm\n',Hw);
fprintf(' Choosing, Hw=210 mm\n');
Hw=210;
 
Aw=Hw*Ww;
fprintf(' Window area,Aw= %0.2f mm^2\n',Aw);
d1=123;
fprintf(' With a 7 steps core, the largest width of the core = %0.2f mm\n',d1);
D=d1+Ww;
fprintf(' Distance between the centers of the adjacent limbs = %0.2f mm\n',D);
H=Hw+48;
TW=(3*d1+2*Ww);
fprintf(' Total width ,TW = %0.2f mm\n',TW);
fprintf(' Choosing, TW=580 mm\n');
TW=580;
TH=340+2*d1;
fprintf(' Total height = %0.2f mm\n',TH);
 
T2=(LV/(sqrt(3)))/Et;
T2=round(T2);
fprintf(' Turns per phase on L.V. winding, T2 = %0.2f turns\n',T2);
fprintf(' Choosing, T2=33/n');
T2=33;
 
T1=round(HV/Et);
fprintf(' Turns per phase on H.V. winding at normal connection, T1 = %0.2f turns\n',T1);
fprintf(' Choosing, T1=1670/n');
T1=1670;
T12=round(T1*1.05);
fprintf(' With +5 percent tapping, T1= %0.2f turns\n',T12);
T13=T1*1.025;
fprintf(' With +2.5 percent tapping, T1= %0.2f turns\n',T13);
T14=T1*0.975;
fprintf(' With -2.5 percent tapping, T1= %0.2f turns\n',T14);
T15=T1*0.95;
fprintf(' With -5 percent tapping, T1= %0.2f turns\n',T15);
T1max=T12;
 
IL=(KVA*10^3)/(sqrt(3)*LV);
IL=round(IL*1e2)/1e2;
fprintf(' Current per phase in low voltage winding = %0.3f A\n',IL);
fprintf(' Choosing, IL=197 A/n');
IL=197;
a2=IL/delta;
a2=round(a2*1e1)/1e1;
fprintf(' Area of LV conductor, a2= %0.2f mm^2\n',a2);
fprintf(' Choosing, a2=42 mm^2/n');
a2=42;

fprintf(' Choosing rectangular conductor strips forming the conductor of LV winding,\n');
fprintf(' Input the thickness of the LV conductor in mm,t=');
t=input(' ');
fprintf(' Input the diameter of the LV conductor in mm,d=');
d2=input(' ');
a2=2*t*d2;
fprintf(' Area of LV conductor with the chosen dia & thickness, a2= %0.2f mm^2\n',a2);

IH=(KVA*10^3)/(3*HV);
IH=round(IH*1e2)/1e2;
fprintf(' Current per phase in high voltage winding = %0.3f A\n',IH);
a1=IH/delta;
d3=sqrt((4*a1)/3.14);
d3=round(d3*1e1)/1e1;
fprintf(' The diameter of the round HV conductor = %0.2f mm\n',d3);
fprintf(' Choosing, d3=1.07 mm/n');
d3=1.07;
a1=(3.14*d3^2)/4;
a1=round(a1*1e3)/1e3;
fprintf(' Area of HV conductor, a1 = %0.3f mm^2\n',a1);
fprintf(' Choosing, a1=0.9 mm/n');
a1=0.9;
Ac=2*(a1*T1max+a2*T2);
fprintf('Copper area in window = %f mm^2\n',Ac);
kw2=Ac/Aw;
fprintf(' Calculated window space factor= %0.2f\n',kw2);
diff=abs(kw2-kw);
 
if (diff>0.02)
    fprintf(' ERROR! The calculated window space factor is way far from the chosen one.\n');
else
    fprintf(' which is near about 0.27 as chosen.\n');
    
    t=t+0.25;
    d2=d2+0.25;
    fprintf(' With paper insulation of 0.25 mm,\n');
    fprintf(' Thickness of the LV conductor,t= %0.3f\n',t);
    fprintf(' Diameter of the LV conductor,d= %0.3f\n',d2);
    N=T2;
    fprintf(' Turns per layer of LV = %0.0f turns\n',N);
    HL=round(N*d2);
    TL=2*t;
    fprintf(' TL= %0.2f mm\n',TL);
    IDL=d+(2*3.5);
    ODL=IDL+2*TL;
    MDL=0.5*(IDL+ODL);
    MLTL=round(3.1416*MDL);
    fprintf(' Height of LV winding in window = %0.2f mm\n',HL);
    fprintf(' Thickness of LV coil = %0.2f mm\n',TL);
    fprintf(' Inside diameter of LV coil = %0.2f mm\n',IDL);
    fprintf(' Outside diameter of LV coil = %0.2f mm\n',ODL);
    fprintf(' Mean diameter of LV coil = %0.2f mm\n',MDL);
    fprintf(' Mean length turn of LV coil = %0.2f mm\n',MLTL);
    
    IDH=ODL+2*12;
    turn=round(T1max/4);
    d3=1.25+0.25;
    fprintf(' Enter the number of layers for HV coil :'); 
    layer=input('');
    N1=turn/layer;
    N1=round(N1*1e2)/1e2;
    fprintf(' Turns per layer of HV = %0.0f turns\n',N1);
    height=round(N1*d3);
    thickness=15;
    ODH=IDH+2*thickness;
    MDH=0.5*(IDH+ODH);
    MLTH=3.1416*MDH;
    HH=height*4+8*3;
    fprintf(' Height of HV winding in window = %0.2f mm\n',HH);
    
    if (HH<Hw)
        fprintf(' ERROR! Height of HV winding is greater than window height.\n');
    else
        fprintf(' Inside diameter of HV coil = %0.2f mm\n',IDH);
        fprintf(' Outside diameter of HV coil = %0.2f mm\n',ODH);
        fprintf(' Mean diameter of HV coil = %0.2f mm\n',MDH);
        fprintf(' Mean length turn of HV coil = %0.4f mm\n',MLTH);
        HW=HH+26*2;
        fprintf(' Height of window with proper spacing = %0.0f mm\n',HW);
        MLTav=0.5*(MLTL+MLTH);
        AT=IL*T2;
        Hav=0.5*(HL+HH);
        at=12;
        b1=thickness;
        b2=TL;
        X=((2*3.1416*f*u0*MLTav*10^-3*AT*(at+(b1+b2)/3)*10^-3)/(Et*Hav*10^-3))*100;
        fprintf(' Percentage reactance, X= %0.4f percent\n',X);
        
        p20=0.01724;
        a20=0.00393;
        fprintf(' Enter the temperature in degree celcius = ');
        theta=input('');
        p=p20*(1+a20*(theta-20));
        p=round(p*1e3)/1e3;
        fprintf(' Resistivity at the given temperature = %0.4f ohm/mm^2/m\n',p);
        RL=round(((p*MLTL*T2)/(a2*1e3))*1e3)/1e3;
        fprintf(' Resistance of LV winding = %0.4f ohm\n',RL);
        RH=round(((p*MLTH*T1)/(a1*1e3))*1e2)/1e2;
        fprintf(' Resistance of HV winding = %0.4f ohm\n',RH);
        k=round((HV/(LV/3^0.5))*1e2)/1e2;
        Req=round((RH+RL*k*k)*1e2)/1e2;
        fprintf(' Equivalent resistance referred to HV winding = % 0.4f ohm\n',Req);
        fprintf(' Choosing, Req=43 mm/n');
        Req=43;
        R=round(((IH*Req*100)/HV)*1e2)/1e2;
        fprintf(' Percentage resistance, R= %0.4f percent\n',R);
        
        Z=(R^2+X^2)^0.5;
        Z=round(Z*1e2)/1e2;
        fprintf(' Percentage impedence, Z= %0.3f percent\n',Z);
        if (Z>4.5 || Z<3.5)
            fprintf(' ERROR! Percentage impedence is beyond the limit.\n');
        else
            V=Ai*(HW*3+TW*2);
           Wc=round(((V*7.85)/(1e6))*1e2)/1e2;
           fprintf(' Weight of the core & yoke = %0.3f kg\n',Wc);
            fprintf(' Choosing, Wc=184 kg/n');
            Wc=184; 
            plc=Wc*1.3;
            fprintf(' Core loss= %0.3f watts,',plc);
            if (KVA<26 && plc>155)
                fprintf(' \nERROR! The core loss is beyond the limited.\n');
            elseif (KVA<41 && plc>200)
                fprintf(' \nERROR! The core loss is beyond the limited.\n');
            elseif (KVA<64 && plc>260)
                fprintf(' \nERROR! The core loss is beyond the limited.\n');
            elseif (KVA<101 && plc>355)
                fprintf(' \nERROR! The core loss is beyond the limited.\n');
            else
                fprintf(' which is within the limit.\n');
                
                VA=round((10*Wc)*1e1)/1e1;
                fprintf(' Magnetising volt-ampere= %0.2f VA\n',VA);
                
                wlw=round((8.89*a2*T2*MLTL)/1e6);
                fprintf(' Weight of LV winding per limb= %0.2f kg\n',wlw);
                whw=round(((8.89*a1*T1*MLTH)/1e6)*1e2)/1e2;
                fprintf(' Weight of HV winding per limb with normal turns= %0.2f kg\n',whw);
                TWC=3*(wlw+whw);
                fprintf(' Total weight of copper in transformer= %0.2f kg\n',TWC);
                fprintf(' Choosing, TWC kg/n');
                TWC=1983;
                fprintf(' Total weight of copper in transformer= %0.2f kg\n',TWC);
                plcu=round(3*IH^2*Req*1e2)/1e2;
                pll=round(plcu*1.07*1e2)/1e2;
                fprintf(' Load loss= %0.3f watts,',pll);
                fprintf(' Choosing, pll=1983 kg/n');
                pll=1983;
                fprintf(' Load loss= %0.3f watts,',pll);
                if (KVA<26 && pll>700)
                fprintf(' \nERROR! The load loss is beyond the limited.\n');
                elseif (KVA<41 && pll>975)
                fprintf(' \nERROR! The load loss is beyond the limited.\n');
                elseif (KVA<64 && pll>1400)
                fprintf(' \nERROR! The load loss is beyond the limited.\n');
                elseif (KVA<101 && pll>2000)
                fprintf(' \nERROR! The load loss is beyond the limited.\n');
                else
                fprintf(' which is within the limit.\n');
                
                Tloss=plc+pll;
                fprintf(' Total loss = %0.2f watts\n',Tloss);
                end
            end
        end
    end
end 
 

