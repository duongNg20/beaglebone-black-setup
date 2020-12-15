import QtQuick 1.0
import VFountain.com 1.0

Rectangle
{
    id: main_window
    height: 768
    width: 1280
    anchors.centerIn: parent

    color: "#FF000000"

    property int square_heigth_index:   0
    property int square_width_index:    1
    property int square_offset_x_index: 2
    property int square_offset_y_index: 3
    property int circle_size_index:     4
    property int circle_pic_index:      5

    property real square_height:    50.0
    property real square_width:     50.0
    property real square_offset_x:  0.0
    property real square_offset_y:  0.0
    property real circle_size:      5.0
    property int  circle_pic:       0

    Component.onCompleted: main_controller.update_params_to_qml()
    BBBController{
        id: main_controller
        running: true
        onStateChanged: {
            if(mystate.toString() != main_window.state)
                console.log("onStateChanged ->" + mystate.toString())
            switch(mystate)
            {
            case "Idle":
                main_window.state = "Idle"
                break;
            case "square":
                main_window.state = "square"
                break;
            case "circle":
                main_window.state = "circle"
                break;
            case "show_logo":
                main_window.state = "show_logo"
                break;
            }
        }

        onQml_params_changed:{
            switch (index){
            case square_heigth_index:
                square_height = value
                break
            case square_width_index:
                square_width = value
                break
            case square_offset_x_index:
                square_offset_x = value
                break
            case square_offset_y_index:
                square_offset_y = value
                break
            case circle_size_index:
                circle_size = value
                break
            case circle_pic_index:
                circle_pic = value

                break
            default: break
            }
        }
    }

    Rectangle {
        id: display_window
        anchors.fill: parent

        color: "#FF000000"
        Image {
            id: logo
            opacity: 0
            source: "Vfountain.png"
            height: parent.height
            width: parent.height / 16 * 9
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            id: logo_text
            height: square.height
            width: square.width
            x: square.x
            y:square.y
            opacity: 0
            color: square.color

            Behavior on  opacity{
                    NumberAnimation { duration: 500; easing.type: Easing.OutCurve }
               }

            Text {
                id: txtWeb
                anchors.fill: parent
                text: qsTr("WWW.AMADA.COM.VN")

                font.pixelSize: 50*0.75
                font.bold: true
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                color: "#FFFF0000"
            }
        }

        Rectangle {
            id: square
            opacity: 0

            height: Math.round(parent.height * square_height / 10.0)
            width: Math.round(parent.height * square_width / 10.0)
            onHeightChanged: console.log("SQUARE_HEIGHT " + height)
            onWidthChanged: console.log("SQUARE_WIDTH " + width)
            anchors.centerIn: parent
            // 1cm ~ 5px
            // chieu cao
            anchors.verticalCenterOffset: square_offset_x * 4
            // chieu rong
            anchors.horizontalCenterOffset: square_offset_y * 4

            color: "#FFFFFFFF"
            rotation: 0

            NumberAnimation on opacity {id: dimSquare_On; running: false; from:0; to: 1; duration: 4000;easing.type: Easing.Linear}
        }

        Image {
            id: circle
            opacity: 0
            source: (circle_pic == 1) ? "p500.png" : "p400.png"
            onSourceChanged: console.log("CIRCLE PIC " + source)
//            for 1st center light
//            height: square.height * 0.74 / 1.3 /67*75
//            width: square.width *  0.74 / 1.3 /67*75

//            for 2st center light
//            height: square.height * 0.74 / 1.3 /67*75
//            width: square.width *  0.74 / 1.3 /67*75

            // 1cm ~ 0.018
            height: square.height * (0.75 + 0.018 * circle_size) / 1.3
            width: height

            onHeightChanged: console.log("CIRCLE SIZE " + circle_size)
            x: square.x + (square.width - width)/2
            y: square.y + (square.height - height) /2

            fillMode: Image.Stretch
            z:2
            rotation: 0

            NumberAnimation on opacity {id: dimCircle_On; running: false; from:0; to: 1; duration: 4000; easing.type: Easing.Linear}
        }
    }


    states: [
        State {
            name: "Idle"
             PropertyChanges {target: logo; opacity: 0}
             PropertyChanges {target: square; opacity: 0}
             PropertyChanges {target: circle; opacity: 0}
//             PropertyChanges {target: dimSquare_On; running: true}
//             PropertyChanges {target: dimCircle_On; running: true}
        },
        State {
            name: "square"
            PropertyChanges {target: logo; opacity: 0}
            PropertyChanges {target: circle; opacity: 0}
            PropertyChanges {target: square; opacity: 0}
            PropertyChanges {target: dimSquare_On; running: true}
//            PropertyChanges {target: dimCircle_On; running: true}
        },
        State {
            name: "circle"
            PropertyChanges {target: logo; opacity: 0}
            PropertyChanges {target: square; opacity: 1}
            PropertyChanges {target: circle; opacity: 0}
            PropertyChanges {target: dimCircle_On; running: true}
        },
        State {
            name: "show_logo"
            PropertyChanges {target: logo; opacity: 0}
            PropertyChanges {target: square; opacity: 0}
            PropertyChanges {target: circle; opacity: 0}
            PropertyChanges {target: logo_text; opacity: 1}
        }
    ]

}



