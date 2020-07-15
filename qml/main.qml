import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.LocalStorage 2.12

import "./components"
import "./views"

Window {
    id: mainQmlApp
    visible: true
    width: 350
    height: 600

    property alias fontAwesomeFontLoader: fontAwesomeFontLoader
    property alias timePickerMain: timePickerMain
    property alias actView: actView

    property real taskOptionsPopupX
    property real taskOptionsPopupY
    property int currentListItemId

    property var categoryOptions: ["Work", "Personal", "Health", "Others"]
    property string userEmail: ""
    property string themeColor: "#fe7c1e"

    property bool isStartTimeSelected: true
    property string timeString: timePickerPopup.time

    property int workTaskCount: 0
    property int personalTaskCount: 0
    property int healthTaskCount: 0
    property int otherTaskCount: 0

    function getDb()
    {
        return LocalStorage.openDatabaseSync("ToDoApplicationDB","2.0","Local storage for To Do App", 1000000)
    }

    Component.onCompleted: {
        //mainQmlApp.showMaximized()
        //console.log("Finished loading ...")

        var db = getDb()

        try{
            db.transaction(
                        function (tx){
                            tx.executeSql('CREATE TABLE IF NOT EXISTS "User" ("email"	TEXT NOT NULL, "password"	TEXT NOT NULL, PRIMARY KEY("email"))');
                            tx.executeSql('CREATE TABLE IF NOT EXISTS "Task" ("id"	INTEGER NOT NULL, "email"	TEXT NOT NULL, "category"	INTEGER NOT NULL, "title"	TEXT NOT NULL, "start"	TEXT NOT NULL, "stop"	TEXT NOT NULL, "content"	TEXT, "finished"	INTEGER NOT NULL DEFAULT 0, "archived"	INTEGER NOT NULL DEFAULT 0, FOREIGN KEY("email") REFERENCES "User"("email"), PRIMARY KEY("id" AUTOINCREMENT))');
                        })
        } catch (err){
            console.log(" Error creating table database: "+ err)
        }
    }

    FontLoader
    {
        id: fontAwesomeFontLoader
        source: "qrc:/assets/fonts/fontawesome.otf"
    }

    Timer
    {
        running: true
        interval: 5500
        repeat: false

        onTriggered: mainAppStackLayout.currentIndex=1
    }

    StackLayout
    {
        id: mainAppStackLayout
        currentIndex: 0
        anchors.fill: parent

        SplashView{}

        LoginView{}

        CreateNewAccountView{}

        ActivityView{id: actView}
    }

    Popup
    {
        id: timePickerMain
        width: mainQmlApp.width
        height: mainQmlApp.height
        modal: true; focus: true
        closePolicy: Popup.NoAutoClose

        signal timepopupClosed()

        contentItem: TimePickerPopup{
            id: timePickerPopup
            onClicked: timePickerMain.close()

            onTimeChanged: {
                //console.log("Main: ", time)
            }
        }

        onClosed: {
            timePickerMain.timepopupClosed()
        }
    }
}
