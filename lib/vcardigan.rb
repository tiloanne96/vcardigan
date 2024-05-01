require_relative 'vcardigan/version'
require_relative 'vcardigan/vcard'
require_relative 'vcardigan/property'
require_relative 'vcardigan/properties/name_property'
require_relative 'vcardigan/errors'

module VCardigan

  class << self

    def create(*args)
      VCardigan::VCard.new(*args)
    end

    def parse(*args)
      VCardigan::VCard.new.parse(*args)
    end

    def parse_from_json(data)
      data = JSON.parse(data.gsub('=>', ':')) if data.kind_of?(String)

      return false unless data.kind_of?(Hash)

      vcard = VCardigan.create

      data.each do |key, array_values|
        array_values.each_with_index do |value, position|
          vcard.add(key,"")

          value.each{ |prop_key, prop_value|
            vcard.send(key)[position].instance_variable_set("@#{prop_key}".to_sym, prop_value)
          }
        end
      end

      vcard
    end
  end
end
