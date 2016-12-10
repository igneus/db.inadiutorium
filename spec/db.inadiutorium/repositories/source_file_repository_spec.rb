require 'spec_helper'

describe SourceFileRepository do
  subject { SourceFileRepository.new }

  before do
    subject.clear
  end

  describe '#find_by_path' do
    describe 'entity does not exist' do
      it 'returns nil' do
        subject.find_by_path(basename: 'basename', directory: 'directory').must_be_nil
      end
    end

    describe 'entity exists' do
      before do
        @source_file = subject.create basename: 'basename', directory: 'directory'
      end

      it 'returns the entity' do
        source_file = subject.find_by_path(basename: 'basename', directory: 'directory')
        source_file.must_be_instance_of SourceFile
        source_file.must_equal @source_file
      end
    end
  end
end
