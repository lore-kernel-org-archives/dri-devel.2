Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B57EC5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D723110E4A6;
	Sat,  8 Aug 2026 09:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APNYwYEy";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9A210E4AA
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:58:26 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f502ff678so35400f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786183105; x=1786787905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=78pbQXQC7rS+xYT3KOYvmzHciozgKbUx+FycpcHfTyI=;
 b=APNYwYEy45O1XU5zVOg4vrR1cRMpH0yxgVTywSWX2S/Tus9xyyT91zltrqNZUcqy0J
 XzMg5Ilp798DbDrkOqjAEpPF7rh2E1GBzpF8y7wWttFbXZcvZMhbUQZlIg5bvrEKaIdR
 iAZYlf+dbSvknO6WVFrT/KI3qt3uidKJNI+HHqCnMlWDQ0raqNgnjC7YQe4m2gDVUqAt
 7/aGq7jgz1bfct6xEhBh4Lw+AJa2j5J+NBPo8VYatelAWpaBVvoTlT4cBvZoyqE6rQTN
 NcsLSGRKwl0qW9vaY/IePLJAIZUu0iyOYLMdsmIV+VQN8rijyLpmSp4Nj1UnRmUuTtAZ
 vQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786183105; x=1786787905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=78pbQXQC7rS+xYT3KOYvmzHciozgKbUx+FycpcHfTyI=;
 b=d7AsnmFYlJJIAnNdaNOvgV6fJEYG+PfzLPvnvz8lFNn69S8wVkyBrz4yB6k7B/80W9
 jEVT5Tq7sxFRhjLUOVmdL+bBRKwLqpGErUYxu5+ak/kz4FVd9TTCalEKy4/Fm0a/JiJB
 IX7jxMV6734lKq/XynwFt34ZFV8RUJIkMqAjk4eCr+zn54qDxFgJLBHYBBbbys7aELbr
 JXvZyZBxm4WtLzuuGg03waTb2ZYNi3OAw5a4G2MtO/JTV4QjuTscrqMgLWnhCeX0C/Gz
 9Jy4ISNxVOr6OlZZxTdkDCjGQ6Qdp+L8ONUyIKGyr1uupIFPoMPPwT5qEhi9KDxcRlhm
 ZvBQ==
X-Gm-Message-State: AOJu0Yxv1j59RfFEceLE7e0HL0JFLvXrot0YH58IlqnE8u+/10+5+xFO
 0pjWUyU3oMeuK8RsnliyZclrdv23HCxItq5wSRxaKJ22CNON20GpoWH9g9MmH5Th
X-Gm-Gg: AR+sD10W98irUP+Vp00xGBJdh+nrM+xg4ymDSyM0e6Ba10e1O9M5F86+n/j6SQky26f
 hmm9gkyv4U8do4ByQR6DmbA8jyXXyMVZS3FZE/IpveQ8FxFtm2hK7qPPDW2RS4yxzyu2mhu8LKV
 PtjLvEVE5DlDhyTFTXzk0ofrQZauGtmlqTmcYPpdS/mORvVzRAAIWrrRnzWw0sFHUrrRL2LoILu
 jgKi7iGU4Ni6K5DERCShe4k99hTaoJ7uyZs9DMaukpyYkw0eBhIeYWxENhp36Pzx5Je2FXNfykW
 wrCfuHsOEJ0LfvWkFvYYOfT/BYYahjjZj/ll94+ImVLCzGOuuSnKW8IkHLZHXctLRiE7+tvrmjx
 kqTZ04NZQD0BrCytsLmZW2Ohgx3tDRBm/Nfps/AThGi3UqdBFDvBcaVimsH4cYUVJQoEYLOksxN
 U65FhyJAKmOEbBlV6ctJA5xnEAS4YTWzSRYrbkRCUdJIwdgT8Cx5BEi6mqHraXalNaOude+G3HC
 2mHs47imqKcfWWWTNC415KQCNo9DQJH6fFetbsuuSAoHR1g2lqQ1lyYA3WpAr+AHIrNiDdsbdxH
 AQEN
X-Received: by 2002:a05:6000:4211:b0:47f:96bc:e370 with SMTP id
 ffacd0b85a97d-47fec63bb0bmr22186473f8f.4.1786183105168; 
 Sat, 08 Aug 2026 02:58:25 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm13255725f8f.0.2026.08.08.02.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:58:24 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 4/5] drm/bridge: synopsys: dw-dp: Add HDR static metadata
 support
Date: Sat,  8 Aug 2026 11:57:23 +0200
Message-ID: <20260808095749.9428-5-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808095749.9428-1-royalnet026@gmail.com>
References: <20260808095749.9428-1-royalnet026@gmail.com>
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

Send an HDR Metadata InfoFrame SDP (DP 1.4a, Table 2-100 and
Table 2-101) when the connector state carries HDR output metadata, and
attach the HDR_OUTPUT_METADATA property in the Rockchip glue so
userspace can set it.

The infoframe is built with drm_hdmi_infoframe_set_hdr_metadata() and
packed with drm_dp_hdr_metadata_infoframe_sdp_pack(), then written
into a free slot of the SDP register bank with vertical interval
transmission, so the controller resends it once per frame during the
vertical blanking period. The SDP is sent at the end of
dw_dp_video_enable(), next to the existing VSC SDP; the connector
state is passed down from atomic_enable(), which already looks it up.

The allocated slot is tracked in hdr_sdp_nr and released in
atomic_disable(), following the VSC SDP pattern exactly:
atomic_disable() only clears tracked slots, so an untracked slot would
leak on every enable/disable cycle until dw_dp_send_sdp() runs out of
free slots and fails with -EBUSY for every SDP, including VSC and
audio.

A metadata change on a live stream (HDR on/off toggle, different
mastering display data) forces a full modeset: atomic_check() compares
the old and new connector state with
drm_connector_atomic_hdr_metadata_equal() and sets
crtc_state->mode_changed, the same approach as dw-hdmi. The resulting
disable/enable cycle then drops or (re)sends the SDP.

Commits without HDR metadata are unaffected: with a NULL metadata blob
in both old and new connector state,
drm_connector_atomic_hdr_metadata_equal() treats them as equal, no
modeset is forced, and dw_dp_video_enable() skips the SDP. This keeps
plain SDR commits a no-op even for compositors that write a NULL blob
on every atomic modeset once the property exists (KWin does).

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c   | 44 +++++++++++++++++++++--
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c |  2 ++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index df149c52fce0..ca997ea53e66 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -24,6 +24,7 @@
 #include <drm/drm_bridge_connector.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_hdmi_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
@@ -369,6 +370,7 @@ struct dw_dp {
 	struct drm_bridge *next_bridge;
 
 	int vsc_sdp_nr;
+	int hdr_sdp_nr;
 	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
 };
 
@@ -1171,6 +1173,28 @@ static int dw_dp_send_vsc_sdp(struct dw_dp *dp)
 	return dw_dp_send_sdp(dp, &sdp);
 }
 
+static int dw_dp_send_hdr_metadata_sdp(struct dw_dp *dp,
+				       const struct drm_connector_state *conn_state)
+{
+	struct hdmi_drm_infoframe frame;
+	struct dw_dp_sdp sdp = {};
+	ssize_t len;
+	int ret;
+
+	ret = drm_hdmi_infoframe_set_hdr_metadata(&frame, conn_state);
+	if (ret)
+		return ret;
+
+	len = drm_dp_hdr_metadata_infoframe_sdp_pack(dp->bridge.dev, &frame,
+						     &sdp.base, sizeof(sdp.base));
+	if (len < 0)
+		return len;
+
+	sdp.flags = DW_DP_SDP_VERTICAL_INTERVAL;
+
+	return dw_dp_send_sdp(dp, &sdp);
+}
+
 static int dw_dp_video_set_pixel_mode(struct dw_dp *dp)
 {
 	switch (dp->pixel_mode) {
@@ -1265,7 +1289,8 @@ static void dw_dp_video_disable(struct dw_dp *dp)
 			   FIELD_PREP(VIDEO_STREAM_ENABLE, 0));
 }
 
-static int dw_dp_video_enable(struct dw_dp *dp)
+static int dw_dp_video_enable(struct dw_dp *dp,
+			      const struct drm_connector_state *conn_state)
 {
 	struct dw_dp_link *link = &dp->link;
 	struct dw_dp_bridge_state *state;
@@ -1440,6 +1465,9 @@ static int dw_dp_video_enable(struct dw_dp *dp)
 	if (dw_dp_video_need_vsc_sdp(dp))
 		dp->vsc_sdp_nr = dw_dp_send_vsc_sdp(dp);
 
+	if (conn_state->hdr_output_metadata)
+		dp->hdr_sdp_nr = dw_dp_send_hdr_metadata_sdp(dp, conn_state);
+
 	return 0;
 }
 
@@ -1597,6 +1625,7 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	struct dw_dp *dp = bridge_to_dp(bridge);
 	struct dw_dp_bridge_state *state;
 	const struct dw_dp_output_format *fmt;
+	struct drm_connector_state *old_conn_state;
 	struct drm_display_mode *mode;
 	int min_hbp = 16;
 	int min_hsync = 9;
@@ -1616,6 +1645,11 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	state->bpc = fmt->bpc;
 	state->bpp = fmt->bpp;
 
+	old_conn_state = drm_atomic_get_old_connector_state(conn_state->state,
+							    conn_state->connector);
+	if (!drm_connector_atomic_hdr_metadata_equal(old_conn_state, conn_state))
+		crtc_state->mode_changed = true;
+
 	if ((adjusted_mode->hsync_start - adjusted_mode->hdisplay) & 0x1) {
 		adjusted_mode->hsync_start += 1;
 		dev_warn(dp->dev, "hfp is not 2 pixeel aligned, fixup to aligned hfp\n");
@@ -2016,7 +2050,7 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 	}
 
-	ret = dw_dp_video_enable(dp);
+	ret = dw_dp_video_enable(dp, conn_state);
 	if (ret < 0) {
 		dev_err(dp->dev, "failed to enable video: %d\n", ret);
 		return;
@@ -2066,6 +2100,11 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 		dp->vsc_sdp_nr = -1;
 	}
 
+	if (dp->hdr_sdp_nr >= 0) {
+		dw_dp_clear_sdp(dp, dp->hdr_sdp_nr);
+		dp->hdr_sdp_nr = -1;
+	}
+
 	dw_dp_reset(dp);
 	pm_runtime_put_autosuspend(dp->dev);
 }
@@ -2668,6 +2707,7 @@ int dw_dp_probe(struct dw_dp *dp)
 		return ret;
 
 	dp->vsc_sdp_nr = -1;
+	dp->hdr_sdp_nr = -1;
 	dp->audio_interface = DW_DP_AUDIO_UNUSED;
 	dp->audio_sdp_nr = -1;
 
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 4dc29963b5d8..c5bc178c0a50 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -198,6 +198,8 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
 		return ret;
 	}
 
+	drm_connector_attach_hdr_output_metadata_property(connector);
+
 	return 0;
 }
 
-- 
2.43.0

