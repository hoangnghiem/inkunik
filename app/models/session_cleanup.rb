class SessionCleanup
  def self.clean
    session_timeout = 40.minutes.ago
    SESSION_CLEANUP_LOG.info "" 
    SESSION_CLEANUP_LOG.info "Start clean up all staled sessions..." 
    begin
      staled_sessions = ActiveRecord::SessionStore::Session.find(:all, :conditions => ["updated_at < ?", session_timeout])
      if (!staled_sessions.blank? && staled_sessions.size > 0)
        SESSION_CLEANUP_LOG.info "Found #{staled_sessions.size} staled_session(s)." 
        staled_sessions.each do |ss|
          # clear working dir
          working_dir = "#{RAILS_ROOT}/dsg/#{ss.session_id}"
          if File.exist?(working_dir)
            FileUtils.rm_rf working_dir
            SESSION_CLEANUP_LOG.info "Removed #{working_dir}." 
          end
        end
        ActiveRecord::SessionStore::Session.destroy_all(["updated_at < ?", session_timeout])
        SESSION_CLEANUP_LOG.info "Finished clean up all staled sessions." 
      else
        SESSION_CLEANUP_LOG.info "There are no staled sessions."
      end
    rescue Exception => e
      SESSION_CLEANUP_LOG.info "Failed clean up all staled sessions due to #{e.message}." 
      SESSION_CLEANUP_LOG.info "#{e.backtrace.inspect}"
    ensure
      SESSION_CLEANUP_LOG.info "Email to admin."
    end
  end
end
