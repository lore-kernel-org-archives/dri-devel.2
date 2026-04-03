Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24733D730AD
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 19:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B0B10F37A;
	Fri,  3 Apr 2026 19:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rb+wIrcK";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A2910F39D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1775243114; bh=cb7kV5xrgzBNF02Z/hIuS/zVAc/l0KXvVzEjt546s3c=;
 b=rb+wIrcKQK1SkUaijqzNYYlQWf2+oVbbQi2pdwAdCaZGdlsGgaJkvCnrtjJYaShbpudi3dDRb
 ZKbnh1zSIS9BMhoYwtmxD06vEsvAnCEWk5yI60gCzGBMsltWFRuvpxBgUDezuOMBGL5FnrEVFWQ
 WWZrSxYTu/1MxpcoeETD+lWHjtUoa14a7zV8BJksBe0c2MrIzOg2EOUjPTpcz8L89VdhkxrGefh
 yh52v6NuKxA4W0QEsvJEJ+vAHmKAzXnr+duV+7aol+PhqoIY1dRgxtAOKslOxsA4gpGMpD+Bhvq
 qoMYyGahLo9ZO33gPbMLD0cndJ+vdZoMpcfwfEnq9DlA==
X-Forward-Email-ID: 69d00ccedc98192b40b893e1
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
Subject: [PATCH v3 09/13] drm: bridge: dw_hdmi: Use delayed_work to debounce
 hotplug event
Date: Fri,  3 Apr 2026 18:52:55 +0000
Message-ID: <20260403185303.80748-10-jonas@kwiboo.se>
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

HDMI Specification Version 1.4b chapter 8.5 mentions:

  An HDMI Sink shall not assert high voltage level on its Hot Plug
  Detect pin when the E-EDID is not available for reading.

  A Source may use a high voltage level Hot Plug Detect signal to
  initiate the reading of E-EDID data.

  An HDMI Sink shall indicate any change to the contents of the E-EDID
  by driving a low voltage level pulse on the Hot Plug Detect pin. This
  pulse shall be at least 100 msec.

Use a work queue to debounce reacting on HPD events to better handle a
HPD low voltage level pulse when a sink changes the EDID.

The 1100 msec hotplug debounce timeout was arbitrarily picked to match
other drivers using same const, and testing using a Raspberry Pi Monitor
seem to use a 200-300 msec pulse when going from standby to power on
state.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index f3f8144ae98e..4d079b689b3b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -51,6 +51,8 @@
 
 #define HDMI14_MAX_TMDSCLK	340000000
 
+#define HOTPLUG_DEBOUNCE_MS	1100
+
 static const u16 csc_coeff_default[3][4] = {
 	{ 0x2000, 0x0000, 0x0000, 0x0000 },
 	{ 0x0000, 0x2000, 0x0000, 0x0000 },
@@ -192,6 +194,7 @@ struct dw_hdmi {
 	hdmi_codec_plugged_cb plugged_cb;
 	struct device *codec_dev;
 	enum drm_connector_status last_connector_result;
+	struct delayed_work hpd_work;
 };
 
 const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
@@ -2528,6 +2531,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = connector->force;
+	hdmi->last_connector_result = connector->status;
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
@@ -3046,6 +3050,16 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
 
+static void dw_hdmi_hpd_work(struct work_struct *work)
+{
+	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
+
+	if (hdmi->bridge.dev) {
+		drm_helper_hpd_irq_event(hdmi->bridge.dev);
+		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
+	}
+}
+
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 {
 	struct dw_hdmi *hdmi = dev_id;
@@ -3097,10 +3111,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 			status == connector_status_connected ?
 			"plugin" : "plugout");
 
-		if (hdmi->bridge.dev) {
-			drm_helper_hpd_irq_event(hdmi->bridge.dev);
-			drm_bridge_hpd_notify(&hdmi->bridge, status);
-		}
+		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
+				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 	}
 
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
@@ -3420,6 +3432,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 		goto err_res;
 	}
 
+	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
+
 	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
 					dw_hdmi_irq, IRQF_SHARED,
 					dev_name(dev), hdmi);
@@ -3552,6 +3566,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
 
 void dw_hdmi_remove(struct dw_hdmi *hdmi)
 {
+	disable_delayed_work_sync(&hdmi->hpd_work);
+
 	drm_bridge_remove(&hdmi->bridge);
 
 	if (hdmi->audio && !IS_ERR(hdmi->audio))
-- 
2.53.0

