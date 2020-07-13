import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../components"

Rectangle
{
    id: root
    radius: 5
    Layout.fillWidth: true
    Layout.preferredHeight: width

    property alias paneltext: paneltext
    property alias panelicon: panelicon
    property alias paneltitle: paneltitle

    GridLayout
    {
        anchors.fill: parent
        anchors.margins: 10

        Text
        {
            id: paneltitle
            color: "black"
            font.pixelSize: 16
            Layout.row: 0
            Layout.column: 0
            Layout.columnSpan: 2
        }

        Text
        {
            id: paneltext
            font.pixelSize: 30
            font.bold: true
            Layout.row: 1
            Layout.column: 0
            Layout.alignment: Qt.AlignLeft|Qt.AlignBottom
        }

        AppIcon
        {
            id: panelicon
            Layout.row: 1
            color: paneltext.color
            opacity: 0.5
            Layout.column: 1
            size: root.width/2
            Layout.alignment: Qt.AlignRight|Qt.AlignBottom

        }
    }
}
