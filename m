Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58943CD37B6
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 12:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26ED10E533;
	Sun, 10 May 2026 12:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qH+ucZYu";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D9C10E621
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778417587; bh=QE7Yi5vksJlhsc7/CDhIQcpwMEDHI3zUdRw0XaGmir8=;
 b=qH+ucZYuosjoCRa4mrzTOoa2tWmBKlaX5DWScyCI+kSWXopmqG6LrLVUpr7j1OYkppJFNK5Gf
 uW5Stfkrh3SSAtrNnQjiCqo+Jw1VWAL86LC2RXNWRW3OI8gX+VirTVlJdKHo4H04NKe0nMGvZbZ
 53U1uWvzS7deC4khHdcTL9AHdwAuf8EptXJwlqBaT+zpQoR05jgGszLiYA+O7qR9K6uIDmno22V
 uxskLU9iDMY/QT0jKIHkUqMQvB40woa2qsZC5OxpkB379GqCYm9jbMkL3xtT/XgmHrnXS9GX1kK
 u+9VvtOmSmHgh88JodekLajYeqGI+wlK6m0OXeTAvK8Q==
X-Forward-Email-ID: 6a007d3c0d91f03a31a0bd1b
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
Subject: [PATCH v5 17/21] drm: bridge: dw_hdmi: Rework HDP and RXSENSE
 interrupt handling
Date: Sun, 10 May 2026 12:41:01 +0000
Message-ID: <20260510124111.1226584-18-jonas@kwiboo.se>
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

The commit aeac23bda87f ("drm: bridge/dw_hdmi: improve HDMI
enable/disable handling") added use of PHY RXSENSE indications to avoid
triggering a full enable/disable of the HDMI block when a sink use a HPD
low voltage level pulse to indicate changes of the EDID.

HDMI Specification Version 1.4b chapter 8.5 mentions:

  An HDMI Sink shall indicate any change to the contents of the E-EDID
  by driving a low voltage level pulse on the Hot Plug Detect pin. This
  pulse shall be at least 100 msec.

A delayed work is now used to debounce reacting on a HPD low voltage
level pulse when a sink changes the EDID.

Remove RXSENSE handling to simplify the HPD interrupt handling and
instead depend on the debounced HPD work to refresh EDID.

This also ensures the initial HPD interrupt polarity is based on current
HPD status to avoid an unnecessary interrupt from being triggered
immediately at probe or resume when a sink is connected.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v5: Add comment about interrupt generation
v4: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 144 ++++------------------
 1 file changed, 21 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index f32eea9106b0..7fd2de41bc02 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -161,11 +161,7 @@ struct dw_hdmi {
 	struct pinctrl_state *unwedge_state;
 
 	struct mutex mutex;		/* for state below */
-	enum drm_connector_force force;	/* mutex-protected force state */
 	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
-	bool disabled;			/* DRM has disabled our bridge */
-	bool rxsense;			/* rxsense state */
-	u8 phy_mask;			/* desired phy int mask settings */
 	u8 mc_clkdis;			/* clock disable register */
 
 	spinlock_t audio_lock;
@@ -196,14 +192,6 @@ const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_to_plat_data);
 
-#define HDMI_IH_PHY_STAT0_RX_SENSE \
-	(HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
-	 HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
-
-#define HDMI_PHY_RX_SENSE \
-	(HDMI_PHY_RX_SENSE0 | HDMI_PHY_RX_SENSE1 | \
-	 HDMI_PHY_RX_SENSE2 | HDMI_PHY_RX_SENSE3)
-
 static inline void hdmi_writeb(struct dw_hdmi *hdmi, u8 val, int offset)
 {
 	regmap_write(hdmi->regm, offset << hdmi->reg_shift, val);
@@ -1702,36 +1690,25 @@ EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
 void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
 			    bool force, bool disabled, bool rxsense)
 {
-	u8 old_mask = hdmi->phy_mask;
-
-	if (force || disabled || !rxsense)
-		hdmi->phy_mask |= HDMI_PHY_RX_SENSE;
-	else
-		hdmi->phy_mask &= ~HDMI_PHY_RX_SENSE;
-
-	if (old_mask != hdmi->phy_mask)
-		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_phy_update_hpd);
 
 void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
 {
 	/*
-	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
-	 * any pending interrupt.
+	 * Configure the PHY HPD interrupt polarity based on current HPD status
+	 * and clear any pending interrupt.
 	 */
-	hdmi_writeb(hdmi, HDMI_PHY_HPD | HDMI_PHY_RX_SENSE, HDMI_PHY_POL0);
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
-		    HDMI_IH_PHY_STAT0);
+	hdmi_modb(hdmi, hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
+		  0 : HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
+	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
 
 	/* Enable cable hot plug irq. */
-	hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
+	hdmi_writeb(hdmi, ~HDMI_PHY_HPD, HDMI_PHY_MASK0);
 
 	/* Clear and unmute interrupts. */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
-		    HDMI_IH_PHY_STAT0);
-	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
-		    HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
+	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_phy_setup_hpd);
 
@@ -2395,26 +2372,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
 	}
 }
 
-/*
- * Adjust the detection of RXSENSE according to whether we have a forced
- * connection mode enabled, or whether we have been disabled.  There is
- * no point processing RXSENSE interrupts if we have a forced connection
- * state, or DRM has us disabled.
- *
- * We also disable rxsense interrupts when we think we're disconnected
- * to avoid floating TDMS signals giving false rxsense interrupts.
- *
- * Note: we still need to listen for HPD interrupts even when DRM has us
- * disabled so that we can detect a connect event.
- */
-static void dw_hdmi_update_phy_mask(struct dw_hdmi *hdmi)
-{
-	if (hdmi->phy.ops->update_hpd)
-		hdmi->phy.ops->update_hpd(hdmi, hdmi->phy.data,
-					  hdmi->force, hdmi->disabled,
-					  hdmi->rxsense);
-}
-
 static enum drm_connector_status dw_hdmi_detect(struct dw_hdmi *hdmi)
 {
 	enum drm_connector_status result;
@@ -2512,9 +2469,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
 
 	mutex_lock(&hdmi->mutex);
-	hdmi->force = connector->force;
 	hdmi->last_connector_result = connector->status;
-	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 
 	dw_hdmi_connector_status_update(connector, connector->status);
@@ -2932,10 +2887,8 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 	struct dw_hdmi *hdmi = bridge->driver_private;
 
 	mutex_lock(&hdmi->mutex);
-	hdmi->disabled = true;
 	hdmi->curr_conn = NULL;
 	dw_hdmi_poweroff(hdmi);
-	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, false);
 	mutex_unlock(&hdmi->mutex);
 }
@@ -2954,10 +2907,8 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
 
 	mutex_lock(&hdmi->mutex);
-	hdmi->disabled = false;
 	hdmi->curr_conn = connector;
 	dw_hdmi_poweron(hdmi, connector, mode);
-	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, true);
 	mutex_unlock(&hdmi->mutex);
 }
@@ -3051,78 +3002,29 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 
 void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 {
-	mutex_lock(&hdmi->mutex);
-
-	if (!hdmi->force) {
-		/*
-		 * If the RX sense status indicates we're disconnected,
-		 * clear the software rxsense status.
-		 */
-		if (!rx_sense)
-			hdmi->rxsense = false;
-
-		/*
-		 * Only set the software rxsense status when both
-		 * rxsense and hpd indicates we're connected.
-		 * This avoids what seems to be bad behaviour in
-		 * at least iMX6S versions of the phy.
-		 */
-		if (hpd)
-			hdmi->rxsense = true;
-
-		dw_hdmi_update_phy_mask(hdmi);
-	}
-	mutex_unlock(&hdmi->mutex);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
 
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 {
 	struct dw_hdmi *hdmi = dev_id;
-	u8 intr_stat, phy_int_pol, phy_pol_mask, phy_stat;
-	enum drm_connector_status status = connector_status_unknown;
-
-	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
-	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
-	phy_stat = hdmi_readb(hdmi, HDMI_PHY_STAT0);
-
-	phy_pol_mask = 0;
-	if (intr_stat & HDMI_IH_PHY_STAT0_HPD)
-		phy_pol_mask |= HDMI_PHY_HPD;
-	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE0)
-		phy_pol_mask |= HDMI_PHY_RX_SENSE0;
-	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE1)
-		phy_pol_mask |= HDMI_PHY_RX_SENSE1;
-	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE2)
-		phy_pol_mask |= HDMI_PHY_RX_SENSE2;
-	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE3)
-		phy_pol_mask |= HDMI_PHY_RX_SENSE3;
-
-	if (phy_pol_mask)
-		hdmi_modb(hdmi, ~phy_int_pol, phy_pol_mask, HDMI_PHY_POL0);
+	u8 intr_stat;
 
 	/*
-	 * RX sense tells us whether the TDMS transmitters are detecting
-	 * load - in other words, there's something listening on the
-	 * other end of the link.  Use this to decide whether we should
-	 * power on the phy as HPD may be toggled by the sink to merely
-	 * ask the source to re-read the EDID.
+	 * Interrupt generation is accomplished in the following way:
+	 *   interrupt = (mask == 0) && (polarity == status)
+	 * All interrupts are forwarded to the Interrupt Handler sticky bit
+	 * register ih_phy_stat0 and muted using the register ih_mute_phy_stat0.
 	 */
-	if (intr_stat &
-	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
-		dw_hdmi_setup_rx_sense(hdmi,
-				       phy_stat & HDMI_PHY_HPD,
-				       phy_stat & HDMI_PHY_RX_SENSE);
+	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
+	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
+		enum drm_connector_status status;
 
-		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
-		    (phy_stat & HDMI_PHY_HPD))
-			status = connector_status_connected;
+		/* Set HPD interrupt polarity based on current HPD status. */
+		status = dw_hdmi_phy_read_hpd(hdmi, hdmi->phy.data);
+		hdmi_modb(hdmi, status == connector_status_connected ?
+			  0 : HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
 
-		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
-			status = connector_status_disconnected;
-	}
-
-	if (status != connector_status_unknown) {
 		dev_dbg(hdmi->dev, "EVENT=%s\n",
 			status == connector_status_connected ?
 			"plugin" : "plugout");
@@ -3132,8 +3034,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	}
 
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
-	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
-		    HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
 
 	return IRQ_HANDLED;
 }
@@ -3324,9 +3225,6 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->dev = dev;
 	hdmi->sample_rate = 48000;
 	hdmi->channels = 2;
-	hdmi->disabled = true;
-	hdmi->rxsense = true;
-	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
 	hdmi->mc_clkdis = 0x7f;
 	hdmi->last_connector_result = connector_status_disconnected;
 
-- 
2.54.0

