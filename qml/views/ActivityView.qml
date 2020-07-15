import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item
{
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int currentNavIndex: 0
    property alias titlebar: titlebar
    property alias taskOptionsPopup: taskOptionsPopup
    property alias newTaskPane: newTaskPane

    onCurrentNavIndexChanged: {
        if(currentNavIndex===0)
            countActivity()

        if(currentNavIndex===1)
            newTaskPane.resetAllFields()

        if(currentNavIndex===2){
            todaysTaskPane.refreshLoadedModel()
        }
    }

    function countActivity()
    {
        var db = mainQmlApp.getDb()

        try{
            db.transaction(
                        function (tx)
                        {
                            var category = 0
                            var response = tx.executeSql("SELECT id from \"Task\" WHERE category=?",
                                                     category);
                            mainQmlApp.workTaskCount = response.rows.length

                            category = 1
                            response = tx.executeSql("SELECT id from \"Task\" WHERE category=?",
                                                     category);
                            mainQmlApp.personalTaskCount = response.rows.length

                            category = 2
                            response = tx.executeSql("SELECT id from \"Task\" WHERE category=?",
                                                     category);
                            mainQmlApp.healthTaskCount = response.rows.length

                            category = 3
                            response = tx.executeSql("SELECT id from \"Task\" WHERE category=?",
                                                     category);
                            mainQmlApp.otherTaskCount = response.rows.length
                        });
        } catch (err){
            console.log("ActivityView: ", err)
        }
    }

    function setArchived(id)
    {
        var db = mainQmlApp.getDb()

        try{
            db.transaction(
                        function (tx)
                        {
                            var response = tx.executeSql("UPDATE \"Task\" SET archived = ? WHERE id =?",
                                                     [1,id]);

                            todaysTaskPane.refreshLoadedModel()
                            console.log("Archived")
                            taskOptionsPopup.close()
                        });
        } catch (err){
            console.log("ActivityView: Archived: ", err)
        }
    }

    function setFinished(id)
    {
        var db = mainQmlApp.getDb()

        try{
            db.transaction(
                        function (tx)
                        {
                            var response = tx.executeSql("UPDATE \"Task\" SET finished = ? WHERE id = ?",
                                                     [1,id]);

                            todaysTaskPane.refreshLoadedModel()
                            console.log("Finished")
                            taskOptionsPopup.close()
                        });
        } catch (err){
            console.log("ActivityView: Finished: ", err)
        }
    }

    function setDelete(id)
    {
        var db = mainQmlApp.getDb()

        try{
            db.transaction(
                        function (tx)
                        {
                            var response = tx.executeSql("DELETE FROM \"Task\" WHERE id = ?",
                                                     [1,id]);

                            todaysTaskPane.refreshLoadedModel()
                            console.log("Deleted")
                            taskOptionsPopup.close()
                        });
        } catch (err){
            console.log("ActivityView: Delete: ", err)
        }
    }

    Component.onCompleted: countActivity()

    Item{
        id: titlebar
        height: 50; width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left


        Text
        {
            id: activityTitle
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "black"; opacity: 0.8
            text: currentNavIndex===0? qsTr("To do"):currentNavIndex===1? qsTr("New Task"):qsTr("Today's Task")
        }

        Item
        {
            width: 30; height: width
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            AppIcon
            {
                color: "#a9a9a9"
                size: 15
                icon: "\uf142"
                anchors.centerIn: parent
            }
        }

        Rectangle
        {
            height: 2; width: parent.width
            color: " grey"; opacity: 0.2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }
    }

    // Center item
    Item
    {
        width: parent.width
        anchors.top: titlebar.bottom
        anchors.bottom: navbar.top
        anchors.bottomMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        clip: true

        ToDoPane
        {
            visible: currentNavIndex===0
        }

        NewTaskPane
        {
            id: newTaskPane
            visible: currentNavIndex===1
        }

        TodaysTaskPane
        {
            id: todaysTaskPane
            visible: currentNavIndex===2
        }
    }


    Rectangle
    {
        height: 2; width: parent.width
        color: " grey"; opacity: 0.2
        anchors.bottom: navbar.top
        anchors.left: parent.left
    }

    Item
    {
        id: navbar
        height: 50; width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        RowLayout
        {
            anchors.fill: parent
            spacing: 10

            NavigationBarItem
            {
                navIcon: "\uf550"
                navText: qsTr("Home")
                isNavItemActive: currentNavIndex===0
                onClicked: currentNavIndex=0
            }

            NavigationBarItem
            {
                navIcon: "\uf055"
                navText: qsTr("Add Task")
                isNavItemActive: currentNavIndex===1
                onClicked: currentNavIndex=1
            }

            NavigationBarItem
            {
                navIcon: "\uf0ae"
                navText: qsTr("Today's Task")
                isNavItemActive: currentNavIndex===2
                onClicked: currentNavIndex=2
            }
        }
    }

    Popup
    {
        id: taskOptionsPopup
        x: mainQmlApp.width-width -30
        y: taskOptionsPopupY  //200
        width: 100
        height: 155
        modal: false; focus: true
        closePolicy: Popup.CloseOnPressOutside

        contentItem: Item {
            anchors.fill: parent
            anchors.margins: 0

            ColumnLayout
            {
                anchors.fill: parent
                spacing: 0
                anchors.topMargin: 5
                anchors.bottomMargin: 5

                Rectangle
                {
                    color: "grey"; height: 1; Layout.fillWidth: true; opacity: 0.5
                }

                MenuButton
                {
                    menuText: qsTr("Finished")
                    onClicked: { setFinished(currentListItemId) }
                }
                Rectangle
                {
                    color: "grey"; height: 1; Layout.fillWidth: true; opacity: 0.5
                }

                MenuButton
                {
                    menuText: qsTr("Archive")
                    onClicked: { setArchived(currentListItemId) }
                }
                Rectangle
                {
                    color: "grey"; height: 1; Layout.fillWidth: true; opacity: 0.5
                }

                MenuButton
                {
                    menuText: qsTr("Delete")
                    onClicked: { setDelete(currentListItemId) }
                }
                Rectangle
                {
                    color: "grey"; height: 1; Layout.fillWidth: true; opacity: 0.5
                }

                MenuButton
                {
                    visible: false
                    menuText: qsTr("Edit")
                    onClicked: {}
                }

                Rectangle
                {
                    visible: false
                    color: "grey"; height: 1; Layout.fillWidth: true
                }
            }
        }

        onClosed: {
        }
    }
}
