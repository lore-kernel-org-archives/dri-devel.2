Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5065EE8538E
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 19:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8655D10F403;
	Fri,  3 Apr 2026 19:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QJvSUpdf";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE8010F47A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1775243114; bh=sn5c19iqNViTK6LNkTJwlq+SfVLeFcREcVA38qtyUTM=;
 b=QJvSUpdftzVw76mUiMTj8b+PcSfyhlfJSa7pgviblkXEKGQDTvBLhVK3xLn0E504MMmB2tLpy
 ksv9kRLC2bWFSZr39e0B4LyCm/R+SrGrmk1mIxy6eWsSf/4+/Ezvrzurk5eRt62Adukvzkj8ykE
 4lMMH8sfmJymgn0xUIVyFn3sPb6d7j9r6OdeIh29BrY8UjmZ5Z8Thm4z1RMGF2QRaifVcO3qkmJ
 Rs5q871NXJnmqKDxegBmPV9E4YfccA+ZALXcnWGS6VaercT68wzJNDieJhK6tVXL5p6fJpESc7X
 1WUVOC9qOUuu0M1SplUNL7Wamu/OJWUvQmEgqXke7/bQ==
X-Forward-Email-ID: 69d00cd2dc98192b40b893fc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.68
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] drm: bridge: dw_hdmi: Use
 drm_connector_helper_hpd_irq_event()
Date: Fri,  3 Apr 2026 18:52:56 +0000
Message-ID: <20260403185303.80748-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403185303.80748-1-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Use drm_connector_helper_hpd_irq_event() or drm_helper_hpd_irq_event()
depending on if a dw-hdmi connector or bridge is used.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 4d079b689b3b..4a0498922476 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3054,10 +3054,13 @@ static void dw_hdmi_hpd_work(struct work_struct *work)
 {
 	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
 
-	if (hdmi->bridge.dev) {
+	if (hdmi->connector.dev)
+		drm_connector_helper_hpd_irq_event(&hdmi->connector);
+	else if (hdmi->bridge.dev)
 		drm_helper_hpd_irq_event(hdmi->bridge.dev);
+
+	if (hdmi->bridge.dev)
 		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
-	}
 }
 
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
-- 
2.53.0

