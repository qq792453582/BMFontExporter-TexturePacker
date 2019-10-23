// return the length of array
const count = function (arr) {
    return arr.length.toString()
};

count.filterName = "count";
Library.addFilter("count");

// return the Unicode for input char
const toUnicode = function (input) {
    input = input.rawString()
    return input.charCodeAt(0).toString()
};
toUnicode.filterName = "toUnicode";
Library.addFilter("toUnicode");

var lineHeight = 1;
// get Line Height from all png array
const calcuLineHeight = function (sprites) {
    for (var i = 0; i < sprites.length; i++) {
        const sprite = sprites[i];
        lineHeight = Math.max(lineHeight, sprite.frameRect.height);
    }
    return lineHeight.toString();
};
calcuLineHeight.filterName = "calcuLineHeight";
Library.addFilter("calcuLineHeight");

// Base on MaxLineHeight get Yoffset
const getYOffset = function (input) {
    return ((lineHeight - input) / 2).toString();
};
getYOffset.filterName = "getYOffset";
Library.addFilter("getYOffset");