running = true;
global manual 
manual= true;
turn = true;
global wait;
wait = false;
global drivingState; 
drivingState = 0;
lastColor = 0;
global key
global pickupState;
pickupState = 0;
InitKeyboard();


while running
    color = brick.ColorCode(2);

    distance = brick.UltrasonicDist(3);

    disp("Color: " + color);
    disp("Distance: " + distance);
    disp("State: " + drivingState);
    disp("Pickup: " + pickupState);
    disp("Manual " + manual);


    
    if key == 'm'
            if manual == true
                manual = false;
            else
                manual = true;
            end
            brick.StopAllMotors();
        end

    if manual == true
        if key == 'w'
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D',-50);
        end
        if key == 's'
            brick.MoveMotor('A', 50);
            brick.MoveMotor('D',50);
        end
        if key == 'a'
            brick.MoveMotor('A', 50);
            brick.MoveMotor('D',-50);
        end
        if key == 'd'
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D',50);
        end
        if key == 'k'
            brick.MoveMotor('C', 25);
        end
        if key == 'l'
            brick.MoveMotor('C', -25);
        end
        if key == 0
            brick.StopMotor('A');
            brick.StopMotor('D');
            brick.StopMotor('C');
        end
        if key == 'q'
            brick.StopAllMotors();
            running = false;
            break;
        end
    else
        if key == 'q'
            brick.StopAllMotors();
            running = false;
            break;
        end
        if color == 5 && lastColor ~= 5 && wait == false
            lastColor = 5;
            brick.StopAllMotors();
            stopped = true;
            drivingState = -1;
            customTimer(.5, 6);
            wait = true;
        end
        if color == 2 && lastColor ~= 2 
            lastColor = 2
            if pickupState == 0
                setManual(0);
            end
        end
        if color == 4 && lastColor ~= 4
            %%lastColor = 4
            %%setManual(pickupState);
        end
        if color == 3 && lastColor ~= 3
            lastColor = 3;
            if pickupState == 1
                setManual(1);
            end
        end
        switch(drivingState)
            case -1
                continue;
            case 0
                if brick.TouchPressed(1) == true && wait == false
                    brick.StopAllMotors();
                    wait = true;
                    drivingState = -1;
                    customTimer(.25, 1);
                end
                if distance > 50 && brick.TouchPressed(1) == false && wait == false && color ~= 55
                    wait = true
                    drivingState = -1;
                    customTimer(.5, 4);
                end
                if wait == false
                    brick.MoveMotor('A', -50);
                    brick.MoveMotor('D',-50);
                end
            case 1
                brick.MoveMotor('A', 50);
                brick.MoveMotor('D',50);
                drivingState = -1;
                customTimer(.25, 2);
            case 2 
                brick.StopAllMotors();
                drivingState = -1;
                customTimer(.25, 3);
            case 3
                if distance < 50
                    brick.MoveMotor('A', -50);
                    brick.MoveMotor('D',50);
                else 
                    brick.MoveMotor('A',50);
                    brick.MoveMotor('D',-50);
                end
                drivingState = -1;
                customTimer(.85, 6);
            case 4
                brick.StopAllMotors();
                drivingState = -1;
                customTimer(.5, 5);
            case 5
                brick.MoveMotor('A', 50);
                brick.MoveMotor('D',-50);
                drivingState = -1;
                customTimer(.85, 6);
            case 6
                drivingState = -1;
                brick.StopAllMotors();
                customTimer(.5, 9);
            case 7
                brick.beep();
                drivingState = 0;
            case 8
                brick.beep();
                drivingState = -1;
                customTimer(.25, 7);
            case 9 
                brick.MoveMotor('A',-50);
                brick.MoveMotor('D',-50);
                drivingState = -1;
                lastColor = 0;
                customTimer(2.25, 0);
                customTimerBrake(.5, false);

        end
        
    end
end

CloseKeyboard();

function customTimer(customTime, nextState)
    
    % Create a timer object
    disp("Timer Started");
    t = timer('StartDelay', customTime, 'ExecutionMode', 'singleShot');
    
    % Define a callback function to execute after the custom time
    t.TimerFcn = @(~,~) setState(nextState);
  
    % Start the timer
    start(t);
   
end

function customTimerBrake(customTime, nextState)
    
    % Create a timer object
    disp("Timer Started");
    t = timer('StartDelay', customTime, 'ExecutionMode', 'singleShot');
    
    % Define a callback function to execute after the custom time
    t.TimerFcn = @(~,~) setBrake(nextState);
  
    % Start the timer
    start(t);
   
end

function setState(state)
    global drivingState;
    drivingState = state;
end

function setBrake(state)
    global wait;
    wait = false;
end

function setManual(state)
    global manual;
    global pickupState;
    switch state
        case 0
            manual = true;
            pickupState = 1;
        case 1
            manual = true;
            pickupState = 2;
        case 2 

    end
end



