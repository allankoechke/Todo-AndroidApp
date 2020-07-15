import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"

Item {
    id: root
    anchors.fill: parent

    property string time

    signal clicked()

    Component.onCompleted: {
        if (time==="")
        {
            time= Qt.formatDateTime(new Date(), "yyyy-MM-ddThh:mm:ss:zzz")
            mainQmlApp.actView.newTaskPane.fromTimeProperty=time
            mainQmlApp.actView.newTaskPane.toTimeProperty=time
        }

    }

    DateTimePickerDialog
    {
        anchors.fill :parent
        anchors.margins: 20

        onCancel: mainQmlApp.timePickerMain.close()

        onOk: {
            time = new Date(Date.parse(getDateTime()))
            mainQmlApp.timePickerMain.close()
        }
    }

}
