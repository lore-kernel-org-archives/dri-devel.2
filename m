Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F24CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 12:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7733C10E13A;
	Sun, 10 May 2026 12:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fzg3nNz5";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9843510E13A
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778416903; bh=X0LXcByJTPpSTjNasSsMucOHjcHJLVs9+adcXo4a/UA=;
 b=fzg3nNz5MMXaLjgok32oaND/fHlJ5fFyE71ClJkWunfObr9idwlC+jiRRULL0mW4l0Mrlhywp
 dVJW3MZy5GzfHi2VlluewtNm+9QUNyG7ChS1ZVOkiBE5ciFs/rPY48LLht+JLE5nWUnver8q6bX
 n6K5vcryfezOd9BJOQ+E+jTBgc/o0nicrhcR3MUoLGSc3o5SRjA7YRkvUOMmkfPO5dfEhApQ/zQ
 BoksBaSYBGzVyTqJeKtcTmf+ongx8YQiDPtvxBOQSaOH9OA9C3L/8Gyj4G1DMAiSoJYNNQPbqgL
 2r8lboVzypxbP4UawgJB5Dl4MgZ2j2Cw3epHejkBtP1Q==
X-Forward-Email-ID: 6a007cfc0d91f03a31a0bb38
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v5 03/21] drm: bridge: dw_hdmi: Call poweron/poweroff from
 atomic enable/disable
Date: Sun, 10 May 2026 12:40:47 +0000
Message-ID: <20260510124111.1226584-4-jonas@kwiboo.se>
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

Change to only call poweron/poweroff from atomic_enable/atomic_disable
funcs instead of trying to be clever by keeping a bridge_is_on state and
poweron/off in the hotplug irq handler.

The bridge is already enabled/disabled depending on connection state
with the call to drm_helper_hpd_irq_event() in hotplug irq handler.

A benefit of this is that drm mode_config mutex is always held at
poweron/off, something that may reduce the need for the dw-hdmi mutex.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v5: No change
v4: No change
v3: Collect r-b tag
v2: Update commit message
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b7bfc0e9a6b2..8f7949d2c7f2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -171,7 +171,6 @@ struct dw_hdmi {
 	enum drm_connector_force force;	/* mutex-protected force state */
 	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
 	bool disabled;			/* DRM has disabled our bridge */
-	bool bridge_is_on;		/* indicates the bridge is on */
 	bool rxsense;			/* rxsense state */
 	u8 phy_mask;			/* desired phy int mask settings */
 	u8 mc_clkdis;			/* clock disable register */
@@ -2400,8 +2399,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
 
 static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
 {
-	hdmi->bridge_is_on = true;
-
 	/*
 	 * The curr_conn field is guaranteed to be valid here, as this function
 	 * is only be called when !hdmi->disabled.
@@ -2415,30 +2412,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
 		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
 		hdmi->phy.enabled = false;
 	}
-
-	hdmi->bridge_is_on = false;
-}
-
-static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
-{
-	int force = hdmi->force;
-
-	if (hdmi->disabled) {
-		force = DRM_FORCE_OFF;
-	} else if (force == DRM_FORCE_UNSPECIFIED) {
-		if (hdmi->rxsense)
-			force = DRM_FORCE_ON;
-		else
-			force = DRM_FORCE_OFF;
-	}
-
-	if (force == DRM_FORCE_OFF) {
-		if (hdmi->bridge_is_on)
-			dw_hdmi_poweroff(hdmi);
-	} else {
-		if (!hdmi->bridge_is_on)
-			dw_hdmi_poweron(hdmi);
-	}
 }
 
 /*
@@ -2563,7 +2536,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = connector->force;
-	dw_hdmi_update_power(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
@@ -2988,7 +2960,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = true;
 	hdmi->curr_conn = NULL;
-	dw_hdmi_update_power(hdmi);
+	dw_hdmi_poweroff(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, false);
 	mutex_unlock(&hdmi->mutex);
@@ -3006,7 +2978,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = false;
 	hdmi->curr_conn = connector;
-	dw_hdmi_update_power(hdmi);
+	dw_hdmi_poweron(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, true);
 	mutex_unlock(&hdmi->mutex);
@@ -3106,7 +3078,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 		if (hpd)
 			hdmi->rxsense = true;
 
-		dw_hdmi_update_power(hdmi);
 		dw_hdmi_update_phy_mask(hdmi);
 	}
 	mutex_unlock(&hdmi->mutex);
-- 
2.54.0

