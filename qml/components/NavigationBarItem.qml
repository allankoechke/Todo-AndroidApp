import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../components"

Item
{
    id: root
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.minimumWidth: _icon.width>_text.width? _icon.width+10:_text.width+10
    Layout.margins: 5

    property bool isNavItemActive: false
    property string navIcon
    property string navText: ""
    signal clicked()

    Item
    {
        anchors.fill: parent

        ColumnLayout
        {
            anchors.fill: parent
            spacing: 10

            AppIcon
            {
                id: _icon
                color: isNavItemActive? "#484848":"#aaaaaa"
                size: 18; icon: navIcon
                Layout.alignment: Qt.AlignHCenter
            }

            Text
            {
                id: _text
                font.pixelSize: 10
                color: isNavItemActive? "#484848":"#aaaaaa"
                Layout.alignment: Qt.AlignHCenter
                text: navText
            }
        }
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
