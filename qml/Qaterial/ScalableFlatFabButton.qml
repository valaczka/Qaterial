/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial 1.0 as Qaterial
import "." as Qaterial

Qaterial.FlatFabButton
{
  rippleClip: true
  scaleDuration: 100
  property bool isActive: hovered || down || visualFocus
  backgroundScale: isActive ? 1.0 : 0.9
} // FlatFabButton
