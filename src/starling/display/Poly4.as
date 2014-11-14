// =================================================================================================
//
//	Starling Shapes
//	Copyright 2014 Fovea. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package starling.display
{
    import flash.geom.Matrix;
    import flash.geom.Matrix3D;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.geom.Vector3D;

    import starling.core.RenderSupport;
    import starling.utils.VertexData;
    import starling.display.Quad;

    /** A Poly4 represents an abitrary quad with a uniform color or a color gradient.
     *
     *  <p>You can set one color per vertex. The colors will smoothly fade into each other over the area
     *  of the quad. To display a simple linear color gradient, assign one color to vertices 0 and 1 and 
     *  another color to vertices 2 and 3. </p>
     *
     *  <p>The indices of the vertices are arranged like this:</p>
     *
     *  <pre>
     *  0 - 1
     *  | / |
     *  2 - 3
     *  </pre>
     *
     *  @see Image
     */
    public class Poly4 extends Quad
    {
        private var _lowerRight:Point;

        public function Poly4(p1:Point, p2:Point, p3:Point, p4:Point, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
        {
            var xmin:Number = Math.min(p1.x,p2.x,p3.x,p4.x);
            var ymin:Number = Math.min(p1.y,p2.y,p3.y,p4.y);
            var xmax:Number = Math.max(p1.x,p2.x,p3.x,p4.x);
            var ymax:Number = Math.max(p1.y,p2.y,p3.y,p4.y);
            super(xmax-xmin,ymax-ymin,color,premultipliedAlpha);
            mVertexData.setPosition(0, p1.x - xmin, p1.y - ymin);
            mVertexData.setPosition(1, p2.x - xmin, p2.y - ymin);
            mVertexData.setPosition(2, p3.x - xmin, p3.y - ymin);
            mVertexData.setPosition(3, p4.x - xmin, p4.y - ymin);
            onVertexDataChanged();
            x = xmin;
            y = ymin;
            _lowerRight = new Point(xmax - xmin, ymax - ymin);
        }

        public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle
        {
            if (resultRect == null) resultRect = new Rectangle();

            if (targetSpace == this) // optimization
            {
                resultRect.setTo(0.0, 0.0, _lowerRight.x, _lowerRight.y);
            }
            else if (targetSpace == parent && rotation == 0.0) // optimization
            {
                var scaleX:Number = this.scaleX;
                var scaleY:Number = this.scaleY;
                resultRect.setTo(x - pivotX * scaleX,      y - pivotY * scaleY,
                                 _lowerRight.x * scaleX, _lowerRight.y * scaleY);
                if (scaleX < 0) { resultRect.width  *= -1; resultRect.x -= resultRect.width;  }
                if (scaleY < 0) { resultRect.height *= -1; resultRect.y -= resultRect.height; }
            }
            else {
                resultRect = super.getBounds(targetSpace, resultRect);
            }

            return resultRect;
        }
    }
}
