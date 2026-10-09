Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D62CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7D910FE31;
	Fri,  9 Oct 2026 03:20:34 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972DC10FE3C;
 Fri,  9 Oct 2026 03:20:32 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515858t71947b7a
X-QQ-Originating-IP: BEBwRLs4BHE/QDuGMdzbEMD3nLzcZB6isiA1tgUil9A=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11807444935371451529
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:01 +0800
Subject: [PATCH v2 09/20] drm/msm/dp: Unwind resources when enabling a
 stream fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14219; i=sophon@radxa.com;
 h=from:subject:message-id; bh=sedurRw9RxkkEsG53qnKAO/mSGlfM6wHhX35znJYuV4=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlYaGmyMLNxr+8SH73ck4yOXryLZU6u1SttfxnKeu
 /ZD+OKrjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABM5+JuR4em1yvWZb1KfLJz6
 zf3Cltltz77dFzryduuar2lzuqK1YnYw/LNdWOknmDjhTN/HS7G3+G/cK9nf5HP3Z86s9NmWGfV
 ZMUwA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDyJFjRsJu3sluq3iECY5mVSyt/64sZBtJc2VOprbW0k2wFww9y5HmTl
 Sh8FGgqOhu1EFJMHVknKz8efaDN4X7sK4tnnXk5m40Bzdh/b5TyNw7/Wni9vaTqhhrUmuSS
 Ty8pWFer2Ggb9AYFMUoD5kHEqnJ/7qht3jTzMC9g11zF/8ngh6GbQZ+7qFafmE0sdPfi8lX
 M4o2qp84fDV6CSUelzNaMl1CqhMuBZVBN+rFRmNUM1qVTr6UO/mDbib3REtA3Xohf75D5LW
 U++fXMx6uyriPnmBHmCOuAMupMnFqgy6LarT+d0k7XK/L/SXJvh9PyxoH6+NEi2Ahd1PlTI
 OsH6AUCZaYVi0RGD+aHUHJMGXzRUXL/P5u252b7HXNPQQIuBDHopYylO4ZUb2AvSdi8cHzs
 zLseBDn/K3ZOOhELaAIcHuRRwGyN/h3MOBds3MpOy8lOTdGvYnIQ9Aun2vFnB9rqUEPkmRW
 K3XLHynkfunKx5sCUws5n0Qx8KQO/bb7h0p9hPu4jtuhDi45WRul++NxxJjc6cqf+pDIv4t
 SwuH+rLcaTy2+w3Qdzh8f+v9GQXcZ+Gj/Xpx98mMSmykIXtKmS2ylVJKFHpiNWK/QOV8FcW
 nTs+FDe5Q+eplvTj1QkSwBp/+z0tlNmSWftxzeN3lUQiRQcevkI7+w0be5owp2tOkltuVTD
 Ni0CTHnUOW/zCifACwDlgswqF7nfonXUIrTY55QAKvhDkyW7zKfnot3Zplew9+L8YW4MhZH
 TZdEfZCy2InXawXVtA0zG2UQI/rdERPEFc+JRoSTIYFEBIq4nh3T2Tjw8uU9ayfdGBjLmMq
 Lw1rXrp/nqu9x/cjjl3JdLJQNm1QtlyD9G0OUrtzqg/BSOV7yBR93xo3iJV+VFdgS0c5uOM
 S88YjTxXyNZ0mUtYkZk+rIquv7mh2kPHffhlEMvP7DXMrcXwvN4edz8IZoDOiEV3J7Y+/D9
 MciTX3nEmuni5/1Y4waJU7OH1o5JVVLMOe/9Z5CcoPVG3A6o/3G9Rx281NAT893gIbXji2V
 xC9P3AmWBjptHZ5TCVbkO6CXXFb3irVulZa6sXLo/SdUNYU+xk2TQTgs5SD9w=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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

Stream enable can fail after acquiring a runtime PM reference or
starting the link. Returning directly leaks those resources, while a
later disable can release a reference that was never acquired.

Track the stream PM reference and whether mainlink startup was
attempted. Use one rollback path for prepare, enable and post-enable
failures, and share the bookkeeping with normal disable to avoid
repeated release.

Keep AUX available for a connected external DP peer, including a
dongle without a downstream sink. If mainlink startup was attempted,
restore the AUX PHY after link shutdown, since partial startup can
power down AUX as well. Use plugged_lock to serialize this decision
with HPD processing, keeping rollback in the same critical section as
the failed enable. Release the lock before eDP unplug handling and
runtime PM put; leave the connection PM reference for the HPD path to
release.

Only access mainlink and SDP registers while the link clocks are
enabled. Startup or link reinitialization can fail with those clocks
already off; keep the controller reset and remaining PHY cleanup
independent of them.

With ownership tracking and rollback in place, propagate errors from
PHY initialization, configuration, power-on, eDP discovery and stream
retraining. Do not mark failed PHY initialization as successful, and
balance resources in the plug, detect and runtime resume paths as
well.

Disable the sink training pattern before returning a retraining error,
while AUX is still available. Preserve the original training error for
the caller to unwind the stream resources.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  42 +++++++----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 135 +++++++++++++++++++++++++++++-------
 3 files changed, 138 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f005421630c6..f633f6cf5764 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1856,17 +1856,22 @@ static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl,
 	ctrl->phy_opts.dp.link_rate = ctrl->link->link_params.rate / 100;
 	ctrl->phy_opts.dp.ssc = drm_dp_max_downspread(dpcd);
 
-	phy_configure(phy, &ctrl->phy_opts);
+	ret = phy_configure(phy, &ctrl->phy_opts);
+	if (ret)
+		return ret;
 	if (!ctrl->phy_powered) {
 		ret = phy_power_on(phy);
-		if (!ret)
-			ctrl->phy_powered = true;
+		if (ret)
+			return ret;
+		ctrl->phy_powered = true;
 	}
 
 	dev_pm_opp_set_rate(ctrl->dev, ctrl->link->link_params.rate * 1000);
 	ret = msm_dp_ctrl_link_clk_enable(&ctrl->msm_dp_ctrl);
-	if (ret)
+	if (ret) {
 		DRM_ERROR("Unable to start link clocks. ret=%d\n", ret);
+		msm_dp_ctrl_phy_power_off(ctrl);
+	}
 
 	drm_dbg_dp(ctrl->drm_dev, "link rate=%d\n", ctrl->link->link_params.rate);
 
@@ -1980,7 +1985,7 @@ static void msm_dp_ctrl_phy_reset(struct msm_dp_ctrl_private *ctrl)
 	msm_dp_write_ahb(ctrl, REG_DP_PHY_CTRL, 0x0);
 }
 
-void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
+int msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -1989,7 +1994,7 @@ void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_phy_reset(ctrl);
-	phy_init(phy);
+	return phy_init(phy);
 }
 
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2021,7 +2026,9 @@ static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl,
 	 */
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	msm_dp_ctrl_phy_power_off(ctrl);
+	ret = msm_dp_ctrl_phy_power_off(ctrl);
+	if (ret)
+		return ret;
 	/* hw recommended delay before re-enabling clocks */
 	msleep(20);
 
@@ -2038,16 +2045,21 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl,
 					     struct msm_dp_panel *panel)
 {
 	struct phy *phy;
+	int ret;
 
 	phy = ctrl->phy;
 
-	msm_dp_ctrl_mainlink_disable(ctrl);
+	/* Reinitializing the link may already have disabled its clocks. */
+	if (ctrl->link_clks_on)
+		msm_dp_ctrl_mainlink_disable(ctrl);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	msm_dp_ctrl_phy_power_off(ctrl);
+	ret = msm_dp_ctrl_phy_power_off(ctrl);
+	if (ret)
+		return ret;
 
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
@@ -2584,9 +2596,9 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
-		msm_dp_ctrl_link_retrain(ctrl, panel);
+		ret = msm_dp_ctrl_link_retrain(ctrl, panel);
 
-	/* stop txing train pattern to end link training */
+	/* Stop sink training even if retraining failed. */
 	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
 
 	return ret;
@@ -2671,9 +2683,11 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	msm_dp_panel_disable_vsc_sdp(panel);
-
-	msm_dp_ctrl_mainlink_disable(ctrl);
+	/* Link startup may have failed before enabling the link clocks. */
+	if (ctrl->link_clks_on) {
+		msm_dp_panel_disable_vsc_sdp(panel);
+		msm_dp_ctrl_mainlink_disable(ctrl);
+	}
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 5902cf7e746a..42c5f847cb02 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -39,7 +39,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
 
 void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl,
 		       struct msm_dp_panel *panel);
-void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_irq_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 787efbcb6c12..b076d44b5118 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -52,6 +52,8 @@ struct msm_dp_display_private {
 	bool core_initialized;
 	bool phy_initialized;
 	bool audio_supported;
+	bool stream_pm_active;
+	bool stream_link_attempted;
 
 	/* Serializes HPD, stream and PSR operations while runtime active. */
 	struct mutex plugged_lock;
@@ -323,22 +325,26 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
  *
  * Prepare DP PHY for the AUX transactions to succeed.
  *
- * Returns: true if this call has initliazed the PHY and false if the PHY has
- * already been setup beforehand.
+ * Returns: 1 if this call initialized the PHY, 0 if it was already
+ * initialized, or a negative error code on failure.
  */
-static bool msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
+static int msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
 {
+	int ret;
+
 	drm_dbg_dp(dp->drm_dev, "type=%d core_init=%d phy_init=%d\n",
 		dp->msm_dp_display.connector_type, dp->core_initialized,
 		dp->phy_initialized);
 
 	if (!dp->phy_initialized) {
-		msm_dp_ctrl_phy_init(dp->ctrl);
+		ret = msm_dp_ctrl_phy_init(dp->ctrl);
+		if (ret)
+			return ret;
 		dp->phy_initialized = true;
-		return true;
+		return 1;
 	}
 
-	return false;
+	return 0;
 }
 
 static void msm_dp_display_host_phy_exit(struct msm_dp_display_private *dp)
@@ -420,7 +426,13 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	msm_dp_aux_enable_xfers(dp->aux, true);
 
-	msm_dp_display_host_phy_init(dp);
+	ret = msm_dp_display_host_phy_init(dp);
+	if (ret < 0) {
+		msm_dp_aux_enable_xfers(dp->aux, false);
+		mutex_unlock(&dp->plugged_lock);
+		pm_runtime_put_sync(&pdev->dev);
+		return ret;
+	}
 
 	ret = msm_dp_display_process_hpd_high(dp);
 
@@ -629,8 +641,11 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 	int rc;
 
-	if (msm_dp_display->is_edp)
-		msm_dp_hpd_plug_handle(dp);
+	if (msm_dp_display->is_edp) {
+		rc = msm_dp_hpd_plug_handle(dp);
+		if (rc)
+			return rc;
+	}
 
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
@@ -638,6 +653,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 		return rc;
 	}
 
+	dp->stream_pm_active = true;
+
 	return 0;
 }
 
@@ -655,10 +672,13 @@ static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp)
 		return -ENOTCONN;
 
 	if (!msm_dp_display->power_on) {
-		msm_dp_display_host_phy_init(dp);
+		rc = msm_dp_display_host_phy_init(dp);
+		if (rc < 0)
+			return rc;
 		force_link_train = true;
 	}
 
+	dp->stream_link_attempted = true;
 	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
 	if (rc) {
 		DRM_ERROR("Failed link training (rc=%d)\n", rc);
@@ -750,6 +770,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
+	dp->stream_link_attempted = false;
 
 	if (dp->link->sink_count == 0)
 		/* re-init the PHY so that we can listen to Dongle disconnect */
@@ -937,7 +958,12 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	mutex_lock(&priv->plugged_lock);
 	put = false;
 
-	phy_deinit = msm_dp_display_host_phy_init(priv);
+	ret = msm_dp_display_host_phy_init(priv);
+	if (ret < 0) {
+		put = true;
+		goto unlock;
+	}
+	phy_deinit = ret;
 
 	msm_dp_aux_enable_xfers(priv->aux, true);
 
@@ -988,6 +1014,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 		put = true;
 	}
+unlock:
 	mutex_unlock(&priv->plugged_lock);
 
 	if (put)
@@ -1323,6 +1350,7 @@ static int msm_dp_pm_runtime_suspend(struct device *dev)
 static int msm_dp_pm_runtime_resume(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
+	int ret;
 
 	/*
 	 * for eDP, host cotroller, HPD block and PHY are enabled here
@@ -1335,7 +1363,12 @@ static int msm_dp_pm_runtime_resume(struct device *dev)
 	msm_dp_display_host_init(dp);
 	if (dp->msm_dp_display.is_edp) {
 		msm_dp_aux_hpd_enable(dp->aux);
-		msm_dp_display_host_phy_init(dp);
+		ret = msm_dp_display_host_phy_init(dp);
+		if (ret < 0) {
+			msm_dp_aux_hpd_disable(dp->aux);
+			msm_dp_display_host_deinit(dp);
+			return ret;
+		}
 	}
 
 	enable_irq(dp->irq);
@@ -1460,6 +1493,52 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
 }
 
+static void msm_dp_display_abort_enable_locked(struct msm_dp_display_private *dp)
+{
+	bool keep_aux;
+	int ret;
+
+	lockdep_assert_held(&dp->plugged_lock);
+
+	keep_aux = !dp->msm_dp_display.is_edp && dp->plugged &&
+		msm_dp_aux_is_link_connected(dp->aux);
+
+	if (dp->stream_link_attempted) {
+		/* The AUX peer is the remaining dongle, not its absent sink. */
+		if (keep_aux && !dp->link->sink_count && dp->phy_initialized)
+			msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+		dp->stream_link_attempted = false;
+
+		/* Mainlink power-off can also power down the AUX circuitry. */
+		msm_dp_display_host_phy_exit(dp);
+		if (keep_aux) {
+			ret = msm_dp_display_host_phy_init(dp);
+			if (ret < 0) {
+				DRM_ERROR("Failed to restore AUX PHY: %d\n", ret);
+				msm_dp_aux_enable_xfers(dp->aux, false);
+			}
+		}
+	} else if (!keep_aux) {
+		msm_dp_display_host_phy_exit(dp);
+	}
+	dp->msm_dp_display.power_on = false;
+}
+
+static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+
+	if (dp->stream_pm_active) {
+		pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+		dp->stream_pm_active = false;
+	}
+
+	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+}
+
 void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 				  struct drm_atomic_commit *state)
 {
@@ -1470,27 +1549,40 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 
 	rc = msm_dp_display_prepare(dp);
 	if (rc)
-		return;
+		goto err_prepare;
 
-	guard(mutex)(&dp->plugged_lock);
+	mutex_lock(&dp->plugged_lock);
 
 	rc = msm_dp_display_prepare_link_locked(dp);
 	if (rc) {
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
-		return;
+		goto err;
 	}
 
 	rc = msm_dp_display_enable(dp, dp->panel);
-	if (rc)
+	if (rc) {
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+		goto err;
+	}
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, dp->panel);
+		goto err;
 	}
 
+	mutex_unlock(&dp->plugged_lock);
+
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+	return;
+
+err:
+	msm_dp_display_abort_enable_locked(dp);
+	mutex_unlock(&dp->plugged_lock);
+err_prepare:
+	if (msm_dp_display->is_edp)
+		msm_dp_hpd_unplug_handle(dp);
+	msm_dp_display_unprepare(dp);
 }
 
 void msm_dp_display_atomic_disable(struct msm_dp *dp)
@@ -1518,15 +1610,6 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
-{
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
-
-	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
-
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
-}
-
 void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 {
 	struct msm_dp_display_private *msm_dp_display;

-- 
2.56.0

