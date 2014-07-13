requires 'perl', '5.008001';
requires 'Apache::LogFormat::Compiler';
requires 'Plack::Middleware::AccessLog';
requires 'parent';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

