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

@:enum abstract Piece(String) to String{
    var X = "X";
    var O = "O";
    var E = "E";
}

class Board extends State {

    var bg : luxe.Sprite;
    var grid : luxe.Sprite;
    var canvas : mint.Canvas;
    var buttons : Array<mint.Button>;

    var places : Array<Piece>;
    var currentPiece : Piece;
    var playerPiece : Piece;

    override function onleave<T>(_:T) {

        bg.destroy();

        grid = null;
        buttons = null;

    } //onleave

    override function onenter<T>(_:T) {

        // game code
        places = [for(i in 0...9) E];
        currentPiece = X;

        // rendering code
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

        buttons = [
        for (i in 0...3) {
            for (a in 0...3) {
                new mint.Button({
                    parent: canvas,
                    name: 'button$i$a',
                    x: a * 160 + 16, y: i * 160 + 16 + 80, w: 128, h: 128,
                    text: '',
                    options: {
                        color: new Color().rgb(0xffffff),
                        color_hover: new Color().rgb(0xf0f0f0),
                        color_down: new Color().rgb(0xaaaaaa),
                        label: { color: new Color().rgb(0x000000), },
                    },
                    onclick: function(e, c) {take(a,i);},
                });
            }
        }
        ];

    } //onenter

    function take(x,y) {
        var i = (y * 3) + (x % 3);
        if (places[i] == E) {
            places[i] = currentPiece;
            buttons[i].label.text = currentPiece;
            currentPiece = currentPiece == X ? O : X;
        }
    }

}
