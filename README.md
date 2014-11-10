Starling Shapes
===============

(c)2014, Fovea

Why?
----

Why another extension, when there's already the [Starling Graphics Extension](https://github.com/StarlingGraphics/Starling-Extension-Graphics)?

Well, one draw-back of the Graphics extension is that it doesn't allow to `flatten` your sprites. Which will result
in poor performances, especially if you have complex static objects that could have been pre-rendered.

So in short, this extension has less features, but is compatible with `flatten`, which will help you write more efficient code.

If all you need are Lines, Circles and custom Polygons, then do not look any further.

What's not in here yet?
-----------------------

The main missing feature is a proper hit test. Objects are using the inherited bounding box hit test check, when then should
override the `hitTest` method.
```as3
public function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
```

If you don't need pixel-perfect hit tests for the Shape you're drawing (or maybe no hit-test at all), then
don't worry.

### Hit test?

Used for example to know if the mouse clicked on the object or not. Bounding box hit tests only check if the
coordinate falls inside the axis-aligned rectangle that covers the object.
