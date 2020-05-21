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
    id: element
    height: rectangle.height

    Rectangle {
        id: rectangle
        height: sideBarIcons.height
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        RowLayout {
            id: sideBarIcons
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.bottom: parent.bottom
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
                Layout.fillWidth: false
                font.pixelSize: 12
            }

            Text {
                id: element19
                color: "#ffffff"
                text: "\uf043"
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font.pixelSize: 12
            }


        }
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}D{i:1;anchors_width:200}
}
##^##*/
