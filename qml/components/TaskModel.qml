import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: tasktextcontent.height+70

    property string taskcategorycolor: taskcategorycolor
    property string taskstarttime: taskstarttime
    property string taskcategory: taskcategory
    property string taskendtime: taskendtime
    property string tasktitle: tasktitle
    property string tasktext: tasktext

    signal clicked()

    RowLayout
    {
        anchors.fill: parent
        spacing: 5

        Item
        {
            width: 30
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft
            clip: true

            Rectangle
            {
                color: "transparent"
                width: 28; height: width
                radius: 5
                border.width: 2
                border.color: "grey"
                anchors.top: parent.top
            }

            Column
            {
                height: parent.height-28; width: 28
                anchors.bottom: parent.bottom
                spacing: 4

                Repeater
                {
                    model: 30
                    Rectangle
                    {
                        width: 1; height: 2; color: "grey"; opacity: 0.7
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        Text
        {
            text: taskstarttime
            textFormat: Text.StyledText
            color: "#555555"
            font.pixelSize: 18
            height: 30
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignTop|Qt.AlignLeft
        }

        Item
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle
            {
                id: colorlabel
                color: taskcategorycolor
                width: 20
                height: parent.height
                radius: 5
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle
            {
                color: "white"
                width: parent.width-5; height: parent.height
                anchors.left: parent.left; anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter

                Rectangle
                {
                    anchors.fill: parent
                    color: Qt.rgba(230/255,230/255,230/255,0.5)

                    Item
                    {
                        anchors.fill: parent
                        anchors.margins: 5

                        Text
                        {
                            font.pixelSize: 14
                            color: taskcategorycolor
                            text: tasktitle
                        }

                        AppIcon
                        {
                            color: "#555555"
                            size: 14
                            icon: "\uf057"
                            anchors.right: parent.right
                            anchors.top: parent.top

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    console.log("Close task pane clicked")
                                    root.clicked()
                                }
                            }
                        }

                        ColumnLayout
                        {
                            anchors.topMargin: 20
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right

                            Text
                            {
                                font.pixelSize: 10
                                color: "grey"; opacity: 0.6
                                text: taskstarttime+" - "+taskendtime
                            }

                            Text
                            {
                                id: tasktextcontent
                                font.pixelSize: 10
                                color: "grey"
                                text: tasktext
                                wrapMode: Text.WordWrap
                                Layout.minimumHeight: 50
                                Layout.maximumHeight: 400
                                Layout.fillWidth: true
                            }

                            Item {
                                Layout.fillWidth: true; height: 20

                                RowLayout
                                {
                                    anchors.fill: parent

                                    Rectangle
                                    {
                                        color: "transparent"
                                        border.width: 1
                                        border.color: colorlabel.color
                                        width: 10; height: width; radius: height/2
                                        Layout.alignment: Qt.AlignVCenter
                                    }

                                    Text
                                    {
                                        font.pixelSize: 10
                                        color: "#535353"
                                        text: taskcategory
                                        Layout.alignment: Qt.AlignVCenter
                                    }

                                    Spacer
                                    {
                                        orientation: "horizontal"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
