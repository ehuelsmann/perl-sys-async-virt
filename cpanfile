#!perl

requires 'perl' => '5.20.0';
requires 'Log::Any';
requires 'Protocol::Sys::Virt' => '10.3.3';


on test => sub {
    requires 'Test2::V0';
};

on devel => sub {
    requires 'Carp::Always';
    requires 'Protocol::Sys::Virt::Devel' => '0.0.4';
};

feature 'examples', 'Dependencies for examples' => sub {
    requires 'Feature::Compat::Try';
    requires 'Future::AsyncAwait';
    requires 'Future::IO';
    requires 'Future::IO::Impl::IOAsync';
    requires 'IO::Async::Loop';
};
