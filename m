Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49264FA1FD5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A039E10EEC0;
	Wed, 22 Apr 2026 16:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="s0s9jpd8";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C1E10EEC0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:49:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E89804E42AC2;
 Wed, 22 Apr 2026 16:49:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BEB2B5FA8F;
 Wed, 22 Apr 2026 16:49:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F4CB10460BF3; 
 Wed, 22 Apr 2026 18:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0eeE3mrCELEPWPnEZgzlOpxoBzd9CK60QrFHjdzxlv8=;
 b=s0s9jpd8EvgeR7YFra2hSCOP2OEE5VwEyMuwNuQC4CyvXP/7gWL7HxCIyAjCiMj2HdgQv7
 DBJdo0F7QR+pxbtfPcrfQ1KjFlvI36DekdrAvTQZ7nqB5EzacZuxYFhrnEZ0XzwDO6s2C/
 pmQapl/Fl6ASQ2gC0KupmY5mVOIz7fzC1D3VNrGd3pTCb6bqclyIT2sM73dvLgF//l+b+P
 C4ZfQ8Rn8iuROarLqcdZv7HC9Ljm9X6JMQlRZAl4rhErHX1t3DWTFVV1pw96TknhjMX3Ut
 S6O965QMkCPdkqafLaDK7Th5aMTtIZZiT8JCeMAsBZag5R591E01BjDe5Bpb5Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:14 +0200
Subject: [PATCH v4 17/37] drm/vkms: Introduce config for plane color encoding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-17-dbb52e9aadc3@bootlin.com>
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
 llvm@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>
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

VKMS driver supports all the color encoding on planes, but for testing it
can be useful to only advertise few of them. This new configuration
interface will allow configuring the color encoding per planes.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 51 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 32 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 64 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             | 15 +++----
 4 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index c33fe737678f..a2a3f1a106a3 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -192,6 +192,14 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_plane_get_default_rotation(plane_cfg),
 				DRM_MODE_ROTATE_0);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_plane_get_supported_color_encodings(plane_cfg),
+				BIT(DRM_COLOR_YCBCR_BT601) |
+				BIT(DRM_COLOR_YCBCR_BT709) |
+				BIT(DRM_COLOR_YCBCR_BT2020));
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_plane_get_default_color_encoding(plane_cfg),
+				DRM_COLOR_YCBCR_BT601);
 	}
 
 	/* Encoders */
@@ -526,6 +534,48 @@ static void vkms_config_test_valid_plane_rotations(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_color_encoding(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, all color encoding supported */
+	vkms_config_plane_set_supported_color_encodings(plane_cfg,
+							BIT(DRM_COLOR_YCBCR_BT601) |
+							BIT(DRM_COLOR_YCBCR_BT709) |
+							BIT(DRM_COLOR_YCBCR_BT2020));
+	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_encoding(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default color encoding is not supported */
+	vkms_config_plane_set_supported_color_encodings(plane_cfg,
+							BIT(DRM_COLOR_YCBCR_BT601) |
+							BIT(DRM_COLOR_YCBCR_BT2020));
+	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT709);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_color_encoding(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, no supported or color encoding */
+	vkms_config_plane_set_supported_color_encodings(plane_cfg, 0);
+	vkms_config_plane_set_default_color_encoding(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_encoding(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, if no supported color encoding, default is ignored */
+	vkms_config_plane_set_supported_color_encodings(plane_cfg, 0);
+	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_encoding(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -1049,6 +1099,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_invalid_plane_number),
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
+	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 7ae382bdee9d..9faf03c60b8b 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -179,6 +179,25 @@ bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_rotation);
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_color_encoding(const struct vkms_config *config,
+					    const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if (vkms_config_plane_get_supported_color_encodings(plane_cfg)) {
+		if ((BIT(vkms_config_plane_get_default_color_encoding(plane_cfg)) &
+		     vkms_config_plane_get_supported_color_encodings(plane_cfg)) !=
+		    BIT(vkms_config_plane_get_default_color_encoding(plane_cfg))) {
+			drm_info(dev, "Configured default color encoding is not supported by the plane\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_encoding);
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -341,6 +360,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	vkms_config_for_each_plane(config, plane_cfg) {
 		if (!vkms_config_valid_plane_rotation(config, plane_cfg))
 			return false;
+
+		if (!vkms_config_valid_plane_color_encoding(config, plane_cfg))
+			return false;
 	}
 
 	if (!valid_plane_number(config))
@@ -418,6 +440,12 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		show_bitfield(m, vkms_config_plane_get_default_rotation(plane_cfg),
 			      drm_get_rotation_name);
 		seq_puts(m, "\n");
+		seq_puts(m, "\tsupported color encoding=");
+		show_bitfield(m, vkms_config_plane_get_supported_color_encodings(plane_cfg),
+			      drm_get_color_encoding_name);
+		seq_puts(m, "\n");
+		seq_printf(m, "\tdefault color encoding=%s\n",
+			   drm_get_color_encoding_name(vkms_config_plane_get_default_color_encoding(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -470,6 +498,10 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	vkms_config_plane_set_supported_rotations(plane_cfg,
 						  DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_supported_color_encodings(plane_cfg, BIT(DRM_COLOR_YCBCR_BT601) |
+							BIT(DRM_COLOR_YCBCR_BT709) |
+							BIT(DRM_COLOR_YCBCR_BT2020));
+	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
 
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 449fead7594a..034eaf51b2ca 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -45,6 +45,8 @@ struct vkms_config {
  *         It can be used to store a temporary reference to a VKMS plane during
  *         device creation. This pointer is not managed by the configuration and
  *         must be managed by other means.
+ * @default_color_encoding: Default color encoding that should be used by this plane
+ * @supported_color_encodings: Color encodings that this plane will support
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -54,6 +56,8 @@ struct vkms_config_plane {
 	enum drm_plane_type type;
 	unsigned int default_rotation;
 	unsigned int supported_rotations;
+	enum drm_color_encoding default_color_encoding;
+	unsigned int supported_color_encodings;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
 
@@ -375,6 +379,66 @@ bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
 				      const struct vkms_config_plane *plane_cfg);
 #endif
 
+/**
+ * vkms_config_plane_get_default_color_encoding() - Get the default color encoding for a plane
+ * @plane_cfg: Plane to get the default color encoding from
+ *
+ * Returns:
+ * The default color encoding for the plane
+ */
+static inline enum drm_color_encoding
+vkms_config_plane_get_default_color_encoding(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->default_color_encoding;
+}
+
+/**
+ * vkms_config_plane_set_default_color_encoding() - Set the default color encoding for a plane
+ * @plane_cfg: Plane to set the default color encoding to
+ * @default_color_encoding: New default color encoding for the plane
+ */
+static inline void
+vkms_config_plane_set_default_color_encoding(struct vkms_config_plane *plane_cfg,
+					     enum drm_color_encoding default_color_encoding)
+{
+	plane_cfg->default_color_encoding = default_color_encoding;
+}
+
+/**
+ * vkms_config_plane_get_supported_color_encodings() - Get the supported color encodings for a plane
+ * @plane_cfg: Plane to get the supported color encodings from
+ *
+ * Returns:
+ * The supported color encodings for the plane. Each set bit correspond to a value of enum
+ * drm_color_encoding: BIT(DRM_COLOR_YCBCR_BT601) | BIT(DRM_COLOR_YCBCR_BT709) means that
+ * DRM_COLOR_YCBCR_BT601 and DRM_COLOR_YCBCR_BT709 are supported.
+ */
+static inline unsigned int
+vkms_config_plane_get_supported_color_encodings(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_color_encodings;
+}
+
+/**
+ * vkms_config_plane_set_supported_color_encodings() - Set the supported color encodings for a plane
+ * @plane_cfg: Plane to set the supported color encodings to
+ * @supported_color_encodings: New supported color encodings for the plane. Each set bit corresponds
+ *                            to a value of enum drm_color_encoding:
+ *                            BIT(DRM_COLOR_YCBCR_BT601) | BIT(DRM_COLOR_YCBCR_BT709) means that
+ *                            DRM_COLOR_YCBCR_BT601 and DRM_COLOR_YCBCR_BT709 are supported.
+ */
+static inline void
+vkms_config_plane_set_supported_color_encodings(struct vkms_config_plane *plane_cfg,
+						unsigned int supported_color_encodings)
+{
+	plane_cfg->supported_color_encodings = supported_color_encodings;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_color_encoding(const struct vkms_config *config,
+					    const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 17d9c6f639b2..4b3bd2a90058 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -239,14 +239,13 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					   vkms_config_plane_get_default_rotation(plane_cfg),
 					   vkms_config_plane_get_supported_rotations(plane_cfg));
 
-	drm_plane_create_color_properties(&plane->base,
-					  BIT(DRM_COLOR_YCBCR_BT601) |
-					  BIT(DRM_COLOR_YCBCR_BT709) |
-					  BIT(DRM_COLOR_YCBCR_BT2020),
-					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
-					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
-					  DRM_COLOR_YCBCR_BT601,
-					  DRM_COLOR_YCBCR_FULL_RANGE);
+	if (vkms_config_plane_get_supported_color_encodings(plane_cfg) != 0)
+		drm_plane_create_color_properties(&plane->base,
+						  vkms_config_plane_get_supported_color_encodings(plane_cfg),
+						  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+						  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+						  vkms_config_plane_get_default_color_encoding(plane_cfg),
+						  DRM_COLOR_YCBCR_FULL_RANGE);
 
 	if (vkms_config_plane_get_default_pipeline(plane_cfg))
 		vkms_initialize_colorops(&plane->base);

-- 
2.54.0

