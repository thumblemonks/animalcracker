# Animal Cracker

## Usage  

In your Sinatra app somewhere:

    require 'animalcracker'

    class MyApp < Sinatra::Base
      register AnimalCracker::Server
      get_assets "/assets" # This is the root pathw where assets are to be found

      configure do
        AnimalCracker::AssetHost.configure(:asset_path => "./assets")
      end
    end

NOW: JUST NEED TO MAKE THIS WORK :)
