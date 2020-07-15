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

    signal clicked()

    Item {
        id: txte
    }

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

        Rectangle
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"; border.width: 1
            Layout.minimumHeight: 30
            Layout.minimumWidth: 30
            border.color: isAccepted==0? "grey":isAccepted==1? "green":"red"
            radius: 5

            Text{
                id: txt; visible: true
                font.pixelSize: 16
                text: Qt.formatDateTime(new Date(), "HH:mm AP")
                color: "#535353"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: titleitempane.clicked()
            }
        }
    }
}
