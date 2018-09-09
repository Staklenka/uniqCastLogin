import QtQuick 2.6
import QtQuick.Controls 2.0

Button {
    id: control
    text: qsTr("Log In")

    property alias name: control.text
    property color baseColor
    property color borderColor


    background: Rectangle {
        id: bgrect
        implicitWidth: 100
        implicitHeight: 50
        color: baseColor //"#6fda9c"
        opacity: control.down ? 0.7 : 1
        radius: height/2
        border.color: borderColor
    }
}
