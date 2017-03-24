import luxe.Color;
import luxe.Vector;
import luxe.Input;
import luxe.Text;
import luxe.States;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.Convert;
import mint.render.luxe.Label;
import mint.layout.margins.Margins;
import luxe.utils.Maths;


class Board extends State {

    var bg : luxe.Sprite;
    var grid : luxe.Sprite;
    var canvas : mint.Canvas;

    override function onleave<T>(_:T) {

        bg.destroy();

        grid = null;

    } //onleave

    override function onenter<T>(_:T) {

        canvas = Main.canvas;

        bg = new luxe.Sprite({
            color: new Color().rgb(0xffffff),
            pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
            size: new Vector(Luxe.screen.size.x, Luxe.screen.size.y),
        });

        var grid_image = Luxe.resources.texture('assets/grid.png');
        var cross_image = Luxe.resources.texture('assets/cross.png');
        var knot_image = Luxe.resources.texture('assets/knot.png');

        grid = new luxe.Sprite({
            name: 'grid',
            texture: grid_image,
            pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
            size: new Vector(480, 480),
        });

    }

    static var box1 = {
        a: {x: 0.0, y: 0.0},
        b: {x: 1.0/3, y: 1.0/3},
    };

    static var box2 = {
        a: {x: 1.0/3, y: 0.0},
        b: {x: 2.0/3, y: 1.0/3},
    };

    static var box3 = {
        a: {x: 2.0/3, y: 0.0},
        b: {x: 3.0, y: 1.0/3},
    };

    static var box4 = {
        a: {x: 0.0, y: 1.0/3},
        b: {x: 1.0/3, y: 2.0/3},
    };

    static var box5 = {
        a: {x: 1.0/3, y: 1.0/3},
        b: {x: 2.0/3, y: 2.0/3},
    };

    static var box6 = {
        a: {x: 2.0/3, y: 1.0/3},
        b: {x: 3.0, y: 2.0/3},
    };

    static var box7 = {
        a: {x: 0.0, y: 3.0},
        b: {x: 1.0/3, y: 2.0/3},
    };

    static var box8 = {
        a: {x: 1.0/3, y: 3.0},
        b: {x: 2.0/3, y: 2.0/3}
    };

    static var box9 = {
        a: {x: 2.0/3, y: 3.0},
        b: {x: 3.0, y: 2.0/3}
    };

    override function onmouseup(e:luxe.MouseEvent) {

        function checkAABB(box:{a:{x:Float,y:Float},b:{x:Float,y:Float}}, pos) {
            if (pos.x > box.a.x && pos.x < box.b.x && pos.y > box.a.y && pos.y < box.b.y) {
                return true;
            }
            return false;
        }

        if (grid.point_inside_AABB(e.pos)) {
            var pos = e.pos.subtract(grid.pos).divideScalar(480);

            if (checkAABB(box1, pos)) {trace('square 1');}
        }

    }

}
