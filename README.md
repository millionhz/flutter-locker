# Locker

![Locker](/images/round.png)

## A beautiful and simple game

Rotate the dials, listen to the sounds and try to unlock the Locker

| ![LockerApp](/images/image1.png) | ![LockerApp](/images/image2.png) |
| -------------------------------- | -------------------------------- |


## Issues and Todos

- Circular Sliders only redraw when interacted with. ~~This behavior is preventing the in-game color switching.~~
- No hint text present.
- ~~Sound stops if the sliders are interacted with as soon as the app starts~~

## Provider Fixes:
- Use a static variable that will hold the values that will not change and use this with consumer
- Make two providers with multi providers and have one as change notifier and the other as a simple one and make them exchange data
