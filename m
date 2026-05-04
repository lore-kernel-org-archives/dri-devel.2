Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E6CFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE1A10E711;
	Mon,  4 May 2026 14:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Lmm3f1Uo";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BA810E711
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777903611;
 bh=jh3Sp6NASVasU8uZv6Mlg4VSABR1Bmq0uDojLqTI0II=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lmm3f1UoYD6d10fcWnfZDk04TI8qiQ1ZqcrVEzVavu6wyi768znCJAusHlYksUGvk
 FxUlxsu4D+44ugBrcKFzvE4SdAt+CQ9OYkEbH3nppEATMDIstPxzr6UdtOwHiq53pK
 ixvbWum+O29RzBXIpN2KQwv0YzNMEL0n0d1oO3V48ivHkZSHCC0juiPi6bdjJpXP1O
 4UUvUPK+5TLIsDvCJy7Ga+QcVoZJT0H5c6Bpdy33QHFj8PI0hOynQk33j/74RqK03H
 PJqknnzfZEjc3bp7OnlZGi8TL+P7sljuMHTYXtTlgVwT15mKAY3gt29MTlBvN0N+dj
 JvPBXCflFb0xQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C15617E131B;
 Mon,  4 May 2026 16:06:47 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm: ensure blend mode supported if alpha exposed
Date: Mon,  4 May 2026 11:06:30 -0300
Message-ID: <20260504140630.68707-3-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504140630.68707-1-leandro.ribeiro@collabora.com>
References: <20260504140630.68707-1-leandro.ribeiro@collabora.com>
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
 drivers/gpu/drm/drm_crtc_internal.h |  1 +
 drivers/gpu/drm/drm_drv.c           |  7 ++++-
 drivers/gpu/drm/drm_mode_config.c   | 42 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index c09409229644..bdbb6b9b94ea 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -96,6 +96,7 @@ int drm_mode_setcrtc(struct drm_device *dev,
 int drm_modeset_register_all(struct drm_device *dev);
 void drm_modeset_unregister_all(struct drm_device *dev);
 void drm_mode_config_validate(struct drm_device *dev);
+int drm_mode_config_enforce(struct drm_device *dev);
 
 /* drm_modes.c */
 const char *drm_get_mode_status_name(enum drm_mode_status status);
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 985c283cf59f..76766a370650 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1059,9 +1059,14 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	const struct drm_driver *driver = dev->driver;
 	int ret;
 
-	if (!driver->load)
+	if (!driver->load) {
 		drm_mode_config_validate(dev);
 
+		ret = drm_mode_config_enforce(dev);
+		if (ret)
+			return ret;
+	}
+
 	WARN_ON(!dev->managed.final_kfree);
 
 	if (drm_dev_needs_global_mutex(dev))
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 66f7dc37b597..20fd26ecb957 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -738,3 +738,45 @@ void drm_mode_config_validate(struct drm_device *dev)
 	     "Must have as many primary planes as there are CRTCs, but have %u primary planes and %u CRTCs",
 	     num_primary, dev->mode_config.num_crtc);
 }
+
+static int plane_require_blend_mode_for_alpha(struct drm_plane *plane)
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
+			        plane->base.id, plane->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int drm_mode_config_enforce(struct drm_device *dev)
+{
+	struct drm_plane *plane;
+	int ret;
+
+	drm_for_each_plane(plane, dev) {
+		ret = plane_require_blend_mode_for_alpha(plane);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
-- 
2.54.0

