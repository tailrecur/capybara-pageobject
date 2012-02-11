module MonkeyPatch
  module Object
    def blank?
      respond_to?(:empty?) ? empty? : !self
    end

    def present?
      !blank?
    end
  end
end

Object.send(:include, MonkeyPatch::Object)