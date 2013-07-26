module Datamappify
  module Data
    module Criteria
      module ActiveRecord
        class Where < Relational::Where
          # @param scope [ActiveRecord::Relation]
          #
          # @return [ActiveRecord::Relation]
          def records(scope = nil)
            (scope || source_class.joins(secondaries.map(&:source_key))).where(
              structured_criteria(primaries, secondaries)
            )
          end

          private

          # @param primaries [Array<Attribute>]
          #
          # @param secondaries [Array<Attribute>]
          #
          # @return [Hash]
          def structured_criteria(primaries, secondaries)
            _criteria = {}

            primaries.each do |primary|
              _criteria[primary.source_attribute_key] = primary.value
            end

            secondaries.each do |secondary|
              _criteria[secondary.source_table] ||= {}
              _criteria[secondary.source_table][secondary.source_attribute_key] = secondary.value
            end

            _criteria
          end
        end
      end
    end
  end
end
