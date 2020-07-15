import QtQuick 2.0
import QtQuick.Layouts 1.3

Item
{
    id: root
    Layout.preferredHeight: 30
    Layout.fillWidth: true

    signal clicked()
    property string menuText: ""

    Text
    {
        text: menuText
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width-5
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 14
        color: "#535353"
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
