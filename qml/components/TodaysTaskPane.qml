import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item
{
    id: root
    anchors.fill: parent

    property int currentModelItemIndex: 0
    property string modelXML: ""
    property bool isEmpty: false

    function getNextDay(offset)
    {
        const today = new Date()
        const tomorrow = new Date(today)
        tomorrow.setDate(tomorrow.getDate() + offset)
        var dd = Qt.formatDateTime(tomorrow, "dd")

        return dd;
    }

    function getNextDayDate(offset)
    {
        const today = new Date()
        const tomorrow = new Date(today)
        tomorrow.setDate(tomorrow.getDate() + offset)
        var dt = Qt.formatDateTime(tomorrow, "yyyy-MM-dd")
        //console.log("0: ", dt)

        return dt;
    }

    function loadModelData(today)
    {
        var db = mainQmlApp.getDb()

        myListModel.clear()

        //var today = Qt.formatDateTime(new Date(), "yyyy-MM-dd")
        today += "%"
        //console.log("TodaysTaskPane-inline: ", today)

        try
        {
            db.transaction(function (tx){
                var response = tx.executeSql('SELECT id,category,title,start,stop,content,finished,archived FROM \"Task\" WHERE start LIKE ? AND archived = ? ORDER BY start DESC', [today, 0]);
                // ,mainQmlApp.userEmail

                for (var i = 0; i<response.rows.length; i++)
                {
                    var archived_ = response.rows[i].archived;
                    var finished_ = response.rows[i].finished;
                    var status__ = archived_ ===1? 2: finished_===1? 1: 0
                    var begin_ = Qt.formatDateTime(response.rows[i].start, "hh:mm AP")
                    var end_ = Qt.formatDateTime(response.rows[i].stop, "hh:mm AP")

                    myListModel.append({
                                           "id_": response.rows[i].id,
                                           "begin" : begin_,
                                           "end" : end_,
                                           "cat_" : response.rows[i].category,
                                           "topic" : response.rows[i].title,
                                           "content" : response.rows[i].content,
                                           "status" : status__})
                }

                if(response.rows.length>0)
                    isEmpty=false
                else
                    isEmpty=true

            });

        } catch (err) {
            console.log("TodatsTaskPane: ", err)
        }
    }

    ListModel
    {
        id: myListModel
    }

    function refreshLoadedModel()
    {
        loadModelData(getNextDayDate(currentModelItemIndex))
    }

    Component.onCompleted: loadModelData(getNextDayDate(currentModelItemIndex))

    onCurrentModelItemIndexChanged: loadModelData(getNextDayDate(currentModelItemIndex))

    Component
    {
        id: itemDelegateComponent

        TaskModel
        {
            taskstarttime: begin
            taskendtime: end
            taskcategory: cat_
            tasktitle: topic
            tasktext: content
            taskStatus: status
            currentId: id_

            onClicked: {
                var globalCoord = mouseArea.mapToItem(mainQmlApp.actView, 0, 0)
                taskOptionsPopupX = globalCoord.x
                taskOptionsPopupY = globalCoord.y
                mainQmlApp.actView.taskOptionsPopup.open()
                mainQmlApp.currentListItemId = currentId
            }
        }
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
                    model: ["Today", "Tomorrow", getNextDay(2), getNextDay(3), getNextDay(4), getNextDay(5), getNextDay(6), getNextDay(7), getNextDay(8), getNextDay(9), getNextDay(10), getNextDay(11), getNextDay(12), getNextDay(13), getNextDay(14), getNextDay(15), getNextDay(16), getNextDay(17)]

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
            id: scroll_
            visible: !isEmpty
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.interactive: true
            Layout.fillWidth: true
            Layout.minimumHeight: 300
            Layout.fillHeight: true
            spacing: 3
            clip: true

            ColumnLayout
            {
                spacing: 5
                width: parent.width
                height: parent.height
                anchors.topMargin: 5

                ListView
                {
                    id: listElementModel_
                    spacing: 5
                    Layout.preferredWidth: scroll_.width
                    Layout.fillHeight: true
                    delegate: itemDelegateComponent
                    model: myListModel
                }
            }
        }
    }

    Item
    {
        anchors.top: topdateselector.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        width: parent.width
        visible: isEmpty

        ColumnLayout
        {
            anchors.centerIn:  parent
            spacing: 20

            AppIcon
            {
                color: "grey"
                icon: "\uf49e"
                size: 20
                Layout.alignment: Qt.AlignHCenter
            }

            Text
            {
                text: qsTr("Oops! Nothing here")
                color: "grey"
                font.pixelSize: 18
            }
        }
    }
}

