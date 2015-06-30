## prideify.sh

Inspired by https://facebook.com/celebratepride - a simple Bash script (30 lines of code) to "prideify" (add rainbow stripes to) any image using ImageMagick.

### Example

![Input](example.jpg?raw=true "Input") => ![Output](example.jpg-prideified?raw=true "Output")

### Dependencies

Only ImageMagick.

### Usage

`./prideify.sh [-r|-b|-p|-t] <input image file>`

Output will be at `<input image file>-pridified`. The optional -r, -b, -p, or -t flags switch between rainbow, bisexual, pansexual, and transgender pride flags, with -r as the default.'

### References

[Prideify.js](https://github.com/alexpeattie/prideify/), which does the same thing and much more in JavaScript + Canvas.
