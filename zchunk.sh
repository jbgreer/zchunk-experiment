#!/bin/bash

# Run zchunk on input file for every lower case letter in English alphabet
for i in a b c d e f g h i j k l m n o p q r s t u v w x y z; do
	zck -s $i lorem.txt -o lorem.txt.$i
done

# Coalesce header information from each output file into a single file
rm -f lorem_header.txt
for i in a b c d e f g h i j k l m n o p q r s t u v w x y z; do
	echo "Split char:" $i >>lorem_header.txt
	zck_read_header lorem.txt.$i >>lorem_header.txt
	echo '-----' >>lorem_header.txt
done

# Sample lorem_header.txt output
#lorem.txt.a
#Overall checksum type: SHA-256
#Header size: 95483
#Header checksum: 5938e23376f7bb0642b171266bcbf468437f83bd4eae031543c11d9ebe4d5bb6
#Data size: 123605
#Data checksum: c8fd444b8a7ad23afa43890ae732342d2c2018025b17ef4ac7511d01119fede5
#Chunk count: 5300
#Chunk checksum type: SHA-512/128
#------

awk '
BEGIN {
  FS = ":";
  split_char = " ";
  smallest_header = 999999999;
  smallest_header_ch = " ";
  largest_header = -1;
  largest_header_ch = " ";
  smallest_data = 999999999;
  smallest_data_ch = " ";
  largest_data = -1;
  largest_data_ch = " ";
  smallest_chunk_count = 999999999;
  smallest_chunk_count_ch = " ";
  largest_chunk_count = -1;
  largest_chunk_count_ch = " ";
}
/^Split char/ { split_char = substr($0, length(), 1) }
/^Header size/ {
    if ($2 < smallest_header) { smallest_header = $2; smallest_header_ch = split_char; }
    if ($2 > largest_header) { largest_header = $2; largest_header_ch = split_char; }
}
/^Data size/ {
    if ($2 < smallest_data) { smallest_data = $2; smallest_data_ch = split_char; }
    if ($2 > largest_data) { largest_data = $2; largest_data_ch = split_char; }
}
/^Chunk count/ {
    if ($2 < smallest_chunk_count) { smallest_chunk_count = $2; smallest_chunk_count_ch = split_char; }
    if ($2 > largest_chunk_count) { largest_chunk_count = $2; largest_chunk_count_ch = split_char; }
}
END {
  print "smallest header:", smallest_header, " ", smallest_header_ch;
  print "largest header:", largest_header, " ", largest_header_ch;
  print "smallest data:", smallest_data, " ", smallest_data_ch;
  print "largest data:", largest_data, " ", largest_data_ch;
  print "smallest chunk count:", smallest_chunk_count, " ", smallest_chunk_count_ch;
  print "largest chuck count:", largest_chunk_count, " ", largest_chunk_count_ch;
}
' lorem_header.txt
