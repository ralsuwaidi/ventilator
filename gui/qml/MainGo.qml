import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "./src/variables/fontawesome.js"
as FontAwesome
import "./src/lists"
import "./material/qml/material"
import "./config.js"
as Config
import "."

Item {
    id: root
    anchors.fill: parent
    signal alarm(string status)
    width: 1280
    height: 800
    signal startVentilation()
    Component.onCompleted: {
        AlarmManager.alarmStatus.connect(root.alarm)
        ModeSelect.modeSelected.connect(root.startVentilation)
    }
    onAlarm: {
        if (status !== "none") {
            alarm.visible = true
        } else {
            alarm.visible = false
        }
        status1.text = AlarmManager.status
        title1.text = AlarmManager.title
        info1.text = AlarmManager.info
    }
    onStartVentilation: {
        stopButton.visible=true
    }

    Rectangle {
        id: mainview
        color: "#ffffff"
        anchors.left: sidebar.right
        anchors.right: sideBarRight.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top


        StackLayout {
            id: stackLayout
            anchors.fill: parent
            currentIndex: sidebar.currentView

            Item {
                id: viewmonitor


                ViewMonitor {
                    id: viewMonitor
                    anchors.fill: parent
                    onPresetClicked: {
                        sidebar.openTab()
                        viewmodeview.presetClicked(mode)

                    }
                }

                Rectangle {
                    id: stopButton
                    width: 200
                    height: 41
                    color: "#ef2929"
                    visible: false

                    Text {
                        id: element
                        color: "#ffffff"
                        text: qsTr("STOP")
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        font.pixelSize: 28
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: {
                            stopButton.visible=false
                            ModeSelect.stopVentilation()
                        }
                    }
                }
            }

            Item {
                id: viewmode
                ViewMode {
                    id: viewmodeview
                    anchors.fill: parent
                }
            }
            Item {
                id: viewpatient
                ViewPatient {

                }

            }
            Item {
                id: viewsettings
                ViewSettings {

                }

            }
        }

        Image {
            id: logo
            x: 484
            y: 0
            width: 166
            height: 46
            anchors.rightMargin: 20
            anchors.right: parent.right
            source: "assets/DFL-LOGO-W.jpg"
            fillMode: Image.PreserveAspectFit
        }
    }

    SideBar {
        id: sidebar
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 0
        width: Config.sidebar_width

    }

    FontLoader {
        id: webFont;source: "./src/variables/fontawesome-webfont.ttf"
    }

    SideBarRight {
        id: sideBarRight
        x: 1169
        y: 0
    }

    Rectangle {
        id: alarm
        x: 327
        y: 127
        width: 200
        height: 200
        color: "#d10000"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        RowLayout {
            x: 2
            y: 3

            ColumnLayout {}

            ColumnLayout {}
        }

        ColumnLayout {
            x: 13
            y: 12

            RowLayout {

                Text {
                    id: status1
                    color: "#ffffff"
                    font.capitalization: Font.AllUppercase
                    font.bold: true
                    text: qsTr("Text")
                    font.pixelSize: 18
                }
            }

            RowLayout {

                Text {
                    id: title1
                    color: "#ffffff"
                    text: qsTr("Text")
                    font.pixelSize: 18
                }
            }

            RowLayout {
                id: row
                Layout.fillWidth: true
            }
        }

        Text {
            id: info1
            y: 74
            height: 126
            color: "#ffffff"
            text: qsTr("Text")
            wrapMode: Text.WordWrap
            anchors.leftMargin: 15
            anchors.left: parent.left
            anchors.rightMargin: 0
            font.pixelSize: 12
            anchors.right: parent.right
        }
    }





}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:1;anchors_width:150}D{i:16;anchors_height:400;anchors_width:200}
D{i:19;anchors_x:46}D{i:20;anchors_x:44}D{i:18;anchors_height:60;anchors_x:0;anchors_y:0}
D{i:21;anchors_x:44}D{i:17;anchors_width:200;anchors_x:8}
}
##^##*/
