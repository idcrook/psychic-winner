# Raspberry Pi 3X 1U 10-inch "mini rack" rack-mount bracket

Summary
-------

10-inch "mini rack" 1U assembled tray to support three side-by-side Raspberry Pis.


Details
-------

-	Targeting a DeskPi RackMate T1 (GeeekPi 8U Server Cabinet with 10-inch rack mount)

-	Used [Raspberry Pi 4 1U 10-inch-rack-mount bracket](https://www.thingiverse.com/thing:5348000) as starting point

### Design customizations

For assembly, using M5 250 mm threaded rod (2X) and M5 nut + washer (4X) to assemble.

An M5 threaded rod is 5.00 mm (0.1969 inch) in diameter. This is a radius of 2.50 mm (0.0984 inch).

In the .scad file, I set the bolt hole radius to 2.4 mm since it already has a fudge factor (set to 0.25 mm) in model that gets added to arrive at effective radius (2.65 mm radius or 5.30 mm diameter) of bore hole.

I am using the tray and ears as imported from starting design.

UPDATES
-------

**2025-Jun-23** : Initial STL import from thing:5348000 and .scad from thing:4125055

-	used a simple `muckup.scad` to import STLs for comparison in OpenSCAD. also used to compose a full assembly for visualizing.

-	`my-raspberry-pi-rack-1u-frame-w67p0-bolt2p4-f0p25.stl`

	-	Recreated a 10-inch frame version. Mine using outer width of `67.0 mm` to match the imported 10-inch design am basing off of.

Printing
--------

Print a left and a right ear (both in `raspberry-pi-rack-1u-ears.stl`)

for each Pi (for three side-by-side)

-	print a frame `my-raspberry-pi-rack-1u-frame-w67p0-bolt2p4-f0p25.stl`
-	print a tray `raspberry-pi-rack-tray.stl`

Drawings and renders
--------------------

![assembled](img/full-assembly.png)

![frame](img/my-raspberry-pi-rack-1u-frame.png)


Model Repositories
------------------

-	Printables: https://www.printables.com/model/645469-iphone-15-pro-max-mechanical-mockup

-	Thingiverse: [iPhone 15 Pro Max mockup mechanical dummy model](https://www.thingiverse.com/thing:6311478)

Acknowledgements
----------------

-	[Raspberry Pi 4 1U 10-inch-rack-mount bracket](https://www.thingiverse.com/thing:5348000) as starting point

-	[10" 1U Rackmount 3x Pi rack](https://www.thingiverse.com/thing:4299802)

-	[Raspberry Pi 4/5 1U rack-mount bracket](https://www.thingiverse.com/thing:4125055)
