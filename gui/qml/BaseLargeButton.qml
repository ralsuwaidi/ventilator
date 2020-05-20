import QtQuick 2.0
import QtQuick.Controls 2.0
import "./config.js"
as Config

Rectangle {
    id: root
    width: rectangle.width
    height: rectangle.height
    property string title: "Volume A/C"
    property bool active: false
    property bool disabled : false
    signal clicked()


    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 233
        height: 74
        color: {
            if (!root.disabled){
            root.active?"green":Config.color_inactive
            }else{
                Config.color_disabled
            }
        }
        radius: 10

        Text {
            color: {
                if (!root.disabled){
                root.active?"white":"black"}
                else{
                    "white"
                }

                }
            text: root.title
            verticalAlignment: Text.AlignVCenter
            anchors.bottom: parent.bottom
            font.bold: false
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 16
        }

        MouseArea {
            id: mousearea
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            onClicked: {

                root.clicked()

            }
        }

    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}D{i:3;anchors_width:70}
}
##^##*/
