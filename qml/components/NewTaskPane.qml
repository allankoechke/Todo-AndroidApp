import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item
{
    id: root
    anchors.fill: parent

    property bool isError: false
    property string errorLabel: ""
    property int taskAccepted: 0
    property int errorInt: 0

    property string fromTimeProperty
    property string toTimeProperty

    Connections
    {
        target: timePickerMain
        onTimepopupClosed:{
            if(isStartTimeSelected)
            {
                fromTimeProperty = mainQmlApp.timeString
                fromTime.textInput.text = Qt.formatDateTime(fromTimeProperty, "HH:mm AP")
            }
            else
            {
                toTimeProperty = mainQmlApp.timeString
                toTime.textInput.text = Qt.formatDateTime(toTimeProperty, "HH:mm AP")
            }
        }
    }

    function resetAllFields()
    {
        taskAccepted=0
        title.isAccepted=0
        fromTime.isAccepted=0
        toTime.isAccepted=0
        category.isAccepted=0

        title.textInput.text=""
        fromTime.textInput.text=Qt.formatDateTime(new Date(), "hh:mm AP")
        toTime.textInput.text=Qt.formatDateTime(new Date(), "hh:mm AP")
        category.textInput.currentIndex=0
        taskdescription.text=""
    }

    function resetFields()
    {
        switchToTasks.running=true
        errortext.text="Task saved!"
        errortext.visible=true

        resetAllFields()
        errorInt=0
    }

    onErrorIntChanged: {
        console.log("Error int changed")

        if(errorInt===0)
        {
            isError=false
            errorLabel=""
            errortext.visible=false
        }
        else
        {
            errortext.visible=true
            isError=true
            errortext.text=errorLabel
        }
    }

    Timer
    {
        id: switchToTasks
        repeat: false
        running: false
        interval: 1500

        onTriggered: {
            isError=false
            errortext.text=""
            errortext.visible=false
            currentNavIndex=0
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 5

        TextInputWithTag
        {
            id: title
            textInput.placeholderText: qsTr("Enter task title")
            textInput.placeholderTextColor: "grey"
            textTitle.text: qsTr("Task title")
        }

        Text {
            Layout.preferredHeight: 15
            text: qsTr("Timespan")
            font.pixelSize: 12
            color: "grey"
        }

        Item{
            Layout.preferredHeight: 40
            Layout.fillWidth: true

            RowLayout{
                anchors.fill: parent

                TextAndATag
                {
                    id: fromTime
                    textTitle.text: qsTr("Start")
                    textInput.text: fromTimeProperty===""? Qt.formatDateTime(new Date(), "HH:mm AP"):Qt.formatDateTime(Date.fromLocaleString(Qt.locale(), fromTimeProperty, "yyyy-MM-dd HH-mm AP"), "HH:mm AP")
                    onClicked: {
                        isStartTimeSelected: true
                        mainQmlApp.timePickerMain.open()
                    }
                }

                TextAndATag
                {
                    id: toTime
                    textTitle.text: qsTr("End")
                    textInput.text: toTimeProperty===""? Qt.formatDateTime(new Date(), "HH:mm AP"):Qt.formatDateTime(Date.fromLocaleString(Qt.locale(), toTimeProperty, "yyyy-MM-dd HH-mm AP"), "HH:mm AP")
                    onClicked: {
                        isStartTimeSelected = false
                        mainQmlApp.timePickerMain.open()
                    }
                }
            }
        }

        Text {
            Layout.preferredHeight: 15
            text: qsTr("Task category & preferred color")
            font.pixelSize: 12
            color: "grey"
        }

        Item {
            Layout.preferredHeight: 40
            Layout.fillWidth: true

            RowLayout{
                anchors.fill: parent

                ComboBoxWithATag
                {
                    id: category
                    textTitle.text: qsTr("Category")
                }
            }
        }

        ScrollView
        {
            Layout.minimumHeight: 100
            Layout.maximumHeight: 600
            Layout.minimumWidth: root.width-40
            Layout.fillHeight: true
            Layout.fillWidth: true

            TextArea
            {
                id: taskdescription
                placeholderText: qsTr("Enter descriptio of the task")
                placeholderTextColor: "grey"
                selectByMouse: true
                wrapMode: TextArea.WordWrap

                background: Rectangle{
                    radius: 4
                    border.width: 1
                    border.color: taskAccepted===0? "grey":taskAccepted===1? "green":"red"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.IBeamCursor
                    acceptedButtons: Qt.NoButton
                }
            }
        }

        Text {
            id: errortext
            visible: false
            Layout.preferredHeight: 15
            text: qsTr("")
            font.pixelSize: 12
            color: isError? "red":"green"
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            Layout.margins: 20
            color: mainQmlApp.themeColor
            radius: 15

            Text {
                text: qsTr("Save task")
                font.pixelSize: 15
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    var _title = title.textInput.text
                    var _fromTime = fromTime.textInput.text
                    var _toTime = toTime.textInput.text
                    var _category = category.textInput.currentIndex
                    var _task = taskdescription.text

                    var passed = true

                    if(_title === "")
                    {
                        title.isAccepted=2
                        errorLabel="Empty field(s) found!"
                        errorInt=1
                        passed=false
                    }

                    else{
                        title.isAccepted=1
                    }

                    if(_task === "")
                    {
                        taskAccepted=2
                        errorInt=6
                        passed=false
                        errorLabel="Empty field(s) found!"
                    }

                    else{
                        taskAccepted=1
                    }

                    if(passed)
                    {
                        var db = mainQmlApp.getDb()
                        try{
                            db.transaction(
                                        function (tx)
                                        {

                                            tx.executeSql("INSERT INTO \"Task\" (email, category, title, start, stop, content) VALUES (?,?,?,?,?,?)",
                                                          [mainQmlApp.userEmail, _category,_title,fromTimeProperty,toTimeProperty, _task]);

                                            console.log(" Saved!")

                                            resetFields()
                                        }
                                        );
                        } catch (err) {
                            console.log(err)
                        }
                    }
                }
            }

        }
    }
}
