import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "../components"

Item {
    id: titleitempane
    Layout.preferredHeight: 40
    Layout.fillWidth: true

    property alias textInput: txt
    property alias textTitle: title
    property int isAccepted: 0

    RowLayout
    {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        Text {
            id: title
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
            color: "#535353"
        }

        ComboBox
        {
            id: txt
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: 16
            model: ["Work", "Personal", "Health", "Others"]

            /*background: Rectangle{
                color: "white"
                border.width: 1
                border.color: isAccepted==0? "grey":isAccepted==1? "green":"red"
                radius: 5

            }*/
        }
    }
}

