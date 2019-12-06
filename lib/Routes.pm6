use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub routes() is export {
    template-location 'templates';

    route {
        get -> {
                  template 'index.crotmp', { title => "タイトル", greeting => "hello Cro" };
        }

        get -> 'profile' {
                  template 'profile.crotmp', { title => "タイトル", name => "AnaTofuZ" , hobby => "Twitter", lang => "Perl"};
        }
    }
}
