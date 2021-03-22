#!/usr/bin/env perl

# ls -d -1 -F  * | grep '/' | grep -v -e Archive -e libraries -e sketchup -e scripts \
#    | ./scripts/generate_skeleton.pl

sub generate_rib {
  my($dirname) = @_;
  my($name) = $dirname;
  my(@output);

  $name =~ s/_/ /g;

  push(@output, "<dt>");
  push(@output, "");
  push(@output, "[$dirname]($dirname/#readme)");
  push(@output, "");
  push(@output, "</dt><dd>");
  push(@output, "$name");
  push(@output, "");
  push(@output, "<!-- ![$name]($dirname/img/IMAGE.png \"$name\") -->");
  push(@output, "");
  push(@output, "</dd>");
  push(@output, "");

  return join ("\n", @output);
}

print("<dl>\n");

while($line = <>) {
  chomp $line;
  ($dirname) = ($line =~ m|(.+)/|);
  $output = &generate_rib($dirname);
  print("$output\n");
}

print("</dl>\n");

# perl -pe 's|(.+)/|\n[\1](\1/)\n: \1\n![\1](\1/img/IMAGE.png)\n|' >! a1
