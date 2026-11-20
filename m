Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30802606CCDD
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CQij0zt6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E969112C78;
	Fri, 20 Nov 2026 18:05:07 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035F0112C6F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C2A1E1A1755;
 Fri, 20 Nov 2026 18:04:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 95C43601B9;
 Fri, 20 Nov 2026 18:04:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 22C9B11BC0627; Fri, 20 Nov 2026 19:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rFEWb/UcLXwzn0YyU/6iOUv8L4nhev7PnaqHfKdpAkQ=;
 b=CQij0zt6GdW9pmQHGf4N+YQ3XwQe3PDxqDueyOCHyQ/rHVb8TH4Tc42l0fKPUAI4+rv6bS
 VECF5m/yq1417gbN915G/2V6ANnXuqvs1QlKDQ7XpvAK+0+VD3SJU+29HnVVN7yxAZxqM3
 wrFJrZfP3uc0VZWxKYN/hHriQiCpxPJKlJkaakJsZUssUeFAxaRjNX9jCDn/njqXGNKvYZ
 GazYlbP45C0FWFOiCVeWWTq/3CvwI3irBRVNTbDhYdLCwFEjJecrxgTw25jT863BrkBCWP
 q4xEUhF8r5XtVpf9utACBUJ5grGWgFhIFBiBhTaShxMnzb7aN9LeUkzQ+JMK7g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:06 +0100
Subject: [PATCH v6 24/43] drm/vkms: Introduce config for plane color range
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-24-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10886;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=RiFNI1bZqpwOL1EdmNXHXX9BHQSZhY/QcWVjyZybtys=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsA31+7RBG3PiEUzyptYGJo+253WsX6dFL0W
 mWN+6WpLt2JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLABsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKMIA//VKiVKH+bvNfyGIf7CdUzNNctFMgDZPM
 QgErT/TvavQh4qovfRoUENfPhZ38cOo+drwcZe+76OvJGtby/AaoaSv1GpYP08fVOSJWUgRp67W
 lYhFgt3tqSY+rlFZcifVf4EpJ3G/1pJv6pQW4LHfCqzGdLf5XjK0fF58kcGzqOOQZbknkq+tkGb
 5nDpy7QkuwuHqJYm2yJNuyDSPQyd9FXBFWGidVRFWGp59IZPSW06roVXAH14nyFsZhhztL8iDdT
 zIvPIg6H4OnhNJWIsGFJ1WLGZzK2AXMpXu4lFdJY9wMoy7PsmCEGvUjaix6dXkexPGFzgjgHd4q
 KLs8loJy6IRkyX4bbc82NsAx6dVWi4JM10t2YBpBKjLNf1X7umXRZUB4ZfVOeiqpHpAFt/6RfVV
 qh3i0Axlh2wqv5I4hXURwA4VsxU+EkZmDyrHyh3h+zJgPJlvrWPFeHSCgAmPRvFIEf2V4WIS3+y
 gimbkwEZJx+nTDzdMNF/ZABk2pn2+d7Vgcrit0ob0Ny4rLoE5JF4H2bMy7r6L+4kmGoDwMWnTYV
 P37Zhs4W8w9QTuc+5AQOc6KuIlAu+FpRuNsie4YVEeSizwLbYTSI4JptKC2YeFjbMRgdzvkRphi
 Qray+Kl/PmAOBA0uA6QKo+rcpzuty1Yo/20FsNTqG0mxsHDYgqq4=
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

VKMS driver supports all the color range on planes, but for testing it can
be useful to only advertise few of them. This new configuration interface
will allow configuring the color range per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 44 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 39 ++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 35 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             |  8 ++---
 4 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 0254268da6a2..0f902e770e4b 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <drm/drm_color_mgmt.h>
 #include <drm/drm_mode.h>
 #include <kunit/test.h>
 
@@ -569,6 +570,7 @@ static void vkms_config_test_valid_plane_color_encoding(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Valid, no supported or color encoding */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, 0);
 	vkms_config_plane_set_supported_color_encodings(plane_cfg, 0);
 	vkms_config_plane_set_default_color_encoding(plane_cfg, 0);
 	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_encoding(config, plane_cfg));
@@ -583,6 +585,47 @@ static void vkms_config_test_valid_plane_color_encoding(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_color_range(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, all color range supported */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg,
+						     BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+						     BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_FULL_RANGE);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default color range is not supported */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg,
+						     BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_LIMITED_RANGE);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, no supported or color range */
+	vkms_config_plane_set_supported_color_encodings(plane_cfg, 0);
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, 0);
+	vkms_config_plane_set_default_color_range(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, if no supported color range, default is ignored */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, 0);
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_LIMITED_RANGE);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -1107,6 +1150,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
+	KUNIT_CASE(vkms_config_test_valid_plane_color_range),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index aad7576b730f..b33760692ba9 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -231,6 +231,25 @@ bool vkms_config_valid_plane_color_encoding(const struct vkms_config *config,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_encoding);
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
+					 const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if (vkms_config_plane_get_supported_color_ranges(plane_cfg)) {
+		if ((BIT(vkms_config_plane_get_default_color_range(plane_cfg)) &
+		     vkms_config_plane_get_supported_color_ranges(plane_cfg)) !=
+		    BIT(vkms_config_plane_get_default_color_range(plane_cfg))) {
+			drm_info(dev, "Configured default color range is not supported by the plane\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_range);
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -387,6 +406,7 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
 
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_plane *plane_cfg;
 
@@ -396,6 +416,16 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 
 		if (!vkms_config_valid_plane_color_encoding(config, plane_cfg))
 			return false;
+
+		if (!vkms_config_valid_plane_color_range(config, plane_cfg))
+			return false;
+
+		if ((vkms_config_plane_get_supported_color_encodings(plane_cfg) == 0) !=
+		    (vkms_config_plane_get_supported_color_ranges(plane_cfg) == 0)) {
+			drm_info(dev,
+				 "Both supported color encodings and color ranges must be set, or none\n");
+			return false;
+		}
 	}
 
 	if (!valid_plane_number(config))
@@ -483,6 +513,12 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "\n");
 		seq_printf(m, "\tdefault color encoding=%s\n",
 			   drm_get_color_encoding_name(vkms_config_plane_get_default_color_encoding(plane_cfg)));
+		seq_puts(m, "\tsupported color ranges=");
+		show_bitfield(m, vkms_config_plane_get_supported_color_ranges(plane_cfg),
+			      drm_get_color_range_name);
+		seq_puts(m, "\n");
+		seq_printf(m, "\tdefault color range=%s\n",
+			   drm_get_color_range_name(vkms_config_plane_get_default_color_range(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -540,6 +576,9 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 							BIT(DRM_COLOR_YCBCR_BT709) |
 							BIT(DRM_COLOR_YCBCR_BT2020));
 	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+								BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_FULL_RANGE);
 
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 554c730aebd2..827f1b3023aa 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -56,6 +56,8 @@ struct vkms_config {
  *         must be managed by other means.
  * @default_color_encoding: Default color encoding that should be used by this plane
  * @supported_color_encodings: Color encodings that this plane will support
+ * @default_color_range: Default color range that should be used by this plane
+ * @supported_color_ranges: Color ranges that this plane will support
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -67,6 +69,8 @@ struct vkms_config_plane {
 	unsigned int supported_rotations;
 	enum drm_color_encoding default_color_encoding;
 	unsigned int supported_color_encodings;
+	enum drm_color_range default_color_range;
+	unsigned int supported_color_ranges;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
 
@@ -467,6 +471,37 @@ bool vkms_config_valid_plane_color_encoding(const struct vkms_config *config,
 					    const struct vkms_config_plane *plane_cfg);
 #endif
 
+static inline enum drm_color_range
+vkms_config_plane_get_default_color_range(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->default_color_range;
+}
+
+static inline void
+vkms_config_plane_set_default_color_range(struct vkms_config_plane *plane_cfg,
+					  enum drm_color_range default_color_range)
+{
+	plane_cfg->default_color_range = default_color_range;
+}
+
+static inline unsigned int
+vkms_config_plane_get_supported_color_ranges(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_color_ranges;
+}
+
+static inline void
+vkms_config_plane_set_supported_color_ranges(struct vkms_config_plane *plane_cfg,
+					     unsigned int supported_color_ranges)
+{
+	plane_cfg->supported_color_ranges = supported_color_ranges;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
+					 const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 6b60b0c09cba..d7bbcaea6351 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -276,13 +276,13 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					   vkms_config_plane_get_default_rotation(plane_cfg),
 					   vkms_config_plane_get_supported_rotations(plane_cfg));
 
-	if (vkms_config_plane_get_supported_color_encodings(plane_cfg) != 0)
+	if (vkms_config_plane_get_supported_color_encodings(plane_cfg) != 0 &&
+	    vkms_config_plane_get_supported_color_ranges(plane_cfg) != 0)
 		drm_plane_create_color_properties(&plane->base,
 						  vkms_config_plane_get_supported_color_encodings(plane_cfg),
-						  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
-						  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+						  vkms_config_plane_get_supported_color_ranges(plane_cfg),
 						  vkms_config_plane_get_default_color_encoding(plane_cfg),
-						  DRM_COLOR_YCBCR_FULL_RANGE);
+						  vkms_config_plane_get_default_color_range(plane_cfg));
 
 	if (vkms_config_plane_get_default_pipeline(plane_cfg))
 		vkms_initialize_colorops(&plane->base);

-- 
2.56.0

