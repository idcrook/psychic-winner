#!/usr/bin/env perl

# cat README.md   | ./scripts/annotate-links-in-md.pl

use FindBin;
use lib $FindBin::Bin;

require "readmeutils.pl";
# - form_html_fragment_id



# writes to global variables:
sub insert_html_frag_id {
  my($line, $fragment_id) = @_;
  my $output;

  # push(@output, "<dt>");
  $line =~ s|(<dt)(>)|\1 id="$fragment_id" \2|;

  return $line;
}



########################################################################
# MAIN
########################################################################


@lines = ();
$i = 0;

my $recentDirname = "";
my $recentHtmlFrag = "";
my $recentDTlinum = 0;

# '## Directories'
my $inDirectories = 0;

# add all lines
while($line = <>) {
  chomp $line;

  # store original line
  $lines[$i] = $line;

  if ($line =~ /^## Directories/) {
    $inDirectories = 1;
  }

  # do not process earlier lines
  if (not $inDirectories ) {
    $i += 1;
    next;
  }

  # extract directory names using markdown links that are present
  if ( ($match) =  $line =~ m|\]\(([^/]+)|) {
    $recentDirname = $match;
    $recentHtmlFrag = &form_html_fragment_id('dir-dt', $match);
  }


  if ($line =~ /\<dt\>?/) {

    # from a previous match
    if ($recentDirname) {
      $recentHtmlFrag = &form_html_fragment_id('dir-dt', $recentDirname);
      $lines[$recentDTlinum] = &insert_html_frag_id($lines[$recentDTlinum], $recentHtmlFrag);
      # print("$lines[$recentDTlinum]\n");
    }

    # only update after consumed
    $recentDTlinum = $i;
  }

  $i += 1;
}

print(join "\n", @lines);
print("\n");
