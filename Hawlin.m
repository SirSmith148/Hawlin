running = true;
manual = true;
global key
InitKeyboard();

while running
    color = brick.ColorCode(4);
    distance = brick.UltrasonicDist(3);
    disp(distance);
    if color == 5
        disp(color);
        brick.StopMotor('A');
        brick.StopMotor('D');
        key = 0;
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
        if distance <= 35
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D',-50);
        else
            pause(1) 
            brick.StopMotor('A');
            brick.StopMotor('D');
            brick.MoveMotorAngleRel('A', 50, 400, 'Brake');
            brick.MoveMotorAngleRel('D', -50, 400, 'Brake');
            pause(1)
            brick.MoveMotor('A', -50);
            brick.MoveMotor('D',-50);
            pause(3)

        end

    end

    if key == 'q'
        brick.StopAllMotors();
        running = false;
    end
end

CloseKeyboard();