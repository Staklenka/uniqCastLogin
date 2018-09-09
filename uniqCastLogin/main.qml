import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 1080
    height: 1920
    title: qsTr("Login")

    property color backGroundColor : "#353535"
    property color mainAppColor: "#ffffff"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"

    FontLoader {
        id: robotoLight
        name: "robotoLight"
        source: "qrc:/fonts/roboto-light.ttf"
    }

    // Main stackview
    StackView{
        id: stackView
        focus: true
        anchors.fill: parent
    }

    // After loading show initial Login Page
    Component.onCompleted: {
        stackView.push("qrc:/LogInPage.qml")   //initial page
    }

    //Popup to show messages or warnings on the bottom postion of the screen
    Popup {
        id: popup
        property alias popMessage: message.text

        background: Rectangle {
            implicitWidth: rootWindow.width
            implicitHeight: 60
            color: popupBackGroundColor
        }
        y: (rootWindow.height - 60)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        Text {
            id: message
            anchors.centerIn: parent
            font.pointSize: 12
            color: popupTextCOlor
        }
        onOpened: popupClose.start()
    }

    // Popup will be closed automatically in 2 seconds after its opened
    Timer {
        id: popupClose
        interval: 2000
        onTriggered: popup.close()
    }

    // Login users
    function loginUser(uname, pword)
    {
        var message = ""
        var http = new XMLHttpRequest()
        var url = "http://176.31.182.158:3001/auth/local";
        var params = {"identifier":uname,"password":pword};
        http.open("POST", url, true);

        // Send the proper header information along with the request
        http.setRequestHeader("Content-type", "application/json");
        //http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");

        http.onreadystatechange = function() { // Call a function when the state changes.
                    if (http.readyState == 4) {
                        if (http.status == 200) {
                            console.log("ok")
                            //console.log(http.getAllResponseHeaders())
                            console.log("Showing info")
                            console.log(http.responseText)
                            showUserInfo()
                        } else {
                            console.log("error: " + http.status)
                            message = "Wrong username or password"
                            popup.popMessage = message
                            popup.open()
                        }
                    }
                }

        http.send(JSON.stringify(params));
    }

    // Show UserInfo page
    function showUserInfo()
    {
        stackView.replace("qrc:/UserInfoPage.qml")
    }

    // Logout and show login page
    function logoutSession()
    {
        stackView.replace("qrc:/LogInPage.qml")
    }
}
