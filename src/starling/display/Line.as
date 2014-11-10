package gamebase.hexaboard
{
    import flash.geom.Point;
    public class Line extends Poly4 {
        public function Line(from:Point, to:Point, thickness:Number, color:uint, premultipliedAlpha:Boolean = true) {
            var dx:Number = to.x - from.x;
            var dy:Number = to.y - from.y;
            var l:Number = Math.sqrt(dx*dx + dy*dy);
            var u:Point = new Point(dx/l, dy/l);
            var v:Point = new Point(u.y, -u.x);
            var halfT:Number = thickness * 0.5;

            var p1:Point = from.clone();
            p1.offset(v.x * halfT, v.y * halfT);
            p1.offset(-u.x * halfT, -u.y * halfT);

            var p2:Point = from.clone();
            p2.offset(-v.x * halfT, -v.y * halfT);
            p2.offset(-u.x * halfT, -u.y * halfT);

            var p3:Point = to.clone();
            p3.offset(v.x * halfT, v.y * halfT);
            p3.offset(u.x * halfT, u.y * halfT);

            var p4:Point = to.clone();
            p4.offset(-v.x * halfT, -v.y * halfT);
            p4.offset(u.x * halfT, u.y * halfT);

            super(p1, p2, p3, p4, color, premultipliedAlpha);
        }
    }
}
