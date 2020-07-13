import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Item
{
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: 40

    property string hintText: ""
    property bool isPasswordField: false
    property alias textComponent: textComponent

    TextField
    {
        id: textComponent
        height: 30; width: parent.width
        anchors.centerIn: parent
        color: "#555555"
        font.pixelSize: 15
        echoMode: isPasswordField? TextInput.Password:TextInput.Normal
        placeholderText: hintText
        inputMethodHints: !isPasswordField? Qt.ImhEmailCharactersOnly:Qt.ImhDialableCharactersOnly

        background: Rectangle{
            color: "white"
        }
    }

    Text
    {
        visible: false
        height: textComponent.height; width: textComponent.width
        anchors.centerIn: textComponent
        color: "grey"
        opacity: 0.8
        font.pixelSize: 14
        text: hintText
    }

    Rectangle
    {
        height: 1; width: parent.width
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        color: "grey"
    }
}
