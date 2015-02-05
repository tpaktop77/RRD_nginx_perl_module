#!/usr/bin/perl -w
use RRDs;
use warnings;
#use strict;

do "/usr/local/etc/scripts/rrd/__disklist2.pl";
do "/usr/local/etc/scripts/rrd/__periods.pl";

my @timeData = localtime(time);
my $minute   = $timeData[1];
my $hour     = $timeData[2];

my $iDrive  = 0;
my $iPeriod = 0;


for ($iPeriod = 0; $iPeriod < (int @periods); $iPeriod++)
{
    # my $periodName          = $periods[$iPeriod][$ePeriodName];
    # my $periodDescription   = $periods[$iPeriod][$ePeriodDescription];
    my $periodName          = $periods[$iPeriod][0];
    my $periodDescription   = $periods[$iPeriod][1];

 if (
     (($iPeriod == 0) | ($iPeriod == 1) | ($iPeriod == 5)) |
     ($iPeriod == 2 && (($minute == 0) | ($minute == 15) | ($minute == 30) | ($minute == 45))) |
     ($iPeriod == 3 && $minute == 0) |
     ($iPeriod == 4 && $hour == 0 && $minute == 0)
    )
  {
    if ($iPeriod == 5)
    {

# --- SHORT

        my @DEF     = ();
        my @GRAPH   = ();
        my @array   = ();

        push @array,"/gs/www/mrtg/img_disk_iops_short.png";
        push @array,"--title=Disk IOps ".$periodDescription;
        push @array,"--imgformat=PNG";
        push @array,"--width=800";
        push @array,"--height=150";
        push @array,"--vertical-label=IO Trnscts per second";
        push @array,"--start=-1d";
        push @array,"--end=now";
        push @array,"--rigid";
        push @array,"--slope-mode";
        push @array,"--lower-limit=0";
        
        for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
        {
            my $driveName = $drives[$iDrive][$eDrivesName];
            my $driveColor = $drives[$iDrive][$eDrivesColor];
            
            push @DEF, "DEF:".$driveName."read=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_transfers.rrd:read:AVERAGE";
            push @DEF, "DEF:".$driveName."write=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_transfers.rrd:write:AVERAGE";
            push @DEF, "CDEF:".$driveName."iops=".$driveName."read,".$driveName."write,+";
            push @GRAPH, "LINE1:".$driveName."iops#".$driveColor.":".$driveName.(" " x (4-length($driveName)));
            # push @GRAPH, "LINE1:".$driveName."read#".$driveColor.":".$driveName.(" " x (4-length($driveName)));
            if ( $iDrive > 0 && (!($iDrive % 12)))
            {
                push @GRAPH, "COMMENT:\\n";
            }
            # push @GRAPH, "COMMENT:\\n";
        }
        # push @DEF, "CDEF:test=5,6,*";

        push @array, @DEF;
        push @array, @GRAPH;
        push @array, "COMMENT:\\n";

        RRDs::graph(@array);
        
    }
    else
    {

# --- Read

        my @DEF     = ();
        my @GRAPH   = ();
        my @array   = ();

        push @array,"/gs/www/mrtg/img_disk_iopsread_".$periodDescription.".png";
        push @array,"--title=Disk IOps read ".$periodDescription;
        push @array,"--imgformat=PNG";
        push @array,"--width=800";
        push @array,"--height=150";
        push @array,"--vertical-label=IO Trnscts per second";
        push @array,"--start=-".$periodName;
        push @array,"--end=now";
        push @array,"--rigid";
        push @array,"--slope-mode";
        # push @array,"--upper-limit=100";
        push @array,"--lower-limit=0";

        for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
        {
        
            
            my $driveName = $drives[$iDrive][$eDrivesName];
            my $driveColor = $drives[$iDrive][$eDrivesColor];
            
            push @DEF, "DEF:".$driveName."read=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_transfers.rrd:read:AVERAGE";
            push @DEF, "DEF:".$driveName."write=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_transfers.rrd:write:AVERAGE";
            push @GRAPH, "LINE1:".$driveName."read#".$driveColor.":".$driveName.(" " x (4-length($driveName)));
            push @GRAPH, "GPRINT:".$driveName."read:MIN: Min\\:%3.0lf tps";
            push @GRAPH, "GPRINT:".$driveName."read:MAX: Max\\:%3.0lf tps";
            push @GRAPH, "GPRINT:".$driveName."read:AVERAGE: Avrg\\:%3.0lf tps";
            push @GRAPH, "GPRINT:".$driveName."read:LAST: Last\\:%3.0lf tps";
            push @GRAPH, "COMMENT:\\n";
        }

        push @array, @DEF;
        push @array, @GRAPH;
        push @array, "COMMENT:\\n";
        RRDs::graph(@array);
        
# --- Write
        @DEF     = ();
        @GRAPH   = ();
        @array   = ();

        push @array,"/gs/www/mrtg/img_disk_iopswrite_".$periodDescription.".png";
        push @array,"--title=Disk IOps write ".$periodDescription;
        push @array,"--imgformat=PNG";
        push @array,"--width=800";
        push @array,"--height=150";
        push @array,"--vertical-label=IO Trnscts per second";
        push @array,"--start=-".$periodName;
        push @array,"--end=now";
        push @array,"--rigid";
        push @array,"--slope-mode";
        # push @array,"--upper-limit=100";
        push @array,"--lower-limit=0";

        for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
        {
        
            
            my $driveName = $drives[$iDrive][$eDrivesName];
            my $driveColor = $drives[$iDrive][$eDrivesColor];
            
            push @DEF, "DEF:".$driveName."write=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_transfers.rrd:write:AVERAGE";
            push @GRAPH, "LINE1:".$driveName."write#".$driveColor.":".$driveName.(" " x (4-length($driveName)));
            push @GRAPH, "GPRINT:".$driveName."write:MIN: Min\\:%3.0lf tps";
            push @GRAPH, "GPRINT:".$driveName."write:MAX: Max\\:%3.0lf tps";
            push @GRAPH, "GPRINT:".$driveName."write:AVERAGE: Avrg\\:%3.0lf tps";
            push @GRAPH, "GPRINT:".$driveName."write:LAST: Last\\:%3.0lf tps";
            push @GRAPH, "COMMENT:\\n";
        }

        push @array, @DEF;
        push @array, @GRAPH;
        push @array, "COMMENT:\\n";
        RRDs::graph(@array);
    }
  }
}
