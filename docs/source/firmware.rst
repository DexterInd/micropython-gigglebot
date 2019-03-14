##################
About the Firmware
##################

.. image:: https://i.imgur.com/3pXQOqD.png

******************
Modules
******************

The GiggleBot MicroPython firmware comes with the following modules:

* :py:mod:`gigglebot` - contains an API to interface with the actual `GiggleBot`_: think motors, line sensor, light sensors, LEDs, servos, etc.
* :py:mod:`gb_diag`- still an API to interface with the `GiggleBot`_, but slightly more advanced and useful for debugging purposes.
* :py:mod:`distance_sensor` - add-on sensor library for the `Distance Sensor`_.
* :py:mod:`thp` - add-on sensor library for the `Temperature Humidity Pressure Sensor`_.
* :py:mod:`lightcolor` - add-on sensor library for the `Light and Color Sensor`_.

Each new release comes with the following artifacts:

* A customized BBC micro:bit firmware that includes all the above modules in it - and we are calling it the GiggleBot firmware.
* The minified modules. These modules were minified to take less space on the BBC micro:bit.
* The pre-compiled modules (bytecodes) that no longer need to be compiled when they get imported on the BBC micro:bit.
* And the modules in their natural state.

.. _firmware-how:

******************
Firmware
******************

This customized firmware that includes the modules listed in this documentation also includes a handful of features meant to make use
of the available RAM on the BBC micro:bit in a more efficient manner. 

The default micrpython runtime that comes with the Mu Editor fills the needs of a single microbit but does not offer enough power to easily drive extra hardware like the GiggleBot. So we have come up with a custom firmware that allows the import of precompiled python modules (to byte-code aka ``.mpy`` files). These ``.mpy`` modules can be treated
like regular ``.py`` modules and copied in exactly the same manner over your microbit's filesystem, but they cannot be opened and edited in any way; it's not like it's necessary anyway.
This has the advantage of skipping the precompiling phase on the microbit that could leave it without RAM resources during or after this process. 

Still, precompiling modules still uses RAM to load them when they get imported, so the best bet is to just incorporate them into the firmware - a process called *freezing*. 
And this is what we have done with our firmware. Freezing the modules leads to a small usage of RAM, which is critical to the microbit, given its limited resources.

Here's a table showing what kind of modules the **GiggleBot firmware** (which is just a custom MicroPython version for the micro:bit) accepts vs the **regular firmware**:

+----------------------------+------------------------+-----------------------+
|                            | GiggleBot Firmware     | Regular Micropython   |
|                            |                        | For The Microbit      |
+============================+========================+=======================+
|regular ``.py`` modules     |          yes           |          yes          |
+----------------------------+------------------------+-----------------------+
|precompiled ``.mpy`` modules|          yes           |          no           |
+----------------------------+------------------------+-----------------------+
|freezed gigglebot           |                        |                       |
|modules                     |          yes           |          no           |
|                            |                        |                       |
+----------------------------+------------------------+-----------------------+

And here's what kind of modules can be used on the `BBC microbit`_ hardware:

+-------------------------------+------------------------+-----------------------+--------------------+
|          Module               | Load ``.py`` module    | Load ``.mpy`` module  | As freezed module  |
|                               |                        |                       |                    |
+===============================+========================+=======================+====================+
|:py:mod:`gigglebot`            |          yes           |          yes          |         yes        |
+-------------------------------+------------------------+-----------------------+--------------------+
|:py:mod:`gb_diag`              |          yes           |          yes          |         yes        |
+-------------------------------+------------------------+-----------------------+--------------------+
|:py:mod:`distance_sensor`      |          no            |          no           |         yes        |
+-------------------------------+------------------------+-----------------------+--------------------+
|:py:mod:`thp`                  |          no            |          yes          |         yes        |
+-------------------------------+------------------------+-----------------------+--------------------+
|:py:mod:`lightcolor`           |          no            |          yes          |         yes        |
+-------------------------------+------------------------+-----------------------+--------------------+

.. note::
    Be advised that loading ``.py`` modules directly to the microbit uses most of the RAM that's available to the board,
    so not much is left to the user to code. That's why it's better to go with ``.mpy`` or freezed modules (*meaning our custom firmware*) and only go with
    the regular ``.py`` when burning the custom GiggleBot MicroPython firmware to the microbit is not possible.

**********
Using It
**********

To download, flash and play with the firmware, follow the :ref:`Getting Started <getting-started>` chapter.

.. _gigglebot: https://www.gigglebot.io/
.. _distance sensor:  https://www.gigglebot.io/collections/frontpage/products/distance-sensor
.. _temperature humidity pressure sensor: https://www.dexterindustries.com/shop/temperature-humidity-pressure-sensor/
.. _light and color sensor: https://www.dexterindustries.com/shop/light-color-sensor/
.. _mu editor: https://codewith.mu/en/
.. _bbc microbit: https://microbit.org/
