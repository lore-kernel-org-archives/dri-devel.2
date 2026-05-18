Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36DDCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BF810E956;
	Mon, 18 May 2026 17:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mCLv/GGp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E0010E956
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779126912;
 bh=/1ILoxpmqZWfAumf47v8TGHhvAX8kM6JHCgLHG3kEHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mCLv/GGpSZ22RKNf9pftuH/DsK49k2rkxzyq60wyL91LxfYmhCV9xu93YIZrjtuia
 01pkBW5GA3Br666jMtgf1VI6eHgfIM7tMvi0LCdMNmh9yYQgbPBtlQTazSTfTDOolM
 RZ+O4JPxaYgpakfW5lXbUKrRX014aT25MQS6vXq0zknT1mXffWapgyhcoeGpc4pGff
 VDMLP+u6XOK1ew7qtBghkbjTPVnOKb2/Rwk3NfLz2CLFUag2lb6uQlkhlR0A5zXEbr
 QKKhDiFjHzuK2Mp87ZZLis9LKCh4jFr/1f4nrNix4DbrPOzOQSrvwKOAyF+I4YBQvA
 zPQ1yvQMrwmAQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A2A1F17E0246;
 Mon, 18 May 2026 19:55:08 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm: ensure blend mode supported if alpha exposed
Date: Mon, 18 May 2026 14:54:29 -0300
Message-ID: <20260518175429.80615-3-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
References: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
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

Before "drm/drm_blend: allow blend mode property without PREMULTI",
userspace would have to assume that only PREMULTI was supported by
drivers that didn't expose the blend mode property. But now userspace
shouldn't relly on that, as they can't count with drivers always
supporting PREMULTI.

Error out if a driver expose alpha property or pixel formats with alpha
and does not expose the blend mode property. This way userspace don't
have to guess. Drivers that hit such error must be fixed.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/drm_crtc_internal.h |  2 +-
 drivers/gpu/drm/drm_drv.c           |  7 ++++--
 drivers/gpu/drm/drm_mode_config.c   | 37 +++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index c09409229644..2a4862202496 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -95,7 +95,7 @@ int drm_mode_setcrtc(struct drm_device *dev,
 /* drm_mode_config.c */
 int drm_modeset_register_all(struct drm_device *dev);
 void drm_modeset_unregister_all(struct drm_device *dev);
-void drm_mode_config_validate(struct drm_device *dev);
+int drm_mode_config_validate(struct drm_device *dev);
 
 /* drm_modes.c */
 const char *drm_get_mode_status_name(enum drm_mode_status status);
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 985c283cf59f..def78046a963 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1059,8 +1059,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	const struct drm_driver *driver = dev->driver;
 	int ret;
 
-	if (!driver->load)
-		drm_mode_config_validate(dev);
+	if (!driver->load) {
+		ret = drm_mode_config_validate(dev);
+		if (ret)
+			return ret;
+	}
 
 	WARN_ON(!dev->managed.final_kfree);
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 66f7dc37b597..18c6b5707532 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -674,16 +674,45 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
 	     encoder->possible_crtcs, crtc_mask);
 }
 
-void drm_mode_config_validate(struct drm_device *dev)
+static int plane_alpha_require_blend_mode(struct drm_plane *plane)
+{
+	struct drm_device *dev = plane->dev;
+	const struct drm_format_info *fmt;
+	u32 i;
+
+	/* blend mode property supported, no need to check anything */
+	if (plane->blend_mode_property)
+		return 0;
+
+	if (plane->alpha_property) {
+		drm_err(dev, "[PLANE:%d:%s] alpha property exposed but blend mode not setup",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < plane->format_count; i++) {
+		fmt = drm_format_info(plane->format_types[i]);
+		if (fmt->has_alpha) {
+			drm_err(dev, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
+				plane->base.id, plane->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int drm_mode_config_validate(struct drm_device *dev)
 {
 	struct drm_encoder *encoder;
 	struct drm_crtc *crtc;
 	struct drm_plane *plane;
 	u32 primary_with_crtc = 0, cursor_with_crtc = 0;
 	unsigned int num_primary = 0;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
-		return;
+		return ret;
 
 	drm_for_each_encoder(encoder, dev)
 		fixup_encoder_possible_clones(encoder);
@@ -732,9 +761,13 @@ void drm_mode_config_validate(struct drm_device *dev)
 	drm_for_each_plane(plane, dev) {
 		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
 			num_primary++;
+
+		ret |= plane_alpha_require_blend_mode(plane);
 	}
 
 	WARN(num_primary != dev->mode_config.num_crtc,
 	     "Must have as many primary planes as there are CRTCs, but have %u primary planes and %u CRTCs",
 	     num_primary, dev->mode_config.num_crtc);
+
+	return ret;
 }
-- 
2.54.0

