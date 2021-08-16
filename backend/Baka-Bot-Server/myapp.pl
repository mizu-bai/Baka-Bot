use Mojolicious::Lite -signatures;
use utf8;

<<EOF;

api::ws
  message template (json)
  {
    "type":    message type (number), 0: client side, 1: server side
    "name":    user name (string)
    "time":    unix time (number)
    "content": message content (string)
   }

EOF

websocket '/api/ws' => sub ($c) {
  $c->on(json => sub ($c, $c_msg) {
    # get client side message
    my $s_content = $c_msg->{content};

    # modify client side message to generate server side message
    if ($s_content =~ m/名字/g) {
      $s_content = "我是人工智能 Bot（其实是人工智障）";
    } else {
      $s_content =~ s/你/我/g;
      $s_content =~ s/吗//g;
      $s_content =~ s/？/！/g;
      $s_content =~ s/?/!/g;
    }

    # server side message json
    my $s_msg = {
        type    => 1,
        name    => "人工智障 Bot",
        time    => time(),
        content => $s_content
    };

    # send
    $c->send({json => $s_msg});
  });
};

app->start;
