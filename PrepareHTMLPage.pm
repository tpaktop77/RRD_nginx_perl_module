sub PrepareHTMLPage()
{
    $h = $h->html(
        [
          $h->head(
            [
            $h->title( 'Sample page' ),
            $h->meta(       { 'http-equiv'=>'Content-Language', 'content'=>'en-us' }        ),
            $h->meta(       { 'http-equiv'=>'imagetoolbar', 'content'=>'no' }               ),
            $h->meta(       { 'http-equiv'=>'refresh', 'content'=>'100' }           ),
            $h->link(       {
                                'href'=>"http://cts.tpaktop.com/stylesheets/base.css",
                                media=>"screen",
                                rel=>"stylesheet",
                                type=>"text/css"
                            }       ),
            $h->link(       {
                                'href'=>"http://cts.tpaktop.com/stylesheets/mainpage.css",
                                media=>"screen",
                                rel=>"stylesheet",
                                type=>"text/css"
                            }       ),
            $h->link(       {
                                'href'=>"http://cts.tpaktop.com/stylesheets/local.css",
                                media=>"screen",
                                rel=>"stylesheet",
                                type=>"text/css"
                            }       )
            ]
          ),
          $h->body(
            [
              $h->div( $_[0] )
            ]
          )
        ]
      );
    return $h;
}
