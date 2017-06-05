use utf8;
package MyHealth::Schema::Result::Gender;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::Gender

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

=head1 TABLE: C<gender>

=cut

__PACKAGE__->table("gender");

=head1 ACCESSORS

=head2 g_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 value

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "g_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "value",
  { data_type => "varchar", is_nullable => 1, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</g_id>

=back

=cut

__PACKAGE__->set_primary_key("g_id");

=head1 RELATIONS

=head2 percentile_hw_bmis

Type: has_many

Related object: L<MyHealth::Schema::Result::PercentileHwBmi>

=cut

__PACKAGE__->has_many(
  "percentile_hw_bmis",
  "MyHealth::Schema::Result::PercentileHwBmi",
  { "foreign.gender_id" => "self.g_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-15 23:14:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f+gMixjVoDWG0Z2Nh1M+JQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
