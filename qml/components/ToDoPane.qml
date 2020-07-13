import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item
{
    anchors.fill: parent

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 5

        Rectangle{
            Layout.preferredHeight: 250
            Layout.fillWidth: true
            color: "#fe7f22"
            radius: 5

            Item
            {
                height: 30; width: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20

                RowLayout
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5

                    Text {
                        text: qsTr("Weekly")
                        color: "white"
                        font.pixelSize: 15
                    }

                    AppIcon
                    {
                        color: "white"
                        size: 15
                        icon: "\uf107"
                    }
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: console.log("Display options popup")
                }
            }

            RoundProgressBar
            {
                id: pb
                width: 110
                showText: false
                suffixText: ""
                dialWidth: 10
                progressColor: "white"
                foregroundColor: "#ff9b4d"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: bottonRect.top
                anchors.bottomMargin: 10

                value: 70

                ColumnLayout
                {
                    anchors.centerIn: parent

                    Text
                    {
                        font.pixelSize: 22
                        font.bold: true
                        text: pb.value+"%"
                        Layout.alignment: Qt.AlignHCenter
                        color: "white"
                    }

                    Text
                    {
                        font.pixelSize: 14
                        text: qsTr("Efficacy")
                        Layout.alignment: Qt.AlignHCenter
                        color: "white"
                    }
                }
            }

            Rectangle
            {
                id: bottonRect
                height: 70; width: parent.width
                radius: 5; color: "#ff8937"
                anchors.bottom: parent.bottom

                RowLayout
                {
                    anchors.fill: parent
                    anchors.margins: 10

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout
                        {
                            anchors.fill: parent

                            Text
                            {
                                color: "white"
                                font.pixelSize: 15
                                text: qsTr("Live")
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text
                            {
                                color: "white"
                                font.pixelSize: 15
                                text: qsTr("16")
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    Rectangle
                    {
                        color: "white"; width: 1; opacity: 0.7; height: 20
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout
                        {
                            anchors.fill: parent

                            Text
                            {
                                color: "white"
                                font.pixelSize: 15
                                text: qsTr("Done")
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text
                            {
                                color: "white"
                                font.pixelSize: 15
                                text: qsTr("19")
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    Rectangle
                    {
                        color: "white"; width: 1; opacity: 0.7; height: 20
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ColumnLayout
                        {
                            anchors.fill: parent

                            Text
                            {
                                color: "white"
                                font.pixelSize: 15
                                text: qsTr("Archive")
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text
                            {
                                color: "white"
                                font.pixelSize: 15
                                text: qsTr("5")
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }
        }

        Item
        {
            id: parentitem
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.bottomMargin: 5

            ScrollView
            {
               clip: true
               width: parentitem.width
               height: parentitem.height
               ScrollBar.vertical.interactive: true
               ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                GridLayout
                {
                    columns: 2
                    columnSpacing: 10
                    rowSpacing: 10
                    width: parentitem.width
                    height: parentitem.height

                    TodoPanelWidget
                    {
                        color: Qt.rgba(252/255,126/255,27/255,.2)
                        Layout.column: 0
                        Layout.row: 0
                        panelicon.icon: "\uf0b1"
                        paneltext{
                            text: qsTr("5")
                            color: Qt.rgba(252/255,126/255,27/255,1)
                        }
                        paneltitle.text: qsTr("Work")
                    }

                    TodoPanelWidget
                    {
                        color: Qt.rgba(144/255,92/255,217/255,.2)
                        Layout.column: 1
                        Layout.row: 0
                        panelicon.icon: "\uf007"
                        paneltext{
                            text: qsTr("7")
                            color: Qt.rgba(144/255,92/255,217/255,1)
                        }
                        paneltitle.text: qsTr("Personal")
                    }

                    TodoPanelWidget
                    {
                        color: Qt.rgba(18/255,119/255,235/255,.2)
                        Layout.column: 0
                        Layout.row: 1
                        panelicon.icon: "\uf21e"
                        paneltext{
                            text: qsTr("4")
                            color: Qt.rgba(18/255,119/255,235/255,1)
                        }
                        paneltitle.text: qsTr("Health")
                    }


                    Rectangle
                    {
                        id: addnew
                        color: "#fef1fa"
                        radius: 5
                        Layout.fillWidth: true
                        Layout.preferredHeight: width
                        Layout.column: 1
                        Layout.row: 1

                        ColumnLayout
                        {
                            anchors.centerIn: parent

                            AppIcon
                            {
                                color: "black"
                                size: 20
                                icon: "\uf067"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text
                            {
                                text: qsTr("Add")
                                font.pixelSize: 18
                                Layout.alignment: Qt.AlignHCenter
                                color: "black"
                            }
                        }
                    }
                }
            }
        }

        Item {
            visible: false //parentitem.height>(addnew.height*2) + 30
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
