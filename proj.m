clc; clear all; close all;
in1 = input('Choose which kinds of PSK modulation: \n1: 2PSK \n2: 4PSK \n3: 2ASK \n4: 4ASK\nYour option is:', 's')
in2 = input('Input hexadecimal string: ','s');   %Input vector signal in terms of hexadecimal 
if      in1=='1' ASK2(in2);
elseif  in1=='2' ASK4(in2);
elseif  in1=='3' PSK2(in2);
elseif  in1=='4' PSK4(in2);
else    fprintf('Wrong Input');
end
spectrum(in1)
%periodogram(in1)