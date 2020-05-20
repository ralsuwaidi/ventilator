import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import "./config.js"
as Config

Item {
    width: 1280
    height: 800
    anchors.fill: parent
    Rectangle {
        id: rectangle
        width: 680
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Text {
            id: element
            y: 15
            color: "#646464"
            text: qsTr("Patient Information")
            anchors.rightMargin: -11
            anchors.leftMargin: 51
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 28
        }

        Text {
            id: element2
            x: 51
            y: 52
            text: qsTr("Tell us about yourself")
            font.bold: true
            font.pixelSize: 16
        }



        Rectangle {
            id: continueButton
            property bool active: false
            x: 267
            y: 390
            width: 106
            height: 41
            color: Config.color_primary
            radius: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 49
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                y: 15
                color: "white"
                text: qsTr("Continue")
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
            }

            MouseArea {
                id: mouseAreacontinue
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                onClicked: {

                }
            }
        }

        RowLayout {
            x: 142
            y: 144
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            ColumnLayout {
                spacing: 30

                GridLayout {
                    Layout.bottomMargin: 40
                    Layout.leftMargin: 30
                    rows: 2
                    columns: 2

                    Text {
                        id: element32
                        color: "#000000"
                        text: qsTr("Gender")
                        font.pixelSize: 24
                    }

                    Item {
                        id: spacer32
                        Layout.preferredHeight: 14
                        Layout.preferredWidth: 14
                    }

                    Rectangle {
                        id: male22
                        property bool active: false
                        color: "#ffffff"
                        radius: 8
                        Layout.preferredHeight: 41
                        Layout.preferredWidth: 106
                        border.color: active ? Config.color_primary : "grey"


                        Text {
                            y: 15
                            color: male.active ? Config.color_primary : "grey"
                            text: qsTr("Male")
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 12
                        }

                        MouseArea {
                            id: mouseAreaMale2
                            anchors.fill: parent
                            onClicked: {
                                male.active = true
                                female.active = false
                            }
                        }
                    }

                    Rectangle {
                        id: female2
                        property bool active: false
                        x: 180
                        y: 27
                        color: "#ffffff"
                        radius: 8
                        Layout.preferredHeight: 41
                        Layout.preferredWidth: 106
                        border.color: active ? Config.color_primary : "grey"

                        Text {
                            y: 15
                            color: female.active ? Config.color_primary : "grey"
                            text: qsTr("Female")
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 12
                        }

                        MouseArea {
                            id: mouseAreaFemale2
                            anchors.fill: parent
                            onClicked: {
                                female.active = true
                                male.active = false
                            }
                        }
                    }
                }

                BasePSlider {
                    id: basePSlider
                    Layout.preferredHeight: 115
                    Layout.preferredWidth: 387
                    val: 15
                    maxVal: 30
                    maxText: "30"
                    minText: "1"
                    title: "Resistance (cmH2O)"
                }

                BasePSlider {
                    id: basePSlider1
                    Layout.preferredHeight: 115
                    Layout.preferredWidth: 387
                    minVal: -50
                    title: "Compliance (ml/cmH2O)"
                    minText: "-50%"
                    val: 0
                    maxText: "+50%"
                    maxVal: 50
                }
            }

            ColumnLayout {
                spacing: 30

                BaseActivity {
                    id: baseActivity
                }

                BasePSlider {
                    id: basePSlider4
                    Layout.preferredHeight: 115
                    Layout.preferredWidth: 387
                    minText: ""
                    title: "Weight (KG)"
                    val: 80
                    minVal: 0
                    maxText: ""
                    maxVal: 300
                }

                BasePSlider {
                    id: basePSlider2
                    Layout.preferredHeight: 115
                    Layout.preferredWidth: 387
                    minText: "Decreased"
                    title: "Metabolism"
                    val: 50
                    minVal: 0
                    maxText: "Increased"
                    maxVal: 100
                }

            }
        }





    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:2;anchors_x:32}
}
##^##*/
