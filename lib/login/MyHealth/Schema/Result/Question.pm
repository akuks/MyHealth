use utf8;
package MyHealth::Schema::Result::Question;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::Question

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

=head1 TABLE: C<questions>

=cut

__PACKAGE__->table("questions");

=head1 ACCESSORS

=head2 ques_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 question

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "ques_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "question",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ques_id>

=back

=cut

__PACKAGE__->set_primary_key("ques_id");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<MyHealth::Schema::Result::ScreeningCategory>

=cut

__PACKAGE__->belongs_to(
  "category",
  "MyHealth::Schema::Result::ScreeningCategory",
  { category_id => "category_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 question_timings

Type: has_many

Related object: L<MyHealth::Schema::Result::QuestionTiming>

=cut

__PACKAGE__->has_many(
  "question_timings",
  "MyHealth::Schema::Result::QuestionTiming",
  { "foreign.ques_id" => "self.ques_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-12 23:21:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:H9/qgEgu8aCXA1jNJbghzw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
