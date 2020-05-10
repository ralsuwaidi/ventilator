package cli

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
	"sync"

	"github.com/fatih/structs"
	"github.com/go-redis/redis"
	"github.com/mzahmi/ventilator/control/sensors"
	"github.com/mzahmi/ventilator/params"
)

func info() {
	fmt.Println("CLI v1.0 Info:\n")
	fmt.Println("	info: i")
	fmt.Println("	quit: q")

	fmt.Println("	read: r sensor_name")
	fmt.Println("	read: rp parameter_name")
	fmt.Println("	write: w o_name value")
	fmt.Println("	write: wp parameter_name value")
	fmt.Println("	list sensors: lss")
	fmt.Println("	list actuators: lsa")
	fmt.Println("	list parameters: lsp")
}

func Run(wg *sync.WaitGroup, s chan sensors.SensorsReading) {
	defer wg.Done()
	client := redis.NewClient(&redis.Options{
		Addr:     "dupi1.local:6379",
		Password: "",
		DB:       0,
	})
	pong, err := client.Ping().Result()
	fmt.Println(pong, err)
	params.InitParams()

	// err = client.Set("IO:pressure", 100, 0).Err()
	// // if there has been an error setting the value
	// // handle the error
	// if err != nil {
	// 	fmt.Println(err)
	// }

	// val, err := client.Get("IO:pressure").Result()
	// if err != nil {
	// 	panic(err)
	// }
	// fmt.Println("IO:pressure = ", val)

	parameters := structs.Names(&params.UserInput{})

	fmt.Println("Type (i) for more info \n")
	reader := bufio.NewReader(os.Stdin)
	for {
		//user_input := <-c
		fmt.Print("> ")

		// get user input
		input, err := reader.ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}

		words := strings.Fields(input)

		// show information
		if words[0] == "i" {
			info()
			continue
		}

		// check for write
		if words[0] == "w" {
			if len(words) < 3 {
				fmt.Println("Incorrect number of parameters")
				continue
			}

			writeto := words[1]
			writevalue := words[2]
			fmt.Println("Changing actuator " + writeto + " to " + writevalue)
			continue
		}

		if words[0] == "wp" {
			if len(words) < 3 {
				fmt.Println("Incorrect number of parameters")
				continue
			}

			writeto := words[1]
			writevalue := words[2]
			fmt.Println("Changing parameter " + writeto + " to " + writevalue)
			//TODO: write them to redis
			continue
		}

		if words[0] == "lsp" {
			fmt.Println("Displaying the list of parameters")
			fmt.Println(strings.Join(parameters, "\t\n"))
			continue
		}

		if words[0] == "lss" {
			fmt.Println("Displaying the list of sensors")
			fmt.Println("	PIns")
			fmt.Println("	PExp")
			fmt.Println("	FInsp")
			fmt.Println("	FExp")
			continue
		}

		if words[0] == "lsa" {
			fmt.Println("Displaying the list of actuators")
			fmt.Println(strings.Join(parameters, "\n"))
			continue
		}

		if words[0] == "r" {
			if len(words) < 2 {
				fmt.Println("Incorrect number or arguments, press i for help")
				continue
			}
			switch words[1] {
			case "PIns":
				val := (<-s).PressureInput
				fmt.Println("PIns:", val)
			case "PExp":
				val := (<-s).PressureOutput
				fmt.Println("PExp:", val)
			case "FIns":
				//val := sensors.FIns.ReadFlow()
				val := 0
				fmt.Println("FIns:", val)
			case "FExp":
				//val := sensors.FExp.ReadFlow()
				val := 0
				fmt.Println("FExp:", val)
			default:
				fmt.Println("Unknow sensors")
			}
			continue
		}

		if words[0] == "rp" {
			if len(words) < 2 {
				fmt.Println("Incorrect number or arguments, press i for help")
				continue
			}
			//TODO: read them to redis
			/*
				switch words[1]; {
				case "":

				}
			*/
			continue
		}

		if words[0] == "q" {
			break
		}
		fmt.Println("Unknown input")
	}
}

/*
func main() {
	var wg sync.WaitGroup
	wg.Add(1)
	ch := make(chan UserInput)
	go cli(&wg, ch)
	wg.Wait()
}
*/
