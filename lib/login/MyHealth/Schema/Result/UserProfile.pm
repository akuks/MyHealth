use utf8;
package MyHealth::Schema::Result::UserProfile;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::UserProfile

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

=head1 TABLE: C<user_profile>

=cut

__PACKAGE__->table("user_profile");

=head1 ACCESSORS

=head2 user_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 login_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  default_value: 'First_Name'
  is_nullable: 0
  size: 255

=head2 middle_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 dob

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 gender

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 blood_group

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 weight

  data_type: 'float'
  is_nullable: 1

=head2 height

  data_type: 'float'
  is_nullable: 1

=head2 aadhar_card

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 address

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 pin_code

  data_type: 'integer'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 updated_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 profile_validation

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "login_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "first_name",
  {
    data_type => "varchar",
    default_value => "First_Name",
    is_nullable => 0,
    size => 255,
  },
  "middle_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "dob",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "gender",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "blood_group",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "weight",
  { data_type => "float", is_nullable => 1 },
  "height",
  { data_type => "float", is_nullable => 1 },
  "aadhar_card",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "address",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "pin_code",
  { data_type => "integer", is_nullable => 1 },
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
  "profile_validation",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-02-20 22:33:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eBMfDXD2OwiltuQnDtvl4Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
