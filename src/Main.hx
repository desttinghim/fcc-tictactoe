
import luxe.GameConfig;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

class Main extends luxe.Game {

    override function config(config:GameConfig) {

        config.window.title = 'luxe game';
        config.window.width = 480;
        config.window.height = 640;
        config.window.fullscreen = false;

        config.preload.textures.push({ id: 'assets/grid.png' });
        config.preload.textures.push({ id: 'assets/cross.png' });
        config.preload.textures.push({ id: 'assets/knot.png' });

        return config;

    } //config

    var back : Sprite;
    var grid : Sprite;

    override function ready() {

      var grid_image = Luxe.resources.texture('assets/grid.png');
      var cross_image = Luxe.resources.texture('assets/cross.png');
      var knot_image = Luxe.resources.texture('assets/knot.png');

      back = new Sprite({
        color: new Color().rgb(0xffffff),
        pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
        size: new Vector(Luxe.screen.size.x, Luxe.screen.size.y),
      });

      grid = new Sprite({
        name: 'grid',
        texture: grid_image,
        pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y + 40),
        size: new Vector(480, 480),
      });

    } //ready

    override function onkeyup(event:KeyEvent) {

        if(event.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(delta:Float) {

    } //update

} //Main
