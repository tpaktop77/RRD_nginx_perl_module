package hello;

do "/etc/nginx/perl/lib/PrepareHTMLPage.pm";

use nginx;
use strict;
use warnings;
use HTML::Tiny;


sub handler {

##### Constants
    use constant uriCisco  => 'cisco';
    use constant uriZFS    => 'zfs';
    use constant uriSystem => 'system';


    our $h = HTML::Tiny->new( mode => 'html' );      # HTML::Tiny object

##### Varialbes
    my $r = shift;
    my $URI = $r->uri;                              # Get URI
    my $DIR = "/cd/";                               # path to perl module, should be removed in Cleaned URI
#    my $result = "";                               # Output
    my $CURI = substr($URI, length($DIR));          # Clean URI
    my @AURI = split("/", $CURI);                   # Clean array of URI emelemts devided by /
    my $htmlContent = "";                           # HTML Content



#### Starting HTTP output by content header
    $r->send_http_header("text/html");
    return OK if $r->header_only;

    $r->flush;


    $htmlContent = $htmlContent.$h->div( { class => 'selectMenu' },
        [
            $h->ul(),
            $h->li( { class => 'topNavLeftLi'   }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco'  }, 'Networking' )),
            $h->li( { class => 'topNavMiddleLi' }, $h->a( { href => 'http://cts.tpaktop.com/cd/zfs'    }, 'ZFS' )),
            $h->li( { class => 'topNavRightLi'  }, $h->a( { href => 'http://cts.tpaktop.com/cd/system' }, 'System' ))
            ]
    );


##### what is in Cleaned URI???
    if ($AURI[0] eq uriCisco)                    # URI must be strongly equal to constant
    {
        $htmlContent = $htmlContent.$h->div( { class => 'selectMenu' },
            [
                $h->ul(),
                $h->li( { class => 'topNavLeftLi'   }, {style => 'border-top: 1px silver solid' }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco/2811'    }, '2811' )),
                $h->li( { class => 'topNavMiddleLi' }, {style => 'border-top: 1px silver solid' }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco/2960G24' }, '2960G24' )),
                $h->li( { class => 'topNavMiddleLi' }, {style => 'border-top: 1px silver solid' }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco/2960G8'  }, '2960G8' )),
                $h->li( { class => 'topNavMiddleLi' }, {style => 'border-top: 1px silver solid' }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco/2940'    }, '2940' )),
                $h->li( { class => 'topNavMiddleLi' }, {style => 'border-top: 1px silver solid' }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco/12421'    }, '1242 1' )),
                $h->li( { class => 'topNavRightLi'  }, {style => 'border-top: 1px silver solid' }, $h->a( { href => 'http://cts.tpaktop.com/cd/cisco/12422'    }, '1242 2' ))
            ]
        );
    }
    elsif ($AURI[0] eq uriZFS)                          # URI must be strongly equal to constant
    {
        do "/etc/nginx/perl/lib/Generate__ZFS.pm";
        $htmlContent = $htmlContent.GenerateZFS(@AURI);
    }
    elsif ($AURI[0] eq uriSystem)            # URI must contains constant
    {

#        if (length($AURI[1]) >2 & length($AURI[1]) <5 )  # Drive name must be 3-4 characters long
#        {
#        }
    }

    $r->print( PrepareHTMLPage( $htmlContent ) );


    ##### Output HTTP

    if (-f $r->filename or -d _) {
        $r->print($r->uri, " exists!\n");
    }

    return OK;
}

1;
__END__
