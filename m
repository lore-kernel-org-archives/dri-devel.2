Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F52F364A4
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0BC10E844;
	Thu,  9 Apr 2026 17:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TdHFtusw";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C997210E844;
 Thu,  9 Apr 2026 17:09:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7329EC5C18D;
 Thu,  9 Apr 2026 17:10:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AA0F8603E4;
 Thu,  9 Apr 2026 17:09:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4965104501B9; 
 Thu,  9 Apr 2026 19:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775754577; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=80i2+SV+RLyeafvPAz3gjWWOqBFxeYH5P0a7No+38o8=;
 b=TdHFtuswVi6gUMeZnFkAQ1h9pYxWbUEmNzplgQT7MQIoLxVUeKQh9ZW6VmZx0JcElV0nTT
 ndiz9X1DMeZeUk8msd8gSMDWTxx2+1v+CUTZ2scRfTPMvu2Bf2YU9h2Xe2RIj4vns7A716
 z5h9gRlT4iPBE+tVe1Yp3+1eSh1qr2E6PmB2LNubQzYatkW9NOJ6mwUB2QsEtWFhOjQ3Dm
 D3KuHtVoL2McBeRsbNBCDGt/hapKZI1sw3s2gEOsQOX2gPJkgiOZUHjeQ0aFejaI+t0+7g
 optEMjLs5g2b4/YnM4lbdoqcSSe9QIytTPOi6B16/duv4oJJLdD/30s7jfvwqw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Apr 2026 19:08:28 +0200
Subject: [PATCH RFC 12/12] drm/mediatek: Use dp_connector helpers to report
 link training state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-feat_link_cap-v1-12-7069e8199ce2@bootlin.com>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
In-Reply-To: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3
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

Set DRM_BRIDGE_OP_DP and populate dp_link_train_caps with the supported
link rates, lane counts, voltage swing and pre-emphasis levels so the
bridge connector uses drmm_connector_dp_init() and exposes the link
training state properties to userspace.

Store per-lane voltage swing and pre-emphasis values in
mtk_dp_train_info and report the negotiated link parameters via
drm_connector_dp_set_link_train_properties() on training completion.
Clear them via drm_connector_dp_reset_link_train_properties() when a
disconnect is detected in the HPD event thread.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This patch has still not been tested. I am in the process of finding the
hardware for that.
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c52cc7c2e2006..119718c1374c5 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_dp_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -72,6 +73,8 @@ struct mtk_dp_train_info {
 	/* link_rate is in multiple of 0.27Gbps */
 	int link_rate;
 	int lane_count;
+	u8 vswing[4];
+	u8 preemphasis[4];
 	unsigned int channel_eq_pattern;
 };
 
@@ -1561,6 +1564,9 @@ static void mtk_dp_train_update_swing_pre(struct mtk_dp *mtk_dp, int lanes,
 		mtk_dp_set_swing_pre_emphasis(mtk_dp, lane, swing, preemphasis);
 		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_TRAINING_LANE0_SET + lane,
 				   val);
+
+		mtk_dp->train_info.vswing[lane] = swing;
+		mtk_dp->train_info.preemphasis[lane] = preemphasis;
 	}
 }
 
@@ -1812,6 +1818,21 @@ static void mtk_dp_train_change_mode(struct mtk_dp *mtk_dp)
 	mtk_dp_reset_swing_pre_emphasis(mtk_dp);
 }
 
+static int mtk_dp_report_link_train(struct mtk_dp *mtk_dp)
+{
+	struct drm_connector_dp_link_train dp_link_train;
+
+	dp_link_train.rate = drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate);
+	dp_link_train.nlanes = mtk_dp->train_info.lane_count;
+
+	for (int i = 0; i < mtk_dp->train_info.lane_count; i++) {
+		dp_link_train.v_swing[i] = 1 << mtk_dp->train_info.vswing[i];
+		dp_link_train.pre_emph[i] = 1 << mtk_dp->train_info.preemphasis[i];
+	}
+
+	return drm_connector_dp_set_link_train_properties(mtk_dp->conn, &dp_link_train);
+}
+
 static int mtk_dp_training(struct mtk_dp *mtk_dp)
 {
 	int ret;
@@ -1892,7 +1913,7 @@ static int mtk_dp_training(struct mtk_dp *mtk_dp)
 	mtk_dp_training_set_scramble(mtk_dp, true);
 	mtk_dp_set_enhanced_frame_mode(mtk_dp);
 
-	return 0;
+	return mtk_dp_report_link_train(mtk_dp);
 }
 
 static void mtk_dp_video_enable(struct mtk_dp *mtk_dp, bool enable)
@@ -2004,6 +2025,7 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 			mtk_dp->need_debounce = false;
 			mod_timer(&mtk_dp->debounce_timer,
 				  jiffies + msecs_to_jiffies(100) - 1);
+			drm_connector_dp_reset_link_train_properties(mtk_dp->conn);
 		} else {
 			mtk_dp_aux_panel_poweron(mtk_dp, true);
 
@@ -2742,6 +2764,14 @@ static int mtk_dp_edp_link_panel(struct drm_dp_aux *mtk_aux)
 
 static int mtk_dp_probe(struct platform_device *pdev)
 {
+	static const u32 dp_rates[] = {162000, 270000, 540000, 810000};
+	static const struct drm_connector_dp_link_train_caps dp_link_train_caps = {
+		.nlanes = DRM_DP_1LANE | DRM_DP_2LANE | DRM_DP_4LANE,
+		.nrates = ARRAY_SIZE(dp_rates),
+		.rates = dp_rates,
+		.v_swings = DRM_DP_VOLTAGE_SWING_LEVEL_MASK,
+		.pre_emphs = DRM_DP_PRE_EMPH_LEVEL_MASK,
+	};
 	struct mtk_dp *mtk_dp;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -2809,6 +2839,8 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	mtk_dp->bridge.of_node = dev->of_node;
 	mtk_dp->bridge.type = mtk_dp->data->bridge_type;
+	mtk_dp->bridge.dp_link_train_caps = &dp_link_train_caps;
+	mtk_dp->bridge.ops = DRM_BRIDGE_OP_DP;
 
 	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
 		/*

-- 
2.43.0

