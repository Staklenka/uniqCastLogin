import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Page {
    id: loginPage

    signal registerClicked()

    background: Rectangle {
        color: backGroundColor
    }

    // Place title uniqCast and profileImage
    Rectangle {
        id: iconRect
        width: parent.width
        height: parent.height / 2.6
        color: backGroundColor

        Text {
            id: title
            text: qsTr("<b>uniq</b>") + qsTr("Cast")
            font.family: "robotLight"
            color: mainAppColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: (parent.height/6) * -1
            font.pixelSize: Math.round(profilePic.height/3)
        }

        Image {
            id: profilePic
            source: "qrc:/images/profilePic.png"
            sourceSize.width: loginPage.width / 5.5
            sourceSize.height: loginPage.height / 5.5
            anchors.horizontalCenter: iconRect.horizontalCenter
            anchors.bottom: iconRect.bottom
        }
    }

    // UserName, PIN and Login btn
    ColumnLayout {
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height / 6
        spacing: parent.height / 10

        TextField {
            Text {
                id: helpUserName
                text: qsTr("User Name")
                color: mainTextCOlor
                font.pixelSize: Math.round(profilePic.height/5)
                font.family: "robotLight"
                leftPadding: 30
                topPadding: (profilePic.height / 3.5) * -1
            }

            id: loginUsername
            Layout.preferredWidth: title.width * 3
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(profilePic.height/5)
            font.family: "robotLight"
            leftPadding: 30
            background: Rectangle {
                    width: parent.width - 10
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: mainAppColor
            }

            onAccepted:
            {
                loginUser(loginUsername.text, loginPassword.text)
            }
        }

        TextField {
            id: loginPassword
            placeholderText: qsTr("Insert PIN")
            Layout.preferredWidth: title.width * 3
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(profilePic.height/5)
            font.family: "robotoLight"
            leftPadding: 30
            echoMode: TextField.Password
            background: Rectangle {
                    width: parent.width - 10
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: mainAppColor
            }

            onAccepted:
            {
                loginUser(loginUsername.text, loginPassword.text)
            }
        }

        Button{
            id: loginBtn
            Layout.preferredWidth: title.width * 3
            Layout.preferredHeight: profilePic.height
            font.pixelSize: Math.round(profilePic.height/5)
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Log In")

            contentItem: Text {
                text: loginBtn.text
                font: loginBtn.font
                opacity: enabled ? 1.0 : 0.3
                color: loginBtn.down ? "burlywood" : "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                height: profilePic.height
                color: "transparent"
                border.color: loginBtn.down ? "burlywood" : "#ffffff"
            }

            // Trigger loginUser with username and password
            onClicked: {
                loginUser(loginUsername.text, loginPassword.text)
            }
        }
    }
}
