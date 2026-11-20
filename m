Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9860A2605
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sN+nNroC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F17112C6C;
	Fri, 20 Nov 2026 18:04:41 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D062E112C66
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8EB304E4168F;
 Fri, 20 Nov 2026 18:04:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5B3CA601B9;
 Fri, 20 Nov 2026 18:04:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D9A8611BC08D7; Fri, 20 Nov 2026 19:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NS3cLlAdqPNMuJ+QKGV0OCOJEdwO55+ni17yKX+sznU=;
 b=sN+nNroCx3hOQl3nBvB0VFQvtdEmFRbARnZGZ6FCHrTuxMf0CFPfs3Sf9CD0f7tSmoxHgG
 FJl4NvUnqGeRb/blKM00DgNB0KjgSUuxLD3GRbDYhhwthzMtOGmqAGGJ45yqwoHCN4Uia/
 +8mepXG4ylvmsX0wh0o7sSLERvOLOgKiuv7LRuEZRSxa4gefLjTMLpmpC/KdR35ehcfAn1
 A1Rq27b106cpInyGEDv8tCgi0UG0kG1XyLfX8Rib6cYH/Gl2WBG9b71MLRO+HBaIXoiMtB
 KKBrKbPauM+xrslTRItR+Wu3VqkbcK1Xc89kuWPTDK4XjaiusYiYhRp91brGAg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:02 +0100
Subject: [PATCH v6 20/43] drm/vkms: Introduce config for plane rotation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-20-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
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
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11621;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Cz/6uXZX6vsgiFxFAxRKl2O8qO3zG0XE85J8WyN5IPw=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsAu+T40ZqBiiH6yjyqcFlv7JfT2mdNdgJIp
 ph2fNkboIqJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLABsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLp5w/6AkXhuZsxaW9BxuUzOjys80B5MVkcvi4
 JmamV2xtz3KBNLA3Tk5XieUMqbbmaYsahQ5KT7T0n9DdaKgp3+kAOE670QizkTiZEIfgkujyZu0
 Q4YcvRxNKnNnHLFuW68JRv78n7xxDgqEy1/lBag95KQgKJRigCeKf4y0d/P/9dPmKqu4ZEc3MiD
 jm9PVUPGLqH04RDWABa/qJU2nw5F4WRDLi6t0esp6VDSlC1o/2k65gReA6OY/4eIJZYGsmKDvwL
 9dhuMNP7r8nDqfFeY4ove9lKbO3Lwr9IZAFtafjcKzjUvqXyKb4V7uuMYfWiy8Hf3QxnVcO3oDY
 X+0ELgkNo5OBEWmaJNpA2+/aKkkyAqbX8eQPM0Pw6AvpJ1tRBZXVy2ooW0khFU6/kt7uvSZ+3H/
 2a1VjirLyR8zh04oxwlaY0HErCksXwCVnaJ1Yl6Mr18fSIkv0u9FN0doK+d+vm2gpe+5KzZgLNJ
 uZdTFTOLSS0ePvKfNNbFeWQORdy0gDrp6r4pIYLx9hGoKfX0yI8awPPopRdmfuHF1nT6W2M2+bb
 JByKbnMcwKy3UlRL1f1SvBgbMZtXTYsNF/7F/UCHFpESK1IdDEqZhwWrbGMZUv6V6VDH+PMN/4B
 OJ4s/8eKLi2H6KGAUu34/J/4r6ZoQtPyGuaBB99vJpXx7yoguci0=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
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

VKMS driver supports all the rotation on planes, but for testing it can be
useful to only advertise few of them. This new configuration interface
will allow configuring the rotation per planes.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 53 ++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 46 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 59 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             |  5 ++-
 4 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 1e4ea1863420..dcb29ed8ac4a 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <drm/drm_mode.h>
 #include <kunit/test.h>
 
 #include "../vkms_config.h"
@@ -185,6 +186,12 @@ static void vkms_config_test_default_config(struct kunit *test)
 			n_possible_crtcs++;
 		}
 		KUNIT_EXPECT_EQ(test, n_possible_crtcs, 1);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_plane_get_supported_rotations(plane_cfg),
+				DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_plane_get_default_rotation(plane_cfg),
+				DRM_MODE_ROTATE_0);
 	}
 
 	/* Encoders */
@@ -481,6 +488,51 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_rotations(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, no rotation, no reflection */
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default rotation is not supported */
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_90);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, supported rotations must contain at least one base rotation angle */
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_REFLECT_MASK);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_REFLECT_X | DRM_MODE_ROTATE_0);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default rotation must contain exactly one base rotation angle */
+	vkms_config_plane_set_supported_rotations(plane_cfg,
+						  DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_REFLECT_X);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, multiple rotation bits in default_rotation */
+	vkms_config_plane_set_supported_rotations(plane_cfg,
+						  DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_MASK);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -1003,6 +1055,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_get_connectors),
 	KUNIT_CASE(vkms_config_test_invalid_plane_number),
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
+	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index fe82fb9e344a..82e8ada05b26 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -2,8 +2,11 @@
 
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/log2.h>
 
+#include <drm/drm_blend.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_mode.h>
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
 #include <kunit/visibility.h>
@@ -180,6 +183,35 @@ static bool valid_plane_number(const struct vkms_config *config)
 	return true;
 }
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
+				      const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if ((vkms_config_plane_get_supported_rotations(plane_cfg) &
+	     DRM_MODE_ROTATE_MASK) == 0) {
+		drm_info(dev, "Configured supported rotations must contain at least one base rotation angle\n");
+		return false;
+	}
+
+	if (!is_power_of_2(vkms_config_plane_get_default_rotation(plane_cfg) &
+			   DRM_MODE_ROTATE_MASK)) {
+		drm_info(dev, "Configured default rotation must contain exactly one base rotation angle\n");
+		return false;
+	}
+
+	if ((vkms_config_plane_get_default_rotation(plane_cfg) &
+	     vkms_config_plane_get_supported_rotations(plane_cfg)) !=
+	    vkms_config_plane_get_default_rotation(plane_cfg)) {
+		drm_info(dev, "Configured default rotation is not supported by the plane\n");
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_rotation);
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -337,6 +369,12 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_plane *plane_cfg;
+
+	vkms_config_for_each_plane(config, plane_cfg) {
+		if (!vkms_config_valid_plane_rotation(config, plane_cfg))
+			return false;
+	}
 
 	if (!valid_plane_number(config))
 		return false;
@@ -397,6 +435,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_printf(m, "\tname=%s\n",
 			   vkms_config_plane_get_name(plane_cfg) ?
 			   vkms_config_plane_get_name(plane_cfg) : "(null)");
+		seq_printf(m, "\tsupported rotations=" DRM_ROTATION_FMT "\n",
+			   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_supported_rotations(plane_cfg)));
+		seq_printf(m, "\tdefault rotation=" DRM_ROTATION_FMT "\n",
+			   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_default_rotation(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -447,6 +489,10 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	if (ret)
 		goto cleanup_plane_cfg;
 
+	vkms_config_plane_set_supported_rotations(plane_cfg,
+						  DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8704b6f71000..b0a5a1ae6537 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -48,6 +48,8 @@ struct vkms_config {
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
  * @possible_crtcs: Array of CRTCs that can be used with this plane
+ * @default_rotation: Default rotation that should be used by this plane
+ * @supported_rotation: Rotation that this plane will support
  * @plane: Internal usage. This pointer should never be considered as valid.
  *         It can be used to store a temporary reference to a VKMS plane during
  *         device creation. This pointer is not managed by the configuration and
@@ -59,6 +61,8 @@ struct vkms_config_plane {
 
 	const char *name;
 	enum drm_plane_type type;
+	unsigned int default_rotation;
+	unsigned int supported_rotations;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
 
@@ -344,6 +348,61 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
 	plane_cfg->default_pipeline = default_pipeline;
 }
 
+/**
+ * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
+ * @plane_cfg: Plane to get the default rotation from
+ *
+ * Returns:
+ * The default rotation for the plane.
+ */
+static inline unsigned int
+vkms_config_plane_get_default_rotation(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->default_rotation;
+}
+
+/**
+ * vkms_config_plane_set_default_rotation() - Set the default rotation for a plane
+ * @plane_cfg: Plane to set the default rotation to
+ * @default_rotation: New default rotation for the plane
+ */
+static inline void
+vkms_config_plane_set_default_rotation(struct vkms_config_plane *plane_cfg,
+				       unsigned int default_rotation)
+{
+	plane_cfg->default_rotation = default_rotation;
+}
+
+/**
+ * vkms_config_plane_get_supported_rotations() - Get the supported rotations for a plane
+ * @plane_cfg: Plane to get the supported rotations from
+ *
+ * Returns:
+ * The supported rotations for the plane.
+ */
+static inline unsigned int
+vkms_config_plane_get_supported_rotations(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_rotations;
+}
+
+/**
+ * vkms_config_plane_set_supported_rotations() - Set the supported rotations for a plane
+ * @plane_cfg: Plane to set the supported rotations to
+ * @supported_rotations: New supported rotations for the plane
+ */
+static inline void
+vkms_config_plane_set_supported_rotations(struct vkms_config_plane *plane_cfg,
+					  unsigned int supported_rotations)
+{
+	plane_cfg->supported_rotations = supported_rotations;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
+				      const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8ea05c1d98e4..91c51a8d908b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -272,8 +272,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_helper_add(&plane->base, &vkms_plane_helper_funcs);
 
-	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
-					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
+	drm_plane_create_rotation_property(&plane->base,
+					   vkms_config_plane_get_default_rotation(plane_cfg),
+					   vkms_config_plane_get_supported_rotations(plane_cfg));
 
 	drm_plane_create_color_properties(&plane->base,
 					  BIT(DRM_COLOR_YCBCR_BT601) |

-- 
2.56.0

