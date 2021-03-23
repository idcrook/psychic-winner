#!/bin/echo Error sourcing -*- perl -*-


# takes a string (with a type) and forms an id for anchor use
sub form_html_fragment_id {
  my ($fragtype, $str) = @_;

  # consolidate any run of underbar-s to a single hyphen
  $str =~ s/[_]+/-/g;

  # consolidate any run of space-s to a single hyphen
  $str =~ s/[ ]+/-/g;

  # make lowercase
  $str = lc($str);

  $str = lc($fragtype) . "-" . $str;

  return $str;
}





1;
