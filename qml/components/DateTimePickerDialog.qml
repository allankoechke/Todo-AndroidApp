import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import Qt.labs.calendar 1.0
import QtQuick.Layouts 1.3

//property var currentDateSelected: Qt.formatDate(new Date(), 'yyyy-MM-dd')


Rectangle {
    id: mainForm
    height: cellSize * 12
    width: cellSize * 8

    property var _ampm: ["AM", "PM"]
    property string timeString: ""
    readonly property int hours: hoursTumbler.currentIndex+1
    readonly property int minutes: minutesTumbler.currentIndex
    readonly property string ampm: _ampm[amPmTumbler.currentIndex]

    onHoursChanged: getTime()
    onMinutesChanged: getTime()
    onAmpmChanged: getTime()

    function getHour()
    {
        var _hours;
        if(ampm==="AM")
        {
            if(hours===12)
                _hours = 0
            else
                _hours=hours
        } else {
            if(hours===12)
                _hours = 12
            else
                _hours=hours+12
        }
        return _hours
    }

    function getTime()
    {
        var hr = getHour()
        var h = hr<10? "0"+hr.toString():hr.toString()
        var m = minutes<10? "0"+minutes.toString():minutes.toString()
        timeString = h + ":" +m
    }

    function getDateTime()
    {
        var date_ = ""

        var mo = (calendar.currentMonth+1)<10? "0"+(calendar.currentMonth+1).toString():(calendar.currentMonth+1).toString()
        var d = calendar.currentDay<10? "0"+calendar.currentDay.toString():calendar.currentDay.toString()

        date=calendar.currentYear.toString() + "-" + mo + "-" + d + "T" + timeString+":00:000+03:00"

        console.log(date)
        return date
    }

    function formatText(count, modelData) {
        var data = count === 12 ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }

    Component.onCompleted: {
        timePicker.hide()
        getTime()
    }

    property double mm: Screen.pixelDensity
    property double cellSize: mm * 7
    property int fontSizePx: cellSize * 0.32
    property var date: new Date(calendar.currentYear, calendar.currentMonth, calendar.currentDay);



    clip: true

    signal ok
    signal cancel

    QtObject {
        id: palette
        property color primary: "#00BCD4"
        property color primary_dark: "#0097A7"
        property color primary_light: "#B2EBF2"
        property color accent: "#FF5722"
        property color primary_text: "#212121"
        property color secondary_text: "#757575"
        property color icons: "#FFFFFF"
        property color divider: "#BDBDBD"
    }

    Rectangle {
        id: titleOfDate
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        height: 2.5 * mainForm.cellSize
        width: parent.width
        color: palette.primary_dark
        z: 2

        Rectangle {
            id: selectedYear
            anchors {
                top: parent.top
                left: parent.left
                right: selectedTime.left
            }
            height: mainForm.cellSize * 1
            color: parent.color

            Text {
                id: yearTitle
                anchors.fill: parent
                leftPadding: mainForm.cellSize * 0.5
                topPadding: mainForm.cellSize * 0.5
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: mainForm.fontSizePx * 1.7
                opacity: yearsList.visible ? 1 : 0.7
                color: "white"
                text: calendar.currentYear
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    yearsList.show();
                }
            }
        }

        Rectangle {
            id: selectedTime
            anchors {
                top: parent.top
                right: parent.right
            }
            height: mainForm.cellSize * 1
            color: parent.color
            width: parent.width/2

            Text {
                id: timeTitle
                anchors.fill: parent
                leftPadding: mainForm.cellSize * 0.5
                topPadding: mainForm.cellSize * 0.5
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: mainForm.fontSizePx * 1.7
                opacity: yearsList.visible ? 1 : 0.7
                color: "white"
                text: timeString+" Hrs"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    timePicker.show()
                }
            }
        }

        Text {
            id: selectedWeekDayMonth
            anchors {
                left: parent.left
                right: parent.right
                top: selectedYear.bottom
                bottom: parent.bottom
            }
            leftPadding: mainForm.cellSize * 0.5
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height * 0.5
            text: calendar.weekNames[calendar.week].slice(0, 3) + ", " + calendar.currentDay + " " + calendar.months[calendar.currentMonth].slice(0, 3)
            color: "white"
            opacity: yearsList.visible ? 0.7 : 1
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    yearsList.hide();
                }
            }
        }
    }

    ListView {
        id: calendar
        anchors {
            top: titleOfDate.bottom
            left: parent.left
            right: parent.right
            leftMargin: mainForm.cellSize * 0.5
            rightMargin: mainForm.cellSize * 0.5
        }
        height: mainForm.cellSize * 8
        visible: true
        z: 1

        snapMode: ListView.SnapToItem
        orientation: ListView.Horizontal
        spacing: mainForm.cellSize
        model: CalendarModel {
            id: calendarModel
            from: new Date(new Date().getFullYear(), 0, 1);
            to: new Date(new Date().getFullYear(), 11, 31);
            function  setYear(newYear) {
                if (calendarModel.from.getFullYear() > newYear) {
                    calendarModel.from = new Date(newYear, 0, 1);
                    calendarModel.to = new Date(newYear, 11, 31);
                } else {
                    calendarModel.to = new Date(newYear, 11, 31);
                    calendarModel.from = new Date(newYear, 0, 1);
                }
                calendar.currentYear = newYear;
                calendar.goToLastPickedDate();
                mainForm.setCurrentDate();
            }
        }

        property int currentDay: new Date().getDate()
        property int currentMonth: new Date().getMonth()
        property int currentYear: new Date().getFullYear()
        property int week: new Date().getDay()
        property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        property var weekNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

        delegate: Rectangle {
            height: mainForm.cellSize * 8.5 //6
            width: mainForm.cellSize * 7
            Rectangle {
                id: monthYearTitle
                anchors {
                    top: parent.top
                }
                height: mainForm.cellSize * 1.3
                width: parent.width

                Text {
                    anchors.centerIn: parent
                    font.pixelSize: mainForm.fontSizePx * 1.2
                    text: calendar.months[model.month] + " " + model.year;
                }
            }

            DayOfWeekRow {
                id: weekTitles
                Layout.column: 1
                locale: monthGrid.locale
                anchors {
                    top: monthYearTitle.bottom
                }
                height: mainForm.cellSize
                width: parent.width
                delegate: Text {
                    text: model.shortName
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: mainForm.fontSizePx
                }
            }

            MonthGrid {
                id: monthGrid
                month: model.month
                year: model.year
                spacing: 0
                anchors {
                    top: weekTitles.bottom
                }
                width: mainForm.cellSize * 7
                height: mainForm.cellSize * 6

                locale: Qt.locale("en_US")
                delegate: Rectangle {
                    height: mainForm.cellSize
                    width: mainForm.cellSize
                    radius: height * 0.5
                    property bool highlighted: enabled && model.day === calendar.currentDay && model.month == calendar.currentMonth

                    enabled: model.month === monthGrid.month
                    color: enabled && highlighted ? palette.primary_dark : "white"

                    Text {
                        anchors.centerIn: parent
                        text: model.day
                        font.pixelSize: mainForm.fontSizePx
                        scale: highlighted ? 1.25 : 1
                        Behavior on scale { NumberAnimation { duration: 150 } }
                        visible: parent.enabled
                        color: parent.highlighted ? "white" : "black"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            calendar.currentDay = model.date.getDate();
                            calendar.currentMonth = model.date.getMonth();
                            calendar.week = model.date.getDay();
                            calendar.currentYear = model.date.getFullYear();
                            mainForm.setCurrentDate();
                        }
                    }
                }
            }
        }


        Component.onCompleted: goToLastPickedDate()
        function goToLastPickedDate() {
            positionViewAtIndex(calendar.currentMonth, ListView.SnapToItem)
        }
    }

    ListView {
        id: yearsList
        anchors.fill: calendar
        orientation: ListView.Vertical
        visible: false
        z: calendar.z

        property int currentYear
        property int startYear: new Date().getFullYear()
        property int endYear : 2050
        model: ListModel {
            id: yearsModel
        }

        delegate: Rectangle {
            width: parent.width
            height: mainForm.cellSize * 1.5
            Text {
                anchors.centerIn: parent
                font.pixelSize: mainForm.fontSizePx * 1.5
                text: name
                scale: index == yearsList.currentYear - yearsList.startYear ? 1.5 : 1
                color: palette.primary_dark
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    calendarModel.setYear(yearsList.startYear + index);
                    yearsList.hide();
                }
            }
        }

        Component.onCompleted: {
            for (var year = startYear; year <= endYear; year ++)
                yearsModel.append({name: year});
        }
        function show() {
            visible = true;
            calendar.visible = false
            timePicker.visible=false
            currentYear = calendar.currentYear
            yearsList.positionViewAtIndex(currentYear - startYear, ListView.SnapToItem);
        }
        function hide() {
            visible = false;
            calendar.visible = true;
            timePicker.visible=false
        }
    }

    Rectangle {
        id: timePicker
        visible: false
        //anchors.centerIn: mainForm
        anchors.bottomMargin: 40
        width: parent.width//frame.implicitWidth + 10
        height: parent.height//frame.implicitHeight + 10

        FontMetrics {
            id: fontMetrics
        }

        Component {
            id: delegateComponent

            Label {
                text: formatText(Tumbler.tumbler.count, modelData)
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: fontMetrics.font.pixelSize * 1.25
            }
        }

        Frame {
            id: frame
            padding: 0
            anchors.centerIn: parent

            Row {
                id: row

                Tumbler {
                    id: hoursTumbler
                    model: 12
                    delegate: delegateComponent
                    currentIndex: Qt.formatTime(new Date(), "hh")>12? Qt.formatTime(new Date(), "hh")-13:Qt.formatTime(new Date(), "hh")-1
                }

                Text
                {
                    text: ":"
                    font.pixelSize: 15
                    font.bold: true
                    color: "black"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Tumbler {
                    id: minutesTumbler
                    model: 60
                    delegate: delegateComponent
                    currentIndex: Qt.formatTime(new Date(), "mm")
                }

                Tumbler {
                    id: amPmTumbler
                    model: ["AM", "PM"]
                    delegate: delegateComponent
                    currentIndex: Qt.formatDate(new Date(), "AP")==="AM"? 0:1
                }
            }
        }

        function show() {
            visible = true;
            calendar.visible = false
            yearsList.visible = false;
        }
        function hide() {
            visible = false;
            calendar.visible = true;
            yearsList.visible = false;
        }
    }


    Rectangle {
        height: mainForm.cellSize * 1.5
        anchors {
            top: calendar.bottom
            topMargin: 40
            right: parent.right
            rightMargin: mainForm.cellSize * 0.5
        }
        z: titleOfDate.z
        color: "black"
        Row {
            layoutDirection: "RightToLeft"
            anchors {
                right: parent.right
            }
            height: parent.height

            Rectangle {
                id: okBtn
                height: parent.height
                width: okBtnText.contentWidth + mainForm.cellSize
                Text {
                    id: okBtnText
                    anchors.centerIn: parent
                    font.pixelSize: mainForm.fontSizePx * 1.8
                    color: palette.primary_dark
                    text: "OK"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        timePicker.hide()
                        mainForm.ok();
                    }
                }
            }
            Rectangle {
                id: cancelBtn
                height: parent.height
                width: cancelBtnText.contentWidth + mainForm.cellSize
                Text {
                    id: cancelBtnText
                    anchors.centerIn: parent
                    font.pixelSize: mainForm.fontSizePx * 1.8
                    color: palette.primary_dark
                    text: "CANCEL"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        timePicker.hide()
                        mainForm.cancel();
                    }
                }
            }
        }
    }

    function setCurrentDate() {
        mainForm.date = new Date(calendar.currentYear, calendar.currentMonth, calendar.currentDay);
    }

}
