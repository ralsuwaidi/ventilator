import QtQuick 2.0
import QtQuick.Controls 2.1
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
    property string title: "_title"
    property string units: "_units"
    property int value: 0
    height: 100
    anchors.right: parent.right
    anchors.left: parent.left

    Text {
        id: element3
        x: 307
        y: 53
        color: "#e4e4e4"
        text: root.title
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
    }

    Rectangle {
        id: rectangle1
        x: 295
        y: 0
        width: 80
        height: 80
        color: Config.col_dark_grey
        radius: 40
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 5
        border.color: "#f5f4f4"
    }

    Text {
        id: element2
        x: 304
        y: 46
        color: "#e4e4e4"
        text: root.units
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Text {
        id: element1
        x: 315
        y: 24
        color: "#ffffff"
        text: root.value
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }




}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}D{i:2;anchors_y:11}
}
##^##*/
