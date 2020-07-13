import QtQuick 2.0
import QtQuick.Controls 2.5

Label {

    property string icon
    property real size

    font.family: mainQmlApp.fontAwesomeFontLoader.name
    font.pixelSize: size
    text: icon
}
