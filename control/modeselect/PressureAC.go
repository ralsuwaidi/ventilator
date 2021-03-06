package modeselect

import (
	"fmt"
	"log"
	"sync"
	"time"

	"github.com/mzahmi/ventilator/control/dac"
	"github.com/mzahmi/ventilator/control/ioexp"
	"github.com/mzahmi/ventilator/control/sensors"
	"github.com/mzahmi/ventilator/control/valves"
	"github.com/mzahmi/ventilator/params"
)

/* PressureAC ... has a triggering window, which opens at late expiration.
If the github.com/mzahmi/ventilatorilator detects a valid pneumatic signal during the triggering window,
it delivers a pressure assist breath. If not, it delivers a pressure control
(time-triggered) breath according to the set rate. The set Pcontrol applies to
both breath types (Pressure Control Breath and Preassure Assist Breath).

In the pressure A/C mode, all breaths are pressure controlled if the github.com/mzahmi/ventilatorilated
patient is passive, and the monitored rate and the set rate are roughly equal.
If the patient is active, some or all breaths are pressure assist breaths,
and the monitored rate is typically higher than the set rate.

In the pressure A/C mode, the baseline pressure (PEEP) is constant.

The pressure A/C mode is suitable for passive or partially active patients.
It can also be used in active patients with weak respiratory drive,
because this mode allows the patient to influence rate, inspiratory flow,
and tidal volume. Compared to the volume assist/control mode,
pressure assist/control has a considerably lower incidence of patient-github.com/mzahmi/ventilatorilator
asynchrony. Another advantage of pressure assist/control is that this mode enables
the github.com/mzahmi/ventilatorilator to compensate for moderate levels of gas leakage.

The perceived disadvantage of this mode is that an operator cannot directly
control tidal volume. The resultant tidal volume may be unstable when the patient’s
breathing effort and/or respiratory mechanics change. Therefore, you should
carefully set the upper and lower limits of the tidal volume alarm.*/
func PressureAC(UI *params.UserInput, s *sensors.SensorsReading, wg *sync.WaitGroup, readStatus chan string, logger *log.Logger) {
	defer wg.Done()
	switch UI.BreathType {
	case "Pressure Control":
		logger.Println("Pressure Control Breath Type")
		PressureControl(UI, s, wg, readStatus, logger)
	case "Pressure Assist":
		logger.Println("Pressure Assist Breath Type")
		PressureAssist(UI, s, wg, readStatus, logger)
	default:
		logger.Println("No supported breath type")
	}
}

// PressureControl a submode of PressureAC.
// 	Triggering:	Time
// 	Cycling: 	Time
// 	Control: 	Pressure
func PressureControl(UI *params.UserInput, s *sensors.SensorsReading, wg *sync.WaitGroup, readStatus chan string, logger *log.Logger) {
	defer wg.Done()
	//initiate Pressure PID based on readings from PIns
	// PressurePID := NewPIDController(0.5, 0.5, 0.5)                            // takes in P, I, and D values to be set trial and error
	// PressurePID.setpoint = float64((UI.InspiratoryPressure + UI.PEEP) / 1020) // Sets the PID setpoint to inspiratory pressure above PEEP
	//valves.MV.Open()
	//control loop; it loops unitll Exit bool is set to false
	for {
		//Open main valve MIns controlled by pressure sensor PIns
		for start := time.Now(); time.Since(start) < (time.Duration(UI.Ti*1000) * time.Millisecond); {

			valves.MIns.Open()

			valves.MExp.Close()

			//prop valve digital in
			ioexp.WritePin(ioexp.Solenoid2, true)

			// feedbackIn := float64(sensors.PIns.ReadPressureBar())

			dac.WriteDac(1, 1, 0.5)
			// fmt.Println(feedbackIn)
			fmt.Println(s.PressureInput)
			// valves.InProp.IncrementValve(PressurePID.Update(float64((<-s).PressureInput)))
		}
		valves.MIns.Close()
		ioexp.WritePin(ioexp.Solenoid2, false)
		dac.WriteDac(1, 1, 0)

		//Close main valve InProp
		// valves.InProp.IncrementValve(0)

		//Open main valve MExp controlled by pressure sensor PExp
		for start := time.Now(); time.Since(start) < (time.Duration(UI.Te*1000) * time.Millisecond); {

			//check for PEEP
			// if (s.PressureOutput) <= (UI.PEEP / 1020) {
			// 	break
			// }
			// Open ExProp valve
			valves.MExp.Open()
		}
		//Close main valve ExProp
		valves.MExp.Close()
		// if it's stop or exit then close valves and break loop
		trig := <-readStatus
		if (trig == "stop") || (trig == "exit") {
			// valves.CloseAllValves(&valves.MIns, &valves.MExp)
			// logger.Println("All valves closed")
			break
		} else {
			continue
		}
	}
	valves.CloseAllValves(&valves.MIns, &valves.MExp)
	logger.Println("All valves closed")

}

// PressureAssist a submode of PressureAC. The Triggering type is chosen by the operator.
// 	Triggering:	Pressure/Flow
// 	Cycling: 	Time
// 	Control: 	Pressure
func PressureAssist(UI *params.UserInput, s *sensors.SensorsReading, wg *sync.WaitGroup, readStatus chan string, logger *log.Logger) {
	defer wg.Done()
	//initiate Pressure PID based on readings from PIns
	PressurePID := NewPIDController(0.5, 0.5, 0.5)         // takes in P, I, and D values to be set trial and error
	PressurePID.setpoint = float64(UI.InspiratoryPressure) // Sets PID setpoint to Inspiratory pressure

	//Check trigger type
	switch UI.PatientTriggerType {
	case "Pressure Trigger ":
		logger.Printf("Pressure Trigger is set at %v cmH2O\n", UI.PressureTrigSense)
		//Calculate trigger threshhold with PEEP and sensitivity
		PTrigger := UI.PEEP + UI.PressureTrigSense

		//control loop; it loops unitll Exit bool is set to false
		for {
			//check if trigger is true
			if sensors.PIns.ReadPressure() <= PTrigger {

				//Open main valve InProp controlled by pressure sensor PIns and check tidal volume alarms
				for start := time.Now(); time.Since(start) < (time.Duration(UI.Ti*1000) * time.Millisecond); {

					valves.InProp.IncrementValve(PressurePID.Update(float64(sensors.PIns.ReadPressure())))
				}
				//Close main valve InProp
				valves.InProp.IncrementValve(0) // closes the valve

				//Open main valve ExProp and check for PEEP value and tidal volume alarms
				for start := time.Now(); time.Since(start) < (time.Duration(UI.Te*1000) * time.Millisecond); {

					//check for PEEP
					if sensors.PExp.ReadPressure() <= UI.PEEP {
						break
					}

					//open ExProp valve
					valves.ExProp.IncrementValve(100)
				}

				//Close main valve ExProp
				valves.ExProp.IncrementValve(0) // closes the valve
			}
			// if it's stop or exit then close valves and break loop
			trig := <-readStatus
			if (trig == "stop") || (trig == "exit") {
				valves.CloseAllValves(&valves.ExProp, &valves.InProp)
				logger.Println("All valves closed")
				break
			} else {
				continue
			}
		}
	case "Flow Trigger ":
		logger.Printf("Flow Trigger is set at %v cmH2O\n", UI.FlowTrigSense)
		//Calculate trigger threshhold with flow trig sensitivity
		FTrigger := UI.FlowTrigSense
		//control loop; it loops unitll Exit bool is set to false
		for {
			//check if trigger is true
			if sensors.FIns.ReadFlow() >= FTrigger {
				//Open main valve InProp controlled by pressure sensor PIns
				for start := time.Now(); time.Since(start) < (time.Duration(UI.Ti*1000) * time.Millisecond); {

					valves.InProp.IncrementValve(PressurePID.Update(float64(sensors.PIns.ReadPressure())))
				}

				//Close main valve InProp
				valves.InProp.IncrementValve(0) // closes the valve

				//Open main valve ExProp and check for PEEP value and tidal volume alarms
				for start := time.Now(); time.Since(start) < (time.Duration(UI.Te*1000) * time.Millisecond); {

					//Check for PEEP
					if sensors.PExp.ReadPressure() <= UI.PEEP {
						break
					}

					//Open ExProp valve
					valves.ExProp.IncrementValve(100)
				}
				//Close main valve MExp
				valves.ExProp.IncrementValve(0) // closes the valve
			}
			// if it's stop or exit then close valves and break loop
			trig := <-readStatus
			if (trig == "stop") || (trig == "exit") {
				valves.CloseAllValves(&valves.ExProp, &valves.InProp)
				logger.Println("All valves closed")
				break
			} else {
				continue
			}
		}
	}
}
