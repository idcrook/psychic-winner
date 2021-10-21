# Libraries


## Directory structure


```text tree --dirsfirst -L 2 -d
.
├── BOLTS
│   ├── backends
│   ├── bolttools
│   ├── data
│   ├── downloads
│   ├── drawings
│   ├── freecad
│   ├── icons
│   ├── misc
│   ├── openscad
│   ├── pythonpackage
│   ├── solidworks
│   └── translations
├── BOSL2
│   ├── examples
│   ├── images
│   ├── scripts
│   ├── tests
│   └── tutorials
├── Chamfers-for-OpenSCAD
│   └── Demo
├── MCAD
│   └── bitmap
├── NopSCADlib
│   ├── docs
│   ├── examples
│   ├── gallery
│   ├── printed
│   ├── scripts
│   ├── tests
│   ├── utils
│   └── vitamins
├── agentscad
│   ├── polyhedron
│   ├── test
│   ├── things
│   └── thread
├── dotSCAD
│   ├── docs
│   ├── examples
│   ├── featured_img
│   ├── src
│   └── test
├── kitwallace__openscad
│   ├── circuits
│   ├── cityscape
│   ├── fractals
│   ├── kinematics
│   ├── knightstour
│   ├── knots
│   ├── lib
│   ├── miller
│   ├── pentagonal-tiles
│   ├── polygons
│   ├── skewdie
│   ├── spiral
│   └── tiling
├── list-comprehension-demos
│   └── screenshots
├── misc
└── scad-utils

```

# BOLTS

<https://github.com/boltsparts/BOLTS>

BOLTS is an Open Library for Technical Specifications.

```text cd BOLTS/openscad && tree --dirsfirst -L 2 -d
. openscad
├── batteries
├── bearings
├── extrusions
├── hex
├── hex_socket
├── nut
├── pipes
├── vacuum
└── washer
```

# BOSL2

<https://github.com/revarbat/BOSL2/wiki>

**The Belfry OpenScad Library, v2**

A library for OpenSCAD, filled with useful tools, shapes, masks, math and manipulators, designed to make OpenSCAD easier to use.

- **NOTE:** BOSL2 IS BETA CODE. THE CODE IS STILL BEING REORGANIZED.
- **NOTE2:** CODE WRITTEN FOR BOSLv1 PROBABLY WON'T WORK WITH BOSL2!

[**BOSL2 Docs**](https://github.com/revarbat/BOSL2/wiki)

### Basics (Imported via std.scad)

- [transforms.scad](https://github.com/revarbat/BOSL2/wiki/transforms.scad): Commonly used transformations shortcuts.
- [distributors.scad](https://github.com/revarbat/BOSL2/wiki/distributors.scad): Modules and Functions to distribute items.
- [mutators.scad](https://github.com/revarbat/BOSL2/wiki/mutators.scad): Modules and Functions to mutate items.
- [attachments.scad](https://github.com/revarbat/BOSL2/wiki/attachments.scad): Modules and functions to enable attachments.
- [shapes2d.scad](https://github.com/revarbat/BOSL2/wiki/shapes2d.scad): Common useful 2D shapes.
- [shapes3d.scad](https://github.com/revarbat/BOSL2/wiki/shapes3d.scad): Common useful 3D shapes.
- [drawing.scad](https://github.com/revarbat/BOSL2/wiki/drawing.scad): Functions and modules to create and draw 2D and 3D paths.
- [masks.scad](https://github.com/revarbat/BOSL2/wiki/masks.scad): Shapes that are useful for masking with `difference()` and `intersect()`.

### [](https://github.com/revarbat/BOSL2/wiki#math-imported-via-stdscad)Math (Imported via std.scad)

- [math.scad](https://github.com/revarbat/BOSL2/wiki/math.scad): Useful math helper functions.
- [vectors.scad](https://github.com/revarbat/BOSL2/wiki/vectors.scad): Functions for vector math.
- [arrays.scad](https://github.com/revarbat/BOSL2/wiki/arrays.scad): Functions to manipulate lists and arrays.
- [quaternions.scad](https://github.com/revarbat/BOSL2/wiki/quaternions.scad): Functions to work with quaternion rotations.
- [coords.scad](https://github.com/revarbat/BOSL2/wiki/coords.scad): Functions for coordinate system conversions and transformations.

### [](https://github.com/revarbat/BOSL2/wiki#geometry-imported-via-stdscad)Geometry (Imported via std.scad)

- [edges.scad](https://github.com/revarbat/BOSL2/wiki/edges.scad): Constants and functions to specify edges and corners.
- [geometry.scad](https://github.com/revarbat/BOSL2/wiki/geometry.scad): Functions to find line intersections, circles from 3 points, etc.
- [hull.scad](https://github.com/revarbat/BOSL2/wiki/hull.scad): Functions to create 2D and 3D convex hulls.
- [paths.scad](https://github.com/revarbat/BOSL2/wiki/paths.scad): Functions and modules to work with arbitrary 3D paths.
- [regions.scad](https://github.com/revarbat/BOSL2/wiki/regions.scad): Perform offsets and boolean geometry on 2D paths and regions.
- [vnf.scad](https://github.com/revarbat/BOSL2/wiki/vnf.scad): Vertices 'n' Faces structure to make creating `polyhedron()`s easier.

### [](https://github.com/revarbat/BOSL2/wiki#common-imported-via-stdscad)Common (Imported via std.scad)

- [utility.scad](https://github.com/revarbat/BOSL2/wiki/utility.scad): Useful helpers for argument processing.
- [strings.scad](https://github.com/revarbat/BOSL2/wiki/strings.scad): String manipulation functions.
- [constants.scad](https://github.com/revarbat/BOSL2/wiki/constants.scad): Useful constants for vectors, edges, etc.
- [version.scad](https://github.com/revarbat/BOSL2/wiki/version.scad): Ways to parse and compare semantic versions.

### [](https://github.com/revarbat/BOSL2/wiki#processes)Processes

- [beziers.scad](https://github.com/revarbat/BOSL2/wiki/beziers.scad): Functions and modules to work with bezier curves.
- [threading.scad](https://github.com/revarbat/BOSL2/wiki/threading.scad): Modules to make triangular and trapezoidal threaded rods and nuts.
- [rounding.scad](https://github.com/revarbat/BOSL2/wiki/rounding.scad): Functions to help rounding corners in a path.
- [knurling.scad](https://github.com/revarbat/BOSL2/wiki/knurling.scad): Masks and shapes to help with knurling.
- [partitions.scad](https://github.com/revarbat/BOSL2/wiki/partitions.scad): Modules to help partition large objects into smaller assembled parts.
- [rounding.scad](https://github.com/revarbat/BOSL2/wiki/rounding.scad): Functions and modules to create rounded paths and boxes.
- [skin.scad](https://github.com/revarbat/BOSL2/wiki/skin.scad): Functions to skin surfaces between 2D cross-section paths.
- [turtle3d.scad](https://github.com/revarbat/BOSL2/wiki/turtle3d.scad): Functions to aid in constructing 3D paths or transform sets.

### [](https://github.com/revarbat/BOSL2/wiki#data-structures)Data Structures

- [structs.scad](https://github.com/revarbat/BOSL2/wiki/structs.scad): Structure/Dictionary creation and manipulation functions.
- [fnliterals.scad](https://github.com/revarbat/BOSL2/wiki/fnliterals.scad): Function Literal algorithms and helpers.

### [](https://github.com/revarbat/BOSL2/wiki#miscellaneous-parts)Miscellaneous Parts

- [polyhedra.scad](https://github.com/revarbat/BOSL2/wiki/polyhedra.scad): Modules to create various regular and stellated polyhedra.
- [walls.scad](https://github.com/revarbat/BOSL2/wiki/walls.scad): Modules to create walls and structural elements for 3D printing.
- [cubetruss.scad](https://github.com/revarbat/BOSL2/wiki/cubetruss.scad): Modules to create modular open-framed trusses and joiners.
- [gears.scad](https://github.com/revarbat/BOSL2/wiki/gears.scad): Modules and functions to make gears, racks, worms, and worm gears.
- [joiners.scad](https://github.com/revarbat/BOSL2/wiki/joiners.scad): Modules to make joiner shapes for connecting separately printed objects.
- [sliders.scad](https://github.com/revarbat/BOSL2/wiki/sliders.scad): Modules for creating simple sliders and rails.
- [screws.scad](https://github.com/revarbat/BOSL2/wiki/screws.scad): Functions and modules to make metric and UTS screws and nuts.
- [metric_screws.scad](https://github.com/revarbat/BOSL2/wiki/metric_screws.scad): Functions and modules to make metric screws, nuts, and screwholes.
- [linear_bearings.scad](https://github.com/revarbat/BOSL2/wiki/linear_bearings.scad): Modules to make mounts for LMxUU style linear bearings.
- [modular_hose.scad](https://github.com/revarbat/BOSL2/wiki/modular_hose.scad): Modules for making modular flexible hose parts.
- [nema_steppers.scad](https://github.com/revarbat/BOSL2/wiki/nema_steppers.scad): Modules to make mounting holes for NEMA motors.
- [screw_drive.scad](https://github.com/revarbat/BOSL2/wiki/screw_drive.scad): Functions and Modules to create Phillips/Torx/etc driver holes.
- [wiring.scad](https://github.com/revarbat/BOSL2/wiki/wiring.scad): Modules to render routed bundles of wires.
- [hingesnaps.scad](https://github.com/revarbat/BOSL2/wiki/hingesnaps.scad): Modules to make foldable, snap-locking parts.
- [bottlecaps.scad](https://github.com/revarbat/BOSL2/wiki/bottlecaps.scad): Modules to make standard beverage bottle caps and necks.

## Terminology

For purposes of these library files, the following terms apply:

- **Left**: Towards X-
- **Right**: Towards X+
- **Front**/**Forward**: Towards Y-
- **Back**/**Behind**: Towards Y+
- **Bottom**/**Down**/**Below**: Towards Z-
- **Top**/**Up**/**Above**: Towards Z+

## [](https://github.com/revarbat/BOSL2/wiki#common-arguments)Common Arguments:

| Args | What it is |
| --- | --- |
| rounding | Radius of rounding for interior or exterior edges. |
| chamfer | Size of chamfers/bevels for interior or exterior edges. |
| anchor | Side/Edge/Corner of the part that is aligned with the origin. Given as a vector away from the center of the part. Default is usually `CENTER` [0,0,0]. |
| spin | Number of degrees that the part should be rotated by around the Z axis. If given as a vector of 3 rotation values, rotates around each axis in order. Default is usually `0`. |
| orient | Vector that points in the direction that the top of the part should be tilted towards. Default is usually `UP` for vertical orientation. |


# Chamfers-for-OpenSCAD

<https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD>

Chamfered primitives for OpenSCAD

A library to create primitives with 45° chamfers in OpenSCAD.

# MCAD

MCAD is a library of useful functions for the OpenSCAD 3D modeling software. Comes bundled with OpenSCAD application.

<https://github.com/openscad/MCAD>

<https://reprap.org/wiki/MCAD>

Currently Provided Tools:

* regular_shapes.scad
    - regular polygons, ie. 2D
    - regular polyhedrons, ie. 3D

* involute_gears.scad (http://www.thingiverse.com/thing:3575):
    - gear()
    - bevel_gear()
    - bevel_gear_pair()

* gears.scad (Old version):
    - gear(number_of_teeth, circular_pitch OR diametrial_pitch, pressure_angle OPTIONAL, clearance OPTIONAL)

* motors.scad:
    - stepper_motor_mount(nema_standard, slide_distance OPTIONAL, mochup OPTIONAL)

Tools (alpha and beta quality):

* nuts_and_bolts.scad: for creating metric and imperial bolt/nut holes
* bearing.scad: standard/custom bearings
* screw.scad: screws and augers
* materials.scad: color definitions for different materials
* stepper.scad: NEMA standard stepper outlines
* servos.scad: servo outlines
* boxes.scad: box with rounded corners
* triangles.scad: simple triangles
* 3d_triangle.scad: more advanced triangles

Very generally useful functions and constants:

* math.scad: general math functions
* constants.scad: mathematical constants
* curves.scad: mathematical functions defining curves
* units.scad: easy metric units
* utilities.scad: geometric funtions and misc. useful stuff
* teardrop.scad (http://www.thingiverse.com/thing:3457): parametric teardrop module
* shapes.scad: DEPRECATED simple shapes by Catarina Mota
* polyholes.scad: holes that should come out well when printed

Other:

* alphabet_block.scad
* bitmap.scad
* letter_necklace.scad
* name_tag.scad
* height_map.scad
* trochoids.scad
* libtriangles.scad
* layouts.scad
* transformations.scad
* 2Dshapes.scad
* gridbeam.scad
* fonts.scad
* unregular_shapes.scad
* metric_fastners.scad
* lego_compatibility.scad
* multiply.scad
* hardware.scad

External utils that generate and process openscad code:

* openscad_testing.py: testing code, see below
* openscad_utils.py: code for scraping function names etc.


# NopSCADlib

<https://github.com/nophead/NopSCADlib>

An ever expanding library of parts modelled in OpenSCAD useful for 3D printers and enclosures for electronics, etc.

It contains lots of vitamins (the RepRap term for non-printed parts), some general purpose printed parts and some utilities. There are also Python scripts to generate Bills of Materials (BOMs), STL files for all the printed parts, DXF files for CNC routed parts in a project and a manual containing assembly instructions and exploded views by scraping markdown embedded in OpenSCAD comments, [see scripts](https://github.com/idcrook/NopSCADlib/blob/e6a26bc7b13ff8fc73f3c17d65e49205e8af4caa/scripts/readme.md). A simple example project can be found [here](https://github.com/idcrook/NopSCADlib/blob/e6a26bc7b13ff8fc73f3c17d65e49205e8af4caa/examples/MainsBreakOutBox/readme.md).

# agentscad

<https://github.com/GillesBouissac/agentscad>

My utilities for OpenSCAD

#### Prerequisites

[Follow these instructions to use the library](https://github.com/GillesBouissac/agentscad/wiki/Prerequisites)


# dotSCAD

<https://github.com/JustinSDK/dotSCAD>

<https://openhome.cc/eGossip/OpenSCAD/>

Reduce the burden of mathematics when playing OpenSCAD.

2D Module

- [arc](https://openhome.cc/eGossip/OpenSCAD/lib2x-arc.html)

- [pie](https://openhome.cc/eGossip/OpenSCAD/lib2x-pie.html)

- [rounded_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_square.html)

- [line2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-line2d.html)

- [polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-polyline2d.html)

- [hull_polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-hull_polyline2d.html)

- [hexagons](https://openhome.cc/eGossip/OpenSCAD/lib2x-hexagons.html)

- [polytransversals](https://openhome.cc/eGossip/OpenSCAD/lib2x-polytransversals.html)

- [multi_line_text](https://openhome.cc/eGossip/OpenSCAD/lib2x-multi_line_text.html)

- [voronoi2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-voronoi2d.html)

3D Module

- [rounded_cube](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_cube.html)

- [rounded_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_cylinder.html)

- [crystal_ball](https://openhome.cc/eGossip/OpenSCAD/lib2x-crystal_ball.html)

- [line3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-line3d.html)

- [polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-polyline3d.html)

- [hull_polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-hull_polyline3d.html)

- [function_grapher](https://openhome.cc/eGossip/OpenSCAD/lib2x-function_grapher.html)

- [sweep](https://openhome.cc/eGossip/OpenSCAD/lib2x-sweep.html)

- [loft](https://openhome.cc/eGossip/OpenSCAD/lib2x-loft.html)

- [starburst](https://openhome.cc/eGossip/OpenSCAD/lib2x-starburst.html)

- [voronoi3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-voronoi3d.html)

Transformation

- [along_with](https://openhome.cc/eGossip/OpenSCAD/lib2x-along_with.html)

- [hollow_out](https://openhome.cc/eGossip/OpenSCAD/lib2x-hollow_out.html)

- [bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-bend.html)

- [shear](https://openhome.cc/eGossip/OpenSCAD/lib2x-shear.html)

2D Function

- [in_shape](https://openhome.cc/eGossip/OpenSCAD/lib2x-in_shape.html)

- [bijection_offset](https://openhome.cc/eGossip/OpenSCAD/lib2x-bijection_offset.html)

- [trim_shape](https://openhome.cc/eGossip/OpenSCAD/lib2x-trim_shape.html)

- [triangulate](https://openhome.cc/eGossip/OpenSCAD/lib2x-triangulate.html)

- [contours](https://openhome.cc/eGossip/OpenSCAD/lib2x-contours.html)

2D/3D Function

- [cross_sections](https://openhome.cc/eGossip/OpenSCAD/lib2x-cross_sections.html)

- [paths2sections](https://openhome.cc/eGossip/OpenSCAD/lib2x-paths2sections.html)

- [path_scaling_sections](https://openhome.cc/eGossip/OpenSCAD/lib2x-path_scaling_sections.html)

- [bezier_surface](https://openhome.cc/eGossip/OpenSCAD/lib2x-bezier_surface.html)

- [bezier_smooth](https://openhome.cc/eGossip/OpenSCAD/lib2x-bezier_smooth.html)

- [midpt_smooth](https://openhome.cc/eGossip/OpenSCAD/lib2x-midpt_smooth.html)

- [in_polyline](https://openhome.cc/eGossip/OpenSCAD/lib2x-in_polyline.html)

Path

- [arc_path](https://openhome.cc/eGossip/OpenSCAD/lib2x-arc_path.html)

- [bspline_curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-bspline_curve.html)

- [bezier_curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-bezier_curve.html)

- [helix](https://openhome.cc/eGossip/OpenSCAD/lib2x-helix.html)

- [golden_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-golden_spiral.html)

- [archimedean_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-archimedean_spiral.html)

- [sphere_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-sphere_spiral.html)

- [torus_knot](https://openhome.cc/eGossip/OpenSCAD/lib2x-torus_knot.html)


Extrusion

- [box_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-box_extrude.html)

- [ellipse_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-ellipse_extrude.html)

- [stereographic_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-stereographic_extrude.html)

- [rounded_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_extrude.html)

- [bend_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-bend_extrude.html)

2D Shape

- [shape_taiwan](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_taiwan.html)

- [shape_arc](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_arc.html)

- [shape_pie](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_pie.html)

- [shape_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_circle.html)

- [shape_ellipse](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_ellipse.html)

- [shape_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_square.html)

- [shape_trapezium](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_trapezium.html)

- [shape_cyclicpolygon](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_cyclicpolygon.html)

- [shape_pentagram](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_pentagram.html)

- [shape_starburst](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_starburst.html)

- [shape_superformula](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_superformula.html)

- [shape_glued2circles](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_glued2circles.html)

- [shape_path_extend](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_path_extend.html)

2D Shape Extrusion

- [path_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-path_extrude.html)

- [ring_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-ring_extrude.html)

- [helix_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-helix_extrude.html)

- [golden_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-golden_spiral_extrude.html)

- [archimedean_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-archimedean_spiral_extrude.html)

- [sphere_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-sphere_spiral_extrude.html)

Util

- [util/sub_str](https://openhome.cc/eGossip/OpenSCAD/lib2x-sub_str.html)

- [util/split_str](https://openhome.cc/eGossip/OpenSCAD/lib2x-split_str.html)

- [util/parse_number](https://openhome.cc/eGossip/OpenSCAD/lib2x-parse_number.html)

- [util/reverse](https://openhome.cc/eGossip/OpenSCAD/lib2x-reverse.html)

- [util/slice](https://openhome.cc/eGossip/OpenSCAD/lib2x-slice.html)

- [util/sort](https://openhome.cc/eGossip/OpenSCAD/lib2x-sort.html)

- [util/rand](https://openhome.cc/eGossip/OpenSCAD/lib2x-rand.html)

- [util/fibseq](https://openhome.cc/eGossip/OpenSCAD/lib2x-fibseq.html)

- [util/bsearch](https://openhome.cc/eGossip/OpenSCAD/lib2x-bsearch.html)

- [util/has](https://openhome.cc/eGossip/OpenSCAD/lib2x-has.html)

- [util/dedup](https://openhome.cc/eGossip/OpenSCAD/lib2x-dedup.html)

- [util/flat](https://openhome.cc/eGossip/OpenSCAD/lib2x-flat.html)

Matrix

- [matrix/m_cumulate](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_cumulate.html)

- [matrix/m_translation](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_translation.html)

- [matrix/m_rotation](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_rotation.html)

- [matrix/m_scaling](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_scaling.html)

- [matrix/m_mirror](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_mirror.html)

- [matrix/m_shearing](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_shearing.html)

Point transformation

- [ptf/ptf_rotate](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_rotate.html)

- [ptf/ptf_x_twist](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_x_twist.html)

- [ptf/ptf_y_twist](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_y_twist.html)

- [ptf/ptf_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_circle.html)

- [ptf/ptf_bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_bend.html)

- [ptf/ptf_ring](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_ring.html)

- [ptf/ptf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_sphere.html)

- [ptf/ptf_torus](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_torus.html)




Turtle

- [turtle2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-turtle2d.html)

- [turtle3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-turtle3d.html)

- [t2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-t2d.html)

- [t3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-t3d.html)

Pixel

- [pixel/px_line](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_line.html)

- [pixel/px_polyline](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_polyline.html)

- [pixel/px_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_circle.html)

- [pixel/px_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_cylinder.html)

- [pixel/px_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_sphere.html)

- [pixel/px_polygon](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_polygon.html)

- [pixel/px_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_from.html)

- [pixel/px_ascii](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_ascii.html)

- [pixel/px_gray](https://openhome.cc/eGossip/OpenSCAD/lib2x-px_gray.html)

Part

- [part/connector_peg](https://openhome.cc/eGossip/OpenSCAD/lib2x-connector_peg.html)

- [part/cone](https://openhome.cc/eGossip/OpenSCAD/lib2x-cone.html)

- [part/joint_T](https://openhome.cc/eGossip/OpenSCAD/lib2x-joint_T.html)

Surface

- [surface/sf_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_square.html)

- [surface/sf_bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_bend.html)

- [surface/sf_ring](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_ring.html)

- [surface/sf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_sphere.html)

- [surface/sf_torus](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_torus.html)

- [surface/sf_solidify](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_solidify.html)

 Noise

- [noise/nz_perlin1](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin1.html)

- [noise/nz_perlin1s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin1s.html)

- [noise/nz_perlin2](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin2.html)

- [noise/nz_perlin2s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin2s.html)

- [noise/nz_perlin3](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin3.html)

- [noise/nz_perlin3s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin3s.html)

- [noise/nz_worley2](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley2.html)

- [noise/nz_worley2s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley2s.html)

- [noise/nz_worley3](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley3.html)

- [noise/nz_worley3s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley3s.html)

- [noise/nz_cell](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_cell.html)


# kitwallace__openscad

<https://github.com/KitWallace/openscad>

OpenSCAD scripts

# list-comprehension-demos

https://github.com/openscad/list-comprehension-demos

This repository contains some demos made possible by the addition of list comprehension to OpenSCAD. In particular it contains a user-space sweep() module which can be used to sweep a 2D shape along a 3D path.


# misc

- `fillet.scad`

# scad-utils

<https://github.com/openscad/scad-utils>

Utility libraries for OpenSCAD

#### Morphology

contains basic 2D morphology operations

    inset(d=1)             - creates a polygon at an offset d inside a 2D shape
    outset(d=1)            - creates a polygon at an offset d outside a 2D shape
    fillet(r=1)            - adds fillets of radius r to all concave corners of a 2D shape
    rounding(r=1)          - adds rounding to all convex corners of a 2D shape
    shell(d,center=false)  - makes a shell of width d along the edge of a 2D shape
                           - positive values of d places the shell on the outside
                           - negative values of d places the shell on the inside
                           - center=true and positive d places the shell centered on the edge
