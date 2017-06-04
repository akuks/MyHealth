use utf8;
package MyHealth::Schema::Result::UserVerificationCode;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::UserVerificationCode

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<user_verification_code>

=cut

__PACKAGE__->table("user_verification_code");

=head1 ACCESSORS

=head2 code_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 code

  data_type: 'integer'
  is_nullable: 1

=head2 user_email

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "code_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "code",
  { data_type => "integer", is_nullable => 1 },
  "user_email",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</code_id>

=back

=cut

__PACKAGE__->set_primary_key("code_id");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-06-04 12:53:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SChmMebkn12JxGMmGPAq6Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
