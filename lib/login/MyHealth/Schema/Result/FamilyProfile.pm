use utf8;
package MyHealth::Schema::Result::FamilyProfile;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::FamilyProfile

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

=head1 TABLE: C<family_profile>

=cut

__PACKAGE__->table("family_profile");

=head1 ACCESSORS

=head2 family_profile_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 login_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 relationship_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 middle_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 dob

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 gender

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 blood_group

  data_type: 'varchar'
  is_nullable: 1
  size: 10

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

=head2 age

  data_type: 'varchar'
  is_nullable: 1
  size: 45

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
  "family_profile_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "login_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "relationship_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "middle_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "dob",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "gender",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "blood_group",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "weight",
  { data_type => "float", is_nullable => 1 },
  "height",
  { data_type => "float", is_nullable => 1 },
  "aadhar_card",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "age",
  { data_type => "varchar", is_nullable => 1, size => 45 },
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

=item * L</family_profile_id>

=back

=cut

__PACKAGE__->set_primary_key("family_profile_id");

=head1 RELATIONS

=head2 development_screening_trackers

Type: has_many

Related object: L<MyHealth::Schema::Result::DevelopmentScreeningTracker>

=cut

__PACKAGE__->has_many(
  "development_screening_trackers",
  "MyHealth::Schema::Result::DevelopmentScreeningTracker",
  { "foreign.family_id" => "self.relationship_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 relationship

Type: belongs_to

Related object: L<MyHealth::Schema::Result::Relationship>

=cut

__PACKAGE__->belongs_to(
  "relationship",
  "MyHealth::Schema::Result::Relationship",
  { relationship_id => "relationship_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 vaccination_schedules

Type: has_many

Related object: L<MyHealth::Schema::Result::VaccinationSchedule>

=cut

__PACKAGE__->has_many(
  "vaccination_schedules",
  "MyHealth::Schema::Result::VaccinationSchedule",
  { "foreign.family_profile_id" => "self.family_profile_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-12 23:21:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yBph+FO0LO3BHzFhP5owOQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
