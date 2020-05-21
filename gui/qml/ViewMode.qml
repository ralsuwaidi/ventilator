import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "./material/qml/material"
import "./config.js"
as Config
import "."


Item {
    id: root
    width: 1000
    height: 800
    property string activeMode
    signal presetClicked(string mode)
    onPresetClicked: {
        if (mode === "Pressure A/C") {
            modePage.visible = false
            modePAC.visible = true
            modeVAC.visible = false
        }
        if (mode === "Volume A/C") {
            modePage.visible = false
            modeVAC.visible = true
            modePAC.visible = false
        }
    }
    signal stop()

    Component.onCompleted: {
        ModeSelect.stopVent.connect(root.stop)
    }

    onStop: {
        ModeSelect.status = "stop"
    }

    Flickable {
        id: flickablePage
        interactive: false
        contentHeight: 500
        anchors.fill: parent
        Text {
            id: heading
            y: 60
            text: qsTr("Select Mode")
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            anchors.right: parent.right
            font.pointSize: 32
        }


        Item {
            id: modePage
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.horizontalCenter

            RowLayout {
            }

            GridLayout {
                x: -237
                y: -56
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                columnSpacing: 40
                rowSpacing: 20
                rows: 5
                columns: 2

                Text {
                    id: element1
                    color: "#000000"
                    text: qsTr("Volume Controlled (adaptive)")
                    Layout.preferredHeight: 50
                    Layout.columnSpan: 2
                    Layout.rowSpan: 1
                    font.pixelSize: 18
                    font.bold: true
                }

                BaseLargeButton {
                    id: vacbutton
                    width: 233
                    active: root.activeMode==="Volume A/C"?true:false
                    title: "Assist/Control"
                    onClicked: {
                        //                    modePage.visible = false
                        //                    modePAC.visible = false
                        //                    modeVAC.visible = true
                        root.activeMode = "Volume A/C"
                    }
                }

                BaseLargeButton {
                    id: volumeac1
                    title: "SIMV"
                    disabled: true
                    onClicked: {
                        console.log("not active")
                    }
                }

                Text {
                    id: pacbutton
                    color: "#040000"
                    text: qsTr("Pressure Controlled (biphasic)")
                    Layout.preferredHeight: 50
                    Layout.columnSpan: 2
                    font.bold: true
                    font.pixelSize: 18
                }

                BaseLargeButton {
                    id: volumeac2
                    active: root.activeMode==="Pressure A/C"?true:false
                    title: "Assist/Control"
                    onClicked: {
                        //                    modePage.visible = false
                        //                    modePAC.visible = true
                        //                    modeVAC.visible = false
                        root.activeMode = "Pressure A/C"
                    }
                }

                BaseLargeButton {
                    id: volumeac3
                    disabled: true
                    title: "SIMV"
                    onClicked: {
                        console.log("not active")
                    }
                }

                BaseLargeButton {
                    id: volumeac4
                    disabled: true
                    title: "Support"
                    onClicked: {
                        console.log("not active")
                    }
                }

                Item {
                    id: spacer2
                    Layout.preferredHeight: 14
                    Layout.preferredWidth: 14
                }
            }
        }

        ModePAC {
            id: modePAC
            visible: false
            anchors.left: parent.left
            anchors.right: parent.right

        }

        ModeVAC {
            id: modeVAC
            visible: false
            anchors.left: parent.left
            anchors.right: parent.right

        }

        Button {
            text: "back"
            onClicked: {
                modePAC.visible = false
                modeVAC.visible = false
                modePage.visible = true
                root.activeMode=""
            }
            visible: !modePage.visible

        }
    }

    Button {
        id: continueButton
        x: 396
        y: 438
        width: 208
        height: 62
        text: qsTr("Continue")
        visible: modePage.visible
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        onClicked: {

            if (root.activeMode==="Pressure A/C"){
                modePage.visible = false
                modePAC.visible = true
                modeVAC.visible = false

            } else if (root.activeMode==="Volume A/C"){
                modePage.visible = false
                modePAC.visible = false
                modeVAC.visible = true
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:1;anchors_height:300;anchors_width:300;anchors_x:88;anchors_y:128}
}
##^##*/
