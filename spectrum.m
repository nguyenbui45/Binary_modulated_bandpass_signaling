function spectrum(in1)
%% BPSK
if in1 == '1'
    f = 3
    t = 0:0.02:1
    y = cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    figure
    stem (f_x, fft_x)
    title('Spectrum of 2-PSK');
    xlabel('Frequency');
    ylabel('Amplitude');

%% QPSK
elseif in1 == '2'
    f = 6
    t = 0:0.02:1
    y = cos(2*pi*f*t+pi/2)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    figure
    stem (f_x, fft_x)
    title('Spectrum of 4-PSK');
    xlabel('Frequency');
    ylabel('Amplitude');

%% 2-ASK
elseif in1 == '3'
    f = 3
    t = 0:0.02:1
    y = cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    figure
    subplot(2,1,1)
    stem (f_x, fft_x)
    title('Spectrum of 2-ASK for input bit 0');
    xlabel('Frequency');
    ylabel('Amplitude');
    
    f = 3
    t = 0:0.02:1
    y = 2*cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    subplot(2,1,2)
    stem (f_x, fft_x)
    title('Spectrum of 2-ASK for input bit 1');
    xlabel('Frequency');
    ylabel('Amplitude');
    
%% 4-ASK
elseif in1 == '4'
    f = 6
    t = 0:0.02:1
    y = cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    figure
    subplot(4,1,1)
    stem (f_x, fft_x)
    title('Spectrum of 2-ASK for input bit 00');
    xlabel('Frequency');
    ylabel('Amplitude');
    
    f = 6
    t = 0:0.02:1
    y = 2*cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    subplot(4,1,2)
    stem (f_x, fft_x)
    title('Spectrum of 4-ASK for input bit 01');
    xlabel('Frequency');
    ylabel('Amplitude');
    
    f = 6
    t = 0:0.02:1
    y = 3*cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    subplot(4,1,3)
    stem (f_x, fft_x)
    title('Spectrum of 4-ASK for input bit 10');
    xlabel('Frequency');
    ylabel('Amplitude');
    
    f = 6
    t = 0:0.02:1
    y = 4*cos(2*pi*f*t)
    len = length(y)-1
    f_x = -25:1:25
    fft_x = fftshift(abs(fft(y)))/len
    subplot(4,1,4)
    stem (f_x, fft_x)
    title('Spectrum of 4-ASK for input bit 11');
    xlabel('Frequency');
    ylabel('Amplitude');
    
%% Wrong input
else
    return
end
end