use utf8;
package MyHealth::Schema::Result::SessionManagement;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::SessionManagement

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

=head1 TABLE: C<session_management>

=cut

__PACKAGE__->table("session_management");

=head1 ACCESSORS

=head2 session_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 login_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 session_start_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 session_end_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "session_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "login_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "session_start_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "session_end_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</session_id>

=back

=cut

__PACKAGE__->set_primary_key("session_id");

=head1 RELATIONS

=head2 login

Type: belongs_to

Related object: L<MyHealth::Schema::Result::Login>

=cut

__PACKAGE__->belongs_to(
  "login",
  "MyHealth::Schema::Result::Login",
  { login_id => "login_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-01-08 21:32:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:axYOTENALJuylxsXMGQoZw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
