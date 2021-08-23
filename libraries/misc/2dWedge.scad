
// [OpenSCAD Wedge Module/Library by WilliamsOb - Thingiverse](https://www.thingiverse.com/thing:1843282)
// - https://www.thingiverse.com/thing:1843282/files
//
// https://creativecommons.org/licenses/by/4.0/


module 2dWedge(radius, startAngle, endAngle, stepsOverride) {

    angleDiff = endAngle - startAngle;
    steps = stepsOverride == undef ? abs(angleDiff) : stepsOverride;
    stepModifier = angleDiff / steps;

    function flatten(arr) = [for (a = arr) for (b = a) for (c = b) c];
    function 2dArr(arr) = [for (i = [0 : 2 : len(arr) - 2]) [arr[i], arr[i+1]]];

    mirror([1, 1, 0]) {
        rotate(180) {
            polygon(2dArr(flatten([
                [0, 0],
                [for (angle = [startAngle : stepModifier : endAngle]) [ radius * sin(angle), radius * cos(angle) ]],
                [0, 0]
            ])));
        }
    }
}
