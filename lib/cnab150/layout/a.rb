module Cnab150
  module Layout
    # Layout of Register A
    # This is a HEADER registry type
    class A
      def keys
        [:registry_code, :registry_type, :agreement,
         :organization,  :bank_code,     :bank_name,
         :file_date,     :file_number,   :version,
         :service,       :filler]
      end

      def layout
        'A' + [1, 1, 20, 20, 3, 20, 8, 6, 2, 17, 52].join('A')
      end
    end
  end
end
