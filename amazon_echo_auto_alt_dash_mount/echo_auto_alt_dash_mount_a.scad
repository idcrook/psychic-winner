////////////////////////////////////////////////////////////////////////
// Initial Revision:
//  2019-Jun-23
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
//   -
//
// Description:
//
//   Alternative dash mount for Echo Auto
//
// Revisions/Notes:
//
//
////////////////////////////////////////////////////////////////////////

// contains dimensional model of Echo Auto
use <model_echo_auto.scad>

use <MCAD/2Dshapes.scad>
use <../libraries/wedge.scad>

e = 0.02; // small number

// TBD!
module dash_mount_a () {

}



showEchoAuto = false;
showEchoAuto = true;

$fn = $preview ? 12 : 100;
if (showEchoAuto) {
  modelEchoAuto();
}

dash_mount_a();
