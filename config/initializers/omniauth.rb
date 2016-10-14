Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '1959790290914602', 'c5203191b64ef18e3ff10bd7c9f959f7'
end