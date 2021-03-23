#!/usr/bin/env perl

# ls -d -1 -F  * | grep '/' | grep -v -e Archive -e libraries -e sketchup -e scripts \
#    | ./scripts/generate_skeleton.pl

use FindBin;
use lib $FindBin::Bin;

require "readmeutils.pl";
# - form_html_fragment_id

# Reads from Global variable:
# - %htmlFragmentTitles
sub form_directory_directory {
  my (@htmlFrags) = @_;
  my ($line, $linkText);
  my @output = ();

  for $htmlFrag (@htmlFrags) {
    $linkText = $htmlFragmentTitles{$htmlFrag};
    #$line = "<a href=\"#$htmlFrag\" >$linkText</a>";
    $line = "[$linkText](#$htmlFrag)";
    push (@output, $line);
  }

  return @output;
}


# writes to global variables:
# - @htmlFragments
# - %htmlFragmentTitles
sub generate_rib {
  my($dirname) = @_;
  my($name) = $dirname;
  my(@output, $html_frag, %info);


  $name =~ s/_/ /g;

  $html_frag = &form_html_fragment_id('dir-dt', $dirname);
  $htmlFragmentTitles{$html_frag} = $name;
  push (@htmlFragments, $html_frag);


  push(@output, "<dt id=\"$html_frag\" >");
  push(@output, "");
  push(@output, "[$dirname]($dirname/#readme)");
  push(@output, "");
  push(@output, "</dt><dd>");
  push(@output, "$name");
  push(@output, "");
  # perl -pe 's| (.+)/ | \n[\1](\1/)\n: \1\n![\1](\1/img/IMAGE.png)\n |'
  push(@output, "<!-- ![$name]($dirname/img/IMAGE.png \"$name\") -->");
  push(@output, "");
  push(@output, "</dd>");
  push(@output, "");

  return join ("\n", @output);
}

########################################################################
# MAIN
########################################################################

@htmlFragments = ();
%htmlFragmentTitles = {};

print("<dl>\n");

while($line = <>) {
  chomp $line;
  ($dirname) = ($line =~ m|(.+)/|);
  $output = &generate_rib($dirname);
  print("$output\n");
}

print("</dl>\n");


print("<!-- Directory of directories -->\n");

print("\n");
print("## Links\n");
print("\n");

@listOfDirectories = &form_directory_directory(@htmlFragments);
for $directoryEntry (@listOfDirectories) {
  #print("<li>$directoryEntry</li>\n");
  print(" -    $directoryEntry\n");
}

print("\n");
print("\n");
