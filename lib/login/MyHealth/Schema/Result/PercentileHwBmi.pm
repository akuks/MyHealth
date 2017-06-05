use utf8;
package MyHealth::Schema::Result::PercentileHwBmi;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::PercentileHwBmi

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

=head1 TABLE: C<percentile_hw_bmi>

=cut

__PACKAGE__->table("percentile_hw_bmi");

=head1 ACCESSORS

=head2 prcnt_heght_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 p_age_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 prcnt_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 gender_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 height

  data_type: 'float'
  is_nullable: 1

=head2 weight

  data_type: 'float'
  is_nullable: 1

=head2 bmi

  data_type: 'float'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "prcnt_heght_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "p_age_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "prcnt_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "gender_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "height",
  { data_type => "float", is_nullable => 1 },
  "weight",
  { data_type => "float", is_nullable => 1 },
  "bmi",
  { data_type => "float", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</prcnt_heght_id>

=back

=cut

__PACKAGE__->set_primary_key("prcnt_heght_id");

=head1 RELATIONS

=head2 gender

Type: belongs_to

Related object: L<MyHealth::Schema::Result::Gender>

=cut

__PACKAGE__->belongs_to(
  "gender",
  "MyHealth::Schema::Result::Gender",
  { g_id => "gender_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 p_age

Type: belongs_to

Related object: L<MyHealth::Schema::Result::PercentileAge>

=cut

__PACKAGE__->belongs_to(
  "p_age",
  "MyHealth::Schema::Result::PercentileAge",
  { prcnt_age_id => "p_age_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 prcnt

Type: belongs_to

Related object: L<MyHealth::Schema::Result::Percentile>

=cut

__PACKAGE__->belongs_to(
  "prcnt",
  "MyHealth::Schema::Result::Percentile",
  { percentile_id => "prcnt_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-15 23:14:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1aybd4r64q1PmEqvjijTAA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
