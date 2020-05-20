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
    id: sidebar
    property int currentView: 0
    // monitor when first started
    Component.onCompleted: {
        currentView = 0
        menulist.model.get(0).class_name = "light"
        menulist.model.get(1).class_name = "dark"
        menulist.model.get(2).class_name = "dark"
        menulist.model.get(3).class_name = "dark"
        ModeSelect.modeSelected.connect(sidebar.openMonitor)
    }
    signal openTab()
    onOpenTab: {
        currentView = 1
        menulist.model.get(0).class_name = "dark"
        menulist.model.get(1).class_name = "light"
        menulist.model.get(2).class_name = "dark"
        menulist.model.get(3).class_name = "dark"
    }
    signal openMonitor()
    width: 300
    height: 800
    onOpenMonitor: {
        currentView = 0
        menulist.model.get(0).class_name = "light"
        menulist.model.get(1).class_name = "dark"
        menulist.model.get(2).class_name = "dark"
        menulist.model.get(3).class_name = "dark"
    }

    Rectangle {
        id: sidebarrectangle
        width: Config.sidebar_width
        color: "#040000"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top

        Column {
            id: menulistcolumn
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top

            Item {
                id: menuitem
                height: 170
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                IconListView {
                    id: menulist
                    anchors.rightMargin: 1
                    anchors.fill: parent

                    onItemClicked: {
                        if (menulist.model.get(index).text === "Monitor") {
                            currentView = 0
                            menulist.model.get(0).class_name = "light"
                            menulist.model.get(1).class_name = "dark"
                            menulist.model.get(2).class_name = "dark"
                            menulist.model.get(3).class_name = "dark"
                        } else if (menulist.model.get(index).text === "Set Mode") {
                            currentView = 1
                            menulist.model.get(0).class_name = "dark"
                            menulist.model.get(1).class_name = "light"
                            menulist.model.get(2).class_name = "dark"
                            menulist.model.get(3).class_name = "dark"
                        } else if (menulist.model.get(index).text === "Patient") {
                            currentView = 2
                            menulist.model.get(0).class_name = "dark"
                            menulist.model.get(1).class_name = "dark"
                            menulist.model.get(2).class_name = "light"
                            menulist.model.get(3).class_name = "dark"
                        } else {
                            currentView = 3
                            menulist.model.get(0).class_name = "dark"
                            menulist.model.get(1).class_name = "dark"
                            menulist.model.get(2).class_name = "dark"
                            menulist.model.get(3).class_name = "light"
                        }
                    }
                    model: ListModel {

                        ListElement {
                            text: "Monitor"
                            leftIcon: "\uf06e"
                            class_name: "light"
                        }

                        ListElement {
                            text: "Set Mode"
                            divider: "Divider 1"
                            leftIcon: "\uf067"
                            class_name: "dark"
                        }
                        ListElement {
                            text: "Patient"
                            divider: "Divider 1"
                            leftIcon: "\uf007"
                            class_name: "dark"
                        }
                        ListElement {
                            text: "Settings"
                            divider: "Divider 1"
                            leftIcon: "\uf044"
                            class_name: "dark"
                        }
                    }
                }
            }
        }


        Item {
            id: view
            anchors.bottomMargin: 10
            anchors.bottom: rectangle.top
            anchors.topMargin: 0
            anchors.top: menulistcolumn.bottom
            anchors.right: parent.right
            anchors.left: parent.left

            Column{
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                spacing: 6

                SidebarData {
                    id: sidebarData1
                    min: 5
                    max: 40
                    units: "cmH2O"
                    title: "Ppeak"
                    value: 19
                }

                SidebarData {
                    id: sidebarData
                    max: 0
                    title: "Pmean"
                    units: "cmH2O"
                    value: 11
                }

                SidebarData {
                    id: sidebarData2
                    units: "l/min"
                    title: "ExpMinVol"
                    value: 7.5
                }

                SidebarData {
                    id: sidebarData3
                    max: 750
                    min: 250
                    title: "VTE"
                    units: "ml"
                    value: 500
                }

                SidebarData {
                    id: sidebarData4
                    max: 23
                    min: 8
                    title: "Rate"
                    units: "b/min"
                    value: 20
                }
            }


        }


        Rectangle {
            id: rectangle
            height: 45
            color: Config.col_dark_grey
            anchors.bottomMargin: 5
            anchors.bottom: sideBarIcons.top
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Text {
                id: element
                height: 50
                color: "white"
                text: qsTr("VAC")
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                font.pixelSize: 30
            }
        }

        SideBarIcons {
            id: sideBarIcons
            y: 778
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

}



/*##^##
Designer {
    D{i:0;height:800;width:200}D{i:18;anchors_y:778}D{i:17;anchors_height:200;anchors_width:200}
D{i:19;anchors_y:778}
}
##^##*/
