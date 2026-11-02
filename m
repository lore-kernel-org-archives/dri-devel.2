Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FC606E01C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/b4hTLF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C49710F0E3;
	Mon,  2 Nov 2026 16:50:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081C610F0CC;
 Mon,  2 Nov 2026 16:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E50E444608;
 Mon,  2 Nov 2026 16:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AA01F01578;
 Mon,  2 Nov 2026 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638193;
 bh=FPR/Ghg+mbQA5dNcfU/XXlDPhtrJNvT0MIlhCyTMhWk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=M/b4hTLFil05zxZXdOQx4SZVEtBCUUX/YbygJuYYsEIhfhGpWK2FjXjsninOhk8f6
 JWZDSKvGwbSER1yxUSbOXHu/UE/2u5L35/9FzLBPA0wuH/vKq0MWtJ5W4VUIXSA36J
 YN9g+VHeLOrB0A6DKZnMokcnGC0p2PsVle5cMACRIUJwwqLT/3xT5rSCLruxn4JK/e
 jhQCjbDZLbUiAbJht0vfchL98mPc7CRTyW4pbmLojAQk+aytXX86Pw6P4/ugETGCKu
 EsKllmGTVplhtfnLVMCnmZHvqhP03dWcq4I6Pt8hEq912alMJBkwFaOjUJAJjxrWRB
 /y8zi8X2qGGDg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:29 -0600
Subject: [PATCH v10 13/15] drm/gma500: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-13-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
In-Reply-To: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mario Limonciello <mario.limonciello@amd.com>

Expose GMA500 panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. Route updates through the existing platform
backlight operations and preserve legacy registration otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/gma500/Kconfig          |  2 +-
 drivers/gpu/drm/gma500/backlight.c      | 45 +++++++++++++++++++++------------
 drivers/gpu/drm/gma500/cdv_intel_lvds.c |  2 ++
 drivers/gpu/drm/gma500/psb_drv.c        |  2 +-
 drivers/gpu/drm/gma500/psb_drv.h        |  4 ++-
 drivers/gpu/drm/gma500/psb_intel_lvds.c |  3 ++-
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index dc4c566388192..08871a8f6fa22 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -9,7 +9,7 @@ config DRM_GMA500
 	select I2C_ALGOBIT
 	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
 	select ACPI_VIDEO if ACPI
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
 	select INPUT if ACPI
 	select ACPI_WMI if ACPI
 	help
diff --git a/drivers/gpu/drm/gma500/backlight.c b/drivers/gpu/drm/gma500/backlight.c
index c8f1716a12d52..4bb39fba04539 100644
--- a/drivers/gpu/drm/gma500/backlight.c
+++ b/drivers/gpu/drm/gma500/backlight.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/backlight.h>
-
 #include <acpi/video.h>
 
 #include <drm/drm_print.h>
@@ -73,10 +72,9 @@ static const struct backlight_ops gma_backlight_ops __maybe_unused = {
 	.update_status  = gma_backlight_update_status,
 };
 
-int gma_backlight_init(struct drm_device *dev)
+int gma_backlight_init(struct drm_device *dev, struct drm_connector *connector)
 {
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
-	struct backlight_properties props __maybe_unused = {};
 	int ret;
 
 	dev_priv->backlight_enabled = true;
@@ -92,28 +90,43 @@ int gma_backlight_init(struct drm_device *dev)
 		return 0;
 	}
 
-#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
-	props.brightness = dev_priv->backlight_level;
-	props.max_brightness = PSB_MAX_BRIGHTNESS;
-	props.type = BACKLIGHT_RAW;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		return drm_connector_attach_luminance_property(connector, 0,
+							 PSB_MAX_BRIGHTNESS,
+							 dev_priv->backlight_level);
+
+	{
+		struct backlight_properties props = {};
 
-	dev_priv->backlight_device =
-		backlight_device_register(dev_priv->ops->backlight_name,
-					  dev->dev, dev,
-					  &gma_backlight_ops, &props);
-	if (IS_ERR(dev_priv->backlight_device))
-		return PTR_ERR(dev_priv->backlight_device);
-#endif
+		props.brightness = dev_priv->backlight_level;
+		props.max_brightness = PSB_MAX_BRIGHTNESS;
+		props.type = BACKLIGHT_RAW;
+
+		dev_priv->backlight_device =
+			backlight_device_register(dev_priv->ops->backlight_name,
+						  dev->dev, dev,
+						  &gma_backlight_ops, &props);
+		if (IS_ERR(dev_priv->backlight_device))
+			return PTR_ERR(dev_priv->backlight_device);
+	}
 
 	return 0;
 }
 
+void gma_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	gma_backlight_set(conn_state->connector->dev, conn_state->luminance);
+}
+
+void gma_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	gma_backlight_disable(conn_state->connector->dev);
+}
+
 void gma_backlight_exit(struct drm_device *dev)
 {
-#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
 
 	if (dev_priv->backlight_device)
 		backlight_device_unregister(dev_priv->backlight_device);
-#endif
 }
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 336ab411d6995..cef97f1532358 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -412,6 +412,8 @@ static const struct drm_connector_helper_funcs
 	.get_modes = cdv_intel_lvds_get_modes,
 	.mode_valid = cdv_intel_lvds_mode_valid,
 	.best_encoder = gma_best_encoder,
+	.set_luminance = gma_connector_set_luminance,
+	.disable_luminance = gma_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs cdv_intel_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index d17cb5b4a4bf2..5de7af651ac39 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -396,7 +396,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 
 		if (gma_encoder->type == INTEL_OUTPUT_LVDS ||
 		    gma_encoder->type == INTEL_OUTPUT_MIPI) {
-			ret = gma_backlight_init(dev);
+			ret = gma_backlight_init(dev, connector);
 			if (ret == 0)
 				acpi_video_register_backlight();
 			break;
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index db197b865b90a..4fc22c66e6c8f 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -604,11 +604,13 @@ int psb_fbdev_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 #endif
 
 /* backlight.c */
-int gma_backlight_init(struct drm_device *dev);
+int gma_backlight_init(struct drm_device *dev, struct drm_connector *connector);
 void gma_backlight_exit(struct drm_device *dev);
 void gma_backlight_disable(struct drm_device *dev);
 void gma_backlight_enable(struct drm_device *dev);
 void gma_backlight_set(struct drm_device *dev, int v);
+void gma_connector_set_luminance(const struct drm_connector_state *conn_state);
+void gma_connector_disable_luminance(const struct drm_connector_state *conn_state);
 
 /* oaktrail_crtc.c */
 extern const struct drm_crtc_helper_funcs oaktrail_helper_funcs;
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index cd882786d9461..fa0bc8492ff7f 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -610,6 +610,8 @@ const struct drm_connector_helper_funcs
 	.get_modes = psb_intel_lvds_get_modes,
 	.mode_valid = psb_intel_lvds_mode_valid,
 	.best_encoder = gma_best_encoder,
+	.set_luminance = gma_connector_set_luminance,
+	.disable_luminance = gma_connector_disable_luminance,
 };
 
 const struct drm_connector_funcs psb_intel_lvds_connector_funcs = {
@@ -808,4 +810,3 @@ void psb_intel_lvds_init(struct drm_device *dev,
 err_free_encoder:
 	kfree(gma_encoder);
 }
-

-- 
2.53.0

