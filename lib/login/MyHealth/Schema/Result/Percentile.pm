use utf8;
package MyHealth::Schema::Result::Percentile;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::Percentile

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

=head1 TABLE: C<percentile>

=cut

__PACKAGE__->table("percentile");

=head1 ACCESSORS

=head2 percentile_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 value

  data_type: 'float'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "percentile_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "value",
  { data_type => "float", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</percentile_id>

=back

=cut

__PACKAGE__->set_primary_key("percentile_id");

=head1 RELATIONS

=head2 percentile_hw_bmis

Type: has_many

Related object: L<MyHealth::Schema::Result::PercentileHwBmi>

=cut

__PACKAGE__->has_many(
  "percentile_hw_bmis",
  "MyHealth::Schema::Result::PercentileHwBmi",
  { "foreign.prcnt_id" => "self.percentile_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-15 23:14:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NoeqoS6SyEr+om308q2Eaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
