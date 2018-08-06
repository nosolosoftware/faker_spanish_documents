# Faker::SpanishDocuments

Gem to generate fake spanish documents as DNI, CIF or NIE. It's based on the well-known gem [Faker](https://github.com/stympy/faker).

## Installation

Add this line to your application's Gemfile:

    gem 'faker_spanish_documents'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faker_spanish_documents

## Usage

Its use is pretty easy, it exposes three method one for each type of document.
```ruby
Faker::SpanishDocuments.dni
Faker::SpanishDocuments.cif
Faker::SpanishDocuments.nie
