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

    jp_draft = <<~HEREDOC
      **メンテナンス予定のお知らせ：**
      **2018年3月10日（日本時間）におけるRave URLメンテナンスのお知らせ**

      **影響するURL：**
      <URL NAME HERE>

      **メンテナンスの予定時間：30日午前9時～午後1時（日本時間）**
      **メンテナンス中は、ホットフィックスのインストール後に再起動が必要となるため、各サーバのRave URLは約20分間使用できなくなります。**

      **詳細：**3月10日（日本時間）に実施される上記Rave URLのダウンタイムについてお知らせします。

      お客様各位 平素より大変お世話になっております。メディデータはヒューストンデータセンター（Houston Data Center；HDC）内のすべてのWindows 2008 R2サーバーで緊急の修正プログラムの展開を予定しております。


      メンテナンス中は、対象となるHDC内の上記URLにはアクセスできなくなり、メンテナンスページが表示されます。このメンテナンスは、Microsoftオペレーティングシステムで発見されたバグ修正のために実施されるものです。バグおよび修正プログラムに関する詳細は、以下を参照してください。https://support.microsoft.com/en-us/help/2553549/all-the-tcp-ip-ports-that-are-in-a-time-wait-status-are-not-closed-aft

      このメールは、自動送信メールです。ご返信いただいてもお答えできません。技術的なサポートが必要な場合は、メディデータのカスタマーサポートjapanhelpdesk@mdsol.comまでご連絡ください。その他のご質問については、メディデータのプロジェクトマネジャーまで直接お問い合わせください。

      よろしくお願いいたします。
    HEREDOC

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @draft_message_html = markdown.render(draft_message)
    @jp_draft_message_html = markdown.render(jp_draft)
  end
end
