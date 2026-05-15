Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4481CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F312910F498;
	Fri, 15 May 2026 09:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IoWT9zok";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA91010F498
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778835807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cU8nfuQshDfTgMYlYFriNnuspV8nePWV/d7r2OJywA8=;
 b=IoWT9zokeni2PxdinLNw/53tHOovzLD/mWaL+XqjpWNJVWkKEJ+HaVlAgf5ATU3p8TsvWZ
 tutaXiEpIpmsMUkw5woJQ2Xavv49VBAd3kEZ3EXyYNTOauOQCUaIF11XaP090YZRKcu71V
 tutCwd1BA1x1+O2Z1tPylMGLVVc8oy4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-d5NqkcMHMf-6vFaPULMtbw-1; Fri, 15 May 2026 05:03:25 -0400
X-MC-Unique: d5NqkcMHMf-6vFaPULMtbw-1
X-Mimecast-MFC-AGG-ID: d5NqkcMHMf-6vFaPULMtbw_1778835804
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bceb2b8bc2bso451400166b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778835804; x=1779440604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cU8nfuQshDfTgMYlYFriNnuspV8nePWV/d7r2OJywA8=;
 b=gx17KgCmTU6ffoDi2aapao2nTxb6UrNI/oMhf4ILyNdExbijYkRoL8tGuiTbJUglsg
 6jk/t/MRZCo7HDLEgJfB0hK4n5hPnJms6EF/8j2YOJ/l0ttsd6kUCNbfYIrIeVdnbjiB
 ETWXFWJt/9emd+EbiEezsnBRdgV+zMsaQ9v7XL05EmF+kUGL8BiZZRWWfLfVZ51CutWK
 07C6/3wJDU7HhS712Bh7zNWpuDkL6IDFbrG0GnK70sJMUqtj5x/KNB021Phzv/MRvPl7
 vYvMa9tmGLloQaReP1/KYC8OZq7r48zKGonVgHLC4MiKdyoMl4QLygwdO46z753whpVG
 EsKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WPfz3JFtBSncXv9TmY7woTukTxDdO1eyHs+BnKfTXqMsZ9AKfPeh0lKHm0jOiEFfqi44gfUe5+5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcKY/XAURVhPjIPm2URqhD2Yy1MxeCFesOWHDwxuswS8Usb6gO
 ABXqPezR1Ogg+001UI0HmTq6mzSmNQs2RHMRB51Nhe1h7BVy5b3YFhbnrfGsvguIYb55NxU7NCf
 B5nEZWrzm+LHXLvUQVHY9hAeoZRFIACW1fGfgkl3u6dma9IYeuZHuIkoFhp85XWOhTb3+dw==
X-Gm-Gg: Acq92OF5iYh2NtqmO/0a7NSBwackOCg3ywsqY3HxdE50k8SPCT9U3lX3uAIc06p45cY
 TY9SQPRPWvkv//qCZwloyvVXXlcsmRhZFN886nFVOKCJJsiMI6nGcm8qR+EUOXzSQDbOzUABQn1
 dtIBG+uG8Z+iYdSrckdrJ2t4wZBrKi2o0uen833E3a2AGFUYBgQX/hcnwqse3H9XKwctbj2OIJu
 /gOFFzmFBIhfLvhudq3Nx6msW0vyEuGvX6hGdM/OZuXEF3KDJ/f1ayHyuMoINw3fIz0ySZFogun
 Ef2r5V6YfisrmqxhsLYI9+3cHL+fEdKldzRN+rU3xjK5eGHaHoq7HaAY0W7g0Hb8X4gWDFphgNs
 EAxit8SktOP55yD6bzWdRIILVSEEuyRGcSaqNkuKc9M97sdk=
X-Received: by 2002:a17:907:785:b0:bd4:f2c9:d094 with SMTP id
 a640c23a62f3a-bd5177a849dmr167237166b.3.1778835803746; 
 Fri, 15 May 2026 02:03:23 -0700 (PDT)
X-Received: by 2002:a17:907:785:b0:bd4:f2c9:d094 with SMTP id
 a640c23a62f3a-bd5177a849dmr167230166b.3.1778835803009; 
 Fri, 15 May 2026 02:03:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm13176383f8f.8.2026.05.15.02.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:03:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 1/3] drm/bridge: ite-it66121: Switch to the HDMI connector
 helpers
Date: Fri, 15 May 2026 11:02:09 +0200
Message-ID: <20260515090220.809830-2-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515090220.809830-1-javierm@redhat.com>
References: <20260515090220.809830-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VK2mPuUxXJj_AMLOogwd1IUX-RPYvYeWShEg7GGZW44_1778835804
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Instead of open coding the HDMI AVI Infoframes buffer management,
use the helpers provided by the HDMI connector framework.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v4:
- New patch for v4

 drivers/gpu/drm/bridge/Kconfig       |   2 +
 drivers/gpu/drm/bridge/ite-it66121.c | 132 ++++++++++++++++-----------
 2 files changed, 83 insertions(+), 51 deletions(-)

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
index 19a027d75b61..947b7a0f0a45 100644
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
@@ -304,7 +306,6 @@ struct it66121_ctx {
 	struct i2c_client *client;
 	u32 bus_width;
 	struct mutex lock; /* Protects fields below and device registers */
-	struct hdmi_avi_infoframe hdmi_avi_infoframe;
 	struct {
 		struct platform_device *pdev;
 		u8 ch_enable;
@@ -727,6 +728,10 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
 	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (!ctx->connector)
+		return;
+
+	drm_atomic_helper_connector_hdmi_update_infoframes(ctx->connector, state);
 
 	it66121_set_mute(ctx, false);
 }
@@ -764,40 +769,10 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
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
@@ -825,24 +800,6 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
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
@@ -873,6 +830,72 @@ static void it66121_bridge_hpd_disable(struct drm_bridge *bridge)
 		dev_err(ctx->dev, "failed to disable HPD IRQ\n");
 }
 
+static enum drm_mode_status
+it66121_bridge_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
+					 const struct drm_display_mode *mode,
+					 unsigned long long tmds_rate)
+{
+	const struct it66121_ctx *ctx =
+		container_of(bridge, const struct it66121_ctx, bridge);
+	unsigned long max_clock;
+
+	max_clock = (ctx->bus_width == 12) ? 74250 : 148500;
+
+	if (mode->clock > max_clock)
+		return MODE_CLOCK_HIGH;
+
+	if (mode->clock < 25000)
+		return MODE_CLOCK_LOW;
+
+	return MODE_OK;
+}
+
+static int it66121_bridge_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
+{
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+
+	return regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, 0);
+}
+
+static int it66121_bridge_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
+{
+	return 0;
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
+static int it66121_bridge_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
+						    const u8 *buffer, size_t len)
+{
+	return 0;
+}
+
 static const struct drm_edid *it66121_bridge_edid_read(struct drm_bridge *bridge,
 						       struct drm_connector *connector)
 {
@@ -913,11 +936,15 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
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
 };
 
 static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
@@ -1588,7 +1615,10 @@ static int it66121_probe(struct i2c_client *client)
 
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

