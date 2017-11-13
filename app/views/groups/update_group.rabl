collection @group

attributes :id, :name
node(:startDate) { @group.start_date.to_time.to_i }
node(:endDate) { @group.end_date.to_time.to_i }
