running = true;
manual = true;
turn = true;
wait = false;
global key
InitKeyboard();


while running
    color = brick.ColorCode(2);

    distance = brick.UltrasonicDist(3);

    disp(distance);
    if color == 5
        brick.StopMotor('A');
        brick.StopMotor('D');
        pause(1)
        brick.MoveMotor('A', -50);
        brick.MoveMotor('D',-50);
        pause(1)
        key = 0;
    end
    if color == 2
        brick.beep();
        pause(.25);
        brick.beep();
        pause(2);
    end
    if color == 3
        brick.beep();
        pause(.25);
        brick.beep();
        pause(.25);
        brick.beep();
        pause(3);
    end
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
    else
        if brick.TouchPressed(1) == true
            brick.StopAllMotors();
            pause(.5);
            brick.MoveMotor('A', 50);
            brick.MoveMotor('D',50);
            pause(.25);
            brick.MoveMotor('A', 50);
            brick.MoveMotor('D',-50);
            pause(1.25);
        end
        if distance > 45
            pause(1);
            brick.StopAllMotors();
            pause(.5);
            brick.MoveMotor('A', 50);
            brick.MoveMotor('D',-50);
            pause(.75);
            brick.StopAllMotors();
            pause(1);
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D',-50);
            pause(1);
        else
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D',-50);
        end
    end

    if key == 'q'
        brick.StopAllMotors();
        running = false;
        break;
    end
end

CloseKeyboard();