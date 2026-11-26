Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B3606A338
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ppJG4EAI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D686611233B;
	Thu, 26 Nov 2026 11:31:34 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FF0112350
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:31:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 96EAD4E41693;
 Thu, 26 Nov 2026 11:31:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6BD0B60237;
 Thu, 26 Nov 2026 11:31:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6BE0E11E6B363; Thu, 26 Nov 2026 12:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692681; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=aQ85UKC/89uHNI16ZfTHc7pBtlL/rDqr1nu7ukRbfQM=;
 b=ppJG4EAIIHWCQbF3LYg4JiH8zWYOqpyzmRmzPnC7AWYrDD8btimeX3xNn+c4vqEDCzQ4CC
 36U+lUZtA1MraiXt6EAGOIs5z//Hd8rGoDvuK+zwirgfgkND3Jw9GLJ+Qy1my4yQY2Fjbv
 VJVYeVgPrAnLRt0JylKCj2lzRNuWbpZNi2jpPne1gF1m1wURCR4MqzcEd5zQubZ/wf17hx
 2vSAQoSAznQpbjjuZSTojuWFRxAr3nBQJYqsIeNadFlROyfS0lbCBwvxDAqjVP23IPT3cf
 FrPiPzmrpcsmZ+yRKzGbzQJlRALi0gXbRRf/Jv8TrIeq4kh765748PB1/cL9Sw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:04 +0100
Subject: [PATCH v7 21/43] drm/vkms: Introduce config for plane color encoding
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-21-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
In-Reply-To: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS driver supports all the color encoding on planes, but for testing it
can be useful to only advertise few of them. This new configuration
interface will allow configuring the color encoding per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 51 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 48 ++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 64 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             | 15 +++----
 4 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index dcb29ed8ac4a..0254268da6a2 100644
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
@@ -533,6 +541,48 @@ static void vkms_config_test_valid_plane_rotations(struct kunit *test)
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
@@ -1056,6 +1106,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_invalid_plane_number),
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
+	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index d4f15f1c53b0..90cc28f3d386 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -208,6 +208,25 @@ bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
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
@@ -370,6 +389,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	vkms_config_for_each_plane(config, plane_cfg) {
 		if (!vkms_config_valid_plane_rotation(config, plane_cfg))
 			return false;
+
+		if (!vkms_config_valid_plane_color_encoding(config, plane_cfg))
+			return false;
 	}
 
 	if (!valid_plane_number(config))
@@ -402,6 +424,22 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
 
+static __nocfi void show_bitfield(struct seq_file *m, uint32_t value, const char *callback(unsigned int))
+{
+	u32 offset = 0;
+	bool first = true;
+
+	while (value >= BIT(offset) && offset < 32) {
+		if (value & BIT(offset)) {
+			if (!first)
+				seq_puts(m, ",");
+			seq_printf(m, "%s", callback(offset));
+			first = false;
+		}
+		offset += 1;
+	}
+}
+
 static int vkms_config_show(struct seq_file *m, void *data)
 {
 	struct drm_debugfs_entry *entry = m->private;
@@ -436,6 +474,12 @@ static int vkms_config_show(struct seq_file *m, void *data)
 				   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_supported_rotations(plane_cfg)));
 			seq_printf(m, "\tdefault rotation=" DRM_ROTATION_FMT "\n",
 				   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_default_rotation(plane_cfg)));
+			seq_puts(m, "\tsupported color encoding=");
+			show_bitfield(m, vkms_config_plane_get_supported_color_encodings(plane_cfg),
+				      drm_get_color_encoding_name);
+			seq_puts(m, "\n");
+			seq_printf(m, "\tdefault color encoding=%s\n",
+				   drm_get_color_encoding_name(vkms_config_plane_get_default_color_encoding(plane_cfg)));
 		}
 
 		vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -489,6 +533,10 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	vkms_config_plane_set_supported_rotations(plane_cfg,
 						  DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_supported_color_encodings(plane_cfg, BIT(DRM_COLOR_YCBCR_BT601) |
+							BIT(DRM_COLOR_YCBCR_BT709) |
+							BIT(DRM_COLOR_YCBCR_BT2020));
+	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
 
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8587a4a28b19..11457213a551 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -60,6 +60,8 @@ struct vkms_config {
  *         It can be used to store a temporary reference to a VKMS plane during
  *         device creation. This pointer is not managed by the configuration and
  *         must be managed by other means.
+ * @default_color_encoding: Default color encoding that should be used by this plane
+ * @supported_color_encodings: Color encodings that this plane will support
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -70,6 +72,8 @@ struct vkms_config_plane {
 	enum drm_plane_type type;
 	unsigned int default_rotation;
 	unsigned int supported_rotations;
+	enum drm_color_encoding default_color_encoding;
+	unsigned int supported_color_encodings;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
 
@@ -429,6 +433,66 @@ bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
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
index 9545bbd1744f..92018e5b7a56 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -281,14 +281,13 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
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
2.56.0

