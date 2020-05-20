import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import "./config.js"
as Config


Item{
    id: root
    property string title: "_title"
    property string minText: "_minText"
    property string maxText: "_maxText"
    property int minVal: 0
    property int maxVal: 100
    property int val:50

    width: rectangle.width
    height: rectangle.height



    Rectangle {
        id: rectangle
        width: 458
        height: 115
        color: "#ffffff"

        Text {
            id: titletext
            x: 33
            color: "#000000"
            text: root.title
            anchors.top: parent.top
            anchors.topMargin: 0
            Layout.columnSpan: 3
            font.pixelSize: 20
        }

        Text {
            id: value
            x: 292
            y: 40
            color: "grey"
            text: Math.floor(slider.value)
            anchors.verticalCenterOffset: 17
            anchors.verticalCenter: parent.verticalCenter
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            font.pixelSize: 24
        }

        GridLayout {
            x: 33
            y: 40
            rows: 2
            columns: 3

            Text {
                id: minText
                text: root.minText
                font.pixelSize: 15
            }

            Item {
                id: spacer
                Layout.preferredHeight: 14
                Layout.preferredWidth: 14
            }

            Text {
                id: maxText
                text: root.maxText
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font.pixelSize: 15
            }

            Slider {
                id: slider
                stepSize: 1
                Layout.columnSpan: 3
                Layout.preferredHeight: 23
                Layout.preferredWidth: 239
                value: root.val
                from: root.minVal
                to: root.maxVal

                background: Rectangle {
                    x: slider.leftPadding
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 4
                    width: slider.availableWidth
                    height: implicitHeight
                    radius: 2
                    color: "#bdbebf"

                    Rectangle {
                        width: slider.visualPosition * parent.width
                        height: parent.height
                        color: Config.color_primary
                        radius: 2
                    }
                }

                handle: Rectangle {
                    x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    implicitWidth: 8
                    implicitHeight: 15
                    radius: 2
                    color: slider.pressed ? "#f0f0f0" : "#f6f6f6"
                    border.color: "#bdbebf"
                }
            }
        }




    }


}
