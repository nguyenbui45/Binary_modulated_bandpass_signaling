function PSK2(in)
%% 2-PSK Modulation 
N = 1; % number of bits used for 2-PSK 
length = 4*size(in,2);                    %Determine the length of input signal 
disp(length)
input = hexToBinaryVector(in,length);     %Convert the hexadecimal type into binary type

%% Initialize variables
t2 = 0: 0.05 : 2*pi;   % 1 bit
t  = 0: 0.05 : 2*N*pi-0.05;  % 1 symbol ( 1 bit)
t = t/N;

%Declare output amplitude and phase for each position of 2-PSK transmitter

signal = [ 1 0 ;
          -1 0];
           
bit0 = convertBitToCosWave(signal(1,:),t);   %QIC = 0
bit1 = convertBitToCosWave(signal(2,:),t);   %QIC = 1

%PSK
f1 = 1;
tp = 0:1/30:1-1/30;
sa1=sin(2*pi*f1*t);
E1=sum(sa1.^2);
sp0=-sin(2*pi*f1*tp)/sqrt(E1);
sp1=sin(2*pi*f1*t)/sqrt(E1);

%% Modulating
lengthbit = size(t,2);      %Return the length of dimension of t 
lengthbit2 = size(t2,2);    %Return the length of dimension of t2

bit0_0 = zeros(1,lengthbit2);   %create vector contains 'lengthbit2' 0's elements
bit1_0 = ones(1,lengthbit2);    %create vector contains 'lengthbit2' 1's elements

disp(lengthbit);
disp(lengthbit2);
%mod_sig_c is the array elements for drawing input signal
mod_sig_c = zeros(1,length*lengthbit2);    %Create 0's vector

for i = 0:length-1            %set up data for drawing input signal
    if input(1,i+1) == 1            %if the bit of input signal is 1, then all elements = 1
        mod_sig_c(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit1_0;  
    else                            %if the bit of input signal is 0, then all elements = 0
        mod_sig_c(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit0_0;
    end
end

%mod_sig is the array elements for drawing 2-PSK 
mod_sig = zeros(1,length*lengthbit2);    %Create 0's vector
for i = 0:1:length-1      %Each combination of 1 input bit stands for each value of 2-PSK
    if input(1,i+1:i+1) == [0]
        i = i/1;
        mod_sig(1,(i)*lengthbit+1:(i+1)*lengthbit) = 1.41*bit0;
    else
        i = i/1;
        mod_sig(1,i*lengthbit+1:(i+1)*lengthbit) = 1.41*bit1;
    end
end
%AWGN (ADD WHITE GAUSSIAN NOISE)
for snr=0:20
    mod_sign=awgn(mod_sig,snr);
    %DETECTION
    %P=[];
    for i=1:length
        %PSK Detection
        %if sum(sp1.*mod_sign(1+30*(i-1):30*i))>0.5
        %    P=[P 1];
        %else
        %    P=[P 0];
        %end
    end
    
    %BER (BIT RATE ERROR)
    %errP=0;
    %for i=1:length
    %    if P(i)==input(i)
    %        errP=errP;
    %    else
    %        errP=errP+1;
    %    end
    %end
    %BER_P(snr+1)=errP/length;
end

figure(4)
subplot(411)
stairs(0:7,[input(1:7) input(7)],'linewidth',1.5)
axis([0 10 -0.5 1.5]);grid on
title('Received signal after AWGN Channel')
subplot(412)
tb=0:1/30:10-1/30;
plot(tb, mod_sign(1:10*30),'b','linewidth',1.5)
title('Received PSK signal');grid on
subplot(413)
%% Demodulating
output = []
for i = 0:1:length/1-1      
    if     mod_sig(1,(i)*lengthbit+1:(i+1)*lengthbit) == 1.41*bit0
        output(1, i*1+1:(i+1)*1) = [0]
    else
        output(1, i*1+1:(i+1)*1) = [1]
    end
end

%demod_sig is the array elements for demodulate signal
demod_sig = zeros(1,length*lengthbit2);    %Create 0's vector

for i = 0:length-1            %set up data for drawing input signal
    if output(1,i+1) == 1            %if the bit of input signal is 1, then all elements = 1
        demod_sig(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit1_0;  
    else                            %if the bit of input signal is 0, then all elements = 0
        demod_sig(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit0_0;
    end
end

%% Plot
subplot(3,1,1);
plot(mod_sig_c,'b');
ylim([-1.5 1.5]);
grid on;
ax = gca;
xlim([0 size(mod_sig,2)]);
ax.XTick = [0:lengthbit2:size(mod_sig,2)];
ax.XTickLabel = {'|'};
xlabel('time(ms)');
ylabel('amplitude(volt)');
title('Input Signal');

subplot(3,1,2);
plot(mod_sig,  'r') %);length*lengthbit,
ylim([-1.5 1.5]);
grid on;
ax = gca;
xlim([0 size(mod_sig,2)]);
ax.XTick = [0:lengthbit2:size(mod_sig,2)];
ax.XTickLabel = {'|'};
xlabel('time(ms)');
ylabel('amplitude(volt)');
title('2-PSK modulated signal');

subplot(3,1,3);
plot(demod_sig,'b');
ylim([-1.5 1.5]);
grid on;
ax = gca;
xlim([0 size(mod_sig,2)]);
ax.XTick = [0:lengthbit2:size(mod_sig,2)];
ax.XTickLabel = {'|','',''};
xlabel('time(ms)');
ylabel('amplitude(volt)');
title('Demodulated Signal');

%% Constellation 
inphase = [ 0  ]; 
quadr =   [ 1.41     ];
inphase = [inphase; -inphase];
inphase = inphase(:);
quadr = [quadr; -quadr];
quadr = quadr(:);
refConst = inphase + 1i*quadr;

figure(2)
plot(refConst,'*');
ylim([-3 3]); 
xlim([-3 3]); grid on; 
title('2-PSK constellation');
xlabel('In-Phase Amplitude');
ylabel('Quadrature Amplitude');
hold on;


end