collection @group

attributes :id, :name
node(:startDate) { @group.start_date.to_time.to_i * 1000 }
node(:endDate) { @group.end_date.to_time.to_i * 1000 }
