use utf8;
package MyHealth::Schema::Result::VaccinationSchedule;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::VaccinationSchedule

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

=head1 TABLE: C<vaccination_schedule>

=cut

__PACKAGE__->table("vaccination_schedule");

=head1 ACCESSORS

=head2 vschedule_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 next_vaccination_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 vaccination_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 family_profile_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 if_missed

  data_type: 'enum'
  default_value: 0
  extra: {list => [0,1]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "vschedule_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "next_vaccination_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "vaccination_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
  "family_profile_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "if_missed",
  {
    data_type => "enum",
    default_value => 0,
    extra => { list => [0, 1] },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</vschedule_id>

=back

=cut

__PACKAGE__->set_primary_key("vschedule_id");

=head1 RELATIONS

=head2 family_profile

Type: belongs_to

Related object: L<MyHealth::Schema::Result::FamilyProfile>

=cut

__PACKAGE__->belongs_to(
  "family_profile",
  "MyHealth::Schema::Result::FamilyProfile",
  { family_profile_id => "family_profile_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 next_vaccination

Type: belongs_to

Related object: L<MyHealth::Schema::Result::Vaccination>

=cut

__PACKAGE__->belongs_to(
  "next_vaccination",
  "MyHealth::Schema::Result::Vaccination",
  { vaccination_id => "next_vaccination_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-01-08 21:32:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BDdUJ6VlrGq1IH6dfWEqTg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
