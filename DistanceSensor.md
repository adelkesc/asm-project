##Assembly Application Project


#Problem Statment
How to make a distance sensor using Assembly that displays the distance of an object from the sensor and makes a sound according to the detected distance.


#Requirements
1. The user should be able to use almost any object to obstruct the system signal and trigger a response.
2. The system should be able to detect the distance of an object with a range of 2cm to 3m.
3. The system should be able to display the distance of an object from itself to an output device.
4. The system should make a sound when an object is within detection range.
5. The system should adjust the pitch of the sound it emits according to the detected distance of the object from the sensor.


#Use Cases
Trigger Sensor
1. Move object or self in front of sensor within 3m.
2. System detects obstruction of the signal and triggers the buzzer.
3. Move object or self closer or further away to the ultrasonic sensor.
4. System detects the distance of the obstruction and adjusts the frequency and pitch of its buzzer blips accordingly.

Exception:
1. Move the object out of range of the sensor.
2. System does nothing.


Display Distance
Precondition: Trigger Sensor
1. Move object or self in front of sensor within 3m.
2. System detects the obstruction and outputs the distance of the obstruction to a physical display.
3. User adjusts the distance of the object or themselves.
4. Return to step 2.
Exception:

1. User moves object out of the sensor's range.
2. System displays the maximum value of its detection range.


#Test Plan
The test plan will mostly consist of testing the use cases and making sure that the established requirements have been fulfilled.  Our group will know for certain that the certain components work individually if they generate the expected outputs based on the inputs as described by the requirements and use cases.