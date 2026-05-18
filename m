Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3385CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415FB10E9A8;
	Mon, 18 May 2026 18:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hyUFtzyz";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EA610E9AB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779128091; bh=+tNbdHFGwve4PQpiDKk/njnhtvjRkwYwD94Sgvq2l/k=;
 b=hyUFtzyzErcB7zcnwKwe5Xr+ZR7/V7KeERo5KAOjJXj3YD60EZwP36AIk0JD0DMOMWJXY89/P
 N0mMSMGU6qw+gzEpGt+74s61AWtoz+Ua4L9iOV3gxoBM8eAtDLr5peO4kIxDqxXDZckRJZbvIAr
 2Xa4pHXp0TQnKaJ/au6fv5z28XbYAjhhvHJ7m3zdzZn272YZZiA4tbBgGCUy9feryUPzmtSzqud
 L4WIQoD59tkT3Z+mz6xpF11jNQFBPeWEi4i65BDfGAZV3TeZ7HKbyB14swqNb9iBcMM1WDmI+jZ
 qoBykplpZiNbpmgb0Gq2+VsrwDrHPClFu8VdoB6yNNtw==
X-Forward-Email-ID: 6a0b5489b84dbc72d2275016
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.12
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
 Simona Vetter <simona@ffwll.ch>
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
Subject: [PATCH v7 23/23] drm: bridge: dw_hdmi: Merge top and bottom half IRQ
 handlers
Date: Mon, 18 May 2026 18:01:59 +0000
Message-ID: <20260518180206.2480119-24-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518180206.2480119-1-jonas@kwiboo.se>
References: <20260518180206.2480119-1-jonas@kwiboo.se>
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

The bottom half IRQ handler only modify delay of or queue a delayed work
used for HPD handling. The mod_delayed_work() called is documented as
being safe to call from any context including IRQ handler.

Merge top and bottom half IRQ handlers to simplify IRQ handling now that
HPD event is handled using a delayed work.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v7: No change
v6: Collect r-b tag
v5: No change
v4: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 34 ++++++++---------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index c596534510da..99dd62b6becf 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2993,30 +2993,18 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 	if (hdmi->i2c)
 		ret = dw_hdmi_i2c_irq(hdmi);
 
-	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
-	if (intr_stat) {
-		hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
-		return IRQ_WAKE_THREAD;
-	}
-
-	return ret;
-}
-
-static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
-{
-	struct dw_hdmi *hdmi = dev_id;
-	u8 intr_stat;
-
 	/*
 	 * Interrupt generation is accomplished in the following way:
 	 *   interrupt = (mask == 0) && (polarity == status)
 	 * All interrupts are forwarded to the Interrupt Handler sticky bit
 	 * register ih_phy_stat0 and muted using the register ih_mute_phy_stat0.
 	 */
-	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
-	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
+	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0) & HDMI_IH_PHY_STAT0_HPD;
+	if (intr_stat) {
 		enum drm_connector_status status;
 
+		hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
+
 		/* Set HPD interrupt polarity based on current HPD status. */
 		status = dw_hdmi_phy_read_hpd(hdmi, hdmi->phy.data);
 		hdmi_modb(hdmi, status == connector_status_connected ?
@@ -3028,12 +3016,13 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 
 		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
+
+		hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
+		hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
+		ret = IRQ_HANDLED;
 	}
 
-	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
-
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void dw_hdmi_hpd_work(struct work_struct *work)
@@ -3343,9 +3332,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
 	disable_delayed_work(&hdmi->hpd_work);
 
-	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
-					dw_hdmi_irq, IRQF_SHARED,
-					dev_name(dev), hdmi);
+	ret = devm_request_irq(dev, irq, dw_hdmi_hardirq, IRQF_SHARED,
+			       dev_name(dev), hdmi);
 	if (ret)
 		goto err_res;
 
-- 
2.54.0

