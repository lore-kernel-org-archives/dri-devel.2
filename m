Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36189CD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 10:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B3E10E293;
	Sat, 23 May 2026 10:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ys0FP99W";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A91810E039
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779532895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnPEN/biZG4V7hzIDC4ybTBTHSPiVXNYVA0O7uBuSdI=;
 b=Ys0FP99WnKgw/35Xuk4cJmaGyM/Dq1n4KdELh9YE/sPWYo73Z60TdjgzMgXzOMrGrNCh5B
 tL0Q+xfC5M57DzlH6N4C0NnkJPqqTsRjGacrT68jQhNgYbkK52+6Fu2KzZIQLg485FFtpS
 mHrzSYVqyvsAJcbvPPJ+EOrb3mAKf00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-xgFgyZEyMSmqeG1SnS942g-1; Sat, 23 May 2026 06:41:31 -0400
X-MC-Unique: xgFgyZEyMSmqeG1SnS942g-1
X-Mimecast-MFC-AGG-ID: xgFgyZEyMSmqeG1SnS942g_1779532891
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48d127eb013so37275315e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779532890; x=1780137690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cnPEN/biZG4V7hzIDC4ybTBTHSPiVXNYVA0O7uBuSdI=;
 b=IsYWsyDWH4q956nB2Ns3V+82mExl6FrsfFsJu76+c2+LvzXjRB+Tp52dzQF5h9+tOf
 t1sHwnLLBbkgB+Naoy2ZeT/wkUOtH74iprxOfdx2oEQkDKqzjwlG28Mj8AUEjWrgAocM
 RMJ8ElBOgdLC+kInelmlRGK01aiOJ7ns/sD+aHJkDb4SiIqKL+HsQKjjZs3NNMxCa2A4
 SGwXVIxrQow/rdEYdXmwWQmaYKbV6MS5lC6WQj4bke3sWibQz23fV10t0PduKiWwv8B5
 E0/dHiUVYrOVfOW4J6uiZ2o17IFGk3jdBtMwNEJYDMKmnNsr1DX6Ty19kr5B0Mf8tUwB
 gNDQ==
X-Gm-Message-State: AOJu0YzSL8ScOtm2FJr44O0ZIGiHFokTh+ERZHrcWU3zJBI+65Hfw45h
 Ft98C3AodqMZg1ioeDV68wgBFlD45+c7yRVCAz4lrWc/cctCGTdK8wrwXDXd+LJeXekn75faMWZ
 j9Zz9OpVqwR+/AJ/+BmYJRqI0Pt9sNj1w3lDcW6A3IzQen9qmztB5EXAFLO9nb4ZMPHMSDY1JDk
 NtGQ==
X-Gm-Gg: Acq92OH93JcXCpvGReNpzAbB8KxcLyIDF0Uqz4ef4S7OoaZ7aPfYtGouE4gKw6vXjNA
 LqZKCkh5hxW5ruhmLfQ/Aa/6HhGtRztbAtyJjA2SPEZR5rDmUI7MwQtYSagST/Uf41rdeNCEYnj
 wZ85WxNImHq6Ctv+ZQCXCGtqqVBPbYRTn0VdExovB+lbb3+JjvoDGx1+5xQzwM/ix1XjVUgp4bi
 czIV6VzsnUVMf6/IHICcNt2YDIxxm/lVIk7oTO3o/tyaIigKiJHKG8MAt2NfmJNwTEsaeybmG72
 OII7E4HAAsomZ6aeMZZkS6HKikaYIw4EKD7K6MeaLnw1b9xtcP/bHgMp1FBzWY5LdLQpYLFNy4u
 KtJuT/uD01xyAV2Y=
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-49044ebc29emr108105335e9.21.1779532890365; 
 Sat, 23 May 2026 03:41:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-49044ebc29emr108104895e9.21.1779532889883; 
 Sat, 23 May 2026 03:41:29 -0700 (PDT)
Received: from localhost ([90.167.87.79]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042d081f5sm48884115e9.5.2026.05.23.03.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 03:41:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Sat, 23 May 2026 12:40:58 +0200
Subject: [PATCH v5 1/3] drm/bridge: ite-it66121: Switch to the HDMI
 connector helpers
MIME-Version: 1.0
Message-Id: <20260523-it66121-fix-dvi-mode-v5-v5-1-33b4468162f9@redhat.com>
References: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
In-Reply-To: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Phong LE <ple@baylibre.com>, Sen Wang <sen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11584; i=javierm@redhat.com;
 h=from:subject:message-id; bh=nVyVeJDK7kujSqes6ziAhvNtVr2bw7e+Lv5PUwohBEI=;
 b=owEBbQKS/ZANAwAKAcdR5ZDWPz1pAcsmYgBqEYRScS89fJvYEbhzfHd+6Ee+e7LUMe1ioL8vx
 /+CMnWpbt6JAjMEAAEKAB0WIQTXXteqJOUM1kXG9FfHUeWQ1j89aQUCahGEUgAKCRDHUeWQ1j89
 aeFKD/4v8c6d6MIhTwx6+OvPGYxafkYHlgVR4LBoA8SzCojSGNsSWJaZDPu2NNZYuMyz0MHYsT1
 H5csmainuTHUKTnvj9VVMp3gIrE5xGULwR9yFK+vG2hVJqM1bRISJh2mDat4cFz9Vu2tc5V5Ljz
 GOIYOCcPob54mOczskrq3wQH9zUY9/EZApBbFBMKEVnNlB15w2pkKVtY18Y5f9wQ5tVI5PKcFm6
 fbQlkrKZVBptceHADKFNmfPE53BW96FuTxesEffPJy249qZq694On6I+7cw145pHmfzWKnnNzza
 o/FY0Z7JUr146mH3ibw7svmSctgSyv85sKlrHkr7TR9J++ZUplh8TjWH97cPdS2zpJIXHAETY7z
 /wPTWjq3v/6Y2e1KlPmFck/C1arPOAtFZ3E3l2Ijy00n2KKwYsc+uF372n+X5r9npOGgPsBbMQf
 gxqV2Zn8A/I3EnZX5h7/clWy0ttLmmXWyG1yQUNY090ipcZSAfX+uQPdCRg+GOp6x1SYeiAWDar
 5Sflrs0u3tKmpZ1yzvLm+hw1lVTlEgs8sB55foXwLCRROYxAPgPasmGdSMiF21XxZi9uOGdqURQ
 XVH3aAidgtw0+SgWbKVm1BD+V9RtY/+aKfkvIQTDFe/KWwE8ksJ5OO/0IBWPVNHYfll+zIRlI/9
 zw+yRUeDQQz43RQ==
X-Developer-Key: i=javierm@redhat.com; a=openpgp;
 fpr=D75ED7AA24E50CD645C6F457C751E590D63F3D69
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IvTu1k1k5Mh4Ju6oq1uHczMhkX8ezxrJYSsbN2WXKfU_1779532891
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Instead of open coding the HDMI AVI Infoframes buffer management, use the
helpers provided by the HDMI connector framework.

Also, add callbacks to implement HDMI Vendor Specific Infoframe and Audio
InfoFrame support. The driver was not sending these before, but they are
required when using the HDMI helpers.

These were implemented following the IT66121 Programming Guide.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/bridge/Kconfig       |   2 +
 drivers/gpu/drm/bridge/ite-it66121.c | 211 ++++++++++++++++++++++++++---------
 2 files changed, 162 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f81b566c82a1..4a57d49b4c6d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -205,6 +205,8 @@ config DRM_LONTIUM_LT8713SX
 config DRM_ITE_IT66121
 	tristate "ITE IT66121 HDMI bridge"
 	depends on OF
+	select DRM_DISPLAY_HDMI_STATE_HELPER
+	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
 	help
diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 19e188fe6e3b..f41f51f300c9 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -20,6 +20,8 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/display/drm_hdmi_helper.h>
+#include <drm/display/drm_hdmi_state_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
@@ -161,6 +163,14 @@
 #define IT66121_PKT_GEN_CTRL_ON			BIT(0)
 #define IT66121_PKT_GEN_CTRL_RPT		BIT(1)
 
+#define IT66121_PKT_NULL_CTRL_REG		0xC9
+#define IT66121_PKT_NULL_CTRL_ON		BIT(0)
+#define IT66121_PKT_NULL_CTRL_RPT		BIT(1)
+
+/* Null packet data registers (used for HDMI Vendor Specific InfoFrame) */
+#define IT66121_PKT_NULL_HB(n)			(0x138 + (n))
+#define IT66121_PKT_NULL_PB(n)			(0x13B + (n))
+
 #define IT66121_AVIINFO_DB1_REG			0x158
 #define IT66121_AVIINFO_DB2_REG			0x159
 #define IT66121_AVIINFO_DB3_REG			0x15A
@@ -180,6 +190,13 @@
 #define IT66121_AVI_INFO_PKT_ON			BIT(0)
 #define IT66121_AVI_INFO_PKT_RPT		BIT(1)
 
+#define IT66121_AUD_INFO_PKT_REG		0xCE
+#define IT66121_AUD_INFO_PKT_ON			BIT(0)
+#define IT66121_AUD_INFO_PKT_RPT		BIT(1)
+
+#define IT66121_AUD_INFO_DB1_REG		0x168
+#define IT66121_AUD_INFO_CSUM_REG		0x16D
+
 #define IT66121_HDMI_MODE_REG			0xC0
 #define IT66121_HDMI_MODE_HDMI			BIT(0)
 
@@ -304,7 +321,6 @@ struct it66121_ctx {
 	struct i2c_client *client;
 	u32 bus_width;
 	struct mutex lock; /* Protects fields below and device registers */
-	struct hdmi_avi_infoframe hdmi_avi_infoframe;
 	struct {
 		u8 ch_enable;
 		u8 fs;
@@ -726,6 +742,10 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
 	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (WARN_ON(!ctx->connector))
+		return;
+
+	drm_atomic_helper_connector_hdmi_update_infoframes(ctx->connector, state);
 
 	it66121_set_mute(ctx, false);
 }
@@ -763,40 +783,10 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 			     const struct drm_display_mode *mode,
 			     const struct drm_display_mode *adjusted_mode)
 {
-	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
-	int ret;
 
 	mutex_lock(&ctx->lock);
 
-	ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe, ctx->connector,
-						       adjusted_mode);
-	if (ret) {
-		DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
-		goto unlock;
-	}
-
-	ret = hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(buf));
-	if (ret < 0) {
-		DRM_ERROR("Failed to pack infoframe: %d\n", ret);
-		goto unlock;
-	}
-
-	/* Write new AVI infoframe packet */
-	ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
-				&buf[HDMI_INFOFRAME_HEADER_SIZE],
-				HDMI_AVI_INFOFRAME_SIZE);
-	if (ret)
-		goto unlock;
-
-	if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
-		goto unlock;
-
-	/* Enable AVI infoframe */
-	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
-			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
-		goto unlock;
-
 	/* Set TX mode to HDMI */
 	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
 		goto unlock;
@@ -824,24 +814,6 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 	mutex_unlock(&ctx->lock);
 }
 
-static enum drm_mode_status it66121_bridge_mode_valid(struct drm_bridge *bridge,
-						      const struct drm_display_info *info,
-						      const struct drm_display_mode *mode)
-{
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
-	unsigned long max_clock;
-
-	max_clock = (ctx->bus_width == 12) ? 74250 : 148500;
-
-	if (mode->clock > max_clock)
-		return MODE_CLOCK_HIGH;
-
-	if (mode->clock < 25000)
-		return MODE_CLOCK_LOW;
-
-	return MODE_OK;
-}
-
 static enum drm_connector_status
 it66121_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
@@ -872,6 +844,128 @@ static void it66121_bridge_hpd_disable(struct drm_bridge *bridge)
 		dev_err(ctx->dev, "failed to disable HPD IRQ\n");
 }
 
+static enum drm_mode_status
+it66121_bridge_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
+					 const struct drm_display_mode *mode,
+					 unsigned long long tmds_rate)
+{
+	const struct it66121_ctx *ctx =
+		container_of(bridge, const struct it66121_ctx, bridge);
+	unsigned long long max_rate;
+
+	max_rate = (ctx->bus_width == 12) ? 74250000ULL : 148500000ULL;
+
+	if (tmds_rate > max_rate)
+		return MODE_CLOCK_HIGH;
+
+	if (tmds_rate < HDMI_TMDS_CHAR_RATE_MIN_HZ)
+		return MODE_CLOCK_LOW;
+
+	return MODE_OK;
+}
+
+static int it66121_bridge_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+
+	/* Clear both IT66121_AVI_INFO_PKT_ON and IT66121_AVI_INFO_PKT_RPT */
+	return regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, 0);
+}
+
+static int it66121_bridge_hdmi_write_avi_infoframe(struct drm_bridge *bridge,
+						   const u8 *buffer, size_t len)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+
+	/* Write new AVI infoframe packet */
+	ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
+				&buffer[HDMI_INFOFRAME_HEADER_SIZE],
+				HDMI_AVI_INFOFRAME_SIZE);
+	if (ret)
+		goto unlock;
+
+	ret = regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buffer[3]);
+	if (ret)
+		goto unlock;
+
+	/* Enable AVI infoframe */
+	ret = regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
+			   IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT);
+
+unlock:
+	mutex_unlock(&ctx->lock);
+	return ret;
+}
+
+static int it66121_bridge_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+
+	/* Clear both IT66121_PKT_NULL_CTRL_ON and IT66121_PKT_NULL_CTRL_RPT */
+	return regmap_write(ctx->regmap, IT66121_PKT_NULL_CTRL_REG, 0);
+}
+
+static int it66121_bridge_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
+						    const u8 *buffer, size_t len)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+
+	/* Write new HDMI Vendor Specific Infoframe packet */
+	ret = regmap_bulk_write(ctx->regmap, IT66121_PKT_NULL_HB(0), buffer, len);
+	if (ret)
+		goto unlock;
+
+	/* Enable HDMI Vendor Specific Infoframe */
+	ret = regmap_write(ctx->regmap, IT66121_PKT_NULL_CTRL_REG,
+			   IT66121_PKT_NULL_CTRL_ON | IT66121_PKT_NULL_CTRL_RPT);
+
+unlock:
+	mutex_unlock(&ctx->lock);
+	return ret;
+}
+
+static int it66121_bridge_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+
+	/* Clear both IT66121_AUD_INFO_PKT_ON and IT66121_AUD_INFO_PKT_RPT */
+	return regmap_write(ctx->regmap, IT66121_AUD_INFO_PKT_REG, 0);
+}
+
+static int it66121_bridge_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
+						     const u8 *buffer, size_t len)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	int ret;
+
+	mutex_lock(&ctx->lock);
+
+	/* Write new Audio infoframe packet */
+	ret = regmap_bulk_write(ctx->regmap, IT66121_AUD_INFO_DB1_REG,
+				&buffer[HDMI_INFOFRAME_HEADER_SIZE],
+				min_t(size_t, len - HDMI_INFOFRAME_HEADER_SIZE, 5));
+	if (ret)
+		goto unlock;
+
+	ret = regmap_write(ctx->regmap, IT66121_AUD_INFO_CSUM_REG, buffer[3]);
+	if (ret)
+		goto unlock;
+
+	/* Enable Audio infoframe */
+	ret = regmap_write(ctx->regmap, IT66121_AUD_INFO_PKT_REG,
+			   IT66121_AUD_INFO_PKT_ON | IT66121_AUD_INFO_PKT_RPT);
+
+unlock:
+	mutex_unlock(&ctx->lock);
+	return ret;
+}
+
 static const struct drm_edid *it66121_bridge_edid_read(struct drm_bridge *bridge,
 						       struct drm_connector *connector)
 {
@@ -1359,6 +1453,10 @@ static int it66121_hdmi_audio_prepare(struct drm_bridge *bridge,
 out:
 	mutex_unlock(&ctx->lock);
 
+	if (!ret)
+		ret = drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector,
+									      &params->cea);
+
 	return ret;
 }
 
@@ -1384,6 +1482,8 @@ static void it66121_hdmi_audio_shutdown(struct drm_bridge *bridge,
 	int ret;
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
+	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
+
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, false);
 	if (ret)
@@ -1433,11 +1533,17 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_disable = it66121_bridge_disable,
 	.atomic_check = it66121_bridge_check,
 	.mode_set = it66121_bridge_mode_set,
-	.mode_valid = it66121_bridge_mode_valid,
 	.detect = it66121_bridge_detect,
 	.edid_read = it66121_bridge_edid_read,
 	.hpd_enable = it66121_bridge_hpd_enable,
 	.hpd_disable = it66121_bridge_hpd_disable,
+	.hdmi_tmds_char_rate_valid = it66121_bridge_hdmi_tmds_char_rate_valid,
+	.hdmi_clear_avi_infoframe = it66121_bridge_hdmi_clear_avi_infoframe,
+	.hdmi_write_avi_infoframe = it66121_bridge_hdmi_write_avi_infoframe,
+	.hdmi_clear_hdmi_infoframe = it66121_bridge_hdmi_clear_hdmi_infoframe,
+	.hdmi_write_hdmi_infoframe = it66121_bridge_hdmi_write_hdmi_infoframe,
+	.hdmi_clear_audio_infoframe = it66121_bridge_hdmi_clear_audio_infoframe,
+	.hdmi_write_audio_infoframe = it66121_bridge_hdmi_write_audio_infoframe,
 	.hdmi_audio_startup = it66121_hdmi_audio_startup,
 	.hdmi_audio_prepare = it66121_hdmi_audio_prepare,
 	.hdmi_audio_shutdown = it66121_hdmi_audio_shutdown,
@@ -1538,7 +1644,10 @@ static int it66121_probe(struct i2c_client *client)
 
 	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
-	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
+			  DRM_BRIDGE_OP_HDMI;
+	ctx->bridge.vendor = "ITE";
+	ctx->bridge.product = "IT66121";
 	if (client->irq > 0) {
 		ctx->bridge.ops |= DRM_BRIDGE_OP_HPD;
 

-- 
2.54.0

