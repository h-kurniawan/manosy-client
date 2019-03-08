class MaintenanceNotificationsController < ApplicationController
  def show
  end

  def review
    draft_message = <<~HEREDOC
      **Scheduled Maintenance Notification:**
      **Rave URL Maintenance Notification for 10-MAR-2018**

      **Affected URL(s):**
      <URL NAME HERE>

      **Maintenance Schedule Time: 12am-4am UTC**
      **During this maintenance, Rave URLs will incur an approximate 20-minute outage as each server will need to be rebooted after the hotfix is installed.**

      **Details:** This is to notify you of the scheduled March 10th Rave URL downtime on the URL(s) listed above.

      Medidata will be will be deploying an emergency hotfix to all Windows 2008 R2 servers in Houston Data Center (HDC).


      During this maintenance, the affected URLs listed above in the HDC may be inaccessible and receive a maintenance page.  This maintenance is necessary due to a bug found in the Microsoft operating system. More details on the bug and hotfix can be found here: https://support.microsoft.com/en-us/help/2553549/all-the-tcp-ip-ports-that-are-in-a-time-wait-status-are-not-closed-aft

      This is an automated email. Replies to this email are not monitored. If you need any technical assistance please contact the Medidata Helpdesk helpdesk@mdsol.com. For any other questions, please contact your Medidata Project Manager directly.

      Thank you
    HEREDOC

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @draft_message_html = markdown.render(draft_message)
  end
end
