Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0F606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a86kEJuH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18299112A0E;
	Fri, 27 Nov 2026 10:27:51 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0424211299B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:34 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so5616880f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774472; x=1796379272; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdDl7Q4foQHYAjSl826AE0/syYoFqrpNAcvwAyqjlxc=;
 b=a86kEJuHaUhE3ODGuutefcHASHI1K0dRarh2TMc25TI8u2eiIBxWyqMWYoumc9M/Ex
 8DcN5yDXXG/osrBiIYrBHkb7iT8Ke4w0rABWgQQBLmU4t5F8mY65R0UkdimKq7rT+55o
 zdod5xVpRLpNzxtpjxRWdp8D21ifszFHmnRM95wl62Vg+Of71/Zlj26vrwSPKwckTwsy
 Jyyy3D1xFQKmUsUajigSI9ahtg0JC2dx9vsjtFdlM5t7XzNpj2SCBLtMSUSpsjtxcLIN
 VjLm1+C4lmUuhRdJ+nf5xSFlDymb4kiMp+9+wzJU/0RLnjNx9S1ReUo0mQVk8TYvAjhh
 Nn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774472; x=1796379272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rdDl7Q4foQHYAjSl826AE0/syYoFqrpNAcvwAyqjlxc=;
 b=ZOh7q1uUG5wp8IN0piOVlPN+amsZ/h3/KFvFTOgQcp+57N8t7+vBkuqBEYLfIbdlAx
 spFMvjmeGexYyaDGtsdu7b7NU8M0OUMKg3tpspTIaUFIkmLChOddH9oLitf1R9UMOAJS
 XqKtSqFv+wkFoLuENSw5NJQBEIUKoo1AjeskUecUSGFCBBEQTYBFrV7npW6LlvIDuKDA
 fnARDBdCkWE4/4uK2wZScvj8BjJ7ux+fOFy9MzhkS08EygR091BFgMhdIpMfWpz9ew5P
 8VHlHtCQjwq38iO8HokZLIrPPPdW5Msl0hmaIJHdShMmzTgQbJ/G1/Eg6JLmWJXmaLQL
 g1CA==
X-Forwarded-Encrypted: i=1;
 AL+hErE8Saamv4a4Ekf14pBENOmD9V/HmbFmWNTDRlyAv5BlDYNYMo+0H/QTYETidPqr+pOQY9Yi9E73leI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/uHKLP40g+rxBdRAVMWEseTQR5vyBzSbMhz24CV2P1SrNOXVs7
 bEVgDVJQlRWphoMdxQqogFFodA8CRw+JtHV5cOA9Jd5MF4nVoiIntKo=
X-Gm-Gg: AZFdTZe0A4kNGaGJX0RwWsJ5wKwraWphR7Di/VwOQxmxYvlveo8m7a71ny/QqJ28+Ld
 KoaJmnTFAlvAtWJ54AO22xq1YQqGX7znssmbSGKWH7ey/PakKTfMdHCJmJF8l16kVE7db8pqvgf
 LQidsRJCGUPJWTyzRMEaXNAxXigJ9aAAHTCrdK1SDZwGHloM0dA52XzDnF+SRuqzQ2uaX9EWVBt
 jkh7rZA4S/l0mC9fyt8DdyzSAPHNLWoNv8GXuIX8m+ajDGgzRsqXJol4VpsXZmKkPGLYKJFyKKm
 08F6mHr7mgfxo7O6iUHIPFSTKLmd+2890ioHbW5lrTY60S6th1z+hITuOtYyTkgCxKEEzZH9vBh
 3qR6x4rC+ifZoFc94x01dWcqRQK4N1EM4/dSiITakWLH12O9525b97meDJp2vdz3xQ76CPLCHGH
 hUxrjlKs3HdUbHf4wxUyBVQgW322qJwNGg+8eDdUH7yC7wWYoVs1NC6D0QBD/mNPpvJBCstHgST
 NOUIfzfyT2/vAX3SQ8W2kdgQ4VbqEDBnebxsG3j2e4KuT9VALkiGjltkMtPEchG5YZFJbgDo8c8
 oI27Jhbo5WJKdNV07EK4G0cVwWzsg3xXwyorbaIPoS4dTC2KFP4GhH6hrP1nVTTba7Qhh5Qdo1g
 akwwHWv138nQ83djCZLz78Xb/As9+oIza00GbDBajZxtcn24IAuQ201ap3/Y=
X-Received: by 2002:a05:6000:2607:b0:48f:bb92:c5a7 with SMTP id
 ffacd0b85a97d-4abb0c5d665mr47747367f8f.9.1795774472210; 
 Fri, 27 Nov 2026 02:14:32 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:31 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 07/10] drm/msm/dp: fix HPD plugged, AUX gate,
 and runtime PM tracking
Date: Fri, 27 Nov 2026 11:14:14 +0100
Message-Id: <20261127101417.24303-8-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keep dp->plugged, AUX transfer enablement, and runtime PM reference
counts balanced across hotplug, detection, and link preparation:

- In msm_dp_hpd_plug_handle(), return early when dp->plugged is already
  set, unwind AUX transfers, PHY init (if initialized by this call), and
  runtime PM on DPCD/AUX failures, and keep dp->plugged = true when an
  empty branch device returns -ENOTCONN so downstream hotplug events
  remain observable.
- In msm_dp_hpd_unplug_handle(), avoid clearing video_test or disabling
  AUX transfers when !dp->plugged.
- In msm_dp_bridge_detect(), stop mutating priv->plugged (leaving
  ownership with the HPD plug/unplug handlers), disable AUX transfers on
  exit whenever !priv->plugged, and unconditionally drop detect's own
  runtime PM reference.
- Serialize msm_dp_display_prepare_link() under dp->plugged_lock and
  require dp->plugged before bringing up the link.
- Preserve dp->plugged in msm_dp_bridge_hpd_notify() when detect reports
  connector_status_disconnected for an attached empty branch dongle.

Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 71 +++++++++++++++++++----------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7831dd13b067..a48f42a17365 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -408,8 +408,9 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 
 static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 {
-	int ret;
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
+	bool phy_deinit;
+	int ret;
 
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
@@ -417,6 +418,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
+	if (dp->plugged)
+		return 0;
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -425,9 +429,16 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	msm_dp_aux_enable_xfers(dp->aux, true);
 
-	msm_dp_display_host_phy_init(dp);
+	phy_deinit = msm_dp_display_host_phy_init(dp);
 
 	ret = msm_dp_display_process_hpd_high(dp);
+	if (ret && ret != -ENOTCONN) {
+		msm_dp_aux_enable_xfers(dp->aux, false);
+		if (phy_deinit)
+			msm_dp_display_host_phy_exit(dp);
+		pm_runtime_put(&pdev->dev);
+		return ret;
+	}
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
@@ -435,8 +446,8 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	dp->plugged = true;
 
-	return ret;
-};
+	return 0;
+}
 
 static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
 		bool plugged)
@@ -458,10 +469,6 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
-	dp->panel->video_test = false;
-
-	msm_dp_aux_enable_xfers(dp->aux, false);
-
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
@@ -469,6 +476,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	if (!dp->plugged)
 		return 0;
 
+	dp->panel->video_test = false;
+	msm_dp_aux_enable_xfers(dp->aux, false);
+
 	/* Don't forget modes for eDP */
 	if (!dp->msm_dp_display.is_edp)
 		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
@@ -497,10 +507,8 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (dp->plugged) {
-		pm_runtime_put(&pdev->dev);
-		dp->plugged = false;
-	}
+	dp->plugged = false;
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 }
@@ -641,13 +649,15 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
 
+	guard(mutex)(&dp->plugged_lock);
+
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return rc;
 	}
 
-	if (dp->link->sink_count == 0)
+	if (!dp->plugged || dp->link->sink_count == 0)
 		return -ENOTCONN;
 
 	if (!msm_dp_display->power_on) {
@@ -926,26 +936,22 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	DRM_DEBUG_DP("aux link status: %x\n", ret);
 	if (!priv->plugged && !ret) {
 		DRM_DEBUG_DP("aux not connected\n");
-		priv->plugged = false;
 		goto end;
 	}
 
 	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
 	if (ret) {
 		DRM_DEBUG_DP("failed to read caps\n");
-		priv->plugged = false;
 		goto end;
 	}
 
 	ret = drm_dp_read_desc(priv->aux, &desc, drm_dp_is_branch(dpcd));
 	if (ret) {
 		DRM_DEBUG_DP("failed to read desc\n");
-		priv->plugged = false;
 		goto end;
 	}
 
 	status = connector_status_connected;
-	priv->plugged = true;
 
 	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
 		int sink_count = drm_dp_read_sink_count(priv->aux);
@@ -958,18 +964,17 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 end:
 	/*
-	 * If we detected the DPRX, leave the controller on so that it doesn't
-	 * lose the state.
+	 * Leave AUX and PHY enabled when the HPD plug handler already owns a
+	 * plugged sink; always release detect's own runtime PM reference.
 	 */
 	if (!priv->plugged) {
-		if (phy_deinit) {
-			msm_dp_aux_enable_xfers(priv->aux, false);
+		msm_dp_aux_enable_xfers(priv->aux, false);
+		if (phy_deinit)
 			msm_dp_display_host_phy_exit(priv);
-		}
-
-		pm_runtime_put_sync(&dp->pdev->dev);
 	}
 
+	pm_runtime_put(&dp->pdev->dev);
+
 	return status;
 }
 
@@ -1598,6 +1603,22 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge)
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 }
 
+static bool msm_dp_display_is_dongle_plugged(struct msm_dp_display_private *dp,
+					     u32 hpd_link_status)
+{
+	u8 rev;
+
+	guard(mutex)(&dp->plugged_lock);
+
+	if (!dp->plugged || !dp->link->has_sink_count || dp->link->sink_count)
+		return false;
+
+	if (hpd_link_status != ISR_DISCONNECTED)
+		return true;
+
+	return !drm_dp_dpcd_read_byte(dp->aux, DP_DPCD_REV, &rev);
+}
+
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
 			      enum drm_connector_status status)
@@ -1626,7 +1647,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		} else {
 			msm_dp_hpd_plug_handle(dp);
 		}
-	} else {
+	} else if (!msm_dp_display_is_dongle_plugged(dp, hpd_link_status)) {
 		msm_dp_hpd_unplug_handle(dp);
 	}
 
-- 
2.25.1

