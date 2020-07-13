import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.12
import "./views"

Window {
    id: mainQmlApp
    visible: true
    width: 350
    height: 600

    property alias fontAwesomeFontLoader: fontAwesomeFontLoader
    property string userEmail: ""
    property string themeColor: "#fe7c1e"

    Component.onCompleted: {
        //mainQmlApp.showMaximized()
        console.log("Finished loading ...")

        var db = LocalStorage.openDatabaseSync("ToDoApplicationDB","1.0","Local storage for To Do App", 1000000)
        try{
            db.transaction(
                        function (tx){
                            tx.executeSql('CREATE TABLE IF NOT EXISTS "User" ("email"	TEXT NOT NULL, "password"	TEXT NOT NULL, PRIMARY KEY("email"))');
                            tx.executeSql('CREATE TABLE IF NOT EXISTS "Task" ("id"	INTEGER NOT NULL, "email"	TEXT NOT NULL, "category"	TEXT NOT NULL, "title"	TEXT NOT NULL, "start"	TEXT NOT NULL, "stop"	TEXT NOT NULL, "content"	TEXT, "finished"	INTEGER NOT NULL DEFAULT 0, FOREIGN KEY("email") REFERENCES "User"("email"), PRIMARY KEY("id" AUTOINCREMENT), FOREIGN KEY("category") REFERENCES "Category"("category"))');
                            tx.executeSql('CREATE TABLE IF NOT EXISTS "Category" ("category"	TEXT NOT NULL, "color"	TEXT NOT NULL, PRIMARY KEY("category"))');
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
        running: false
        interval: 5500
        repeat: false

        onTriggered: mainAppStackLayout.currentIndex=1
    }

    StackLayout
    {
        id: mainAppStackLayout
        currentIndex: 1
        anchors.fill: parent

        SplashView{}

        LoginView{}

        CreateNewAccountView{}

        ActivityView{}
    }
}
