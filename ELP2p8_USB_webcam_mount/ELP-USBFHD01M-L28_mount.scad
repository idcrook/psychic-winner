///////////////////////////////////////////////////////////////////////////////
// Initial Revision:
//   2019-Dec-28
//
// Author:
//
//   David Crook <idcrook@users.noreply.github.com>
//
// Inspired by:
//
// Description:
//
//
//
// Revisions/Notes:
//
//   2019-Dec-28: Initial PCB dimensions
//
//   2019-Dec-28: First draft mount
//
///////////////////////////////////////////////////////////////////////////////

use <mockup/elp_usbfhd01m_l28_dummy.scad>
use <MCAD/2Dshapes.scad>

e = 1/128; // small number


// $preview requires version 2019.05
$fn = $preview ? 30 : 100;


elp_usbfhd01m_l28_dummy();
