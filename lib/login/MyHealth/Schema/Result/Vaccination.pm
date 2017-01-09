use utf8;
package MyHealth::Schema::Result::Vaccination;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::Vaccination

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

=head1 TABLE: C<vaccination>

=cut

__PACKAGE__->table("vaccination");

=head1 ACCESSORS

=head2 vaccination_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 vaccine_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "vaccination_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "vaccine_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</vaccination_id>

=back

=cut

__PACKAGE__->set_primary_key("vaccination_id");

=head1 RELATIONS

=head2 vaccination_schedules

Type: has_many

Related object: L<MyHealth::Schema::Result::VaccinationSchedule>

=cut

__PACKAGE__->has_many(
  "vaccination_schedules",
  "MyHealth::Schema::Result::VaccinationSchedule",
  { "foreign.next_vaccination_id" => "self.vaccination_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-01-08 21:32:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EySKoGwk9zA2YeCJN/+7DA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
