import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item
{
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int currentNavIndex: 0

    Item
    {
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
            visible: currentNavIndex===1
        }

        TodaysTaskPane
        {
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
}
