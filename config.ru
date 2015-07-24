require 'unicorn/worker_killer'
use Unicorn::WorkerKiller::MaxRequests, 3072, 4096
use Unicorn::WorkerKiller::Oom, (192 * (1024**2)), (256 * (1024**2))

require ::File.expand_path('../config/environment', __FILE__)
if ENV['RAILS_RELATIVE_URL_ROOT']
  map ENV['RAILS_RELATIVE_URL_ROOT'] do
    run Rails.application
  end
else
  run Rails.application
end
