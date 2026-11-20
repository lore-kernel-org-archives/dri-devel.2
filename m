Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6660A382B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qoFPlKEc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEF8112C82;
	Fri, 20 Nov 2026 18:05:43 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7881F112C79
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:05:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E6A94C62225;
 Fri, 20 Nov 2026 18:05:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 27851601B9;
 Fri, 20 Nov 2026 18:05:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 985FD11BC08D7; Fri, 20 Nov 2026 19:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+XvchRtynTpwELTgYDKVNwIcQQr8a8wNXVGmxkW3c/Y=;
 b=qoFPlKEccsevEvLgYr+AX9euEwewFujm9GSFvuOgFfOxxQGjLOQ9sEhDdLbCEUOzNw8rz1
 3HvQmRRRkAvOCDVUUe1OgU4jJ7ibF5ivVEiLFsE6VdfZO19pT+BHUH3gclLdwxKxL5qfGW
 5Ug3u6VYYwY0rKvO4+0uwJhQ3SjkynfVvaXXnpfHriIEk65pnR+enM3l0OKW88+/RG54WE
 H2F9eIiMZbyqmMIFamwUl/MOXHIJI1vb+Or9HX4TcXliJlOi9P89dI5tEfO5ne5GoaBWAc
 Zx2hdrAPqQL/BaU5+SPth5D9lJXQ559RtTFrjOK38AxPlQ8lt68HVPwBvcLotg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:11 +0100
Subject: [PATCH v6 29/43] drm/vkms: Introduce config for plane zpos
 property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-29-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16166;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tQRoenFHz5mcGl4GcnQAGaVle5+bkr+KEtG3vtzN2J0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsBWnzwoR6SbXzsqLQIEpwpDjpFhxpN9wdPW
 12qgt98kPqJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLARsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKeDhAAnqurF2TTMycLJWARahws/C12AKG4hfU
 Ej4vQCkrfoqG8YwVWXh2dFMyy8nZjPSdpIuc/bqtohuzoZsDrzWqx1S69tSl5zfk21S0ec+9yF6
 GpoUW5HVr/LZGyP4EaD99zQQZxxTdu782STh5GVSmw/5vEcV80OMAnrhZz/2SAe4y6Fgpmoch9k
 fBNvxO/IyVJupDt7HcmpNXzAy4vnpybOTF9OAAHMxep3ghwok/W5wloUaEvM+KoRBENk9JAedwZ
 e5D3GHp0NSR7PezADBvpXPmGHRv1ZRDZCMoRWVAWHgQhVsZuVSwCA5gGSLDxLVwPh8t7YB+bP3B
 b1kffUx7LTi56iSLX21dFVEBf8Sl45bIY5rodfi9uDp/qzo6q0391H466taqaOfsNwHkQyCrKF8
 57itKaM9vJ+jWErpLOhICUj3QVIxJxUv+cfKD3HdKzbeY+pzfCZU0KLp79t2avfNkUAU45mCXPe
 1NHdd7wC5iDuk6SoXI8MNuA1BSbTv7+MmfwsC4HmdXgb7LSqWhLG1gaWE+Tvtlr4qjJO4UD3ZAJ
 lKyFWJdTESv91XxFxCww3W29f2an+J0V83JQkx99P8HbI5AfGW51Gr2RuY5iMPnrwlnKSaveNJ2
 Ok4NMz4GuTNh/IJ38cyKP34XEY9vlthtxWREsyheg7bM8urQHYas=
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
index 0f902e770e4b..a43dff511fc3 100644
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
@@ -626,6 +629,91 @@ static void vkms_config_test_valid_plane_color_range(struct kunit *test)
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
@@ -1151,6 +1239,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_range),
+	KUNIT_CASE(vkms_config_test_valid_plane_zpos),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 5286363f80f7..963e32d5adf7 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -96,6 +96,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	if (IS_ERR(plane_cfg))
 		goto err_alloc;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 	crtc_cfg = vkms_config_create_crtc(config);
 	if (IS_ERR(crtc_cfg))
@@ -115,6 +116,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 			vkms_config_plane_set_type(plane_cfg,
 						   DRM_PLANE_TYPE_OVERLAY);
 			vkms_config_plane_set_default_pipeline(plane_cfg, enable_plane_pipeline);
+			vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 			if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
 				goto err_alloc;
@@ -128,6 +130,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 
 		vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
 		vkms_config_plane_set_default_pipeline(plane_cfg, enable_plane_pipeline);
+		vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 		if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
 			goto err_alloc;
@@ -286,6 +289,33 @@ bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
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
@@ -446,6 +476,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_plane *plane_cfg;
 
+	bool has_zpos_enabled = false;
+	bool has_zpos_disabled = false;
+
 	vkms_config_for_each_plane(config, plane_cfg) {
 		if (vkms_config_plane_get_supported_formats_count(plane_cfg) == 0) {
 			drm_info(dev, "Plane must have at least one supported format.\n");
@@ -473,6 +506,19 @@ bool vkms_config_is_valid(const struct vkms_config *config)
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
@@ -579,6 +625,16 @@ static int vkms_config_show(struct seq_file *m, void *data)
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
index 7488a17aee8d..9d0a0087c9da 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -60,6 +60,11 @@ struct vkms_config {
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
@@ -77,6 +82,11 @@ struct vkms_config_plane {
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
@@ -586,6 +596,139 @@ vkms_config_plane_get_name(const struct vkms_config_plane *plane_cfg)
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
index e028c39b0c81..acff64be12b0 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -251,6 +251,17 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
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
2.56.0

