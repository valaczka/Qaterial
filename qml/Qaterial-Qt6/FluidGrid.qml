import QtQuick
import Qaterial as Qaterial
import "." as Qaterial

Qaterial.Grid
{
  id: root

  leftPadding: flow === Flow.LeftToRight ? padding : 0
  rightPadding: flow === Flow.LeftToRight ? padding : 0
  topPadding: flow === Flow.TopToBottom ? padding : 0
  bottomPadding: flow === Flow.TopToBottom ? padding : 0
}