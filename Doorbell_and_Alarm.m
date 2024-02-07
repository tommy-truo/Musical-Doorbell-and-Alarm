% Author: Tommy Truong
% Date: 1/23/2024
% Description: FINAL Musical Doorbell and Alarm

% HOUSEKEEPING
clc, clear, close

%Initialize Arduino
ardy = arduino("com3", "Uno");
disp("Doorbell and Alarm Start")
disp("Press BUTTON1 for DOORBELL")
disp("Press BUTTON2 for ALARM")



%All frequencies for song notes
noteFreqs = {2637, 2637, 0, 2637, ...
    0, 2093, 2637, 0, ...
    3136, 0, 0, 0, ...
    1568, 0, 0, 0, ...
    ...
    2093, 0, 0, 1568, ...
    0, 0, 1319, 0, ...
    0, 1760, 0, 1976, ...
    0, 1865, 1760, 0};

noteDuration = 0.07;

%Constantly checks for input
while true
    D12 = readDigitalPin(ardy, "D12");
    D13 = readDigitalPin(ardy, "D13");
    
    if D12 == true
        disp("Playing DOORBELL MUSIC")
        for current_freq = 1:length(noteFreqs)            
            %Plays current note
            playTone(ardy, "D11", noteFreqs{current_freq});
            
            %Turns on GREEN LED if tone is playing
            if noteFreqs{current_freq} > 0
                writeDigitalPin(ardy, "D9", 1);
            end
            
            pause(noteDuration);

            %Turns off GREEN LED
            writeDigitalPin(ardy, "D9", 0);
            
            %Stops playing note
            playTone(ardy, "D11", 0);
        end
    end

    if D13 == true
        disp("Playing ALARM")
        for i = 1:6
            playTone(ardy, "D11", 1175);

            %Turns on RED LED
            writeDigitalPin(ardy, "D10", 1);

            pause(0.6);

            %Turns off RED LED
            writeDigitalPin(ardy, "D10", 0);
            
            %Stops playing tone
            playTone(ardy, "D11", 0);

            pause(0.3);
        end
    end
end