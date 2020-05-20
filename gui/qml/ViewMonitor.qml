import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "src/cards"
import "./material/qml/material"


Item {
    id: root
    signal presetClicked(string mode)
    anchors.fill: parent



    Rectangle {
        id: rectangle
        color: "#040000"
        anchors.fill: parent
    }

    Column {
        id: column
        anchors.fill: parent

        BasicChart1 {
            id: chart1
            height: root.height/3
            anchors.top: parent.top
            anchors.topMargin: 29
            anchors.left: parent.left
            anchors.right: parent.right

        }

        BasicChart2 {
            id: chart2
            height: root.height/3
            anchors.top: chart1.bottom
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
        }

        BasicChart3 {
            id: chart3
            anchors.top: chart2.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }




    }


}



/*##^##
Designer {
    D{i:0;anchors_height:200;anchors_width:200;anchors_x:18;anchors_y:46;autoSize:true;formeditorZoom:0.75;height:480;width:640}
D{i:1;anchors_height:200;anchors_width:200}D{i:3;anchors_x:188}D{i:2;anchors_height:200;anchors_width:200}
}
##^##*/
