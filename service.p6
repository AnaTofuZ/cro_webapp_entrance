use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use Routes;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<ENTRANCE_HOST> ||
        die("Missing ENTRANCE_HOST in environment"),
    port => %*ENV<ENTRANCE_PORT> ||
        die("Missing ENTRANCE_PORT in environment"),
    application => routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://%*ENV<ENTRANCE_HOST>:%*ENV<ENTRANCE_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
