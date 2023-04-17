// https://json-generator.com/
[
	'{{repeat(600, 700)}}',
	{
		import_id: '{{objectId()}}',
		external_id: '{{guid()}}',
		vrbo_id: '{{surname()}}',
		title: function () {
			var roomconfigs = ['2br/2ba ', '3br/2ba ', '3br/3ba ', '4br/2ba ', '4br/3ba ', '4br/5ba ', '5br/3ba ', '', ''];
			var adjs = ['Amazing ', 'Stunning ', 'Outstanding ', ''];
			var closers = ['near ', 'in the heart of ', 'short walk from '];
			var nouns = ['the beach', 'the city center', 'a great neighborhood', 'great nightlife', 'so much to do'];
			return adjs[Math.floor(Math.random() * adjs.length)] +
				roomconfigs[Math.floor(Math.random() * roomconfigs.length)] +
				closers[Math.floor(Math.random() * closers.length)] +
				nouns[Math.floor(Math.random() * nouns.length)];
		},
		location: {
			latitude: '{{floating(-90.000001, 90)}}',
			longitude: '{{floating(-180.000001, 180)}}'
		},
		bedrooms: '{{integer(1, 10)}}',
		bathrooms: '{{integer(1, 4)}}',
		reviews_count: '{{integer(0, 999)}}',
		rating: '{{floating(0, 5, 2)}}',
		max_guests: '{{integer(1, 16)}}',
		isActive: '{{bool()}}',
		balance: '{{floating(1000, 4000, 2, "$0,0.00")}}',
		property_type: '{{random("hotel", "bed and breakfast", "entire home", "apartment", "aparthotel")}}',
		name: '{{firstName()}} {{surname()}}',
		gender: '{{gender()}}',
		company: '{{company().toUpperCase()}}',
		email: '{{email()}}',
		phone: '+1 {{phone()}}',
		address: '{{integer(100, 999)}} {{street()}}, {{city()}}, {{state()}}, {{integer(100, 10000)}}',
		about: '{{lorem(1, "paragraphs")}}',
		created_at: '{{date(new Date(2014, 0, 1), new Date(), "YYYY-MM-ddThh:mm:ss Z")}}',
		updated_at: '{{date(new Date(2014, 0, 1), new Date(), "YYYY-MM-ddThh:mm:ss Z")}}',
		disabled_at: '{{date(new Date(2014, 0, 1), new Date(), "YYYY-MM-ddThh:mm:ss Z")}}',
		amenities: [
			'{{repeat(1, 7)}}',
			'{{lorem(1, "words")}}'
		],
		images: [
			'{{repeat(3, 30)}}',
			{
				id: '{{index() + 1}}',
				picture: function () {
					return "http://placehold.it/" + Math.floor(Math.random() * 10000) + "/32x32";
				}
			}
		]
	}
]