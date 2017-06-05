use utf8;
package MyHealth::Schema::Result::QuestionTiming;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::QuestionTiming

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

=head1 TABLE: C<question_timing>

=cut

__PACKAGE__->table("question_timing");

=head1 ACCESSORS

=head2 option_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 age_in_months

  data_type: 'float'
  is_nullable: 1

=head2 ques_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "option_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "age_in_months",
  { data_type => "float", is_nullable => 1 },
  "ques_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</option_id>

=back

=cut

__PACKAGE__->set_primary_key("option_id");

=head1 RELATIONS

=head2 que

Type: belongs_to

Related object: L<MyHealth::Schema::Result::Question>

=cut

__PACKAGE__->belongs_to(
  "que",
  "MyHealth::Schema::Result::Question",
  { ques_id => "ques_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-12 23:21:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4Q8v999f6XS5GiGO+nyZsg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
