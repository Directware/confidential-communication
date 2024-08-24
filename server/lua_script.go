package main

import "github.com/redis/go-redis/v9"

const getMessageLuaScript = `
-- Input arguments
-- KEYS[1]: The Redis stream key
-- ARGV[1]: The ID from where to start reading
-- ARGV[2]: The maximum number of elements to return

local stream_key = KEYS[1]
local start_id = ARGV[1]
local max_elements = tonumber(ARGV[2])

-- Read from the stream
local stream_entries = redis.call('XRANGE', stream_key, '(' .. start_id, '+', 'COUNT', max_elements)

local result = {}
local last_id = nil

for _, entry in ipairs(stream_entries) do
    local id = entry[1]
    local fields = entry[2]
    local data = {}

    -- Convert the field-value pairs to a Lua table
    for i = 1, #fields, 2 do
        data[fields[i]] = fields[i+1]
    end

    if data['type'] == 'reference' then
        -- If type is "reference", fetch the referenced value from Redis
        local ref_key = data['r']
        local ref_value = redis.call('HGET', ref_key, 'message')
        if ref_value then
            table.insert(result, ref_value)
        end
    elseif data['type'] == 'message' then
        -- If type is "message", append the element directly
        table.insert(result, data['body'])
    end

    last_id = id
end

-- Return the resulting list and the last processed ID
return {result, last_id}
	`

var (
	getMessageScript = redis.NewScript(getMessageLuaScript)
)
