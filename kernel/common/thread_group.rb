# -*- encoding: us-ascii -*-

class ThreadGroup
  def initialize
    @threads = []
  end

  def add(thread)
    if thread.group
      thread.group.remove(thread)
    end
    thread.add_to_group self

    @threads.delete_if do |w|
      obj = w.__object__
      !(obj and obj.alive?)
    end

    @threads << WeakRef.new(thread)
    self
  end

  def remove(thread)
    @threads.delete_if { |w| w.__object__ == thread }
  end

  def list
    list = []
    @threads.each do |w|
      obj = w.__object__
      list << obj if obj and obj.alive?
    end
    list
  end
end
