use utf8;
package MyHealth::Schema::Result::Login;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::Login

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

=head1 TABLE: C<login>

=cut

__PACKAGE__->table("login");

=head1 ACCESSORS

=head2 login_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

login_id

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 created_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 updated_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "login_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "created_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "updated_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</login_id>

=back

=cut

__PACKAGE__->set_primary_key("login_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<email_UNIQUE>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("email_UNIQUE", ["email"]);

=head1 RELATIONS

=head2 family_profiles

Type: has_many

Related object: L<MyHealth::Schema::Result::FamilyProfile>

=cut

__PACKAGE__->has_many(
  "family_profiles",
  "MyHealth::Schema::Result::FamilyProfile",
  { "foreign.login_id" => "self.login_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 physical_activities

Type: has_many

Related object: L<MyHealth::Schema::Result::PhysicalActivity>

=cut

__PACKAGE__->has_many(
  "physical_activities",
  "MyHealth::Schema::Result::PhysicalActivity",
  { "foreign.login_id" => "self.login_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 session_managements

Type: has_many

Related object: L<MyHealth::Schema::Result::SessionManagement>

=cut

__PACKAGE__->has_many(
  "session_managements",
  "MyHealth::Schema::Result::SessionManagement",
  { "foreign.login_id" => "self.login_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_profiles

Type: has_many

Related object: L<MyHealth::Schema::Result::UserProfile>

=cut

__PACKAGE__->has_many(
  "user_profiles",
  "MyHealth::Schema::Result::UserProfile",
  { "foreign.login_id" => "self.login_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-02-20 22:33:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+0FpKn4CpW20vHwC2Uworw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
