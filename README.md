# 🕵️ Code Heist

**Hack the vault with Python.** Write real Python code to guide a thief past lasers, guards and security cameras, grab the 💎 and escape.

▶ **Play now:** https://kaustubhhbhoirr.github.io/code-heist/

No install, no account. It runs entirely in your browser (Python runs locally via [Pyodide](https://pyodide.org)).

## What's inside

- **20 jobs** that teach Python step by step: loops, `while`, `if`, functions, lists, and finally a random-maze boss
- **♾ Endless Bot Mode**: write one bot and watch it beat random heists back to back. How long is your streak?
- **3 stars per job**: escape · use few ticks · write short code
- Lasers, guards, rotating cameras, keys and coloured doors, vault terminals
- Thief skins, trophies, chiptune sounds, retro 90s look

## How to play

Your thief understands commands like these:

```python
def step(d):
    while not is_safe(d):   # wait for the laser / guard / camera to look away
        wait()
    move(d)

for i in range(6):
    step(east)              # east, East, EAST or right all work
grab()
step(east)
```

Directions: `east` = → right · `west` = ← left · `north` = ↑ up · `south` = ↓ down.
New commands unlock as you progress. Check the **Gadgets** panel in game.

## Run it locally

It's a single HTML file. Serve the folder with any static server:

```bash
npx http-server . -p 8091
```

Then open http://localhost:8091. (Opening the file directly with `file://` won't work because Python needs to load over http.)

## Add your own level 🧩

Levels live in the `LEVELS` array inside `index.html`. A level is just a grid of characters:

| Char | Meaning | Char | Meaning |
|---|---|---|---|
| `#` | wall | `L` | laser (blinks) |
| `.` | floor | `G` | guard, walks ↕ |
| `S` | start | `H` | guard, walks ↔ |
| `D` | diamond (can have several) | `C` | security camera (rotates) |
| `E` | exit | `T` | terminal (`hack()` opens `X`) |
| `X` | vault door | `r` / `b` | red / blue key |
| | | `R` / `B` | red / blue door |

```js
{name:'My Level', map:['#########',
                       '#S..L.DE#',
                       '#########'],
 par:10, lines:8, unlock:[],
 text:'Briefing shown by The Boss.', hint:'A hint.', start:'\n'},
```

All rows must be the same length. `par` = ticks for the ⭐ speed star, `lines` = lines of code for the ⭐ short-code star.
Please make sure your level is solvable before you open a pull request.

## Contributing

Pull requests are welcome: new levels, new gadgets, bug fixes, translations.

1. Fork this repo
2. Make your change in `index.html`
3. Test it locally (see above)
4. Open a pull request describing what you added

## License

[MIT](LICENSE). Free to use, change and share.
