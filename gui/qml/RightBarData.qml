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
    id: rightBarData
    height: 51
    anchors.right: parent.right
    anchors.left: parent.left
    
    ColumnLayout {
        spacing: 0
        anchors.fill: parent
        
        Text {
            id: element1
            color: "#ffffff"
            text: qsTr("20")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 18
        }
        
        Text {
            id: element2
            color: "#e4e4e4"
            text: qsTr("b/min")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
        
        Text {
            id: element3
            color: "#e4e4e4"
            text: qsTr("Rate")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }
    }
}
