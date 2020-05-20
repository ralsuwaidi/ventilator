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

Rectangle {
    id: sideBarRight
    width: 111
    color: Config.col_dark_grey
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    
    Column {
        id: column
        y: 74
        height: 326
        spacing: 40
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        
        
        RightBarData {
            id: rightBarData
            title: "Rate"
            units: "b/min"
            value: 20
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
        
        RightBarData {
            id: rightBarData1
            title: "%MinVol"
            value: 50
            units: "%"
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
        
        RightBarData {
            id: rightBarData2
            value: 5
            title: "PEEP/PCAP"
            units: "cmH2O"
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
        
        RightBarData {
            id: rightBarData3
            title: "Oxygen"
            units: "%"
            value: 60
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
    }
}
