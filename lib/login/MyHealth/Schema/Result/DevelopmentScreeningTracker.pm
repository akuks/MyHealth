use utf8;
package MyHealth::Schema::Result::DevelopmentScreeningTracker;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::DevelopmentScreeningTracker

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

=head1 TABLE: C<development_screening_tracker>

=cut

__PACKAGE__->table("development_screening_tracker");

=head1 ACCESSORS

=head2 dst_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 family_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 question_id

  data_type: 'integer'
  is_nullable: 1

=head2 counter

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 status

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 user_input

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "dst_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "family_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "question_id",
  { data_type => "integer", is_nullable => 1 },
  "counter",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "status",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "user_input",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</dst_id>

=back

=cut

__PACKAGE__->set_primary_key("dst_id");

=head1 RELATIONS

=head2 family

Type: belongs_to

Related object: L<MyHealth::Schema::Result::FamilyProfile>

=cut

__PACKAGE__->belongs_to(
  "family",
  "MyHealth::Schema::Result::FamilyProfile",
  { relationship_id => "family_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-12 23:21:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GXTkdM7o/X6/xKs3amYIvg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
