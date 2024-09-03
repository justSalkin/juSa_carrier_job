# juSa_carrier_job (v.1.2)
This script allows players to perform a carrier job at the port of Saint Denis.<br>
As a reward you can set the amount of money or which items you get and the chance for getting items or money.

Youtube Video: <br>
[![Watch the video](https://img.youtube.com/vi/Edc4nzMxJ9c/3.jpg)](https://youtu.be/Edc4nzMxJ9c)
<br>

------------------<br>

1) Add ``juSa_carrier_job`` to your resources folder
2) Add ``ensure juSa_carrier_job`` to your server.cfg
3) Start server

# Framework
Currently this script only works with VORP.

# Requirements
You`ll need : <br>
- ``vorp_core`` <br>
- ``vorp_api`` <br>
- ``vorp_inventory`` <br>
- ``vorp_progressbar`` <br>
- ``vorp_animations`` <br>

you have to add one animation to the vorp_animations config.lua (or update your vorp_animations):
``
    ["carry_box"] = {
        dict = "mech_carry_box",
        name = "idle", 
        flag = 31,
        type = 'standard',
        prop = {
            model = 'p_chair_crate02x',
            coords = {
                x = 0.1, 
                y = -0.1399, 
                z = 0.21, 
                xr = 263.2899,
                yr = 619.19,
                zr = 334.3
            },
            bone = 'SKEL_L_Hand'
        }
    },
``

# Support

If you want to support me, you can do this here: <br>
https://www.buymeacoffee.com/justSalkin

# Changelog

Hope you enjoying working with the script :)
