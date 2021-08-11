use Mojolicious::Lite -signatures;

websocket '/echo' => sub ($c) {
  $c->on(json => sub ($c, $hash) {
    $hash->{msg} = "echo: $hash->{msg}";
    $c->send({json => $hash});
  });
};

app->start;
