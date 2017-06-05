use utf8;
package MyHealth::Schema::Result::ScreeningCategory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::ScreeningCategory

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

=head1 TABLE: C<screening_categories>

=cut

__PACKAGE__->table("screening_categories");

=head1 ACCESSORS

=head2 category_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 category_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "category_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "category_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</category_id>

=back

=cut

__PACKAGE__->set_primary_key("category_id");

=head1 RELATIONS

=head2 questions

Type: has_many

Related object: L<MyHealth::Schema::Result::Question>

=cut

__PACKAGE__->has_many(
  "questions",
  "MyHealth::Schema::Result::Question",
  { "foreign.category_id" => "self.category_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-12 23:21:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NY4fR9F1ICBhkIyS/PcGFw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
