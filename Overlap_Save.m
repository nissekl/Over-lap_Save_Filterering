input_signal = load('noisy.txt');
filter = load('lpf.txt');
size(input_signal);
size(filter);
%Convolution
y1 = conv(input_signal, filter);

%overlape-save
y2=[];
%front pad L-1
front_pad = zeros(1,126);
back_pad = zeros(1,571);
signal_after_pad = [front_pad, input_signal,back_pad];
data_size=size(signal_after_pad);
for i=1:14
          if i == 14
            tem_signal = signal_after_pad(1:end);
            dft_stuff = [fft(tem_signal).* fft(filter,1024)];
            tem_y2 = ifft(dft_stuff);
            y2 = [y2, tem_y2(127:579)];
          else
            tem_signal = signal_after_pad(1:1024);
            signal_after_pad = signal_after_pad(899:end); 
            dft_stuff = [fft(tem_signal).* fft(filter,1024)];
            tem_y2 = ifft(dft_stuff);
            y2 = [y2, tem_y2(127:end)];
          end
end
size(signal_after_pad)


%multiply = fft_input.*fft_filter
%y2 = ifft(,1024);
size(y1)
size(y2)
max(abs(y1-y2))
soundsc(y2)