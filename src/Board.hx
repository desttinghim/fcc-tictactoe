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

import Piece;

class Board extends State {

    var bg : luxe.Sprite;
    var grid : luxe.Sprite;
    var canvas : mint.Canvas;
    var buttons : Array<mint.Button>;
    var images : Array<mint.Image>;

    var place : Array<Piece>;
    var currentPiece : Piece;
    var playerPiece : Piece;

    override function onleave<T>(_:T) {

        bg.destroy();
        grid.destroy();

        grid = null;
        buttons = null;
        images = null;
        place = null;
        currentPiece = null;
        playerPiece = null;

    } //onleave

    override function onenter<T>(_:T) {

        // game code
        place = [for(i in 0...9) E];
        currentPiece = Main.piece;

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
                    name: 'button$a$i',
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

        images = [];

    } //onenter

    function take(x,y) {
        var i = (y * 3) + (x % 3);
        takeIndex(i);
    } //take

    function takeIndex(i) {
        if (place[i] == E) {
            place[i] = currentPiece;
            // buttons[i].label.text = currentPiece;
            images.push(new mint.Image({
                parent: canvas,
                x: buttons[i].x, y: buttons[i].y , w: 128, h: 128,
                path: 'assets/$currentPiece.png'
            }));
            currentPiece = currentPiece == X ? O : X;
        }
        var win = checkBoard();
        if (win != E) {
            trace('$win won');
            Main.changeState('state1');
            return;
        } else if (currentPiece != Main.piece) computerTurn();
    } //takeIndex

    function computerTurn() {
        if(place.indexOf(E) == -1) return; //TODO: tie handling
        var openSpots = [];
        for (i in 0...place.length) {
            if (place[i] == E) openSpots.push(i);
        }
        takeIndex(openSpots[Math.floor(Math.random()*openSpots.length)]);
    } //computerTurn

    function checkBoard():Piece {

        var stateOfX:Array<Bool> = place.map(function (item) {
            return item == X;
        });

        var stateOfO:Array<Bool> = place.map(function (item) {
            return item == O;
        });

        var win = E;

        for (arr in wins) {
            var reduceO = true;
            var reduceX = true;
            for (i in 0...arr.length) {
                if(!stateOfO[i] && arr[i] && reduceO) {reduceO = false;}
                if(!stateOfX[i] && arr[i] && reduceX) {reduceX = false;}
            }
            if(reduceO) {win = O; break;}
            if(reduceX) {win = X; break;}
        }

        return win;

    } //checkBoard

    public static var wins = [
    [
    true, true, true,
    false, false, false,
    false, false, false,
    ],
    [
    false, false, false,
    true, true, true,
    false, false, false,
    ],
    [
    false, false, false,
    false, false, false,
    true, true, true,
    ],
    [
    true, false, false,
    true, false, false,
    true, false, false,
    ],
    [
    false, true, false,
    false, true, false,
    false, true, false,
    ],
    [
    false, false, true,
    false, false, true,
    false, false, true,
    ],
    [
    true, false, false,
    false, true, false,
    false, false, true,
    ],
    [
    false, false, true,
    false, true, false,
    true, false, false,
    ],
    ];

}
