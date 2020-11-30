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
    import flash.geom.Matrix3D;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.geom.Vector3D;
    import starling.display.Mesh;
    import starling.rendering.IndexData;
    import starling.rendering.VertexData;
    import starling.styles.MeshStyle;

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
    public class Poly4 extends Mesh
    {
        private var _bounds:Rectangle;
        private var _lowerRight:Point;
        private var _p1:Point;
        private var _p2:Point;
        private var _p3:Point;
        private var _p4:Point;

        // helper objects
        private static var sPoint3D:Vector3D = new Vector3D();
        private static var sMatrix:Matrix = new Matrix();
        private static var sMatrix3D:Matrix3D = new Matrix3D();

        public function Poly4(p1:Point, p2:Point, p3:Point, p4:Point, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
        {
            _p1 = p1;
            _p2 = p2;
            _p3 = p3;
            _p4 = p4;

            var xmin:Number = Math.min(p1.x,p2.x,p3.x,p4.x);
            var ymin:Number = Math.min(p1.y,p2.y,p3.y,p4.y);
            var xmax:Number = Math.max(p1.x,p2.x,p3.x,p4.x);
            var ymax:Number = Math.max(p1.y,p2.y,p3.y,p4.y);
            _bounds = new Rectangle(0, 0, xmax - xmin, ymax - ymin);
            _lowerRight = new Point(xmax - xmin, ymax - ymin);

            var vertexData:VertexData = new VertexData(MeshStyle.VERTEX_FORMAT, 4);
            var indexData:IndexData = new IndexData(6);
            super(vertexData, indexData);

            setupVertices();
            this.color = color;
            this.x = xmin;
            this.y = ymin;
        }

        protected function setupVertices():void {
            var posAttr:String = "position";
            var texAttr:String = "texCoords";
            var vertexData:VertexData = this.vertexData;
            var indexData:IndexData = this.indexData;

            indexData.numIndices = 0;
            indexData.addQuad(0, 1, 2, 3);
            if (vertexData.numVertices != 4) {
                vertexData.numVertices = 4;
                vertexData.trim();
            }

            var xmin:Number = Math.min(_p1.x,_p2.x,_p3.x,_p4.x);
            var ymin:Number = Math.min(_p1.y,_p2.y,_p3.y,_p4.y);
            var xmax:Number = Math.max(_p1.x,_p2.x,_p3.x,_p4.x);
            var ymax:Number = Math.max(_p1.y,_p2.y,_p3.y,_p4.y);
            var width:Number = xmax - xmin;
            var height:Number = ymax - ymin;
            _lowerRight = new Point(width, height);
            vertexData.setPoint(0, posAttr, _p1.x - xmin, _p1.y - ymin);
            vertexData.setPoint(1, posAttr, _p2.x - xmin, _p2.y - ymin);
            vertexData.setPoint(2, posAttr, _p3.x - xmin, _p3.y - ymin);
            vertexData.setPoint(3, posAttr, _p4.x - xmin, _p4.y - ymin);
            vertexData.setPoint(0, texAttr, _p1.x / width, _p1.y / height);
            vertexData.setPoint(1, texAttr, _p2.x / width, _p2.y / height);
            vertexData.setPoint(2, texAttr, _p3.x / width, _p3.y / height);
            vertexData.setPoint(3, texAttr, _p4.x / width, _p4.y / height);
            setRequiresRedraw();
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

        /** @inheritDoc */
        override public function hitTest(localPoint:Point):DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(localPoint)) return null;
            else if (_bounds.containsPoint(localPoint)) return this;
            else return null;
        }
    }
}