def clean_up(document, what)
  # :document - expected Hash document to be cleaned up
  # :what - expected list of keys to be removed from document
  
  document.each do |key, value|
    if what.include? key
      document.delete(key) if what.include? key

    else
      if [Hash, BSON::Document].include? value.class
        document[key] = clean_up(value, what)

      elsif value.class == Array
        value.each do |sd|

          if [Hash, Array, BSON::Document].include? sd.class
            document[key] = clean_up(sd, what)
          end
        end
      end
    end
  end
  document
end