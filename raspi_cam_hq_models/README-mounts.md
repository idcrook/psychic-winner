README for Raspberry Pi HQ Camera mount designs
=====================================================

Refer to main [README](README.md) for Raspberry Pi HQ Camera and Lens models


<!-- *Table Of Contents* -->

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Simple mount on PoE hat case modded to be open-chassis](#simple-mount-on-poe-hat-case-modded-to-be-open-chassis)
    - [Inspirations or Remix components](#inspirations-or-remix-components)
- [Raspberry Pi HQ Camera and Lens models](#raspberry-pi-hq-camera-and-lens-models)

<!-- markdown-toc end -->

# Simple mount on PoE hat case modded to be open-chassis

The existing Pi 3B+ PoE case was not dissipating heat well and the fan was kicking in a few times a minute. With this open-chassis design mod, it is much more seldom now.


| Description             | .scad file or original                                           | STL file                                                                                             |
| ----------------------- | ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| simple HQ cam mount     | [designs/hqcam_pcb_housing.scad](designs/hqcam_pcb_housing.scad) | [designs/hqcam_pcb_housing_with_attached_arms.stl](designs/hqcam_pcb_housing_with_attached_arms.stl) |
| open-chassis case model | [raspi_hq_cam_mounts.scad](raspi_hq_cam_mounts.scad)             | [designs/RasPi3Case-Top-PoE_open_chassis.stl](designs/RasPi3Case-Top-PoE_open_chassis.stl)           |
| mount footer            | https://www.thingiverse.com/thing:3948548                        | [designs/Camera-pi-case-adapter.stl](designs/Camera-pi-case-adapter.stl)                             |
| shown together          | [raspi_hq_cam_mounts.scad](raspi_hq_cam_mounts.scad)             | [RasPi3Case-Top-PoE_open_chassis_simple_mount.stl](RasPi3Case-Top-PoE_open_chassis_simple_mount.stl) |


![Simple mount - PoE HAT case](img/piHQcam_simple_mount_poe_hat_case.png)


![Photo - assembled Simple mount - PoE HAT case](img/photo_assembled_piHQcam_simple_mount_poe_hat_case_sm1.jpg)

## Inspirations or Remix components

| Component         | Original Design                                                                                                        |
| ---               | ---                                                                                                                    |
| Pi PoE HAT case   | [Raspberry Pi 3 Model B+ PoE Case by codebio - Thingiverse](https://www.thingiverse.com/thing:3085529/remixes)         |
| mount footer      | [Raspberry Pi case to camera mount adapter by agmcmll - Thingiverse](https://www.thingiverse.com/thing:3948548)        |
| cam PCB mount     | *camera housing* in [Raspberry Pi Camera Arm by altrome - Thingiverse](https://www.thingiverse.com/thing:547506/files) |
| Vesa tripod mount | [Tripod Adapter to 75mm VESA by agmcmll - Thingiverse](https://www.thingiverse.com/thing:3963789)                      |


# Raspberry Pi HQ Camera and Lens models

shared on **Thingiverse**: [Raspberry Pi HQ Camera Reference Dummy Model](https://www.thingiverse.com/thing:4335497/)


![Back-side model designed in OpenSCAD](img/piHQcam_backside_model.png)
