import QtQuick 2.0
import QtQuick.Layouts 1.3

Item
{
    property string orientation: "vertical"

    Layout.preferredHeight: 1
    Layout.preferredWidth: 1

    Component.onCompleted: {
        if(orientation==="vertical")
            Layout.fillHeight=true

        else
            Layout.fillWidth=true
    }
}
