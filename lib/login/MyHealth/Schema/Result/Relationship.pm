use utf8;
package MyHealth::Schema::Result::Relationship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyHealth::Schema::Result::Relationship

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

=head1 TABLE: C<relationship>

=cut

__PACKAGE__->table("relationship");

=head1 ACCESSORS

=head2 relationship_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 relationship_name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=cut

__PACKAGE__->add_columns(
  "relationship_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "relationship_name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</relationship_id>

=back

=cut

__PACKAGE__->set_primary_key("relationship_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<relationship_name_UNIQUE>

=over 4

=item * L</relationship_name>

=back

=cut

__PACKAGE__->add_unique_constraint("relationship_name_UNIQUE", ["relationship_name"]);

=head1 RELATIONS

=head2 family_profiles

Type: has_many

Related object: L<MyHealth::Schema::Result::FamilyProfile>

=cut

__PACKAGE__->has_many(
  "family_profiles",
  "MyHealth::Schema::Result::FamilyProfile",
  { "foreign.relationship_id" => "self.relationship_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-01-09 20:57:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vVkhH7PlgNEBCeIl4apMpw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
