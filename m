Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A1CD4F58
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD7110E8CE;
	Mon, 18 May 2026 19:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WYrZGCyD";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46B110E8C6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133731; bh=fvEaZQvi82SxaGEnMSzH5YpUg8QLUYBGz0XPExRQPFs=;
 b=WYrZGCyDXFAQq0rpy0fKcZhTpin+KCUcDSFi+hzDvkG8JLKHCG0Ew8lTeRWGX98IUf8ED6ri5
 NQxDhsUxowlP97Qxa3x76oPi8+YKo9KnNXwVwbMasFYXpyg62/1LEilH0eQAEgjQYzsh1QDVJjq
 qk1cqczDC4VmDwkf7xfCTovXCGngPghZXm5q4zB2WW7+4u7wffVyikK8R1tRH044hd0J4DAVmTA
 kJmY1tc87jY96nHMD5ZG25kuC3TDuDXQdrQk2yW8Y3MlXhrZbL/ZnoQHuW8CA6/ROsvti5AXYxp
 25lsmyvSoE9yYJdB8sohcy7yKFxkI1URhVn7Et5l4CeA==
X-Forward-Email-ID: 6a0b6d18b74b0ebd362eef4d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: [PATCH 11/13] drm/bridge: dw-hdmi: Export dw_hdmi_schedule_hpd_work()
 helper
Date: Mon, 18 May 2026 19:47:39 +0000
Message-ID: <20260518194744.2483580-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518194744.2483580-1-jonas@kwiboo.se>
References: <20260518194744.2483580-1-jonas@kwiboo.se>
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

Export a dw_hdmi_schedule_hpd_work() helper that schedule the HPD
delayed work. Primarily to be used by the meson dw-hdmi driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +++++++++--
 include/drm/bridge/dw_hdmi.h              |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 99dd62b6becf..54d75317ce9c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3014,8 +3014,7 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 			status == connector_status_connected ?
 			"plugin" : "plugout");
 
-		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
-				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
+		dw_hdmi_schedule_hpd_work(hdmi);
 
 		hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
 		hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
@@ -3025,6 +3024,14 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 	return ret;
 }
 
+void dw_hdmi_schedule_hpd_work(struct dw_hdmi *hdmi)
+{
+	if (!IS_ERR_OR_NULL(hdmi))
+		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
+				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_schedule_hpd_work);
+
 static void dw_hdmi_hpd_work(struct work_struct *work)
 {
 	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 10013b8d3adb..c56d1775f04a 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -184,6 +184,8 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 
 void dw_hdmi_resume(struct dw_hdmi *hdmi);
 
+void dw_hdmi_schedule_hpd_work(struct dw_hdmi *hdmi);
+
 int dw_hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn,
 			   struct device *codec_dev);
 void dw_hdmi_set_sample_non_pcm(struct dw_hdmi *hdmi, unsigned int non_pcm);
-- 
2.54.0

