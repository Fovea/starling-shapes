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

Shapes
------

### starling.display.Poly4

A Poly4 represents an abitrary 4-sided polygon with a uniform color or a color gradient.

```as3
Poly4(p1:Point, p2:Point, p3:Point, p4:Point, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
```

It inherits directly from starling.display.Quad, so all fancy coloring options of Quads can be used with Poly4.

Hit test: the polygon's axis-aligned bounding box.

### starling.display.Ring

A Ring represents a ring (what else?), see [this image](http://sugabetic.files.wordpress.com/2011/11/blue-circle.png).

constructor:
```as3
Ring(innerRadius:Number, outerRadius:Number, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
```

It's built using a set of polygons. Number of vertices is relative to the outer radius.

Hit test: fully functional.

### starling.display.Disk

A Disk is like a ring but without a hole in the middle.

constructor:
```as3
Disk(radius:Number, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
```

It's actually a ring with innerRadius set to 0.

Hit test: fully functional.

### starling.display.Line

A Line represents a segment with a thickness and uniform color or a color gradient.

constructor:
```as3
Line(from:Point, to:Point, thickness:Number, color:uint, premultipliedAlpha:Boolean = true) {
```

It inherit from the Poly4 class which means you can setup per-vertex color.
The first two points of the Poly4 are those associated with the `from` point of the Line.
The last two points are associated with the `to` point of the Line.

Hit test: the line's axis-aligned bounding box.

Hit tests?
----------

Used for example to know if the mouse clicked on the object or not. Bounding box hit tests only check if the
coordinate falls inside the axis-aligned rectangle that covers the object.

If you don't need pixel-perfect hit tests for the Shape you're drawing (or maybe no hit-test at all), then
don't worry.
