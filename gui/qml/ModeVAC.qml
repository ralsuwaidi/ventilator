import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtMultimedia 5.10
import "./config.js"
as Config

Item {
    id: root
    height: 800
    anchors.fill: parent
    property string triggerType: "Time"

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Flickable {
            id: flickable
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.fill: parent
            // contentHeight: root.height + column.height - 380

            Column {
                id: column
                anchors.topMargin: 40
                anchors.fill: parent

                Text {
                    id: title
                    height: 80
                    text: root.triggerType === "Time" ? "Volume Control" : "Volume Assist"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 38
                }

                Text {
                    id: titleBasic
                    color: "#4c4c4c"
                    text: qsTr("Basic Input")
                    x: peep.x
                    font.pixelSize: 18

                }

                BaseSlider {
                    id: peep
                    name: UserInput.PEEP.name
                    stepSize: UserInput.PEEP.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: Params.PEEP ? Params.PEEP : UserInput.PEEP.initialVal
                    minVal: UserInput.PEEP.minVal
                    maxVal: UserInput.PEEP.maxVal
                }

                BaseSlider {
                    id: fio2
                    name: UserInput.FIO2.name
                    stepSize: UserInput.FIO2.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: Params.Fio2 ? Params.Fio2 : UserInput.FIO2.initialVal
                    minVal: UserInput.FIO2.minVal
                    maxVal: UserInput.FIO2.maxVal
                }

                BaseSlider {
                    id: vt
                    name: UserInput.VT.name
                    stepSize: UserInput.VT.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: Params.VT ? Params.VT : UserInput.VT.initialVal
                    minVal: UserInput.VT.minVal
                    maxVal: UserInput.VT.maxVal
                }

                BaseSlider {
                    id: rate
                    name: UserInput.BreathPerMinute.name
                    stepSize: UserInput.BreathPerMinute.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: Params.Rate ? Params.Rate : UserInput.BreathPerMinute.initialVal
                    minVal: UserInput.BreathPerMinute.minVal
                    maxVal: UserInput.BreathPerMinute.maxVal
                }

                Text {
                    id: titleIE
                    x: peep.x
                    height: 50
                    color: "#4c4c4c"
                    text: qsTr("I:E")
                    verticalAlignment: Text.AlignBottom
                    font.pixelSize: 18
                }
                BaseRadioGroup {
                    id: er
                    width: 500
                    height: 60
                    name: ""
                    anchors.horizontalCenterOffset: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                Text {
                    id: titleTrigger
                    x: peep.x
                    height: 50
                    color: "#4c4c4c"
                    text: qsTr("Trigger")
                    verticalAlignment: Text.AlignBottom
                    font.pixelSize: 18
                }

                BaseSlider {
                    id: trigger
                    name: {
                        if (value < 0) {
                            root.triggerType = "Pressure"
                            return "Pressure"
                        } else if (value > 0) {
                            root.triggerType = "Flow"
                            return "Flow"
                        } else {
                            root.triggerType = "Time"
                            return "Time"
                        }
                    }

                    minVal: -20
                    initialVal: 0
                    stepSize: 1
                    maxVal: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Audio {
                    id: playMusic
                    source: "./assets/done.mp3"
                }

                Rectangle {
                    id: buttonSubmit
                    width: 110
                    height: 38
                    color: Config.color_primary
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onReleased: {
                            ModeSelect.sendInt("TidalVolume", vt.value)
                            ModeSelect.sendString("Mode", "Volume A/C")
                            ModeSelect.mode = "Volume A/C"
                            ModeSelect.sendString("BreathType", root.triggerType === "Time" ? "Volume Control" : "Volume Assist")
                            ModeSelect.breath = root.triggerType === "Time" ? "Volume Control" : "Volume Assist"
                            ModeSelect.sendString("PatientTriggerType", root.triggerType === "Flow" ? "Flow Trigger" : "Pressure Trigger")
                            ModeSelect.trigger = root.triggerType
                            ModeSelect.sendInt("FiO2", fio2.value)
                            ModeSelect.sendInt("Rate", rate.value)
                            ModeSelect.sendInt("PEEP", peep.value)
                            ModeSelect.sendInt("ER", er.value)
                            ModeSelect.startVentilation()
                            playMusic.play()
                        }
                    }

                    Text {
                        id: element
                        text: qsTr("SUBMIT")
                        font.bold: true
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        font.pixelSize: 12
                    }
                }


            }
        }
    }
}



