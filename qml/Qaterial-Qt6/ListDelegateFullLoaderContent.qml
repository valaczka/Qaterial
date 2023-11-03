/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 * Copyright (c) Valaczka János Pál 2023
 */

// Qt
import QtQuick
import Qt5Compat.GraphicalEffects

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

Rectangle
{
	id: _control

	property alias contentSource: _contentLoader.source
	property alias contentSourceComponent: _contentLoader.sourceComponent

	property alias leftSource: _leftLoader.source
	property alias leftSourceComponent: _leftLoader.sourceComponent

	property alias rightSource: _rightLoader.source
	property alias rightSourceComponent: _rightLoader.sourceComponent

	property bool largeThumbnail: false

	// ALIGNMENT
	property bool drawline: false
	property bool enabled: true
	property bool mirrored: false
	property double spacing: 0

	property double padding
	property double leftPadding: padding
	property double rightPadding: padding
	property double topPadding: padding
	property double bottomPadding: padding

	readonly property int type: (_leftLoader.item ? Qaterial.Style.DelegateType.Round : Qaterial.Style.DelegateType.Default)

	color: "transparent"
	implicitWidth: _contentLoader.implicitWidth
	implicitHeight: _contentLoader.implicitHeight

	function reanchors()
	{
		_leftLoader.reanchors()
		_rightLoader.reanchors()
	} // function reanchors()

	onMirroredChanged: reanchors()
	onTypeChanged: reanchors()
	Component.onCompleted: reanchors()


	Loader {
		id: _leftLoader

		enabled: _control.enabled
		visible: item
		/*width: Qaterial.Style.delegate.roundWidth(_control.largeThumbnail)
		height: Qaterial.Style.delegate.roundWidth(_control.largeThumbnail)

		anchors.top: _control.top
		anchors.topMargin: Qaterial.Style.delegate.topPadding(_control.type, _control.lines)*/
		anchors.left: _control.left
		anchors.verticalCenter: _control.verticalCenter

		function reanchors()
		{
			anchors.left = undefined
			anchors.right = undefined
			if(mirrored)
				anchors.right = _control.right
			else
				anchors.left = _control.left
		} //function reanchors()
	}

	Loader {
		id: _contentLoader

		enabled: _control.enabled
		anchors.top: _control.top
		anchors.bottom: _control.bottom
		anchors.left: mirrored ? (_rightLoader.item ? _rightLoader.right : _control.left)
							   : (_leftLoader.item ? _leftLoader.right : _control.left)
		anchors.right: mirrored ? (_leftLoader.item ? _leftLoader.left : _control.right)
								: (_rightLoader.item ? _rightLoader.left : _control.right)
		anchors.leftMargin: !mirrored ? _control.spacing : _control.leftPadding
		anchors.rightMargin: mirrored ? _control.spacing : _control.rightPadding
	}


	Loader {
		id: _rightLoader

		enabled: _control.enabled
		visible: item

		anchors.verticalCenter: _control.verticalCenter
		anchors.right: _control.right

		function reanchors()
		{
			anchors.left = undefined
			anchors.right = undefined
			if(mirrored)
				anchors.left = _control.left
			else
				anchors.right = _control.right
		} //function reanchors()
	}

	Qaterial.DebugRectangle
	{
		anchors.fill: parent
		border.color: "red"
		visible: _control.drawline
	} // DebugRectangle
} // Rectangle
