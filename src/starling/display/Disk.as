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
    import starling.display.Sprite;
    import starling.display.Quad;

    /** A Disk represents a circle filled with a uniform color. */
    public class Disk extends Sprite
    {
        public function Disk(radius:Number, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
        {
            var nParts:int = radius / 2;
            // super(radius * 2.0, radius * 2.0, color, premultipliedAlpha);
            var c:Point = new Point(radius, radius);
            var angle:Number = 0;
            for (var i:int = 0; i <= nParts; ++i) {
                var a0:Number = (i + 0.0) * 2.0 * Math.PI / nParts;
                var a1:Number = (i + 1.0) * 2.0 * Math.PI / nParts;
                var p0:Point = new Point(radius + Math.cos(a0) * radius, radius + Math.sin(a0) * radius);
                var p1:Point = new Point(radius + Math.cos(a1) * radius, radius + Math.sin(a1) * radius);
                var q:Poly4 = new Poly4(c,p0,p1,c,color,premultipliedAlpha);
                addChild(q);
            }
            /*
            // mVertexData.setUniformColor(color);
            mVertexData.setPosition(0, p1.x - xmin, p1.y - ymin);
            mVertexData.setPosition(1, p2.x - xmin, p2.y - ymin);
            mVertexData.setPosition(2, p3.x - xmin, p3.y - ymin);
            mVertexData.setPosition(3, p4.x - xmin, p4.y - ymin);
            onVertexDataChanged();
            */
        }

        /*
        public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle
        {
            if (resultRect == null) resultRect = new Rectangle();

            if (targetSpace == this) // optimization
            {
                mVertexData.getPosition(3, sHelperPoint);
                resultRect.setTo(0.0, 0.0, sHelperPoint.x, sHelperPoint.y);
            }
            else if (targetSpace == parent && rotation == 0.0) // optimization
            {
                var scaleX:Number = this.scaleX;
                var scaleY:Number = this.scaleY;
                mVertexData.getPosition(3, sHelperPoint);
                resultRect.setTo(x - pivotX * scaleX,      y - pivotY * scaleY,
                                 sHelperPoint.x * scaleX, sHelperPoint.y * scaleY);
                if (scaleX < 0) { resultRect.width  *= -1; resultRect.x -= resultRect.width;  }
                if (scaleY < 0) { resultRect.height *= -1; resultRect.y -= resultRect.height; }
            }
            else if (is3D && stage)
            {
                stage.getCameraPosition(targetSpace, sHelperPoint3D);
                getTransformationMatrix3D(targetSpace, sHelperMatrix3D);
                mVertexData.getBoundsProjected(sHelperMatrix3D, sHelperPoint3D, 0, 4, resultRect);
            }
            else
            {
                getTransformationMatrix(targetSpace, sHelperMatrix);
                mVertexData.getBounds(sHelperMatrix, 0, 4, resultRect);
            }

            return resultRect;
        }
        */

    }
}

