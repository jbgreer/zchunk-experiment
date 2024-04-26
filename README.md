# Example of the impact of split character choice on zchunk performance


## zchunk

To quote the documentation "zchunk is a compressed file format that splits the file into independent chunks."
```
https://github.com/zchunk/zchunk
```
Thus, zchunk performance is dependent upon choice of value to split the input file.
To demonstrate this, I've 
- created a dummy input file using a Lorem Ipsum generator, ```https://loremipsum.io``` of 50 paragraphs.
- coerced all uppercase input letters to lowercase to reduce the size of the alphabet.
- run ```zchk```, the zchunk compression utility, using each character as a splitter, a-z.
- gathered the metadata for each run using the ```zchk_read_header``` utility
- analyzed the results to identify the smallest/largest header, data, and chunk counts


Enjoy.

