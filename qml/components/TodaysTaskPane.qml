import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item
{
    id: root
    anchors.fill: parent

    property int currentModelItemIndex: 0

    function getNextDay(offset)
    {
        const today = new Date()
        const tomorrow = new Date(today)
        tomorrow.setDate(tomorrow.getDate() + offset)
        var dd = Qt.formatDateTime(tomorrow, "dd")

        return dd;
    }

    Item {
        id: topdateselector
        height: 40; width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left

        ScrollView
        {
            id: scroll
            height: parent.height
            width: parent.width
            ScrollBar.horizontal.interactive: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            RowLayout
            {
                anchors.fill: parent

                Repeater
                {
                    model: ["Today", "Tomorrow", getNextDay(2), getNextDay(3), getNextDay(4), getNextDay(5), getNextDay(6), getNextDay(7), getNextDay(8), getNextDay(9)]

                    Item
                    {
                        height: scroll.height
                        width: txt.width>30? (txt.width+5):35

                        Text
                        {
                            id: txt
                            font.bold: currentModelItemIndex===index
                            font.pixelSize: 15
                            text: modelData
                            color: currentModelItemIndex===index? "#fe7d1f":"#555555"
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked: {
                                currentModelItemIndex=index
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle
    {
        color: "grey"; opacity: 0.2
        height: 3; width: parent.width+20
        x: -10
        anchors.top: topdateselector.bottom
    }

    ColumnLayout
    {
        anchors.top: topdateselector.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        spacing: 5; width: parent.width

        ScrollView
        {
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.interactive: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 3
            clip: true

            ColumnLayout
            {
                spacing: 5
                width: parent.width

                TaskModel
                {
                    taskcategorycolor: "#fc7e21"
                    taskstarttime: "7.30 PM"
                    taskendtime: "5:30 PM"
                    taskcategory: "Work"
                    tasktitle: "Project meeting"
                    tasktext: qsTr("ProgressBar also supports a special indeterminate mode, which is useful, for example, when unable to determine the size of the item being downloaded, or if the download progress gets interrupted due to a network disconnection.")
                }

                TaskModel
                {
                    taskcategorycolor: "#1277eb"
                    taskstarttime: "1.00 PM"
                    taskendtime: "1:30 PM"
                    taskcategory: "Health"
                    tasktitle: "Doctor appointment"
                    tasktext: qsTr("When unable to determine the size of the item being downloaded, or if the download progress gets interrupted due to a network disconnection.")
                }

                TaskModel
                {
                    taskcategorycolor: "#fc7e21"
                    taskstarttime: "4.30 PM"
                    taskendtime: "4.50 PM"
                    taskcategory: "Work"
                    tasktitle: "Give project update to client"
                    tasktext: qsTr(" Which is useful when unable to determine the size of the item being downloaded, or if the download progress gets interrupted due to a network disconnection.")
                }

                TaskModel
                {
                    taskcategorycolor: "#8f5cdd"
                    taskstarttime: "7.00 AM"
                    taskendtime: "08:30 AM"
                    taskcategory: "Personal"
                    tasktitle: "Continue with online course"
                    tasktext: qsTr("ProgressBar also supports a special indeterminate mode, which is useful, for example, when unable to determine the size of the item being downloaded, or if the download progress gets interrupted due to a network disconnection.")
                }
            }
        }
    }

}
