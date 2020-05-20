import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import "./config.js"
as Config

Rectangle {
    id: root
    width: 387
    height: 115
    property string activity: "passive"
    color: "#ffffff"
    
    Text {
        id: element1
        x: 33
        y: 0
        text: qsTr("Activity")
        font.pixelSize: 24
    }
    
    Rectangle {
        id: passive
        x: 26
        y: 51
        width: 133
        height: 34
        color: root.activity==="passive"?Config.color_primary:Config.color_inactive
        
        Text {
            id: element3
            text: qsTr("Passive")
            color: root.activity==="passive"?"white":"black"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 12
        }
        
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: root.activity="passive"
        }
    }

    Rectangle {
        id: active
        x: 218
        y: 51
        width: 133
        height: 34
        color: root.activity==="active"?Config.color_primary:Config.color_inactive
        Text {
            id: element4
            color: root.activity==="active"?"white":"black"
            text: qsTr("Passive")
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
        }

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: root.activity="active"
        }
    }
}
