module Pipedrive

  class Organization < Base

    def self.all
      res = get "/organizations"
      if res.ok?
        res['data'].map{|org| Organization.new(org)}
      else
        bad_response(res)
      end
    end

    def self.create( opts = {} )
      res = post "/organizations", :body => opts
      if res.success?
        res['data'] = opts.merge res['data']
        Organization.new(res)
      else
        bad_response(res)
      end
    end

    def self.find_or_create_by_name( name, opts={} )
      find_by_name( name ).first || create( opts.merge( :title => name ) )
    end

    def self.find(id)
      res = get "/organizations/#{id}"
      if res.ok?
        Organization.new(res)
      else
        bad_response(res)
      end
    end

    def self.find_by_name(name, opts={})
      res = get "/organizations/find", :query => { :term => name }.merge(opts)
      if res.ok?
        Organization.new_list(res)
      else
        bad_response(res)
      end
    end

  end

end