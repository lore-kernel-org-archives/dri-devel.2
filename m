Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADEAFA1FD8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292AF10EED3;
	Wed, 22 Apr 2026 16:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QE7CCEnn";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A831910EECA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:49:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 915C34E42AC3;
 Wed, 22 Apr 2026 16:49:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 640165FA8F;
 Wed, 22 Apr 2026 16:49:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D10E410460C0F; 
 Wed, 22 Apr 2026 18:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IpzMECLKTSe/War2MJcO3x6aVJ8DOQxC0k5xyZktq0Q=;
 b=QE7CCEnnDaigTi9K92Z86FxxOk+Rn3cFn0kj3arAGASUXrgQeTh6hMkCogDpt2sQKFliwy
 RIZivjpyIJv2kcWDLgrMIKgRcAiDTD3aOcsoZnJQ+xq5d5Ll0P6L8hTCbAG43Zm0QklhZE
 7m516Aab+qYofhSgSNhioLyQromG9fXIdvFSqwbTcSeIdLTQVEuR4BjmDAtL6S2IFY//Mx
 X4TJuj37bOiHIcDSNe8GWMt5tqXDrYYJPIvV+Upd1cY1nwajkOJDIfeh6cIiv9kZi9Rowd
 fo9XrplCTjfU4TXf6rxUIQgX5rKL9TNXdUTJtOdt7JVJHEPpTVr+KAp3VPz/Jw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:21 +0200
Subject: [PATCH v4 24/37] drm/vkms: Introduce config for plane zpos
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-24-dbb52e9aadc3@bootlin.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
In-Reply-To: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.16-dev
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

VKMS can render plane in any order. Introduce the appropriate
configuration.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  89 ++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            |  56 ++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 143 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             |  11 ++
 4 files changed, 299 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index a88d8b4a969e..4a5899b8ccfd 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -201,6 +201,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_plane_get_default_color_encoding(plane_cfg),
 				DRM_COLOR_YCBCR_BT601);
+		KUNIT_EXPECT_EQ(test, vkms_config_plane_get_zpos_enabled(plane_cfg), false);
+		// No need to test the other zpos configurations as they are discarded if
+		// the zpos property is not created.
 	}
 
 	/* Encoders */
@@ -619,6 +622,91 @@ static void vkms_config_test_valid_plane_color_range(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_zpos(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, zpos disabled */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos disabled, min/max are ignored */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 8);
+	vkms_config_plane_set_zpos_min(plane_cfg, 3);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled but mutable disabled */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 1);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled but mutable disabled */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, zpos enabled with min > max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 1);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled with min <= max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 1);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, zpos enabled with initial < min */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 1);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, zpos enabled with initial > max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 3);
+	vkms_config_plane_set_zpos_min(plane_cfg, 1);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled with initial between min and max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 1);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -1144,6 +1232,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_range),
+	KUNIT_CASE(vkms_config_test_valid_plane_zpos),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 1b51545385dd..c2b0c99b620f 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -91,6 +91,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	if (IS_ERR(plane_cfg))
 		goto err_alloc;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 	crtc_cfg = vkms_config_create_crtc(config);
 	if (IS_ERR(crtc_cfg))
@@ -110,6 +111,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 			vkms_config_plane_set_type(plane_cfg,
 						   DRM_PLANE_TYPE_OVERLAY);
 			vkms_config_plane_set_default_pipeline(plane_cfg, enable_plane_pipeline);
+			vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 			if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
 				goto err_alloc;
@@ -123,6 +125,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 
 		vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
 		vkms_config_plane_set_default_pipeline(plane_cfg, enable_plane_pipeline);
+		vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 		if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
 			goto err_alloc;
@@ -253,6 +256,33 @@ bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_range);
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_zpos(const struct vkms_config *config,
+				  const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if (!vkms_config_plane_get_zpos_enabled(plane_cfg) ||
+	    !vkms_config_plane_get_zpos_mutable(plane_cfg))
+		return true;
+
+	if (vkms_config_plane_get_zpos_initial(plane_cfg) >
+	    vkms_config_plane_get_zpos_max(plane_cfg)) {
+		drm_info(dev, "Configured initial zpos value bigger than zpos max\n");
+		return false;
+	}
+
+	if (vkms_config_plane_get_zpos_max(plane_cfg) <
+	    vkms_config_plane_get_zpos_min(plane_cfg) ||
+	    vkms_config_plane_get_zpos_initial(plane_cfg) <
+	    vkms_config_plane_get_zpos_min(plane_cfg)) {
+		drm_info(dev, "Configured zpos value outside (zpos min; zpos max)\n");
+		return false;
+	}
+
+	return true;
+}
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -413,6 +443,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_plane *plane_cfg;
 
+	bool has_zpos_enabled = false;
+	bool has_zpos_disabled = false;
+
 	vkms_config_for_each_plane(config, plane_cfg) {
 		if (!vkms_config_valid_plane_rotation(config, plane_cfg))
 			return false;
@@ -429,6 +462,19 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 				 "Both supported color encodings and color ranges must be set, or none\n");
 			return false;
 		}
+
+		if (!vkms_config_valid_plane_zpos(config, plane_cfg))
+			return false;
+
+		if (vkms_config_plane_get_zpos_enabled(plane_cfg))
+			has_zpos_enabled = true;
+		else
+			has_zpos_disabled = true;
+	}
+
+	if (has_zpos_enabled && has_zpos_disabled) {
+		drm_info(dev, "In the same device, all planes must have zpos enabled or none of them");
+		return false;
 	}
 
 	if (!valid_plane_number(config))
@@ -531,6 +577,16 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		show_formats(m, vkms_config_plane_get_supported_formats(plane_cfg),
 			     vkms_config_plane_get_supported_formats_count(plane_cfg));
 		seq_puts(m, "\n");
+		seq_printf(m, "\tzpos_enabled=%s\n",
+			   str_true_false(vkms_config_plane_get_zpos_enabled(plane_cfg)));
+		seq_printf(m, "\tzpos_mutable=%s\n",
+			   str_true_false(vkms_config_plane_get_zpos_mutable(plane_cfg)));
+		seq_printf(m, "\tzpos_min=%d\n",
+			   vkms_config_plane_get_zpos_min(plane_cfg));
+		seq_printf(m, "\tzpos_initial=%d\n",
+			   vkms_config_plane_get_zpos_initial(plane_cfg));
+		seq_printf(m, "\tzpos_max=%d\n",
+			   vkms_config_plane_get_zpos_max(plane_cfg));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index ea09768a678e..df2ec432a1af 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -51,6 +51,11 @@ struct vkms_config {
  * @supported_color_ranges: Color ranges that this plane will support
  * @supported_formats: List of supported formats
  * @supported_formats_count: Length of @supported_formats
+ * @zpos_enabled: Enable or disable the zpos property
+ * @zpos_mutable: Make the zpos property mutable or not (ignored if @zpos_enabled is false)
+ * @zpos_initial: Initial value for zpos property (ignored if @zpos_enabled is false)
+ * @zpos_min: Minimal value for zpos property (ignored if @zpos_enabled is false)
+ * @zpos_max: Maximal value for zpos property (ignored if @zpos_enabled is false)
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -68,6 +73,11 @@ struct vkms_config_plane {
 	unsigned int supported_formats_count;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
+	bool zpos_enabled;
+	bool zpos_mutable;
+	unsigned int zpos_initial;
+	unsigned int zpos_min;
+	unsigned int zpos_max;
 
 	/* Internal usage */
 	struct vkms_plane *plane;
@@ -556,6 +566,139 @@ vkms_config_plane_get_name(const struct vkms_config_plane *plane_cfg)
 	return plane_cfg->name;
 }
 
+/**
+ * vkms_config_plane_set_zpos_enabled() - Enable or disable zpos property for a plane
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_enabled: Whether to enable the zpos property
+ */
+static inline
+void vkms_config_plane_set_zpos_enabled(struct vkms_config_plane *plane_cfg,
+					bool zpos_enabled)
+{
+	plane_cfg->zpos_enabled = zpos_enabled;
+}
+
+/**
+ * vkms_config_plane_set_zpos_mutable() - Set whether zpos property is mutable
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_mutable: Whether the zpos property should be mutable
+ */
+static inline
+void vkms_config_plane_set_zpos_mutable(struct vkms_config_plane *plane_cfg,
+					bool zpos_mutable)
+{
+	plane_cfg->zpos_mutable = zpos_mutable;
+}
+
+/**
+ * vkms_config_plane_set_zpos_initial() - Set the initial zpos value
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_initial: Initial zpos value
+ */
+static inline
+void vkms_config_plane_set_zpos_initial(struct vkms_config_plane *plane_cfg,
+					unsigned int zpos_initial)
+{
+	plane_cfg->zpos_initial = zpos_initial;
+}
+
+/**
+ * vkms_config_plane_set_zpos_min() - Set the minimum zpos value
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_min: Minimum zpos value
+ */
+static inline
+void vkms_config_plane_set_zpos_min(struct vkms_config_plane *plane_cfg,
+				    unsigned int zpos_min)
+{
+	plane_cfg->zpos_min = zpos_min;
+}
+
+/**
+ * vkms_config_plane_set_zpos_max() - Set the maximum zpos value
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_max: Maximum zpos value
+ */
+static inline
+void vkms_config_plane_set_zpos_max(struct vkms_config_plane *plane_cfg,
+				    unsigned int zpos_max)
+{
+	plane_cfg->zpos_max = zpos_max;
+}
+
+/**
+ * vkms_config_plane_get_zpos_enabled() - Check if zpos property is enabled
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * True if the zpos property is enabled for this plane, false otherwise.
+ */
+static inline
+bool vkms_config_plane_get_zpos_enabled(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_enabled;
+}
+
+/**
+ * vkms_config_plane_get_zpos_mutable() - Check if zpos property is mutable
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * True if the zpos property is mutable for this plane, false otherwise.
+ */
+static inline
+bool vkms_config_plane_get_zpos_mutable(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_mutable;
+}
+
+/**
+ * vkms_config_plane_get_zpos_initial() - Get the initial zpos value
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * The initial zpos value for this plane. The return value is undefined if
+ * zpos is disabled.
+ */
+static inline
+unsigned int vkms_config_plane_get_zpos_initial(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_initial;
+}
+
+/**
+ * vkms_config_plane_get_zpos_min() - Get the minimum zpos value
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * The minimum allowed zpos value for this plane. The return value is undefined
+ * if zpos is disabled.
+ */
+static inline
+unsigned int vkms_config_plane_get_zpos_min(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_min;
+}
+
+/**
+ * vkms_config_plane_get_zpos_max() - Get the maximum zpos value
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * The maximum allowed zpos value for this plane. The return value is undefined
+ * if zpos is disabled.
+ */
+static inline
+unsigned int vkms_config_plane_get_zpos_max(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_max;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_zpos(const struct vkms_config *config,
+				  const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
  * @plane_cfg: Plane to attach
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index d8fcf928d8ec..43f38d2d2fdc 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -214,6 +214,17 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	if (vkms_config_plane_get_default_pipeline(plane_cfg))
 		vkms_initialize_colorops(&plane->base);
+	if (vkms_config_plane_get_zpos_enabled(plane_cfg)) {
+		if (vkms_config_plane_get_zpos_mutable(plane_cfg)) {
+			drm_plane_create_zpos_property(&plane->base,
+						       vkms_config_plane_get_zpos_initial(plane_cfg),
+						       vkms_config_plane_get_zpos_min(plane_cfg),
+						       vkms_config_plane_get_zpos_max(plane_cfg));
+		} else {
+			drm_plane_create_zpos_immutable_property(&plane->base,
+								 vkms_config_plane_get_zpos_initial(plane_cfg));
+		}
+	}
 
 	return plane;
 }

-- 
2.54.0

