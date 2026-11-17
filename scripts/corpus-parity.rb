# frozen_string_literal: true

# Corpus parity harness (P1a): every fixture with an "input" and a
# "parses" expectation must accept/reject identically under the PARG
# artifact. Usage:
#   ruby scripts/corpus-parity.rb /path/to/asciichem-tests/corpus/fixtures
#
# GRAMMAR-LEVEL SCOPE: this harness checks the GRAMMAR's accept/reject.
# A corpus case whose rejection lives in the BUILD layer (the value
# tree the grammar accepts but the semantic walk refuses — the
# structure-reference family's dot-components, for one: the reference
# value is any quoted string at grammar level; its component count is
# the runtime's SMILES reader's domain) is out of this harness's
# scope and skipped with a note. The runtimes' own runners gate those.
require "json"
require "parsanol"
require "parsanol/parg"

BUILD_LEVEL_PREFIXES = ["structure-reference/"].freeze

fixtures_dir = ARGV[0] || "/Users/mulgogi/src/asciichem/asciichem-tests/corpus/fixtures"
src = File.read(File.join(__dir__, "..", "grammar/asciichem.parg"))
doc = Parsanol::PARG::Frontend.parse(src)
compiled = Parsanol::PARG::Compiler.compile(doc)
artifact_path = "/tmp/asciichem-grammar-parity.json"
File.write(artifact_path, JSON.generate(compiled.envelope))
artifact = Parsanol::PARG::Artifact.load(artifact_path)

total = 0
skipped = []
mismatches = []
Dir.glob(File.join(fixtures_dir, "*.json")).sort.each do |file|
  data = JSON.parse(File.read(file))
  items = data.is_a?(Array) ? data : [data]
  items.flatten.each do |fixture|
    next unless fixture.is_a?(Hash) && fixture["input"] && fixture.key?("parses")

    id = fixture["id"] || File.basename(file)
    if BUILD_LEVEL_PREFIXES.any? { |prefix| id.start_with?(prefix) }
      skipped << id
      next
    end

    total += 1
    input = fixture["input"]
    expected = fixture["parses"]
    begin
      artifact.parse("formula", input)
      actual = true
    rescue StandardError
      actual = false
    end
    next if actual == expected

    mismatches << [id, input, expected, actual]
  end
end

puts "checked: #{total}"
puts "skipped (build-level rejects, out of grammar scope): #{skipped.length}"
skipped.each { |id| puts "  #{id}" }
puts "mismatches: #{mismatches.length}"
mismatches.each do |id, input, expected, actual|
  puts "  #{id}: input=#{input.inspect} expected=#{expected} actual=#{actual}"
end
exit(mismatches.empty? ? 0 : 1)
