#!perl

requires 'perl' => '5.20.0';
requires 'Future::AsyncAwait';
requires 'IO::Async::Loop';
requires 'Log::Any';
requires 'Protocol::Sys::Virt' => '10.3.3';


on test => sub {
    requires 'Test2::V0';
};

on develop => sub {
    requires 'Carp::Always';
    requires 'Protocol::Sys::Virt::Devel' => '0.0.4';
};

feature 'examples', 'Dependencies for examples' => sub {
    requires 'Feature::Compat::Try';
};
