Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49721CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9678110F37B;
	Wed, 30 Sep 2026 12:43:30 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDFD10EA14;
 Wed, 30 Sep 2026 12:43:27 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772152t7dc9c172
X-QQ-Originating-IP: WceE0gQRa+4Zl99cOV+oa3GjiJFg+QGWfuaL0DqcC08=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15150268539478603505
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:49 +0800
Subject: [PATCH 05/13] drm/msm/dp: Unwind resources when enabling a stream
 fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-5-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13206; i=sophon@radxa.com;
 h=from:subject:message-id; bh=Li99yqPRw0UnF7s6fDANEJDsnjXuUUhvb0y6Pc2dEfk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZfWGlkLLOdNO/NZsltwm12o8CeXnrgNeR92Cuh1f
 bJaa/mlo5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwEQS2Rj+J3jEvpWNOPd9juva
 L9o93YfUtu+K2uyrVbrft1PiP/Psg4wMHQcObfq/9ulXB/G/e3YtvlRxSsH7VsH8U3xPf5zcvPz
 bJ14A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NVMPT1fnJchtdAd+fFpOyKpo/eJM/R7uH9UtoaMVxnQwfYpZ7SAv9O/+
 vzpO5TqRB8STggDXwaZHTuUvpakAmWomUNH6rooQewnHROPVy49n6H7vkFIq1SxKIBWXzMb
 alGHNT4d8uOXVN40j3rqLtLR5l1LuTVNKpURAEP0gjJEV8mvfWMVOmyCqL5JmMVo5tjs7EU
 XHntBcTvWk6ArNPrkkEHFJiJnWtw6PqNxFcX/yGQclRN3Brsxi2EuZ8r0Yu65yEuEA5w7Gv
 0WtO2vgDlBXzNzDQ4/JTFcpC5sd+Qi+k0Xo6vtikeS4lxZQz3Rh+9WA00jseadYPtPsc2yV
 znMl66knkkLylDzLMpY62CgJUwl+viCIqpJJ0BEP1gPgBjagaQ/OD8bD3QvtPrjLfCNqnTR
 0ee65p1fR06tfKr9z7TmsZNmOQC/g+njJXp5vMCFcUq8GS/PUYSvG60KtbOgkJw0l+wkOKo
 tfMIboJPZ0RV+1yLENvSWiqGL/HN8Iyx+yf7pzO/XXio5I1WZ91qpj94yzsByOWSZvGTjbB
 +CEWUv/6nU13q9A/kBMYn6R6WKnv15o3lGijPhQbukLtmKXqUPg2tL5MVXpFS4v8+m1a4eS
 JkKiWp2mEbScIRxkKih6B6bAd6PYzWA8uXkY0D+mAhofV2I+MyBaRhpXxwbqZf6w2Qgf7vP
 1s+oJcJA17k1fj0jieGLK++OcLgqGelGnfgw1u1ZyotO3Z5953AAXIIEKi5b27892cyzQIJ
 dZ9lb56YMQfLUPcsj0mnxkO+VQUAQ8NKIAmelcvxXHm55Y3daRh5NhtAVrKOvjuITS43UM1
 C+U8cerqkU12rPtxQkiENADS9Ne+z1A8+m3IGsFDXHx/KAK7ag8EzJYZdubEFCSLGF8ymVC
 KPvIigAsEnYHgUqOWRpliGIU4n6voOg9eRpObaOAgo1Uc0Ts9W9nGG3iv3f/AQrEJspwfuT
 dtNOhV9EfG8rWxFr0te+DPKI4sDSN3RcdaxfUgDTAuwVKiG7lqXBMA+Co+bk3Z3hr+bN8sw
 gCWhvYCRE5JCva/Dke1HWipsFZKUYunzyvrrteJOpSKxX40wP1jw/FEvzB4BM=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
with HPD processing; leave the connection PM reference for the HPD
path to release.

Only access mainlink and SDP registers while the link clocks are
enabled. Startup or link reinitialization can fail with those clocks
already off; keep the controller reset and remaining PHY cleanup
independent of them.

With ownership tracking and rollback in place, propagate errors from
PHY initialization, configuration, power-on, eDP discovery and stream
retraining. Do not mark failed PHY initialization as successful, and
balance resources in the plug, detect and runtime resume paths as
well.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  45 +++++++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 120 +++++++++++++++++++++++++++++++-----
 3 files changed, 135 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f005421630c6..16c9165b5f31 100644
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
@@ -2583,8 +2595,11 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 		}
 	}
 
-	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
-		msm_dp_ctrl_link_retrain(ctrl, panel);
+	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl)) {
+		ret = msm_dp_ctrl_link_retrain(ctrl, panel);
+		if (ret)
+			return ret;
+	}
 
 	/* stop txing train pattern to end link training */
 	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
@@ -2671,9 +2686,11 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
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
index 3ca039ff57b8..ae967ca652c9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -52,6 +52,8 @@ struct msm_dp_display_private {
 	bool core_initialized;
 	bool phy_initialized;
 	bool audio_supported;
+	bool stream_pm_active;
+	bool stream_link_attempted;
 
 	struct mutex plugged_lock;
 	bool plugged;
@@ -322,22 +324,26 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
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
@@ -419,7 +425,12 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	msm_dp_aux_enable_xfers(dp->aux, true);
 
-	msm_dp_display_host_phy_init(dp);
+	ret = msm_dp_display_host_phy_init(dp);
+	if (ret < 0) {
+		msm_dp_aux_enable_xfers(dp->aux, false);
+		pm_runtime_put_sync(&pdev->dev);
+		return ret;
+	}
 
 	ret = msm_dp_display_process_hpd_high(dp);
 
@@ -628,8 +639,11 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
-	if (msm_dp_display->is_edp)
-		msm_dp_hpd_plug_handle(dp);
+	if (msm_dp_display->is_edp) {
+		rc = msm_dp_hpd_plug_handle(dp);
+		if (rc)
+			return rc;
+	}
 
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
@@ -637,18 +651,22 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 		return rc;
 	}
 
+	dp->stream_pm_active = true;
+
 	if (dp->link->sink_count == 0)
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
-		// TODO: schedule drm_connector_set_link_status_property()
 		return rc;
 	}
 
@@ -730,6 +748,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
+	dp->stream_link_attempted = false;
 
 	if (dp->link->sink_count == 0)
 		/* re-init the PHY so that we can listen to Dongle disconnect */
@@ -912,7 +931,12 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 		return status;
 	}
 
-	phy_deinit = msm_dp_display_host_phy_init(priv);
+	ret = msm_dp_display_host_phy_init(priv);
+	if (ret < 0) {
+		pm_runtime_put_sync(&dp->pdev->dev);
+		return status;
+	}
+	phy_deinit = ret;
 
 	msm_dp_aux_enable_xfers(priv->aux, true);
 
@@ -1294,6 +1318,7 @@ static int msm_dp_pm_runtime_suspend(struct device *dev)
 static int msm_dp_pm_runtime_resume(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
+	int ret;
 
 	/*
 	 * for eDP, host cotroller, HPD block and PHY are enabled here
@@ -1306,7 +1331,12 @@ static int msm_dp_pm_runtime_resume(struct device *dev)
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
@@ -1431,6 +1461,53 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
 }
 
+static void msm_dp_display_abort_enable(struct msm_dp_display_private *dp)
+{
+	bool keep_aux;
+	int ret;
+
+	/* Do not access the controller if stream preparation never resumed it. */
+	if (!dp->stream_pm_active)
+		goto unplug;
+
+	scoped_guard(mutex, &dp->plugged_lock) {
+		keep_aux = !dp->msm_dp_display.is_edp && dp->plugged &&
+			msm_dp_aux_is_link_connected(dp->aux);
+
+		if (dp->stream_link_attempted) {
+			/* The AUX peer is the remaining dongle, not its absent sink. */
+			if (keep_aux && !dp->link->sink_count && dp->phy_initialized)
+				msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+
+			msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+			msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+			dp->stream_link_attempted = false;
+
+			/* Mainlink power-off can also power down the AUX circuitry. */
+			msm_dp_display_host_phy_exit(dp);
+			if (keep_aux) {
+				ret = msm_dp_display_host_phy_init(dp);
+				if (ret < 0) {
+					DRM_ERROR("Failed to restore AUX PHY: %d\n", ret);
+					msm_dp_aux_enable_xfers(dp->aux, false);
+				}
+			}
+		} else if (!keep_aux) {
+			msm_dp_display_host_phy_exit(dp);
+		}
+		dp->msm_dp_display.power_on = false;
+	}
+
+unplug:
+	if (dp->msm_dp_display.is_edp)
+		msm_dp_hpd_unplug_handle(dp);
+
+	if (dp->stream_pm_active) {
+		pm_runtime_put_sync(&dp->msm_dp_display.pdev->dev);
+		dp->stream_pm_active = false;
+	}
+}
+
 void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 				  struct drm_atomic_commit *state)
 {
@@ -1442,20 +1519,26 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 	rc = msm_dp_display_prepare_link(dp);
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
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+	return;
+
+err:
+	msm_dp_display_abort_enable(dp);
 }
 
 void msm_dp_display_atomic_disable(struct msm_dp *dp)
@@ -1485,7 +1568,10 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+	if (dp->stream_pm_active) {
+		pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+		dp->stream_pm_active = false;
+	}
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }

-- 
2.55.0

