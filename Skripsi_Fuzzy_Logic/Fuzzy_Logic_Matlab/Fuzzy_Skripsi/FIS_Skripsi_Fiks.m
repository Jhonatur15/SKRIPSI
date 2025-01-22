% function m = FIS(pH,tp,do,wl)
%% Fuzzy Interface System (FIS) Monitoring Kolam bibit ikan mas/karper
% creator: Jhonador Stheven S
% email: jhonador15@sdodents.unnes.ac.id
% data: 07/12/2023

%% tgl : 07/12/2023 (Kontrol Air Kolam Pembibitan Ikan Karper")
% Visual FIS
% Input
% Rules
% Agregasi
% Defuzzifikasi
%% Syntax
% m = FIS(pH,tp,do,wl)
% m = mesin valve(pwm)-->[SOM,MOM,LOM,Centroid,Kandel,Center of Gravity]
% pH = input 1 Potential of Hydrogen (derajat keasaman dalam pH)
% tp = input 2 temperature (suhu dalam Celcius)
% tu = input 3 Turbidity (kekeruhan dalam NTU)
% do = input 4 DO (Kadar Oksigen dalam mg/l)

%% Visual FIS
% Skala rentang sumbu x input 1 suhu
pH = 8;  %(di isi)
tp = 23; %(di isi)
do = 6; %(di isi)
tu = 15; %(di isi)

% (%error)
SetDO = 5;
err = ((do - SetDO)/ SetDO) * 100;

% (%Saturasi)
saturasi = 14.1271 - 0.33935*tp + (5.1333 * 10^-3 * tp^2) - (3.5556 * 10^-5 * tp^3);
sat = (do / saturasi) * 100;


%%%======================== FUNGSI KEANGGOTAAN ===========================%%%
%%INPUT
%===========================================================================%
%Skala rentang sumbu x input 1 pH
x1 = 4:0.1:11;
figure(1),hold on,
%---------------------------------------------------------------------------%
Asam = trapesium(x1, 4, 4, 6, 7);
plot(x1,Asam,'y','LineWidth',2);
text(5,0.5, strcat('AC'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Neteral = segitiga(x1, 6.5, 7.5, 8.5);
plot(x1,Neteral,'m','LineWidth',2);
text(7.2,0.5, strcat('NT'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Basa = trapesium(x1, 8, 9, 11, 11);
plot(x1,Basa,'b','LineWidth',2);
text(9.8,0.5, strcat('AL'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Derajat Keasaman ')
xlabel('x1 = Potential of Hydrogen(pH)')
ylabel('Mu-(x1)')
hold off
%===========================================================================%
% Skala rentang sumbu x input 2 Temperature
x2 = 20:0.1:35;
figure(2),hold on,
%---------------------------------------------------------------------------%
Dingin = trapesium(x2,0,20,23,25);
plot(x2,Dingin,'b','LineWidth',2);
text(21,0.5, strcat('CD'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Sedang = segitiga(x2,25,27.5,30);
plot(x2,Sedang,'y','LineWidth',2);
text(27,0.5, strcat('NM'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Panas = trapesium(x2,29,30,35,35);
plot(x2,Panas,'r','LineWidth',2);
text(32,0.5, strcat('HO'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title('Fungsi Keanggotaan Suhu')
xlabel('x2 = temperature (C)')
ylabel('Mu-(x2)')
hold off
%===========================================================================%
% Skala rentang sumbu x input 3 Turbidity
x3 = 0:0.1:100;
figure(3),hold on,
Rendah = trapesium(x3, 0, 0, 10, 15);
plot(x3,Rendah,'k','LineWidth',2);
text(4,0.5, strcat('LT'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Sedang = trapesium(x3, 10, 15, 20, 26);
plot(x3,Sedang,'c','LineWidth',2);
text(14,0.5, strcat('MT'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Tinggi = trapesium(x3, 26, 30, 100, 100);
plot(x3,Tinggi,'r','LineWidth',2);
text(65,0.5, strcat('HT'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Kekeruhan')
xlabel('x3 = Turbidity(NTU)')
ylabel('Mu-(x3)')
hold off
%===========================================================================%
% Skala rentang sumbu x input 4 err DO
x4 = 0:100;
figure(4),hold on,
%---------------------------------------------------------------------------%
Zero = segitiga(x4,0,0,25);
plot(x4,Zero,'k','LineWidth',2);
text(4,0.5, strcat('ZD'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
OFF_H = segitiga(x4,0,30,60);
plot(x4,OFF_H,'k','LineWidth',2);
text(28,0.5, strcat('LD'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Med = segitiga(x4,40,70,100);
plot(x4,Med,'k','LineWidth',2);
text(68,0.5, strcat('MD'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
ON_H = segitiga(x4,75,100,100) ;
plot(x4,ON_H,'k','LineWidth',2);
text(94,0.5, strcat('HD'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Error DO ')
xlabel('x4 = err (%)')
ylabel('Mu-(x4)')
hold off
%===========================================================================%
% Skala rentang sumbu x input 5 saturasion
x5 = 0:100;
figure(5),hold on,
%---------------------------------------------------------------------------%
ON_H_Sat = trapesium(x5,0,0,10,20);
plot(x5,ON_H_Sat,'k','LineWidth',2);
text(4,0.5, strcat('LS'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Med_Sat = trapesium(x5,10,20,45,55);
plot(x5,Med_Sat,'k','LineWidth',2);
text(30,0.5, strcat('MS'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
OFF_H_Sat = trapesium(x5,45,60,100,100);
plot(x5,OFF_H_Sat,'k','LineWidth',2);
text(70,0.5, strcat('HS'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Saturation ')
xlabel('x5 = Saturation (%)')
ylabel('Mu-(x5)')
hold off

%% OUTPUT
%===========================================================================%
% Skala rentang sumbu x Output 1 Valve
x6 = 0:0.1:1;
figure(6),hold on,
OFF_V = trapesium(x6,0,0,0.4,0.6);
plot(x6,OFF_V,'k','LineWidth',2);
text(0,0.5, strcat('OFF_V'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'b');
%---------------------------------------------------------------------------%
ON_V = trapesium(x6,0.4,0.6,1,1);
plot(x6,ON_V,'k','LineWidth',2);
text(0.8,0.5, strcat('ON_V'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Output Valve')
xlabel('x6 = Jumlah Soleoind Valve(Unit)')
ylabel('Mu-(x6)')
hold off
%===========================================================================%
% Skala rentang sumbu x Output 2 Aerator
x7 = 0:0.1:3;
figure(7),hold on,
Mati = segitiga(x7,0,0,1);
plot(x7,Mati,'k','LineWidth',2);
text(0,0.5, strcat('None'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Satu_AER = segitiga(x7,0,1,2);
plot(x7,Satu_AER,'k','LineWidth',2);
text(0.8,0.5, strcat('Satu_AER'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Dua_AER = segitiga(x7,1,2,3);
plot(x7,Dua_AER,'k','LineWidth',2);
text(1.8,0.5, strcat('Dua_AER'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
Tiga_AER = segitiga(x7,2,3,3);
plot(x7,Tiga_AER,'k','LineWidth',2);
text(2.8,0.5, strcat('Tiga_AER'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Output Aerator')
xlabel('x7 = Jumlah AERator(Unit)')
ylabel('Mu-(x7)')
hold off
%===========================================================================%
% Skala rentang sumbu x Output 3 Heater
x8 = 0:0.1:1;
figure(8),hold on,
OFF_H = trapesium(x8,0,0,0.4,0.6);
plot(x8,OFF_H,'b','LineWidth',2);
text(0.2,0.5, strcat('OFF_H'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
ON_H = trapesium(x8,0.4,0.6,1,1);
plot(x8,ON_H,'r','LineWidth',2);
text(0.75,0.5, strcat('ON_H'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%---------------------------------------------------------------------------%
title ('Fungsi Keanggotaan Output Heater')
xlabel('x8 = Heater(Pemanas)')
ylabel('Mu-(x8)')
hold off

%%%============================= FUZZIFIKASI =================================%%%
%% Fuzzifikasi input pH
% nilai default Derajat Keasaman
D_Keasaman = [0,0,0];%[Asam,Neteral,Basa]
if (0 <= pH && pH <= 7)%Asam
    D_Keasaman(1)= trapesium(pH, 4, 4, 6, 7);
end
if (5.5 <= pH && pH <= 8.5)%Neteral
    D_Keasaman(2)= segitiga(pH, 6.5, 7.5, 8.5);
end
if (8 <= pH && pH <= 14)%Basa
    D_Keasaman(3)= trapesium(pH, 8, 9, 11 , 11);
end
%% Fuzzifikasi input Suhu
% nilai default suhu
temperature = [0,0,0];%[Dingin,Normal,Panas]
if (20 <= tp && tp <= 25.5)%Dingin
    temperature(1)= trapesium(tp,0,20,23,25);
end
if (25 < tp && tp <= 30)%Normal
    temperature(2)= segitiga(tp,25,27.5,30);
end
if (29 <= tp && tp <= 35)%Panas
    temperature(3)= trapesium(tp,29,30,35,35);
end
%% Fuzzifikasi input Turbidity
% nilai default turbidity
turbidity = [0,0,0];%[Rendah,Sedang,Tinggi]
if (0 <= tu && tu <= 35)%Rendah
    turbidity(1)= trapesium(tu,29,30,35,35);
end
if (10 < tu && tu <= 26)%Sedang
    turbidity(2)= trapesium(tu, 10, 15, 20, 26);
end
if (26 <= tu && tu <= 100)%Tinggi
    turbidity(3)= trapesium(tu, 26, 30, 100, 100);
end
%% Fuzzifikasi input Error DO
error = [0,0,0,0];%[Zero,OFF_H,Med,ON_H]
if (0 <= err && err <= 25)%Zero
    error(1)= segitiga(err,0,0,25);
end
if (10 < err && err <= 50)%OFF_H
    error(2)= segitiga(err,0,30,60);
end
if (40 <= err && err <= 100)%Med
    error(3)= segitiga(err,40,70,100);
end
if (75 <= err && err <= 100)%Med
    error(4)= segitiga(err,75,100,100);
end
%% Fuzzifikasi input Saturasion
saturasion = [0,0,0];%[ON_H,Medium,OFF_H]
if (0 <= sat && sat <= 20)%ON_H
    saturasion(1)= trapesium(sat,0,0,5,20);
end
if (10 < tp && tp <= 55)%Medium
    saturasion(2)= trapesium(sat,10,25,40,55);
end
if (45 <= tp && tp <= 100)%OFF_H
    saturasion(3)= trapesium(sat,45,60,100,100);
end

%% ================ Aturan-Aturan Fuzzy ============ %%
%% Aturan-aturan Valve dan Heater
HeaVal = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%            [A1,A2,A3,A4,A5,A6,N1,N2,N3,N4,N5,N6,N7,N8,N9,B1,B2,B3,B4,B5,B6]
% A(Asam), N(Netral), B(Basa)
% HeaVal = Heater dan Valve (output)
% ================ A(Asam) ====================
% Rule 1 ==> Jika Asam, Dingin, dan Rendah A1
if (D_Keasaman(1)>0 && temperature(1)>0 && turbidity(1)>0)
    HeaVal(1) = min([D_Keasaman(1), temperature(1), turbidity(1)]);
end
% Rule 2 ==> Jika Asam, Dingin, dan Sedang A2
if (D_Keasaman(1)>0 && temperature(1)>0 && turbidity(2)>0)
    HeaVal(2) = min([D_Keasaman(1), temperature(1), turbidity(2)]);
end
% Rule 3 ==> Jika Asam, Dingin, dan Tinggi A3
if (D_Keasaman(1)>0 && temperature(1)>0 && turbidity(3)>0)
    HeaVal(3) = min([D_Keasaman(1), temperature(1), turbidity(3)]);
end
% Rule 4 ==> Jika Asam, Normal, dan Rendah A4
if (D_Keasaman(1)>0 && temperature(2)>0 && turbidity(1)>0)
    HeaVal(4) = min([D_Keasaman(1), temperature(2), turbidity(1)]);
end
% Rule 5 ==> Jika Asam, Normal, dan Sedang A5
if (D_Keasaman(1)>0 && temperature(2)>0 && turbidity(3)>0)
    HeaVal(5) = min([D_Keasaman(1), temperature(2), turbidity(2)]);
end
% Rule 6 ==> Jika Asam, Normal, dan Tinggi A6
if (D_Keasaman(1)>0 && temperature(2)>0 && turbidity(3)>0)
    HeaVal(6) = min([D_Keasaman(1), temperature(2), turbidity(3)]);
end
% ================ N(Netral) ====================
% Rule 7 ==> Jika Netral, Dingin, dan Rendah N1
if (D_Keasaman(2)>0 && temperature(1)>0 && turbidity(1)>0)
    HeaVal(7) = min([D_Keasaman(2), temperature(1), turbidity(1)]);
end
% Rule 8 ==> Jika Netral, Dingin, dan Sedang N2
if (D_Keasaman(2)>0 && temperature(1)>0 && turbidity(2)>0)
    HeaVal(8) = min([D_Keasaman(2), temperature(1), turbidity(2)]);
end
% Rule 9 ==> Jika Netral, Dingin, dan Tinggi N3
if (D_Keasaman(2)>0 && temperature(1)>0 && turbidity(3)>0)
    HeaVal(9) = min([D_Keasaman(2), temperature(1), turbidity(3)]);
end
% Rule 10 ==> Jika Netral, Normal, dan Rendah N4
if (D_Keasaman(2)>0 && temperature(2)>0 && turbidity(1)>0)
    HeaVal(10) = min([D_Keasaman(2), temperature(2), turbidity(1)]);
end
% Rule 11 ==> Jika Netral, Normal, dan Sedang N5
if (D_Keasaman(2)>0 && temperature(2)>0 && turbidity(2)>0)
    HeaVal(11) = min([D_Keasaman(2), temperature(2), turbidity(2)]);
end
% Rule 12 ==> Jika Netral, Normal, dan Tinggi N6
if (D_Keasaman(2)>0 && temperature(2)>0 && turbidity(3)>0)
    HeaVal(12) = min([D_Keasaman(2), temperature(2), turbidity(3)]);
end
% Rule 13 ==> Jika Netral, Panas, dan Rendah N7
if (D_Keasaman(2)>0 && temperature(3)>0 && turbidity(1)>0)
    HeaVal(13) = min([D_Keasaman(2), temperature(3), turbidity(1)]);
end
% Rule 14 ==> Jika Netral, Panas, dan Sedang N8
if (D_Keasaman(2)>0 && temperature(3)>0 && turbidity(2)>0)
    HeaVal(14) = min([D_Keasaman(2), temperature(3), turbidity(2)]);
end
% Rule 15 ==> Jika Netral, Panas, dan Tinggi N9
if (D_Keasaman(2)>0 && temperature(3)>0 && turbidity(3)>0)
    HeaVal(15) = min([D_Keasaman(2), temperature(3), turbidity(3)]);
end
% ================ B(Basa) ====================
% Rule 16 ==> Jika Basa, Dingin, dan Rendah B1
if (D_Keasaman(3)>0 && temperature(1)>0 && turbidity(1)>0)
    HeaVal(16) = min([D_Keasaman(3), temperature(1), turbidity(1)]);
end
% Rule 17 ==> Jika Basa, Dingin, dan Sedang B2
if (D_Keasaman(3)>0 && temperature(1)>0 && turbidity(2)>0)
    HeaVal(17) = min([D_Keasaman(3), temperature(1), turbidity(2)]);
end
% Rule 18 ==> Jika Basa, Dingin, dan Tinggi B3
if (D_Keasaman(3)>0 && temperature(1)>0 && turbidity(3)>0)
    HeaVal(18) = min([D_Keasaman(3), temperature(1), turbidity(3)]);
end
% Rule 19 ==> Jika Basa, Normal, dan Rendah B4
if (D_Keasaman(3)>0 && temperature(2)>0 && turbidity(1)>0)
    HeaVal(19) = min([D_Keasaman(3), temperature(2), turbidity(1)]);
end
% Rule 20 ==> Jika Basa, Normal, dan Sedang B5
if (D_Keasaman(3)>0 && temperature(2)>0 && turbidity(2)>0)
    HeaVal(19) = min([D_Keasaman(3), temperature(2), turbidity(2)]);
end
% Rule 21 ==> Jika Basa, Normal, dan Tinggi B6
if (D_Keasaman(3)>0 && temperature(2)>0 && turbidity(3)>0)
    HeaVal(19) = min([D_Keasaman(3), temperature(2), turbidity(3)]);
end

%====================================================================%
%% Aturan-aturan Aerator
AER = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%     [S1,S2,S3,S4,S5,D1,D2,D3,T1,T2,T3,T4]  S(Satu), D(Dua), T(Tiga)

%============= 1 AERator Hidup =================
% Rule 22 ==> Jika Zero, dan Low S1
if (error(1)>0 && saturasion(1)>0)
    AER(1) = min([error(1),saturasion(1)]);
end
% Rule 23 ==> Jika Low, dan Low S2
if (error(2)>0 && saturasion(1)>0)
    AER(2) = min([error(2),saturasion(1)]);
end
% Rule 24 ==> Jika Zero, dan Medium S3
if (error(1)>0 && saturasion(2)>0)
    AER(5) = min([error(1),saturasion(2)]);
end
% Rule 25 ==> Jika Low, dan Medium S4
if (error(2)>0 && saturasion(2)>0)
    AER(6) = min([error(2),saturasion(2)]);
end
% Rule 26 ==> Jika Zero, dan High S5
if (error(1)>0 && saturasion(3)>0)
    AER(9) = min([error(1),saturasion(3)]);
end
%============= 2 AERator Hidup =================
% Rule 27 ==> Jika Medium, dan Low D1
if (error(3)>0 && saturasion(1)>0)
    AER(3) = min([error(3),saturasion(1)]);
end
% Rule 28 ==> Jika Medium, dan Medium D2
if (error(3)>0 && saturasion(2)>0)
    AER(7) = min([error(3),saturasion(2)]);
end
% Rule 29 ==> Jika Medium, dan High D3
if (error(3)>0 && saturasion(3)>0)
    AER(10) = min([error(3),saturasion(3)]);
end
%============= 3 AERator Hidup =================
% Rule 30 ==> Jika High, dan Low T1
if (error(4)>0 && saturasion(1)>0)
    AER(4) = min([error(4),saturasion(1)]);
end
% Rule 31 ==> Jika High, dan Medium T2
if (error(4)>0 && saturasion(2)>0)
    AER(8) = min([error(4),saturasion(2)]);
end
% Rule 32 ==> Jika Medium, dan High T3
if (error(3)>0 && saturasion(3)>0)
    AER(11) = min([error(3),saturasion(3)]);
end
% Rule 33 ==> Jika High, dan High T4
if (error(4)>0 && saturasion(3)>0)
    AER(12) = min([error(4),saturasion(3)]);
end


%%%=========================== AGREGASI ===========================%%%
%% Agregasi Valve
%====================================================================%
w_Valve = max(HeaVal);
%itrapesium(HeaVal(1),0,0,0.4,0.6);   //OFF
%itrapesium(HeaVal(1)0.4,0.6,1,1);    //ON
%--------------------------------------------------------------------%
% ----------- Valve OFF--------------%
% jika hasil agregasi adalah V_OFF_1
[~, V_OFF1_Max] = itrapesium(HeaVal(7),0,0,0.4,0.6);
% jika hasil agregasi adalah V_OFF_2
[~, V_OFF2_Max] = itrapesium(HeaVal(8),0,0,0.4,0.6);
% jika hasil agregasi adalah V_OFF_3
[~, V_OFF3_Max] = itrapesium(HeaVal(10),0,0,0.4,0.6);
% jika hasil agregasi adalah V_OFF_4
[~, V_OFF4_Max] = itrapesium(HeaVal(11),0,0,0.4,0.6);
% jika hasil agregasi adalah V_OFF_5
[~, V_OFF5_Max] = itrapesium(HeaVal(13),0,0,0.4,0.6);
% jika hasil agregasi adalah V_OFF_6
[~, V_OFF6_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
% ----------- Valve ON--------------%
% jika hasil agregasi adalah V_ON_1
[V_ON1_Min, ~] = itrapesium(HeaVal(1),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_2
[V_ON2_Min, ~] = itrapesium(HeaVal(2),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_3
[V_ON3_Min, ~] = itrapesium(HeaVal(3),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_4
[V_ON4_Min, ~] = itrapesium(HeaVal(4),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_5
[V_ON5_Min, ~] = itrapesium(HeaVal(5),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_6
[V_ON6_Min, ~] = itrapesium(HeaVal(6),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_7
[V_ON7_Min, ~] = itrapesium(HeaVal(9),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_8
[V_ON8_Min, ~] = itrapesium(HeaVal(12),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_9
[V_ON9_Min, ~] = itrapesium(HeaVal(15),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_10
[V_ON10_Min, ~] = itrapesium(HeaVal(16),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_11
[V_ON11_Min, ~] = itrapesium(HeaVal(17),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_12
[V_ON12_Min, ~] = itrapesium(HeaVal(18),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_13
[V_ON13_Min, ~] = itrapesium(HeaVal(19),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_14
[V_ON14_Min, ~] = itrapesium(HeaVal(20),0.4,0.6,1,1);
% jika hasil agregasi adalah V_ON_15
[V_ON15_Min, ~] = itrapesium(HeaVal(21),0.4,0.6,1,1);
%====================================================================%

%% Agregasi Aerator
%====================================================================%
w_AER = max(AER);
%--------------------------------------------------------------------%
% -----------SATU--------------%
% jika hasil agregasi adalah S1
[~, AER_S1_Max] = isegitiga(AER(1),0,1,2);
% jika hasil agregasi adalah S2
[~, AER_S2_Max] = isegitiga(AER(2),0,1,2);
% jika hasil agregasi adalah S3
[~, AER_S3_Max] = isegitiga(AER(5),0,1,2);
% jika hasil agregasi adalah S4
[~, AER_S4_Max] = isegitiga(AER(6),0,1,2);
% jika hasil agregasi adalah S5
[~, AER_S5_Max] = isegitiga(AER(9),0,1,2);
% -----------DUA--------------%
% jika hasil agregasi adalah D1
[AER_D1_Min, ~] = isegitiga(AER(3),1,2,3);
% jika hasil agregasi adalah D2
[AER_D2_Min, ~] = isegitiga(AER(7),1,2,3);
% jika hasil agregasi adalah D3
[AER_D3_Min, ~] = isegitiga(AER(10),1,2,3);
% -----------TIGA--------------%
% jika hasil agregasi adalah T1
[AER_T1_Min, ~] = isegitiga(AER(4),1,2,3);
% jika hasil agregasi adalah T2
[AER_T2_Min, ~] = isegitiga(AER(8),1,2,3);
% jika hasil agregasi adalah T3
[AER_T3_Min, ~] = isegitiga(AER(11),1,2,3);
% jika hasil agregasi adalah T3
[AER_T4_Min, ~] = isegitiga(AER(12),1,2,3);
%====================================================================%

%% Agregasi Heater
%====================================================================%
w_Heater = max(HeaVal);
%--------------------------------------------------------------------%
% ----------- Heater OFF--------------%
% jika hasil agregasi adalah H_OFF_1
[~, H_OFF1_Max] = itrapesium(HeaVal(4),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_2
[~, H_OFF2_Max] = itrapesium(HeaVal(5),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_3
[~, H_OFF3_Max] = itrapesium(HeaVal(6),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_4
[~, H_OFF4_Max] = itrapesium(HeaVal(10),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_5
[~, H_OFF5_Max] = itrapesium(HeaVal(11),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_6
[~, H_OFF6_Max] = itrapesium(HeaVal(12),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_7
[~, H_OFF7_Max] = itrapesium(HeaVal(13),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_8
[~, H_OFF8_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_9
[~, H_OFF9_Max] = itrapesium(HeaVal(15),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_10
[~, H_OFF10_Max] = itrapesium(HeaVal(19),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_11
[~, H_OFF11_Max] = itrapesium(HeaVal(20),0,0,0.4,0.6);
% jika hasil agregasi adalah H_OFF_12
[~, H_OFF12_Max] = itrapesium(HeaVal(21),0,0,0.4,0.6);
% ----------- Valve ON--------------%
% jika hasil agregasi adalah H_ON_1
[H_ON1_Min, ~] = itrapesium(HeaVal(1),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_2
[H_ON2_Min, ~] = itrapesium(HeaVal(2),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_3
[H_ON3_Min, ~] = itrapesium(HeaVal(3),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_4
[H_ON4_Min, ~] = itrapesium(HeaVal(7),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_5
[H_ON5_Min, ~] = itrapesium(HeaVal(8),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_6
[H_ON6_Min, ~] = itrapesium(HeaVal(9),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_7
[H_ON7_Min, ~] = itrapesium(HeaVal(16),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_8
[H_ON8_Min, ~] = itrapesium(HeaVal(17),0.4,0.6,1,1);
% jika hasil agregasi adalah H_ON_9
[H_ON9_Min, ~] = itrapesium(HeaVal(18),0.4,0.6,1,1);


%%%======================= DEFUZZIFIKASI===========================%%%
% Defuzzifikasi Valve 
m_Valve = [0,0,0,0,0,0];%[SOM,MOM,LOM,Centroid,Kandel,CoG]
%====================================================================%
% -------------------------Valve OFF-----------------------------%
if w_Valve == HeaVal(7)% Jika hasil agerasi adalah V_OFF_1
    [V_OFF1_Min,V_OFF1_Max] = itrapesium(HeaVal(7),0,0,0.4,0.6);
    %SOM
    m_Valve(1)= V_OFF1_Min;
    %MOM
    m_Valve(2)= (V_OFF1_Max+V_OFF1_Min)/2;
    %LOM
    m_Valve(3)= V_OFF1_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(7);
    y(index)=HeaVal(7);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(8)% Jika hasil agerasi adalah V_OFF_2
    [V_OFF2_Min,V_OFF2_Max] = itrapesium(HeaVal(8),0,0,0.4,0.6);
    %SOM
    m_Valve(1)= V_OFF2_Min;
    %MOM
    m_Valve(2)= (V_OFF2_Max+V_OFF2_Min)/2;
    %LOM
    m_Valve(3)= V_OFF2_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(8);
    y(index)=HeaVal(8);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(10)% Jika hasil agerasi adalah V_OFF_3
    [V_OFF3_Min,V_OFF3_Max] = itrapesium(HeaVal(10),0,0,0.4,0.6);
    %SOM
    m_Valve(1)= V_OFF3_Min;
    %MOM
    m_Valve(2)= (V_OFF3_Max+V_OFF3_Min)/2;
    %LOM
    m_Valve(3)= V_OFF3_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(10);
    y(index)=HeaVal(10);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(11)% Jika hasil agerasi adalah V_OFF_4
    [V_OFF4_Min,V_OFF4_Max] = itrapesium(HeaVal(11),0,0,0.4,0.6);
    %SOM
    m_Valve(1)= V_OFF4_Min;
    %MOM
    m_Valve(2)= (V_OFF4_Max+V_OFF4_Min)/2;
    %LOM
    m_Valve(3)= V_OFF4_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(11);
    y(index)=HeaVal(11);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(13)% Jika hasil agerasi adalah V_OFF_5
    [V_OFF5_Min,V_OFF5_Max] = itrapesium(HeaVal(13),0,0,0.4,0.6);
    %SOM
    m_Valve(1)= V_OFF5_Min;
    %MOM
    m_Valve(2)= (V_OFF5_Max+V_OFF5_Min)/2;
    %LOM
    m_Valve(3)= V_OFF5_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(13);
    y(index)=HeaVal(13);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(14)% Jika hasil agerasi adalah V_OFF_6
    [V_OFF6_Min,V_OFF6_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
    %SOM
    m_Valve(1)= V_OFF6_Min;
    %MOM
    m_Valve(2)= (V_OFF6_Max+V_OFF6_Min)/2;
    %LOM
    m_Valve(3)= V_OFF6_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(14);
    y(index)=HeaVal(14);
    m_Valve(4)= sum(x.*y)/sum(y);
% -------------------------Valve ON-----------------------------%
elseif w_Valve == HeaVal(1)% Jika hasil agerasi adalah V_ON_1
    [V_ON1_Min,V_ON1_Max] = itrapesium(HeaVal(1),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON1_Min;
    %MOM
    m_Valve(2)= (V_ON1_Max+V_ON1_Min)/2;
    %LOM
    m_Valve(3)= V_ON1_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(1);
    y(index)=HeaVal(1);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(2)% Jika hasil agerasi adalah V_ON_2
    [V_ON2_Min,V_ON2_Max] = itrapesium(HeaVal(2),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON2_Min;
    %MOM
    m_Valve(2)= (V_ON2_Max+V_ON2_Min)/2;
    %LOM
    m_Valve(3)= V_ON2_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(2);
    y(index)=HeaVal(2);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(3)% Jika hasil agerasi adalah V_ON_3
    [V_ON3_Min,V_ON3_Max] = itrapesium(HeaVal(3),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON3_Min;
    %MOM
    m_Valve(2)= (V_ON3_Max+V_ON3_Min)/2;
    %LOM
    m_Valve(3)= V_ON3_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(3);
    y(index)=HeaVal(3);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(4)% Jika hasil agerasi adalah V_ON_4
    [V_ON4_Min,V_ON4_Max] = itrapesium(HeaVal(4),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON4_Min;
    %MOM
    m_Valve(2)= (V_ON4_Max+V_ON4_Min)/2;
    %LOM
    m_Valve(3)= V_ON4_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(4);
    y(index)=HeaVal(4);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(5)% Jika hasil agerasi adalah V_ON_5
    [V_ON5_Min,V_ON5_Max] = itrapesium(HeaVal(5),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON5_Min;
    %MOM
    m_Valve(2)= (V_ON5_Max+V_ON5_Min)/2;
    %LOM
    m_Valve(3)= V_ON5_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(5);
    y(index)=HeaVal(5);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(6)% Jika hasil agerasi adalah V_ON_6
    [V_ON6_Min,V_ON6_Max] = itrapesium(HeaVal(6),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON6_Min;
    %MOM
    m_Valve(2)= (V_ON6_Max+V_ON6_Min)/2;
    %LOM
    m_Valve(3)= V_ON6_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(6);
    y(index)=HeaVal(6);
    m_Valve(4)= sum(x.*y)/sum(y);
elseif w_Valve == HeaVal(9)% Jika hasil agerasi adalah V_ON_7
    [V_ON7_Min,V_ON7_Max] = itrapesium(HeaVal(9),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON7_Min;
    %MOM
    m_Valve(2)= (V_ON7_Max+V_ON7_Min)/2;
    %LOM
    m_Valve(3)= V_ON7_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(9);
    y(index)=HeaVal(9);
    m_Valve(4)= sum(x.*y)/sum(y);      
elseif w_Valve == HeaVal(12)% Jika hasil agerasi adalah V_ON_8
    [V_ON8_Min,V_ON8_Max] = itrapesium(HeaVal(12),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON8_Min;
    %MOM
    m_Valve(2)= (V_ON8_Max+V_ON8_Min)/2;
    %LOM
    m_Valve(3)= V_ON8_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(12);
    y(index)=HeaVal(12);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(15)% Jika hasil agerasi adalah V_ON_9
    [V_ON9_Min,V_ON9_Max] = itrapesium(HeaVal(15),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON9_Min;
    %MOM
    m_Valve(2)= (V_ON9_Max+V_ON8_Min)/2;
    %LOM
    m_Valve(3)= V_ON9_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(15);
    y(index)=HeaVal(15);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(16)% Jika hasil agerasi adalah V_ON_10
    [V_ON10_Min,V_ON10_Max] = itrapesium(HeaVal(16),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON10_Min;
    %MOM
    m_Valve(2)= (V_ON10_Max+V_ON10_Min)/2;
    %LOM
    m_Valve(3)= V_ON10_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(16);
    y(index)=HeaVal(16);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(17)% Jika hasil agerasi adalah V_ON_11
    [V_ON11_Min,V_ON11_Max] = itrapesium(HeaVal(17),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON11_Min;
    %MOM
    m_Valve(2)= (V_ON11_Max+V_ON11_Min)/2;
    %LOM
    m_Valve(3)= V_ON11_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(17);
    y(index)=HeaVal(17);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(18)% Jika hasil agerasi adalah V_ON_12
    [V_ON12_Min,V_ON12_Max] = itrapesium(HeaVal(18),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON12_Min;
    %MOM
    m_Valve(2)= (V_ON12_Max+V_ON12_Min)/2;
    %LOM
    m_Valve(3)= V_ON12_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(18);
    y(index)=HeaVal(18);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(18)% Jika hasil agerasi adalah V_ON_13
    [V_ON13_Min,V_ON13_Max] = itrapesium(HeaVal(19),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON13_Min;
    %MOM
    m_Valve(2)= (V_ON13_Max+V_ON13_Min)/2;
    %LOM
    m_Valve(3)= V_ON13_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(19);
    y(index)=HeaVal(19);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(20)% Jika hasil agerasi adalah V_ON_14
    [V_ON14_Min,V_ON14_Max] = itrapesium(HeaVal(20),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON14_Min;
    %MOM
    m_Valve(2)= (V_ON14_Max+V_ON14_Min)/2;
    %LOM
    m_Valve(3)= V_ON14_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(20);
    y(index)=HeaVal(20);
    m_Valve(4)= sum(x.*y)/sum(y);    
elseif w_Valve == HeaVal(21)% Jika hasil agerasi adalah V_ON_15
    [V_ON15_Min,V_ON15_Max] = itrapesium(HeaVal(21),0.4,0.6,1,1);
    %SOM
    m_Valve(1)= V_ON15_Min;
    %MOM
    m_Valve(2)= (V_ON15_Max+V_ON15_Min)/2;
    %LOM
    m_Valve(3)= V_ON15_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(21);
    y(index)=HeaVal(21);
    m_Valve(4)= sum(x.*y)/sum(y);    
end
    % Kandel(rerata berbobot)
m_Valve(5)= ((HeaVal(1)*V_ON1_Min)+(HeaVal(2)*V_ON2_Min)+(HeaVal(3)*V_ON3_Min)+(HeaVal(4)*V_ON4_Min)+(HeaVal(5)*V_ON5_Min)+(HeaVal(6)*V_ON6_Min)+(HeaVal(7)*V_OFF1_Max)+(HeaVal(8)*V_OFF2_Max)+(HeaVal(9)*V_ON7_Min)+(HeaVal(10)*V_OFF3_Max)+(HeaVal(11)*V_OFF4_Max)+(HeaVal(12)*V_ON8_Min)+(HeaVal(13)*V_OFF5_Max)+(HeaVal(14)*V_OFF6_Max)+(HeaVal(15)*V_ON9_Min)+(HeaVal(16)*V_ON10_Min)+(HeaVal(17)*V_ON11_Min)+(HeaVal(18)*V_ON12_Min)+(HeaVal(19)*V_ON13_Min)+(HeaVal(20)*V_ON14_Min)+(HeaVal(21)*V_ON15_Min))/(HeaVal(1)+HeaVal(2)+HeaVal(3)+HeaVal(4)+HeaVal(5)+HeaVal(6)+HeaVal(7)+HeaVal(8)+HeaVal(9)+HeaVal(10)+HeaVal(11)+HeaVal(12)+HeaVal(13)+HeaVal(14)+HeaVal(15)+HeaVal(16)+HeaVal(17)+HeaVal(18)+HeaVal(19)+HeaVal(20)+HeaVal(20)+HeaVal(21));

% % Center of Grafity
% yp = 50*(speed(1))+25;
% x1 = 0:0.01:yp;%Skala universe of discourse
% y1= (speed(1))*trapesium(x1,0,0,yp,yp);
% x2 = yp:0.01:FastMin;
% y2= segitiga(x2,25,75,75);
% x3 = FastMin:0.01:100;
% y3= (speed(2))*trapesium(x3,62.5,62.5,100,100);
% w_Valve(6)= (sum(x1.*y1)+sum(x2.*y2)+sum(x3.*y3))/(sum(y1)+sum(y2)+sum(y3));
%====================================================================%

% Defuzzifikasi Aerator
m_AER = [0,0,0,0,0,0];%[SOM,MOM,LOM,Centroid,Kandel,CoG]
%====================================================================%
% -------------------------SATU-----------------------------%
if w_AER == AER(1)% Jika hasil agerasi adalah S1
    [AER_S1_Min ,AER_S1_Max] = isegitiga(AER(1),0,1,2);
    %SOM
    m_AER(1)= AER_S1_Min;
    %MOM
    m_AER(2)= (AER_S1_Max+AER_S1_Min)/2;
    %LOM
    m_AER(3)= AER_S1_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=AER(1);
    y(index)=AER(1);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(2)% Jika hasil agerasi adalah S2
    [AER_S2_Min ,AER_S2_Max] = isegitiga(AER(2),0,1,2);
    %SOM
    m_AER(2)= AER_S2_Min;
    %MOM
    m_AER(2)= (AER_S2_Max+AER_S2_Min)/2;
    %LOM
    m_AER(3)= AER_S2_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=AER(2);
    y(index)=AER(2);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(5)% Jika hasil agerasi adalah S3
    [AER_S3_Min ,AER_S3_Max] = isegitiga(AER(5),0,1,2);
    %SOM
    m_AER(3)= AER_S3_Min;
    %MOM
    m_AER(2)= (AER_S3_Max+AER_S3_Min)/2;
    %LOM
    m_AER(3)= AER_S3_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=AER(5);
    y(index)=AER(5);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(6)% Jika hasil agerasi adalah S4
    [AER_S4_Min ,AER_S4_Max] = isegitiga(AER(6),0,1,2);
    %SOM
    m_AER(3)= AER_S4_Min;
    %MOM
    m_AER(2)= (AER_S4_Max+AER_S4_Min)/2;
    %LOM
    m_AER(3)= AER_S4_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=AER(6);
    y(index)=AER(6);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(9)% Jika hasil agerasi adalah S5
    [AER_S5_Min ,AER_S5_Max] = isegitiga(AER(9),0,1,2);
    %SOM
    m_AER(3)= AER_S5_Min;
    %MOM
    m_AER(2)= (AER_S5_Max+AER_S5_Min)/2;
    %LOM
    m_AER(3)= AER_S5_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=AER(9);
    y(index)=AER(9);
    m_AER(4)= sum(x.*y)/sum(y);
% -------------------------DUA-----------------------------%
elseif w_AER == AER(3)% Jika hasil agerasi adalah D1
    [AER_D1_Min ,AER_D1_Max] = isegitiga(AER(3),0,1,2);
    %SOM
    m_AER(2)= AER_D1_Min;
    %MOM
    m_AER(2)= (AER_D1_Max+AER_D1_Min)/2;
    %LOM
    m_AER(3)= AER_D1_Max;
    %Centroid
    x = 0:.01:2;
    y= segitiga(x, 0,1,2);
    index= y>=AER(3);
    y(index)=AER(3);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(7)% Jika hasil agerasi adalah D2
    [AER_D2_Min ,AER_D2_Max] = isegitiga(AER(7),0,1,2);
    %SOM
    m_AER(1)= AER_D2_Min;
    %MOM
    m_AER(2)= (AER_D2_Max+AER_D2_Min)/2;
    %LOM
    m_AER(3)= AER_D2_Max;
    %Centroid
    x = 0:.01:2;
    y= segitiga(x, 0,1,2);
    index= y>=AER(7);
    y(index)=AER(7);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(10)% Jika hasil agerasi adalah D3
    [AER_D3_Min ,AER_D3_Max] = isegitiga(AER(10),0,1,2);
    %SOM
    m_AER(1)= AER_D3_Min;
    %MOM
    m_AER(2)= (AER_D3_Max+AER_D3_Min)/2;
    %LOM
    m_AER(3)= AER_D3_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=AER(10);
    y(index)=AER(10);
    m_AER(4)= sum(x.*y)/sum(y);
% -------------------------TIGA-----------------------------%
elseif w_AER == AER(4)% Jika hasil agerasi adalah T1
    [AER_T1_Min ,AER_T1_Max] = isegitiga(AER(4),1,2,3);
    %SOM
    m_AER(1)= AER_T1_Min;
    %MOM
    m_AER(2)= (AER_T1_Max+AER_T1_Min)/2;
    %LOM
    m_AER(3)= AER_T1_Max;
    %Centroid
    x = 1:.01:3;
    y= segitiga(x, 1,2,3);
    index= y>=AER(4);
    y(index)=AER(4);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(8)% Jika hasil agerasi adalah T2
    [AER_T2_Min ,AER_T2_Max] = isegitiga(AER(8),1,2,3);
    %SOM
    m_AER(1)= AER_T2_Min;
    %MOM
    m_AER(2)= (AER_T2_Max+AER_T2_Min)/2;
    %LOM
    m_AER(3)= AER_T2_Max;
    %Centroid
    x = 1:.01:3;
    y= segitiga(x, 1,2,3);
    index= y>=AER(8);
    y(index)=AER(8);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(11)% Jika hasil agerasi adalah T3
    [AER_T3_Min ,AER_T3_Max] = isegitiga(AER(11),1,2,3);
    %SOM
    m_AER(1)= AER_T3_Min;
    %MOM
    m_Valve(2)= (AER_T3_Max+AER_T3_Min)/2;
    %LOM
    m_Valve(3)= AER_T3_Max;
    %Centroid
    x = 1:.01:3;
    y= segitiga(x, 1,2,3);
    index= y>=AER(11);
    y(index)=AER(11);
    m_AER(4)= sum(x.*y)/sum(y);
elseif w_AER == AER(12)% Jika hasil agerasi adalah T4
    [AER_T1_Min ,AER_T1_Max] = isegitiga(AER(12),2,3,3);
    %SOM
    m_AER(10)= AER_T1_Min;
    %MOM
    m_Valve(2)= (AER_T1_Max+AER_T1_Min)/2;
    %LOM
    m_Valve(3)= AER_T1_Max;
    %Centroid
    x = 2:.01:3;
    y= segitiga(x, 2,3,3);
    index= y>=AER(12);
    y(index)=AER(12);
    m_AER(4)= sum(x.*y)/sum(y);
end

% Kandel(rerata berbobot)
m_AER(5)= (AER(1)*AER_S1_Max)+(AER(2)*AER_S2_Max)+(AER(3)*AER_D1_Min)+(AER(4)*AER_T1_Min)+(AER(5)*AER_S3_Max)+(AER(6)*AER_S4_Max)+(AER(7)*AER_D2_Min)+(AER(8)*AER_T2_Min)+(AER(9)*AER_S5_Max)+(AER(10)*AER_D3_Min)+(AER(11)*AER_T3_Min)+(AER(12)*AER_T4_Min)/(AER(1)+AER(2)+AER(3)+AER(4)+AER(5)+AER(6)+AER(7)+AER(8)+AER(9)+AER(10)+AER(11)+AER(12));

% % Center of Grafity
% yp = 50*(speed(1))+25;
% x1 = 0:0.01:yp;%Skala universe of discourse
% y1= (speed(1))*trapesium(x1,0,0,yp,yp);
% x2 = yp:0.01:FastMin;
% y2= segitiga(x2,25,75,75);
% x3 = FastMin:0.01:100;
% y3= (speed(2))*trapesium(x3,62.5,62.5,100,100);
% w_Heater(6)= (sum(x1.*y1)+sum(x2.*y2)+sum(x3.*y3))/(sum(y1)+sum(y2)+sum(y3));

%====================================================================%
%% Defuzzifikasi Heater 
m_Heater = [0,0,0,0,0,0];%[Centroid,Kandel,SOM,MOM,LOM,CoG]
%====================================================================%
% -------------------------Valve OFF-----------------------------%
if w_Heater == HeaVal(4)% Jika hasil agerasi adalah V_OFF_1
    [H_OFF1_Min,H_OFF1_Max] = itrapesium(HeaVal(4),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF1_Min;
    %MOM
    m_Heater(2)= (H_OFF1_Max+H_OFF1_Min)/2;
    %LOM
    m_Heater(3)= H_OFF1_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(4);
    y(index)=HeaVal(4);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(5)% Jika hasil agerasi adalah H_OFF_2
    [H_OFF2_Min,H_OFF2_Max] = itrapesium(HeaVal(5),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF2_Min;
    %MOM
    m_Heater(2)= (H_OFF2_Max+H_OFF2_Min)/2;
    %LOM
    m_Heater(3)= H_OFF2_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(5);
    y(index)=HeaVal(5);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(6)% Jika hasil agerasi adalah H_OFF_3
    [H_OFF3_Min,H_OFF3_Max] = itrapesium(HeaVal(6),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF3_Min;
    %MOM
    m_Heater(2)= (H_OFF3_Max+H_OFF3_Min)/2;
    %LOM
    m_Heater(3)= H_OFF3_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(6);
    y(index)=HeaVal(6);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(10)% Jika hasil agerasi adalah H_OFF_4
    [H_OFF4_Min,H_OFF4_Max] = itrapesium(HeaVal(10),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF4_Min;
    %MOM
    m_Heater(2)= (H_OFF4_Max+H_OFF4_Min)/2;
    %LOM
    m_Heater(3)= H_OFF4_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(10);
    y(index)=HeaVal(10);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(11)% Jika hasil agerasi adalah H_OFF_5
    [H_OFF5_Min,H_OFF5_Max] = itrapesium(HeaVal(11),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF5_Min;
    %MOM
    m_Heater(2)= (H_OFF5_Max+H_OFF5_Min)/2;
    %LOM
    m_Heater(3)= H_OFF5_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(11);
    y(index)=HeaVal(11);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(12)% Jika hasil agerasi adalah H_OFF_6
    [H_OFF6_Min,H_OFF6_Max] = itrapesium(HeaVal(12),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF6_Min;
    %MOM
    m_Heater(2)= (H_OFF6_Max+H_OFF6_Min)/2;
    %LOM
    m_Heater(3)= H_OFF6_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(12);
    y(index)=HeaVal(12);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(13)% Jika hasil agerasi adalah H_OFF_7
    [H_OFF7_Min,H_OFF7_Max] = itrapesium(HeaVal(13),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF7_Min;
    %MOM
    m_Heater(2)= (H_OFF7_Max+H_OFF7_Min)/2;
    %LOM
    m_Heater(3)= H_OFF7_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(13);
    y(index)=HeaVal(13);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(14)% Jika hasil agerasi adalah H_OFF_8
    [H_OFF8_Min,H_OFF8_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF8_Min;
    %MOM
    m_Heater(2)= (H_OFF8_Max+H_OFF8_Min)/2;
    %LOM
    m_Heater(3)= H_OFF8_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(14);
    y(index)=HeaVal(14);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(15)% Jika hasil agerasi adalah H_OFF_9
    [H_OFF9_Min,H_OFF9_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF9_Min;
    %MOM
    m_Heater(2)= (H_OFF9_Max+H_OFF9_Min)/2;
    %LOM
    m_Heater(3)= H_OFF9_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(15);
    y(index)=HeaVal(15);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(19)% Jika hasil agerasi adalah H_OFF_10
    [H_OFF10_Min,H_OFF10_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF10_Min;
    %MOM
    m_Heater(2)= (H_OFF10_Max+H_OFF10_Min)/2;
    %LOM
    m_Heater(3)= H_OFF10_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(19);
    y(index)=HeaVal(19);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(20)% Jika hasil agerasi adalah H_OFF_11
    [H_OFF11_Min,H_OFF11_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF11_Min;
    %MOM
    m_Heater(2)= (H_OFF11_Max+H_OFF11_Min)/2;
    %LOM
    m_Heater(3)= H_OFF11_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(20);
    y(index)=HeaVal(20);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(21)% Jika hasil agerasi adalah H_OFF_12
    [H_OFF12_Min,H_OFF12_Max] = itrapesium(HeaVal(14),0,0,0.4,0.6);
    %SOM
    m_Heater(1)= H_OFF12_Min;
    %MOM
    m_Heater(2)= (H_OFF12_Max+H_OFF12_Min)/2;
    %LOM
    m_Heater(3)= H_OFF12_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(21);
    y(index)=HeaVal(21);
    m_Heater(4)= sum(x.*y)/sum(y); 
% -------------------------Valve ON-----------------------------%
elseif w_Heater == HeaVal(1)% Jika hasil agerasi adalah H_ON_1
    [H_ON1_Min,H_ON1_Max] = itrapesium(HeaVal(1),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON1_Min;
    %MOM
    m_Heater(2)= (H_ON1_Max+H_ON1_Min)/2;
    %LOM
    m_Heater(3)= H_ON1_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(1);
    y(index)=HeaVal(1);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(2)% Jika hasil agerasi adalah H_ON_2
    [H_ON2_Min,H_ON2_Max] = itrapesium(HeaVal(2),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON2_Min;
    %MOM
    m_Heater(2)= (H_ON2_Max+H_ON2_Min)/2;
    %LOM
    m_Heater(3)= H_ON2_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(2);
    y(index)=HeaVal(2);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(3)% Jika hasil agerasi adalah H_ON_3
    [H_ON3_Min,H_ON3_Max] = itrapesium(HeaVal(3),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON3_Min;
    %MOM
    m_Heater(2)= (H_ON3_Max+H_ON3_Min)/2;
    %LOM
    m_Heater(3)= H_ON3_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(3);
    y(index)=HeaVal(3);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(7)% Jika hasil agerasi adalah H_ON_4
    [H_ON4_Min,H_ON4_Max] = itrapesium(HeaVal(7),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON4_Min;
    %MOM
    m_Heater(2)= (H_ON4_Max+H_ON4_Min)/2;
    %LOM
    m_Heater(3)= H_ON4_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(7);
    y(index)=HeaVal(7);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(8)% Jika hasil agerasi adalah H_ON_5
    [H_ON5_Min,H_ON5_Max] = itrapesium(HeaVal(8),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON5_Min;
    %MOM
    m_Heater(2)= (H_ON5_Max+H_ON5_Min)/2;
    %LOM
    m_Heater(3)= H_ON5_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(8);
    y(index)=HeaVal(8);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(9)% Jika hasil agerasi adalah H_ON_6
    [H_ON6_Min,H_ON6_Max] = itrapesium(HeaVal(9),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON6_Min;
    %MOM
    m_Heater(2)= (H_ON6_Max+H_ON6_Min)/2;
    %LOM
    m_Heater(3)= H_ON6_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(9);
    y(index)=HeaVal(9);
    m_Heater(4)= sum(x.*y)/sum(y);
elseif w_Heater == HeaVal(16)% Jika hasil agerasi adalah H_ON_7
    [H_ON7_Min,H_ON7_Max] = itrapesium(HeaVal(16),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON7_Min;
    %MOM
    m_Heater(2)= (H_ON7_Max+H_ON7_Min)/2;
    %LOM
    m_Heater(3)= H_ON7_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(16);
    y(index)=HeaVal(16);
    m_Heater(4)= sum(x.*y)/sum(y);      
elseif w_Heater == HeaVal(17)% Jika hasil agerasi adalah H_ON_8
    [H_ON8_Min,H_ON8_Max] = itrapesium(HeaVal(17),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON8_Min;
    %MOM
    m_Heater(2)= (H_ON8_Max+H_ON8_Min)/2;
    %LOM
    m_Heater(3)= H_ON8_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(17);
    y(index)=HeaVal(17);
    m_Heater(4)= sum(x.*y)/sum(y);    
elseif w_Heater == HeaVal(18)% Jika hasil agerasi adalah H_ON_9
    [H_ON9_Min,H_ON9_Max] = itrapesium(HeaVal(18),0.4,0.6,1,1);
    %SOM
    m_Heater(1)= H_ON9_Min;
    %MOM
    m_Heater(2)= (H_ON9_Max+H_ON8_Min)/2;
    %LOM
    m_Heater(3)= H_ON9_Max;
    %Centroid
    x = 0:.01:1;
    y= segitiga(x, 0,0,1);
    index= y>=HeaVal(18);
    y(index)=HeaVal(18);
    m_Heater(4)= sum(x.*y)/sum(y);    
end
    % Kandel(rerata berbobot)
m_Heater(5)= ((HeaVal(1)*H_ON1_Min)+(HeaVal(2)*H_ON2_Min)+(HeaVal(3)*H_ON3_Min)+(HeaVal(4)*H_OFF1_Max)+(HeaVal(5)*H_OFF2_Max)+(HeaVal(6)*H_OFF3_Max)+(HeaVal(7)*H_ON4_Min)+(HeaVal(8)*H_ON5_Min)+(HeaVal(9)*H_ON6_Min)+(HeaVal(10)*H_OFF4_Max)+(HeaVal(11)*H_OFF5_Max)+(HeaVal(12)*H_OFF6_Max)+(HeaVal(13)*H_OFF7_Max)+(HeaVal(14)*H_OFF8_Max)+(HeaVal(15)*H_OFF9_Max)+(HeaVal(16)*H_ON7_Min)+(HeaVal(17)*H_ON8_Min)+(HeaVal(18)*H_ON9_Min)+(HeaVal(19)*H_OFF10_Max)+(HeaVal(20)*H_OFF11_Max)+(HeaVal(21)*H_OFF11_Max))/(HeaVal(1)+HeaVal(2)+HeaVal(3)+HeaVal(4)+HeaVal(5)+HeaVal(6)+HeaVal(7)+HeaVal(8)+HeaVal(9)+HeaVal(10)+HeaVal(11)+HeaVal(12)+HeaVal(13)+HeaVal(14)+HeaVal(15)+HeaVal(16)+HeaVal(17)+HeaVal(18)+HeaVal(19)+HeaVal(20)+HeaVal(20)+HeaVal(21));

% % Center of Grafity
% yp = 50*(speed(1))+25;
% x1 = 0:0.01:yp;%Skala universe of discourse
% y1= (speed(1))*trapesium(x1,0,0,yp,yp);
% x2 = yp:0.01:FastMin;
% y2= segitiga(x2,25,75,75);
% x3 = FastMin:0.01:100;
% y3= (speed(2))*trapesium(x3,62.5,62.5,100,100);
% w_Heater(6)= (sum(x1.*y1)+sum(x2.*y2)+sum(x3.*y3))/(sum(y1)+sum(y2)+sum(y3));

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
%% Plot Hasil inferensi pH
figure(1), hold on
% Asam
plot(pH,D_Keasaman(1),'ok')
text(pH, D_Keasaman(1), strcat(['(', num2str(pH), ', ', num2str(D_Keasaman(1)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_pH1 =0:.01:pH;
y_pH1 =0:.01:D_Keasaman(1);
plot(x_pH1,D_Keasaman(1).*ones(size(x_pH1)),'-.g')
plot(pH.*ones(size(y_pH1)),y_pH1,'-.k')
% Neteral
plot(pH,D_Keasaman(2),'ok')
text(pH,D_Keasaman(2), strcat(['(', num2str(pH), ', ',num2str(D_Keasaman(2)),')','->Rule 2, 12, 15, 22, 24, 26, 29, 31, 33, 40, 43, 50']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_pH2 =0:.01:pH;
y_pH2 =0:.01:D_Keasaman(2);
plot(x_pH2,D_Keasaman(2).*ones(size(x_pH2)),'-.m')
plot(pH.*ones(size(y_pH2)),y_pH2,'-.k')
% Basa
plot(pH,D_Keasaman(3),'ok')
text(pH,D_Keasaman(3), strcat(['(', num2str(pH), ', ',num2str(D_Keasaman(3)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_pH3 =0:.01:pH;
y_pH3 =0:.01:D_Keasaman(3);
plot(x_pH3,D_Keasaman(3).*ones(size(x_pH3)),'-.m')
plot(pH.*ones(size(y_pH3)),y_pH3,'-.k')
hold off


%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%
%==================PLOT HASIL FUZZY LOGOC CONTROL MAMDANI========================%
%% Plot Hasil inferensi pH
figure(1), hold on
%====================================================================%
% Asam
plot(pH,D_Keasaman(1),'ok')
text(pH,D_Keasaman(1), strcat(['(', num2str(pH), ', ', num2str(D_Keasaman(1)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'b');
x_pH1 =0:.01:pH;
y_pH1 =0:.01:D_Keasaman(1);
plot(x_pH1,D_Keasaman(1).*ones(size(x_pH1)),'-.g')
plot(pH.*ones(size(y_tu1)),y_tu1,'-.k')
% Sedang
plot(pH,D_Keasaman(2),'ok')
text(pH,D_Keasaman(2), strcat(['(', num2str(pH), ', ',num2str(D_Keasaman(2)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');
x_pH2 =0:.01:pH;
y_pH2 =0:.01:D_Keasaman(2);
plot(x_pH2,D_Keasaman(2).*ones(size(x_pH2)),'-.m')
plot(tu.*ones(size(y_pH2)),y_pH2,'-.k')
% Tinggi
plot(pH,D_Keasaman(3),'ok')
text(pH,D_Keasaman(3), strcat(['(', num2str(pH), ', ',num2str(D_Keasaman(3)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');
x_pH3 =0:.01:tu;
y_pH3 =0:.01:D_Keasaman(3);
plot(x_pH3,D_Keasaman(3).*ones(size(x_pH3)),'-.m')
plot(pH.*ones(size(y_pH3)),y_pH3,'-.k')
hold off
%====================================================================%
%% Plot Hasil inferensi Suhu
figure(2), hold on
%====================================================================%
% Dingin
plot(tp,temperature(1),'ok')
text(tp,temperature(1), strcat(['(', num2str(tp), ', ',num2str(temperature(1)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');%Ragu-Ragu
x_tp2 =0:.01:tp;
y_tp2 =0:.01:temperature(1);
plot(x_tp2,temperature(1).*ones(size(x_tp2)),'-.m')
plot(tp.*ones(size(y_tp2)),y_tp2,'-.k')
% Sedang
plot(tp,temperature(2),'ok')
text(tp,temperature(2), strcat(['(', num2str(tp), ', ',num2str(temperature(2)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');%Ragu-Ragu
x_tp3 =0:.01:tp;
y_tp3 =0:.01:temperature(2);
plot(x_tp3,temperature(2).*ones(size(x_tp3)),'-.m')
plot(tp.*ones(size(y_tp3)),y_tp3,'-.k')
% Panas
plot(tp,temperature(2),'ok')
text(tp,temperature(2), strcat(['(', num2str(tp), ', ',num2str(temperature(2)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');%Ragu-Ragu
x_tp3 =0:.01:tp;
y_tp3 =0:.01:temperature(2);
plot(x_tp3,temperature(2).*ones(size(x_tp3)),'-.m')
plot(tp.*ones(size(y_tp3)),y_tp3,'-.k')
hold off
%====================================================================%
%% Plot Hasil inferensi Turbidity
figure(3), hold on
%====================================================================%
% Rendah
plot(tu,turbidity(1),'ok')
text(tu, turbidity(1), strcat(['(', num2str(tu), ', ', num2str(turbidity(1)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'b');
x_tu1 =0:.01:tu;
y_tu1 =0:.01:turbidity(1);
plot(x_tu1,turbidity(1).*ones(size(x_tu1)),'-.g')
plot(tu.*ones(size(y_tu1)),y_tu1,'-.k')
% Sedang
plot(tu,turbidity(2),'ok')
text(tu,turbidity(2), strcat(['(', num2str(tu), ', ',num2str(turbidity(2)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');%Ragu-Ragu
x_tu2 =0:.01:tu;
y_tu2 =0:.01:turbidity(2);
plot(x_tu2,turbidity(2).*ones(size(x_tu2)),'-.m')
plot(tu.*ones(size(y_tu2)),y_tu2,'-.k')
% Tinggi
plot(tu,turbidity(3),'ok')
text(tu,turbidity(3), strcat(['(', num2str(tu), ', ',num2str(turbidity(3)),')']),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'y');
x_tu3 =0:.01:tu;
y_tu3 =0:.01:turbidity(3);
plot(x_tu3,turbidity(3).*ones(size(x_tu3)),'-.m')
plot(tu.*ones(size(y_tu3)),y_tu3,'-.k')
hold off
%====================================================================%
figure(4), hold on
%% Plot Hasil inferensi Error DO
%====================================================================%
%Zero
plot(err,error(1),'ok')
text(err, error(1), strcat(['(', num2str(err), ', ', num2str(error(1)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_err1 =0:.01:err;
y_err1 =0:.01:error(1);
plot(x_err1,error(1).*ones(size(x_err1)),'-.g')
plot(err.*ones(size(y_err1)),y_err1,'-.k')
%OFF_H
plot(err,error(2),'ok')
text(err, error(2), strcat(['(', num2str(err), ', ', num2str(error(2)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_err2 =0:.01:err;
y_err2 =0:.01:error(2);
plot(x_err2 ,error(2).*ones(size(x_err2 )),'-.g')
plot(err.*ones(size(y_err2)),y_err2,'-.k')
%Medium
plot(err,error(3),'ok')
text(err, error(3), strcat(['(', num2str(err), ', ', num2str(error(3)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_err3 =0:.01:err;
y_err3 =0:.01:error(3);
plot(x_err3 ,error(3).*ones(size(x_err3 )),'-.g')
plot(err.*ones(size(y_err3)),y_err3,'-.k')
%ON_H
plot(err,error(4),'ok')
text(err, error(4), strcat(['(', num2str(err), ', ', num2str(error(4)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_err4 =0:.01:err;
y_err4 =0:.01:error(4);
plot(x_err4 ,error(4).*ones(size(x_err4 )),'-.g')
plot(err.*ones(size(y_err4)),y_err4,'-.k')
hold off
%====================================================================%
%% Plot Hasil inferensi Saturation
figure(5), hold on
%====================================================================%
%OFF_H
plot(sat,saturasion(1),'ok')
text(sat, saturasion(1), strcat(['(', num2str(sat), ', ', num2str(saturasion(1)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_sat1 =0:.01:sat;
y_sat1 =0:.01:saturasion(1);
plot(x_sat1,saturasion(1).*ones(size(x_sat1)),'-.g')
plot(sat.*ones(size(y_sat1)),y_sat1,'-.k')
%Med
plot(sat,saturasion(2),'ok')
text(sat, saturasion(2), strcat(['(', num2str(sat), ', ', num2str(saturasion(2)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_sat2 =0:.01:sat;
y_sat2 =0:.01:saturasion(2);
plot(x_sat2 ,saturasion(2).*ones(size(x_sat2 )),'-.g')
plot(sat.*ones(size(y_sat2)),y_sat2,'-.k')
%ON_H
plot(sat,saturasion(3),'ok')
text(sat, saturasion(3), strcat(['(', num2str(sat), ', ', num2str(saturasion(3)), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_sat3 =0:.01:sat;
y_sat3 =0:.01:saturasion(3);
plot(x_sat3 ,saturasion(3).*ones(size(x_sat3 )),'-.g')
plot(sat.*ones(size(y_sat3)),y_sat3,'-.k')
hold off
%====================================================================%
%%==========================OUTPUT==================================%%
%====================================================================%
% Output Valve
figure(6), hold on
%====================================================================%
% ------------- VALVE ON -------------- %
V_ON_Min = max([V_ON1_Min, V_ON2_Min, V_ON3_Min, V_ON4_Min, V_ON5_Min, V_ON6_Min, V_ON7_Min, V_ON8_Min, V_ON9_Min, V_ON10_Min, V_ON11_Min, V_ON12_Min, V_ON13_Min, V_ON14_Min, V_ON15_Min]);
Val_ON = [7,8,9,10,11,13,14];
plot(V_ON_Min, max(HeaVal(Val_ON)), 'ok')
text(V_ON_Min, max(HeaVal(Val_ON)), strcat(['(', num2str(V_ON_Min), ', ', num2str(max(HeaVal(Val_ON))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_V_OFF = 0:.01:V_ON_Min;
y_V_OFF = 0:.01:max(HeaVal(Val_ON));
plot(x_V_OFF, max(HeaVal(Val_ON)).*ones(size(x_V_OFF)), '-.g')
plot(V_ON_Min.*ones(size(y_V_OFF)), y_V_OFF, '-.k')
% ------------- VALVE OFF -------------- %
V_OFF_Max = min([V_OFF1_Max, V_OFF2_Max, V_OFF3_Max, V_OFF4_Max, V_OFF5_Max, V_OFF6_Max]);
Val_OFF = [1,2,3,4,5,6,9,12,15,16,17,18,19,20,21];
plot(V_OFF_Max, min(HeaVal(Val_OFF)), 'ok')
text(V_OFF_Max, min(HeaVal(Val_OFF)), strcat(['(', num2str(V_OFF_Max), ', ', num2str(min(HeaVal(Val_OFF))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_V_OFF = 0:.01:V_OFF_Max;
y_V_OFF = 0:.01:min(HeaVal(Val_OFF));
plot(x_V_OFF, min(HeaVal(Val_OFF)).*ones(size(x_V_OFF)), '-.g')
plot(y_V_OFF.*ones(size(y_V_OFF)), y_V_OFF, '-.k')
hold off
%====================================================================%
% Output Aerator
figure(7), hold on
%====================================================================%
% ------------- Zero (Satu) -------------- %
%AER_Z_Max = min([AER_Z1_Max, AER_Z2_Max, AER_Z3_Max]);
%plot(AER_Z_Max, min(AER(1:3)), 'ok')
%text(AER_Z_Max, min(AER(1:3)), strcat(['(', num2str(AER_Z_Max), ', ', num2str(min(Valve(1:3))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
%x_Z = 0:.01:AER_Z_Max;
%y_Z = 0:.01:min(AER(1:3));
%plot(x_Z, min(AER(1:3)).*ones(size(x_Z)), '-.g')
%plot(AER_Z_Max.*ones(size(y_Z)), y_Z, '-.k')
% ------------- Low (Satu) -------------- %
AER_L_Max = min([AER_S1_Max, AER_S2_Max, AER_S3_Max, AER_S4_Max, AER_S5_Max]);
AER_Satu = [1,2,5,6,9];
plot(AER_L_Max, min(AER(AER_Satu)), 'ok')
text(AER_L_Max, min(AER(AER_Satu)), strcat(['(', num2str(AER_L_Max), ', ', num2str(min(AER(AER_Satu))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_S = 0:.01:AER_L_Max;
y_S = 0:.01:min(AER(AER_Satu));
plot(x_S, min(AER(AER_Satu)).*ones(size(x_S)), '-.g')
plot(AER_L_Max.*ones(size(y_S)), y_S, '-.k')
% ------------- Medium (Dua) -------------- %
AER_M_Min = max([AER_D1_Min, AER_D2_Min, AER_D3_Min]);
AER_Dua = [3,7,10];
plot(AER_M_Min, max(AER(AER_Dua)), 'ok')
text(AER_M_Min, max(AER(AER_Dua)), strcat(['(', num2str(AER_M_Min), ', ', num2str(max(AER(AER_Dua))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_M = 0:.01:AER_M_Min;
y_M = 0:.01:max(AER(AER_Dua));
plot(x_M, max(AER(AER_Dua)).*ones(size(x_M)), '-.g')
plot(AER_M_Min.*ones(size(y_M)), y_M, '-.k')
% ------------- High (Tiga) -------------- %
AER_H_Min = max([AER_T1_Min, AER_T2_Min, AER_T3_Min, AER_T4_Min]);
AER_Tiga = [4,8,11,12];
plot(AER_H_Min, max(AER(AER_Tiga)), 'ok')
text(AER_H_Min, max(AER(AER_Tiga)), strcat(['(', num2str(AER_H_Min), ', ', num2str(max(AER(AER_Tiga))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_H = 0:.01:AER_H_Min;
y_H = 0:.01:max(AER(AER_Tiga));
plot(x_H, max(AER(AER_Tiga)).*ones(size(x_H)), '-.g')
plot(AER_H_Min.*ones(size(y_H)), y_H, '-.k')
hold off
%====================================================================%
% Output Heater
figure(8), hold on
%====================================================================%
% ------------- HEATER OFF -------------- %
H_OFF_Max = min([H_OFF1_Max, H_OFF2_Max, H_OFF3_Max, H_OFF4_Max, H_OFF5_Max, H_OFF6_Max, H_OFF7_Max, H_OFF6_Max, H_OFF9_Max, H_OFF10_Max, H_OFF11_Max, H_OFF12_Max]);
Hea_OFF = [4,5,6,10,11,12,13,14,15,19,20,21];
plot(H_OFF_Max, min(HeaVal(Hea_OFF)), 'ok')
text(H_OFF_Max, min(HeaVal(Hea_OFF)), strcat(['(', num2str(H_OFF_Max), ', ', num2str(min(HeaVal(Hea_OFF))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_H_OFF = 0:.01:H_OFF_Max;
y_H_OFF = 0:.01:min(HeaVal(Hea_OFF)); 
plot(x_H_OFF, min(HeaVal(Hea_OFF)).*ones(size(x_H_OFF)), '-.g')
plot(H_OFF_Max.*ones(size(y_H_OFF)), y_H_OFF, '-.k')
% ------------- HEATER ON -------------- %
H_ON_Min = max([H_ON1_Min, H_ON2_Min, H_ON3_Min, H_ON4_Min, H_ON5_Min, H_ON6_Min, H_ON7_Min, H_ON8_Min, H_ON9_Min]);
Hea_ON = [1,2,3,7,8,9,16,17,18]; 
plot(H_ON_Min, max(HeaVal(Hea_ON)), 'ok')
text(H_ON_Min, max(HeaVal(Hea_ON)), strcat(['(', num2str(H_ON_Min), ', ', num2str(max(HeaVal(Hea_ON))), ')']), 'FontWeight', 'bold', 'FontSize', 9, 'Color', 'k');
x_H_ON = 0:.01:H_ON_Min;
y_H_ON = 0:.01:max(HeaVal(Hea_ON));
plot(x_H_ON, max(HeaVal(Hea_ON)).*ones(size(x_H_ON)), '-.g')
plot(H_ON_Min.*ones(size(y_H_ON)), y_H_ON, '-.k')
hold off
%====================================================================%


%%========================== Menghitung Hasil Deffuzyfikasi===========================%%
% %% Hasil Defuzzifikasi
% figure(3), hold on
% yC =0:.1:1;
% plot(s(1).*ones(size(yC)),yC,'r')% SOM
% text(s(1)-3,0.97, strcat('SOM'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r')
% plot(s(2).*ones(size(yC)),yC,'r')% MOM
% text(s(2)-3,0.97, strcat('MOM'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r')
% plot(s(3).*ones(size(yC)),yC,'r')% LOM
% text(s(3)-3,0.97, strcat('LOM'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r')
% plot(s(4).*ones(size(yC)),yC,'r')% Centroid
% text(s(4)-5,0.35, strcat('Centroid'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r')
% plot(s(5).*ones(size(yC)),yC,'r')% Rerata Berbobot Kandel
% text(s(5)-5,0.55, strcat('Kandel'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r')
% plot(s(6).*ones(size(yC)),yC,'r')% Center of Gravity
% text(s(6)-5,0.45, strcat('CoGrav'),'FontWeight', 'bold', 'FontSize', 9, 'Color', 'r')
% hold off
