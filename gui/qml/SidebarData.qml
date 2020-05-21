import QtQuick 2.0
import "./src/variables/fontawesome.js"
as FontAwesome
import "./src/lists"
import "./config.js"
as Config
import QtQuick.Layouts 1.0
import "."
import QtQuick.Controls 2.1


Item {
    id: root
    anchors.right: parent.right
    anchors.left: parent.left
    height:rectangle.height
    property double value: 0
    property string backgroundColor:Config.col_dark_grey
    property string title:"_title"
    property string units:"_units"
    property double max:50.0
    property double min: 0.0
    signal clicked()

    Rectangle {
        id: rectangle
        color: root.backgroundColor
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        height: maindata.height+10

        ColumnLayout {
            id: maindata
            x: 594
            y: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0
            anchors.right: parent.right
            anchors.rightMargin: 8

            Text {
                id: value
                height: 60
                text: root.value
                Layout.preferredHeight: 60
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                color:{
                    if (root.value>root.max || root.value<root.min){
                        "red"
                    }else{
                        "white"
                    }
                }
                font.pixelSize: 70
            }

            Text {
                id: title
                color: "white"
                text: root.title
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 16
            }

            Text {
                id: units
                color: "#ffffff"
                text: root.units
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 14
            }
        }

        ColumnLayout {
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.top: maindata.top
            anchors.topMargin: 0

            Text {
                id: maximum
                color: "white"
                text: root.max
                font.pixelSize: 15
            }

            Text {
                id: minimum
                color: "white"
                text: root.min
                font.pixelSize: 15
            }
        }

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}D{i:3;anchors_y:16}D{i:4;anchors_y:16}D{i:5;anchors_y:16}
D{i:2;anchors_y:10}D{i:6;anchors_x:8;anchors_y:21}D{i:1;anchors_height:200;anchors_width:200}
}
##^##*/
