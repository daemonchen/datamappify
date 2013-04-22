module Datamappify
  module Repository
    module QueryMethod
      class Count < Method
        # @return [Integer]
        def perform
          dispatch_criteria_to_default_source(:Count)
        end
      end
    end
  end
end
