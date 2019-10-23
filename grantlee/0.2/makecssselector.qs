// create a css selector by replacing -hover with :hover
var MakeSelectorFilter = function(input)
{
  var input = input.rawString();
  return input.replace("-hover",":hover");
};
// create name in BMFont_custom.fnt to invoke
MakeSelectorFilter.filterName = "makecssselector";
// add the function to TexturePacker Library
Library.addFilter("MakeSelectorFilter");

// return the length of array
var GetArrayLength = function(input) {
    return input.length.toString()
};
GetArrayLength.filterName = "getArrayLength";
Library.addFilter("GetArrayLength");

// return the Unicode for input char
var GetUnicode = function(input) {
    input=MakeSelectorFilter(input)
    return input.charCodeAt(0).toString()
};
GetUnicode.filterName = "getUnicode";
Library.addFilter("GetUnicode");

// getMaxLineHeight from all png array
maxLineH=1;
var GetMaxLineH = function(input) {
    for (index in input){
        if (input[index].frameRect.height > maxLineH){
            maxLineH = input[index].frameRect.height;
        };
    }
    return input[index].frameRect.height.toString();
};
GetMaxLineH.filterName = "getMaxLineH";
Library.addFilter("GetMaxLineH");

// Base on MaxLineHeight get Yoffset
var GetYoffset = function(input) {
    return ((maxLineH - input) / 2).toString();
};
GetYoffset.filterName = "getYoffset";
Library.addFilter("GetYoffset");