import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "../components"

Item
{
    Layout.fillHeight: true
    Layout.fillWidth: true

    Timer
    {
        id: tim
        running: true
        repeat: true
        interval: 100

        onTriggered: {
            if(progressValue.value >= 100)
                tim.running=false
            else
                progressValue.value += 2
        }
    }

    Item
    {
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        anchors.rightMargin: 10
        anchors.leftMargin: 10

        ColumnLayout
        {
            anchors.fill: parent

            Spacer{}

            Item
            {
                Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                width: 100; height: 100

                AppIcon
                {
                    icon: "\uf04b"
                    size: 90
                    color: mainQmlApp.themeColor
                    anchors.centerIn: parent

                }


                AppIcon
                {
                    size: 30
                    icon: "\uf00c"
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            Text {
                id: title_
                text: qsTr("To Do")
                color: mainQmlApp.themeColor
                font.bold: true
                font.pixelSize: 30
                Layout.alignment: Qt.AlignHCenter
            }

            Spacer{}

            Item
            {
                Layout.fillWidth: true
                height: 30

                Text
                {
                    color: mainQmlApp.themeColor
                    text: qsTr("Loading ...")
                    font.pixelSize: 12
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text
                {
                    color: mainQmlApp.themeColor
                    text: qsTr("")+progressValue.value.toString()+"%"
                    font.pixelSize: 12
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }


            ProgressBar
            {
                id: progressValue
                value: 0
                from: 0
                to: 100
                Layout.fillWidth: true
            }
        }
    }
}
