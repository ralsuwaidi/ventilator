import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
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
                    text: root.triggerType === "Time" ? "Pressure Control" : "Pressure Assist"
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
                    initialVal: UserInput.PEEP.initialVal
                    minVal: UserInput.PEEP.minVal
                    maxVal: UserInput.PEEP.maxVal
                }

                BaseSlider {
                    id: fio2
                    name: UserInput.FIO2.name
                    stepSize: UserInput.FIO2.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: UserInput.FIO2.initialVal
                    minVal: UserInput.FIO2.minVal
                    maxVal: UserInput.FIO2.maxVal
                }

                BaseSlider {
                    id: insparotaryPressure
                    name: UserInput.InsparotaryPressure.name
                    stepSize: UserInput.InsparotaryPressure.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: UserInput.InsparotaryPressure.initialVal
                    minVal: UserInput.InsparotaryPressure.minVal
                    maxVal: UserInput.InsparotaryPressure.maxVal
                }

                BaseSlider {
                    id: rate
                    name: UserInput.BreathPerMinute.name
                    stepSize: UserInput.BreathPerMinute.stepSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    initialVal: UserInput.BreathPerMinute.initialVal
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
                    name: ""
                    width: 500
                    height: 100
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

                Rectangle {
                    id: buttonSubmit
                    width: 110
                    height: 38
                    color: Config.color_dark
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onReleased: {
                            ModeSelect.startVentilation()
                            ModeSelect.mode = "Pressure A/C"
                            ModeSelect.trigger = root.triggerType
                            ModeSelect.sendValues("FiO2", fio2.value)
                            ModeSelect.sendValues("InspiratoryPressure", insparotaryPressure.value)
                            ModeSelect.sendValues("Rate", rate.value)
                            ModeSelect.sendValues("PEEP", peep.value)
                            ModeSelect.sendValues("ER", er.value)
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



