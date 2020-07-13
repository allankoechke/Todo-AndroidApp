import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.12
import "../components"

Item
{
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
                text: qsTr("Sign In")
                font.bold: true
                color: "#555555"
            }

            Text
            {
                font.pixelSize: 14
                text: "Sign in to your account to use To Do<br><font color=\"orange\">without limits</font>. For free"
                color: "#555555"
                textFormat: Text.StyledText
            }

            TextBoxInput
            {
                id: email
                hintText: qsTr("Email")
            }

            TextBoxInput
            {
                id:password
                hintText: qsTr("Password")
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
                Layout.topMargin: 20
                Layout.bottomMargin: 20

                Text
                {
                    text: qsTr("Sign in")
                    color: "#1178e9"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        if(email.textComponent.text.length < 5)
                        {
                            error.visible=true
                            error.text=qsTr("Email field too short")
                        }

                        else if(password.textComponent.text.length < 5)
                        {
                            error.visible=true
                            error.text=qsTr("Password field too short")
                        }

                        else
                        {
                            try
                            {
                                var db = LocalStorage.openDatabaseSync("ToDoApplicationDB","1.0","Local storage for To Do App", 1000000)

                                var _email = email.textComponent.text
                                var _pswd = password.textComponent.text

                                db.transaction(function(tx){

                                    var result = tx.executeSql("SELECT password FROM \"User\" u WHERE email=? ", _email);

                                    if(result.rows.length===0)
                                    {
                                        error.visible=true
                                        error.text=qsTr("User email not found!")
                                    }

                                    else if(result.rows.item(0).password === _pswd)
                                    {
                                        userEmail = _email

                                        mainAppStackLayout.currentIndex=3

                                        email.textComponent.text=""
                                        password.textComponent.text=""
                                        mainAppStackLayout.currentIndex=3
                                        error.visible=false
                                        error.text=""
                                    }

                                    else
                                    {
                                        error.visible=true
                                        error.text=qsTr("Wrong user password given!")
                                    }
                                })

                            } catch (err){
                                console.log(err)
                            }
                        }
                    }
                }
            }

            Text
            {
                font.pixelSize: 14
                text: "I dont have an account. <font color=\"orange\">Sign up</font>"
                color: "#555555"
                textFormat: Text.StyledText
                Layout.alignment: Qt.AlignHCenter

                MouseArea
                {
                    anchors.fill: parent

                    onClicked: {
                        email.textComponent.text=""
                        password.textComponent.text=""
                        mainAppStackLayout.currentIndex=2
                    }
                }
            }
        }
    }
}
