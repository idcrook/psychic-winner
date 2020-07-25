# Libraries


## Directory structure


```shell tree --dirsfirst -L 2 -d
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
│   ├── output
│   ├── solidworks
│   └── translations
├── BOSL
│   ├── examples
│   ├── scripts
│   └── tests
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
│   ├── fractals
│   ├── kinematics
│   ├── knightstour
│   ├── knots
│   ├── lib
│   ├── pentagonal-tiles
│   ├── polygons
│   └── tiling
├── list-comprehension-demos
│   └── screenshots
├── misc
└── scad-utils
```

## BOLTS

https://github.com/boltsparts/BOLTS

BOLTS is an Open Library for Technical Specifications.

```
├── openscad
    ├── batteries
    ├── bearings
    ├── extrusions
    ├── hex
    ├── hex_socket
    ├── nut
    ├── pipes
    └── washer
```

## BOSL


https://github.com/revarbat/BOSL/wiki

The Belfry OpenScad Library - A library of tools, shapes, and helpers to make OpenScad easier to use.

This library is a set of useful tools, shapes and manipulators that I developed while working on various projects, including large ones like the Snappy-Reprap printed 3D printer.


### Commonly Used
  - [`transforms.scad`](transforms.scad): The most commonly used transformations, manipulations, and shortcuts are in this file.
  - [`shapes.scad`](shapes.scad): Common useful shapes and structured objects.
  - [`masks.scad`](masks.scad): Shapes that are useful for masking with `difference()` and `intersect()`.
  - [`threading.scad`](threading.scad): Modules to make triangular and trapezoidal threaded rods and nuts.
  - [`paths.scad`](paths.scad): Functions and modules to work with arbitrary 3D paths.
  - [`beziers.scad`](beziers.scad): Functions and modules to work with bezier curves.

### Standard Parts
  - [`involute_gears.scad`](involute_gears.scad): Modules and functions to make involute gears and racks.
  - [`joiners.scad`](joiners.scad): Modules to make joiner shapes for connecting separately printed objects.
  - [`sliders.scad`](sliders.scad): Modules for creating simple sliders and rails.
  - [`metric_screws.scad`](metric_screws.scad): Functions and modules to make metric screws, nuts, and screwholes.
  - [`linear_bearings.scad`](linear_bearings.scad): Modules to make mounts for LMxUU style linear bearings.
  - [`nema_steppers.scad`](nema_steppers.scad): Modules to make mounting holes for NEMA motors.
  - [`phillips_drive.scad`](phillips_drive.scad): Modules to create Phillips screwdriver tips.
  - [`torx_drive.scad`](torx_drive.scad): Functions and Modules to create Torx bit drive holes.
  - [`wiring.scad`](wiring.scad): Modules to render routed bundles of wires.

### Miscellaneous
  - [`constants.scad`](constants.scad): Useful constants for vectors, edges, etc.
  - [`math.scad`](math.scad): Useful helper functions.
  - [`convex_hull.scad`](convex_hull.scad): Functions to create 2D and 3D convex hulls.
  - [`quaternions.scad`](quaternions.scad): Functions to work with quaternion rotations.
  - [`triangulation.scad`](triangulation.scad): Functions to triangulate `polyhedron()` faces that have more than 3 vertices.
  - [`debug.scad`](debug.scad): Modules to help debug creation of beziers, `polygons()`s and `polyhedron()`s

## Terminology
For purposes of these library files, the following terms apply:
- **Left**: Towards X-
- **Right**: Towards X+
- **Front**/**Forward**: Towards Y-
- **Back**/**Behind**: Towards Y+
- **Bottom**/**Down**/**Below**: Towards Z-
- **Top**/**Up**/**Above**: Towards Z+

- **Axis-Negative**: Towards the negative end of the axis the object is oriented on.  IE: X-, Y-, or Z-.
- **Axis-Positive**: Towards the positive end of the axis the object is oriented on.  IE: X+, Y+, or Z+.

## Common Arguments:

Args    | What it is
------- | ----------------------------------------
fillet  | Radius of rounding for interior or exterior edges.
chamfer | Size of chamfers/bevels for interior or exterior edges.
orient  | Axis a part should be oriented along.  Given as an XYZ triplet of rotation angles.  It is recommended that you use the `ORIENT_` constants from `constants.scad`.  Default is usually `ORIENT_Z` for vertical orientation.
align   | Side of the origin that the part should be on.  Given as a vector away from the origin.  It is recommended that you use the `V_` constants from `constants.scad`.  Default is usually `V_ZERO` for centered.




## Chamfers-for-OpenSCAD

https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD

Chamfered primitives for OpenSCAD

A library to create primitives with 45° chamfers in OpenSCAD.

## MCAD

MCAD is a library of useful functions for the OpenSCAD 3D modeling software.

https://reprap.org/wiki/MCAD

https://github.com/openscad/MCAD

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


## NopSCADlib


https://github.com/nophead/NopSCADlib

An ever expanding library of parts modelled in OpenSCAD useful for 3D printers and enclosures for electronics, etc.

It contains lots of vitamins (the RepRap term for non-printed parts), some general purpose printed parts and some utilities. There are also Python scripts to generate Bills of Materials (BOMs), STL files for all the printed parts, DXF files for CNC routed parts in a project and a manual containing assembly instructions and exploded views by scraping markdown embedded in OpenSCAD comments, [see scripts](https://github.com/idcrook/NopSCADlib/blob/e6a26bc7b13ff8fc73f3c17d65e49205e8af4caa/scripts/readme.md). A simple example project can be found [here](https://github.com/idcrook/NopSCADlib/blob/e6a26bc7b13ff8fc73f3c17d65e49205e8af4caa/examples/MainsBreakOutBox/readme.md).

## agentscad

My utilities for OpenSCAD

#### Prerequisites

[Follow these instructions to use the library](https://github.com/GillesBouissac/agentscad/wiki/Prerequisites)

#### Canvas and Lithophanes

![Canvas panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-canvas.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Canvas">Tutorial for canvas here</a>
</p>

#### Snap Joint

![Snap Joint panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-snap-joint.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Snap-Joint">Tutorial for Snap Joint here</a>
</p>

#### Screws, Bolts and Nuts shapes and passages

![MX bolt panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-screw.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Screws shapes">Tutorial for screws here</a>
</p>

#### Threaded Screws, Bolts and Nuts (3D Printable)

![MX threaded panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-thread.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Screws threaded">Tutorial for threaded bolts</a>
</p>

#### Hirth Joint

![Hirth Joint panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-hirth-joint.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Hirth-Joint">Tutorial for Hirth Joint here</a>
</p>

#### Metric screw knobs

![Screw Knobs panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-mx-knob.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Screw-Knobs">Tutorial for screw knobs here</a>
</p>

#### Beveling library

![Beveling panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-bevel.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Cut-and-Bevel">Tutorial for beveling here</a>
</p>

#### Glue shapes library

![Glue panel](https://raw.githubusercontent.com/wiki/GillesBouissac/agentscad/img/panel-glue.png)

<p align="center">
<a href="https://github.com/GillesBouissac/agentscad/wiki/Glue-shapes">Tutorial for glue shapes here</a>
</p>

## dotSCAD

https://github.com/JustinSDK/dotSCAD

https://openhome.cc/eGossip/OpenSCAD/

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


## kitwallace__openscad

https://github.com/KitWallace/openscad

OpenSCAD scripts

## list-comprehension-demos

https://github.com/openscad/list-comprehension-demos

This repository contains some demos made possible by the addition of list comprehension to OpenSCAD. In particular it contains a user-space sweep() module which can be used to sweep a 2D shape along a 3D path.


## misc

- `fillet.scad`

## scad-utils

https://github.com/openscad/scad-utils

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
