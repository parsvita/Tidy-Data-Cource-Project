#Code Book
###Description of the data in the `tidy_data.txt`

This file comtaine description of the `tidy_data.txt` file which is a result of the running `run_analysis.R` script.
Please find the original description of the experimental `sourse data` under this [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


>tidy_data.txt
File stores the table with 81 Columns and 180 Rows.
Column 1	The `Subject` identificator (int value)
Column 2	Activyty` performed by the `Subject` during the experiment (Factor/String)
Column 3:81	The Average values of the `Features`  which were obtained during the experiment (double)

>Subject
Subject is coded one of the experiment's participants. It has values from 1 up to 30

>Activity
The one of the activity performed by the `Subject` during experiment. Following values available:
- STANDING
- SITTING
- LAYING
- WALKING
- WALKINGDOWNSTAIRS
- WALKINGUPSTAIRS

>Features
```
Please note that the in the `tidy_data.txt` additional Mean function was applied on the described Features below 
(as a result of the `run_analysis.R` script run)
```
Feature is the kind of the data gatherd during the experiment. The name of each Feature consits from the following parts:
1. kind of the domain, could be following values:
	1. TimeDomain - row signals data from the accelerometer or gyroscope
	2. FrequencyDomain - application of the Fast Fourier Transform to the time-domain row signals data
2. Body accelearation data or Gravity acceleration data
	1. Body - data of the Body accelerations (movements)
	2. Gravity - data from the Gravitometer (gravity acceleration)
3. Type of the Device which generates the Signals
	1. Accelerometer
	2. Gyroscope
4. Additional function applied on the raw data
	1. `<empty>` - if the no additional function applied
	2. Jerk - rate of change of acceleration
	3. Magnitude - size of the acceleration vector (General X Y Z dimension's vector)	
5. Statistical function which was applied to the raw data
	1. Mean
	2. StandardDeviation
	3. MeanFrequency (Weighted average of the frequency)
6. Direction of the movement
	1. `<empty>` - if the data is a magnitude.
	2. X
	3. Y
	4. Z	

For example:

`timeDomainGravityAccelerometerMeanX` -> `timeDomain` `Gravity` `Accelerometer` `Mean` `X`

or `Mean` function of the `Gravity` raw data (`timeDomain`) from the `Acelerometer` along the axis `X`


hope this helpfull :wink:
