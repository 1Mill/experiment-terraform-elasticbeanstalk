3.times do |n|
	Article.where(
		:text => "#{Faker::Lorem.paragraphs}",
		:title => "Why #{Faker::Appliance.brand} #{Faker::Appliance.equipment} is awesome",
	).first_or_create
end
