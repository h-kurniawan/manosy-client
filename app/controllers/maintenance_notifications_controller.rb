class MaintenanceNotificationsController < ApplicationController
  def show
    @response = client.fetch_downtime(params[:id])
  end

  def review
    @response = client.fetch_downtime(params[:id])

    @to = @response[:product_urls].map do |product|
      product[:client_emails]
    end.flatten.uniq

    @cc = @response[:product_urls].map do |product|
      product[:project_manager_emails]
    end.flatten.uniq

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
    @draft_message_html = markdown.render(@response[:draft_message])
    @jp_draft_message_html = markdown.render(jp_draft)
  end

  private

  def client
    @_client ||= APIClient.new
  end
end
