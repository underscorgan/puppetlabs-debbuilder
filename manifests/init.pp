# This is the main entry to the debbuilder module. It takes four parameters,
# three of which get passed down into sub-classes. $pe customizes the module
# for internal Puppet Labs builds, $use_cows sets up cows as builders and
# brings in all the dependencies to set cows up. $cows and $cow_root customize
# which cows are build during the setup phase and which basepath to use when
# setting the cows up (if $use_cows is set to true). $debian_mirror,
# $debian_archive_mirror, and $ubuntu_mirror can be used to specify the mirrors
# that will be used by pbuilder/cowbuilder during dependency resolution/OS
# build.

class debbuilder (
  $pe = false,
  $use_cows = false,
  $cows = undef,
  $cow_root = undef,
  $debian_mirror = 'ftp.us.debian.org',
  $debian_archive_mirror = 'archive.debian.org',
  $ubuntu_mirror = 'us.archive.ubuntu.com',
) {
  include debbuilder::packages::essential

  if ($use_cows) {
    class { 'debbuilder::packages::extra':
      pe => $pe,
    }

    class { 'debbuilder::setup::cows':
      cows => $cows,
      cow_root => $cow_root,
      pe => $pe,
    }
  }
}
