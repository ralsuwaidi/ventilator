package demo

import (
	"fmt"

	"vent/control/modeselect"
	"vent/control/sensors"
)

type SensorsReading struct {
	PressureInput  float32
	PressureOutput float32
	FlowInput      float32
	FlowOutput     float32
}

func Launch() {

	s := make(chan SensorsReading)
	a := make(chan error)

	go func() {
		for !modeselect.Exit {
			//read the sensors
			Pin, Pout, Fin, Fout := sensors.ReadAllSensors()
			s <- SensorsReading{Pin, Pout, Fin, Fout}
			//check for alarms
			err := modeselect.CheckAlarms(&modeselect.UserInput{})
			a <- err
			//add time delay based on the speed test of sensor reading
		}
		close(s)
		close(a)
	}()

	go func() {
		//ventilation control
		modeselect.ModeSelection(&modeselect.UserInput{})
		// define a better exit trigger
	}()

	// extract from channels to populate the chart and see the alarms
	readings := SensorsReading{0, 0, 0, 0}
	for {
		select {
		case value := <-s:
			readings = value
			fmt.Println(readings)
		case alarm := <-a:
			fmt.Println(alarm)
			return
		}
	}

}