Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74E6CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 12:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3501B10E43E;
	Sun, 10 May 2026 12:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CG9ikb+b";
	dkim-atps=neutral
X-Greylist: delayed 650 seconds by postgrey-1.36 at gabe;
 Sun, 10 May 2026 12:53:07 UTC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C2110E43E
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778417577; bh=3GqVsmYGwtYL1lA8+dzYuKNA/PzhqGwOr6aKWiXkMl0=;
 b=CG9ikb+bm4ha48gQEPyNDuLioEFHcVWsKnSSsZuZtmD27vjn7osKTB8tCY/xYNTeLF38Jz27z
 dc6JyzC/s8kVJowO6jnLhSvnA11YcpI/vrzUjfr96kkOhYZ5K47LfFl44s59oNptgDgTYOmTcv+
 bmD9SmtzFPVbGr9wB25T/X2cOay1A7meNUE/+AcQhIKNGIgS9XW3a4xlCiOZnRPlVXtL4p3TTjf
 ZO5GCyEXMIQDBa7dJF065PzGkW2dpFhYZgHidvZs/j0cmf8rkj/Jt14A4Bz9mCPnfF+oKpt2rvY
 +vpK7L4IdM/p0UkGjNI94EhFAUsNaCXMa8iHCrsvN8tA==
X-Forward-Email-ID: 6a007d410d91f03a31a0bd38
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 18/21] drm: bridge: dw_hdmi: Remove the empty
 dw_hdmi_setup_rx_sense()
Date: Sun, 10 May 2026 12:41:02 +0000
Message-ID: <20260510124111.1226584-19-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510124111.1226584-1-jonas@kwiboo.se>
References: <20260510124111.1226584-1-jonas@kwiboo.se>
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

The dw_hdmi_setup_rx_sense() helper is empty and no longer needed after
recent RXSENSE and HPD rework, remove it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v5: No change
v4: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 -----
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 3 ---
 include/drm/bridge/dw_hdmi.h              | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7fd2de41bc02..a388efeb6a87 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3000,11 +3000,6 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 	return ret;
 }
 
-void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
-{
-}
-EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
-
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 {
 	struct dw_hdmi *hdmi = dev_id;
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 9ba83bf4787c..3ad84cebf2c9 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -524,9 +524,6 @@ static irqreturn_t dw_hdmi_top_thread_irq(int irq, void *dev_id)
 		if (stat & HDMITX_TOP_INTR_HPD_RISE)
 			hpd_connected = true;
 
-		dw_hdmi_setup_rx_sense(dw_hdmi->hdmi, hpd_connected,
-				       hpd_connected);
-
 		drm_helper_hpd_irq_event(dw_hdmi->bridge->dev);
 		drm_bridge_hpd_notify(dw_hdmi->bridge,
 				      hpd_connected ? connector_status_connected
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index d587c4076a25..cea6618f097c 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -187,8 +187,6 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 void dw_hdmi_suspend(struct dw_hdmi *hdmi);
 void dw_hdmi_resume(struct dw_hdmi *hdmi);
 
-void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
-
 int dw_hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn,
 			   struct device *codec_dev);
 void dw_hdmi_set_sample_non_pcm(struct dw_hdmi *hdmi, unsigned int non_pcm);
-- 
2.54.0

