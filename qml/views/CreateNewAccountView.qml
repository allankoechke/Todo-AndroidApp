import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.12
import "../components"

Item
{
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    Item
    {
        anchors.fill: parent
        anchors.margins: 20

        ColumnLayout
        {
            anchors.fill: parent
            spacing: 20

            Item
            {
                Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                Layout.topMargin: 20
                Layout.fillWidth: true
                height: 50

                Item
                {
                    anchors.fill: parent

                    RowLayout
                    {
                        anchors.fill: parent

                        Item
                        {
                            Layout.fillHeight: true
                            Layout.preferredWidth: 50

                            AppIcon
                            {
                                icon: "\uf04b"
                                size: 40
                                color: mainQmlApp.themeColor
                                anchors.centerIn: parent
                            }


                            AppIcon
                            {
                                size: 18
                                icon: "\uf00c"
                                color: "white"
                                anchors.centerIn: parent
                            }
                        }

                        Text
                        {
                            font.pixelSize: 16
                            text: qsTr("To Do")
                            font.bold: true
                            color: mainQmlApp.themeColor
                        }

                        Spacer
                        {
                            orientation: "horizontal"
                        }
                    }
                }
            }

            Text
            {
                font.pixelSize: 20
                text: qsTr("Sign Up")
                font.bold: true
                color: "#555555"
            }

            Text
            {
                font.pixelSize: 14
                text: "Create an account to use To Do<br><font color=\"orange\">without limits</font>. For free"
                color: "#555555"
                textFormat: Text.StyledText
            }

            TextBoxInput
            {
                id: email
                hintText: qsTr("Email/Username")
            }

            TextBoxInput
            {
                id: password
                hintText: qsTr("Password")
                isPasswordField: true
            }

            TextBoxInput
            {
                id: passwordConfirm
                hintText: qsTr("Repeat password")
                isPasswordField: true
            }

            Text
            {
                id: error
                visible: false
                color: "red"
                font.pixelSize: 14
            }

            Rectangle
            {
                height: 50
                radius: height/2
                Layout.fillWidth: true
                color: '#e1eeff'
                Layout.topMargin: 10
                Layout.bottomMargin: 10

                Text
                {
                    text: qsTr("Sign up")
                    color: "#1178e9"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        if(password.textComponent.text===passwordConfirm.textComponent.text)
                        {
                            try
                            {
                                var db = mainQmlApp.getDb()

                                db.transaction(
                                            function(tx)
                                            {
                                                var _email = email.textComponent.text
                                                var _pswd = password.textComponent.text
                                                var result = tx.executeSql("insert into \"User\" values(?,?)", [_email, _pswd]);
                                            })

                                mainAppStackLayout.currentIndex=1

                                email.textComponent.text=""
                                password.textComponent.text=""
                                passwordConfirm.textComponent.text=""
                                error.visible=false
                                error.text=""

                                console.log("User saved succesfully")

                            } catch (err){
                                console.log(err)
                            }
                        }

                        else
                        {
                            error.visible=true
                            error.text=qsTr("The passwords do not match!")
                        }
                    }
                }
            }

            Text
            {
                font.pixelSize: 14
                text: "I already have an account. <font color=\"orange\">Log in</font>"
                color: "#555555"
                textFormat: Text.StyledText
                Layout.alignment: Qt.AlignHCenter

                MouseArea
                {
                    anchors.fill: parent

                    onClicked: {
                        email.textComponent.text=""
                        password.textComponent.text=""
                        passwordConfirm.textComponent.text=""
                        mainAppStackLayout.currentIndex=1
                    }
                }
            }
        }
    }
}
