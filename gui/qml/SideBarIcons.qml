import QtQuick 2.0
import "./src/variables/fontawesome.js"
as FontAwesome
import "./src/lists"
import "./config.js"
as Config
import QtQuick.Layouts 1.0
import "."
import QtQuick.Controls 2.1

RowLayout {
    id: sideBarIcons
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 20
    anchors.leftMargin: 15
    anchors.right: parent.right
    anchors.left: parent.left
    
    Text {
        id: element17
        color: "#ffffff"
        text: "\uf015"
        font.pixelSize: 12
        font.family: webFont.name
    }
    
    Text {
        id: element18
        color: "#ffffff"
        text: "\uf06a"
        font.pixelSize: 12
    }
    
    Text {
        id: element19
        color: "#ffffff"
        text: "\uf043"
        font.pixelSize: 12
    }
}
