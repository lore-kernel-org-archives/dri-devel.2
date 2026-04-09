Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F69EF364A6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7014F10E838;
	Thu,  9 Apr 2026 17:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="h9xR02kI";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A4F10E838
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:09:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0A420C5C18A;
 Thu,  9 Apr 2026 17:10:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4094D603E4;
 Thu,  9 Apr 2026 17:09:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D624B104500F2; 
 Thu,  9 Apr 2026 19:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775754569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HqD0mr7sf75LjT0yNP7LvO47dnEsZGkmyqhNV5eLXkg=;
 b=h9xR02kI1jjYrNVTXgx/FD2R2tfo46THPCu9f5RgxizVaElcH1nVrVJgn9XpW++icA9cMD
 L6S0aZ7ez4L3CLg+I8sm1VUojyEkqoID3PPOS43uaDB1FF65SFPwqUATKJFyU0t7vdQwD6
 eulVpzdY8P1DuKHwIy4wsoQp99WkcUQI1B/QrBRFc3kH18/WjmOzAUTQU9BztWNvn3E3et
 hz0cJzJ7aa3wtQmaBtpF2CBTN4u41rNwmDq9B530eeAy5Is3pvdhs6XD+6glpyitFhdYJu
 6+CzEOl1ypzGo0xkDgmMno01+uxHAGlysBB9+twiEWhERUswxbd5CwYjGK9law==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Apr 2026 19:08:26 +0200
Subject: [PATCH RFC 10/12] drm/i915/display/dp: Adopt dp_connector helpers
 to expose link training state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-feat_link_cap-v1-10-7069e8199ce2@bootlin.com>
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

Switch the i915 DP connector initialization from drmm_connector_init()
to drmm_connector_dp_init(), providing the source link capabilities
(supported lane counts, link rates, DSC support, voltage swing and
pre-emphasis levels).

Add intel_dp_report_link_train() to collect the negotiated link
parameters (rate, lane count, DSC enable, per-lane voltage swing and
pre-emphasis) and report them via drm_connector_dp_set_link_train_properties()
once link training completes successfully.

Reset the link training properties via
drm_connector_dp_reset_link_train_properties() when the connector is
reported as disconnected or when the display device is disabled, so
the exposed state always reflects the current link status.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c            | 31 +++++++++++++++++++---
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 25 +++++++++++++++++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2af64de9c81de..641406bdc0cc9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -45,6 +45,7 @@
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_dp_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_managed.h>
@@ -6337,8 +6338,10 @@ intel_dp_detect(struct drm_connector *_connector,
 	drm_WARN_ON(display->drm,
 		    !drm_modeset_is_locked(&display->drm->mode_config.connection_mutex));
 
-	if (!intel_display_device_enabled(display))
+	if (!intel_display_device_enabled(display)) {
+		drm_connector_dp_reset_link_train_properties(_connector);
 		return connector_status_disconnected;
+	}
 
 	if (!intel_display_driver_check_access(display))
 		return connector->base.status;
@@ -6388,6 +6391,8 @@ intel_dp_detect(struct drm_connector *_connector,
 
 		intel_dp_tunnel_disconnect(intel_dp);
 
+		drm_connector_dp_reset_link_train_properties(_connector);
+
 		goto out_unset_edid;
 	}
 
@@ -7162,10 +7167,12 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 			struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(dig_port);
+	struct drm_connector_dp_link_train_caps link_caps;
 	struct intel_dp *intel_dp = &dig_port->dp;
 	struct intel_encoder *encoder = &dig_port->base;
 	struct drm_device *dev = encoder->base.dev;
 	enum port port = encoder->port;
+	u32 *rates;
 	int type;
 
 	if (drm_WARN(dev, dig_port->max_lanes < 1,
@@ -7213,8 +7220,25 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 		    type == DRM_MODE_CONNECTOR_eDP ? "eDP" : "DP",
 		    encoder->base.base.id, encoder->base.name);
 
-	drmm_connector_init(dev, &connector->base, &intel_dp_connector_funcs,
-			    type, &intel_dp->aux.ddc);
+	intel_dp_set_source_rates(intel_dp);
+	link_caps.nlanes = DRM_DP_1LANE | DRM_DP_2LANE | DRM_DP_4LANE;
+	link_caps.nrates = intel_dp->num_source_rates;
+	rates = kzalloc_objs(*rates, intel_dp->num_source_rates);
+	if (!rates)
+		goto fail;
+
+	for (int i = 0; i < intel_dp->num_source_rates; i++)
+		rates[i] = intel_dp->source_rates[i];
+
+	link_caps.rates = rates;
+	link_caps.dsc = true;
+	link_caps.v_swings = DRM_DP_VOLTAGE_SWING_LEVEL_MASK;
+	link_caps.pre_emphs = DRM_DP_PRE_EMPH_LEVEL_MASK;
+
+	drmm_connector_dp_init(dev, &connector->base, &intel_dp_connector_funcs,
+			       &link_caps, type, &intel_dp->aux.ddc);
+	kfree(rates);
+
 	drm_connector_helper_add(&connector->base, &intel_dp_connector_helper_funcs);
 
 	if (drmm_add_action_or_reset(dev, intel_connector_destroy, connector)) {
@@ -7240,7 +7264,6 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 	if (!intel_edp_init_connector(intel_dp, connector))
 		goto fail;
 
-	intel_dp_set_source_rates(intel_dp);
 	intel_dp_set_common_rates(intel_dp);
 	intel_dp_reset_link_params(intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 54c585c59b900..c2fd46a323650 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -25,6 +25,7 @@
 #include <linux/iopoll.h>
 
 #include <drm/display/drm_dp_helper.h>
+#include <drm/drm_dp_connector.h>
 #include <drm/drm_print.h>
 
 #include "intel_display_core.h"
@@ -1116,6 +1117,27 @@ intel_dp_128b132b_intra_hop(struct intel_dp *intel_dp,
 	return sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION ? 1 : 0;
 }
 
+static void intel_dp_report_link_train(struct intel_dp *intel_dp)
+{
+	struct intel_connector *connector = intel_dp->attached_connector;
+	struct drm_connector_dp_link_train dp_link_train;
+
+	dp_link_train.rate = intel_dp->link_rate;
+	dp_link_train.nlanes = intel_dp->lane_count;
+	dp_link_train.dsc_en = connector->dp.dsc_decompression_enabled;
+
+	for (int i = 0; i < intel_dp->lane_count; i++) {
+		int v_swing_level = (intel_dp->train_set[i] &
+				     DP_TRAIN_VOLTAGE_SWING_MASK) >> DP_TRAIN_VOLTAGE_SWING_SHIFT;
+		int pre_emph_level = (intel_dp->train_set[i] &
+				      DP_TRAIN_PRE_EMPHASIS_MASK) >> DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		dp_link_train.v_swing[i] = 1 << v_swing_level;
+		dp_link_train.pre_emph[i] = 1 << pre_emph_level;
+	}
+
+	drm_connector_dp_set_link_train_properties(&connector->base, &dp_link_train);
+}
+
 /**
  * intel_dp_stop_link_train - stop link training
  * @intel_dp: DP struct
@@ -1144,6 +1166,9 @@ void intel_dp_stop_link_train(struct intel_dp *intel_dp,
 	intel_dp_program_link_training_pattern(intel_dp, crtc_state, DP_PHY_DPRX,
 					       DP_TRAINING_PATTERN_DISABLE);
 
+	if (!intel_dp->is_mst)
+		intel_dp_report_link_train(intel_dp);
+
 	if (intel_dp_is_uhbr(crtc_state)) {
 		ret = poll_timeout_us(ret = intel_dp_128b132b_intra_hop(intel_dp, crtc_state),
 				      ret == 0,

-- 
2.43.0

