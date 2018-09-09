import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Page {
    id: userInfoPage

    background: Rectangle {
        color: backGroundColor
    }

    // Top toolbar for back button
    header: ToolBar {
        background:
            Rectangle {
            implicitHeight: 50
            implicitWidth: 200
            color: backGroundColor
        }

        RowLayout {
            anchors.fill: parent
            Item { Layout.fillWidth: true }
            ToolButton {
                id: control
                font.family: "robotoLight"
                text: qsTr("\u27F5")
                font.pixelSize: Math.round(elementRect.height/15)
                rightPadding: 10
                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: mainTextCOlor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                onClicked: logoutSession()
            }
        }
    }

    // Rect for list view
    Rectangle {
        id: elementRect
        width: parent.width
        height: parent.height
        color: "darkgray"

        Text {
            id: noChannels
            visible: false
            text: "Nema kanala"
            anchors.centerIn: parent
            font.family: "robotoLight"
            font.pixelSize: Math.round(elementRect.height/20)
            color: mainTextCOlor
        }

        ListModel {
            id: channelModel
            ListElement {
                name: ""
                url: ""
            }
        }

        Component {
            id: channelDelegate
            Item {
                width: elementRect.width
                height: elementRect.height / 6

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: elementRect.height / 35
                    Text {
                        font.family: "robotoLight";
                        font.pixelSize: Math.round(elementRect.height/35)
                        text: 'Channel name: ' + name
                    }
                    Text {
                        font.family: "robotoLight";
                        font.pixelSize: Math.round(elementRect.height/35)
                        text: 'Channel url: '  + url
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: list.currentIndex = index
                }
            }
        }

        ListView {
            id: list
            anchors.fill: parent
            anchors.bottomMargin: parent.height / 11
            model: channelModel
            delegate: channelDelegate
            highlight: Rectangle {
                color: 'grey'
            }
            highlightMoveVelocity: 1200          // Will make it move faster x3 from default
            highlightMoveDuration: 300           // Durations is made shorter from 400 to 300
            highlightResizeVelocity: Infinity    // Will make instant resize

            // Focus on newly selected item and handle arrow keys up and down
            focus:true
            Keys.onUpPressed: {
                if (list.currentIndex - 1 >= 0)
                    list.currentIndex -= 1;
            }
            Keys.onDownPressed: {
                if (list.currentIndex + 1 < list.count)
                    list.currentIndex += 1;
            }
          }

        Component.onCompleted: {
            channelModel.remove(0); // remove intitialized values
            getChannelsJSON()
        }

        // get channels JSON, then loop and append name and password to model
        function getChannelsJSON() {
            var request = new XMLHttpRequest()
            request.open('GET', 'http://176.31.182.158:3001/channels', true);
            request.onreadystatechange = function() {
                if (request.readyState === XMLHttpRequest.DONE) {
                    if (request.status && request.status === 200) {
                        console.log("response", request.responseText)
                        var result = JSON.parse(request.responseText)
                        if(!result[0])
                        {
                            noChannels.visible = true
                            console.log("Result array has falsy value")
                            return
                        }
                        for (var i in result)
                        {
                            channelModel.append({
                                "name": result[i].name,
                                "url": result[i].url
                            })
                        }
                    } else {
                        console.log("HTTP:", request.status, request.statusText)
                    }
                }
            }
            request.send()
        }
    }
}
