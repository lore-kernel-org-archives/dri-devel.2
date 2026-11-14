Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D75606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=JZC2n1TB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D05410F0B8;
	Sat, 14 Nov 2026 18:05:45 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5569610F08C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679461;
 bh=ZWTQEEczkVGgKkc4bB2rqbYLmXEDkUYp3897Fxz3Vag=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JZC2n1TBKlpyORqDNpvvr9oySz8ohEvYu0Ja6CRt1Cmij8yyLl6zVZgbsSFokY7H5
 6lIOL4tn9wI+pjbORPJuLyqLVVC6otU+SaVYqRxHmhGnqwYJRAFq6PG37+qE6ouVx2
 P/eH4EkUXMC8K34qpZZzo+OC3/BpsWEk0M+U6VHRhXELbdvlb33HF/3tQEJYA0Pri5
 L50j17VM36q29CYgGtaaLo/LaF+NpM1CKXhfqzRdjqD01Vp6KxD7Sd3yoly69NvpOD
 J5++cFvP3Zqk4GeYaaA4JB7FPeC/acZ6rNrAkkjagM0FZg4HtpmMk1hXz3goJrJPID
 7fDE3vyvN7BIA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AE3E617E14F9;
 Sat, 14 Nov 2026 19:04:21 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:30 +0200
Subject: [PATCH 06/25] drm/tests: hdmi: Convert to drmm_connector_hdmi_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

Switch tests over to the new drmm_connector_hdmi_init() signature, where
the vendor, product, supported_formats and max_bpc values previously
passed as arguments are now provided through struct
drm_connector_hdmi_funcs.

As a consequence, the tests exercising those values can no longer share
the static hdmi_funcs and need a modified copy of their own.  Since the
connector retains a pointer to it, such a copy must not live on the
caller's stack, which is gone by the time the DRM-managed actions
release the connector.

Let __connector_hdmi_init() store it in struct
drm_atomic_helper_connector_hdmi_priv instead.  This structure embeds
the DRM device and is freed through managed.final_kfree only after
drm_dev_release() has run all DRM-managed actions, so it strictly
outlives the connector.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 334 ++++++++++-----------
 1 file changed, 164 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 336bb644cb7c..f1bdd197429c 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -32,6 +32,7 @@ struct drm_atomic_helper_connector_hdmi_priv {
 	struct drm_crtc *crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
+	struct drm_connector_hdmi_funcs hdmi_funcs;
 
 	const void *current_edid;
 	size_t current_edid_len;
@@ -124,6 +125,11 @@ static int accept_infoframe_write_infoframe(struct drm_connector *connector,
 }
 
 static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
 		.write_infoframe = accept_infoframe_write_infoframe,
@@ -143,6 +149,11 @@ reject_connector_tmds_char_rate_valid(const struct drm_connector *connector,
 }
 
 static const struct drm_connector_hdmi_funcs reject_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.tmds_char_rate_valid	= reject_connector_tmds_char_rate_valid,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
@@ -163,6 +174,11 @@ reject_100mhz_connector_tmds_char_rate_valid(const struct drm_connector *connect
 }
 
 static const struct drm_connector_hdmi_funcs reject_100mhz_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.tmds_char_rate_valid	= reject_100mhz_connector_tmds_char_rate_valid,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
@@ -240,8 +256,6 @@ static const struct drm_encoder_helper_funcs test_encoder_helper_funcs = {
 static
 struct drm_atomic_helper_connector_hdmi_priv *
 __connector_hdmi_init(struct kunit *test,
-		      unsigned int formats,
-		      unsigned int max_bpc,
 		      const struct drm_connector_hdmi_funcs *hdmi_funcs,
 		      const void *edid_data, size_t edid_len)
 {
@@ -282,16 +296,15 @@ __connector_hdmi_init(struct kunit *test,
 	enc->possible_crtcs = drm_crtc_mask(priv->crtc);
 
 	conn = &priv->connector;
-	conn->ycbcr_420_allowed = !!(formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
+	conn->ycbcr_420_allowed = !!(hdmi_funcs->supported_formats &
+				     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 
-	ret = drmm_connector_hdmi_ini2(drm, conn,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = *hdmi_funcs;
+	ret = drmm_connector_hdmi_init(drm, conn,
 				       &dummy_connector_funcs,
-				       hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       NULL,
-				       formats,
-				       max_bpc);
+				       NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
@@ -307,18 +320,14 @@ __connector_hdmi_init(struct kunit *test,
 	return priv;
 }
 
-#define drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, formats, max_bpc, funcs, edid) \
-	__connector_hdmi_init(test, formats, max_bpc, funcs, edid, ARRAY_SIZE(edid))
+#define drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, funcs, edid)	\
+	__connector_hdmi_init(test, funcs, edid, ARRAY_SIZE(edid))
 
 static
 struct drm_atomic_helper_connector_hdmi_priv *
-drm_kunit_helper_connector_hdmi_init(struct kunit *test,
-				     unsigned int formats,
-				     unsigned int max_bpc)
+drm_kunit_helper_connector_hdmi_init(struct kunit *test)
 {
 	return drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				formats,
-				max_bpc,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 }
@@ -342,9 +351,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -417,9 +424,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -492,9 +497,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -559,9 +562,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -626,9 +627,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -695,9 +694,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -764,9 +761,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -833,9 +828,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -892,6 +885,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
  */
 static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	enum drm_hdmi_broadcast_rgb broadcast_rgb;
 	struct drm_modeset_acquire_ctx ctx;
@@ -904,12 +898,11 @@ static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
 	int ret;
 
 	broadcast_rgb = *(enum drm_hdmi_broadcast_rgb *)test->param_value;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420),
-				8,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -993,6 +986,7 @@ KUNIT_ARRAY_PARAM(check_broadcast_rgb_cea_mode_yuv420,
  */
 static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
@@ -1005,10 +999,9 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 10;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				10,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1075,6 +1068,7 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
  */
 static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
@@ -1087,10 +1081,9 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 10;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				10,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1154,6 +1147,7 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
  */
 static void drm_test_check_output_bpc_dvi(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1164,12 +1158,12 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_dvi_1080p);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1222,8 +1216,6 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1267,6 +1259,7 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
  */
 static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1276,10 +1269,9 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 10;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				10,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1322,6 +1314,7 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
  */
 static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1331,10 +1324,9 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1390,9 +1382,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -1447,6 +1437,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1458,10 +1449,9 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1521,6 +1511,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1532,11 +1523,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1597,6 +1588,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1608,12 +1600,12 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1678,6 +1670,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1689,11 +1682,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1749,6 +1742,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit
  */
 static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1761,10 +1755,9 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1835,6 +1828,7 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
  */
 static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1846,12 +1840,12 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1906,6 +1900,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
  */
 static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1917,10 +1912,9 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -1979,6 +1973,7 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
  */
 static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1990,12 +1985,12 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -2067,8 +2062,6 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2121,6 +2114,7 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
  */
 static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -2132,12 +2126,12 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -2196,9 +2190,7 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm_modeset_acquire_init(&ctx, 0);
@@ -2265,6 +2257,7 @@ struct color_format_test_param {
  */
 static void drm_test_check_hdmi_color_format(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	const struct color_format_test_param *param = test->param_value;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
@@ -2275,13 +2268,13 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
 	struct drm_display_mode *preferred;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -2373,6 +2366,7 @@ KUNIT_ARRAY_PARAM_DESC(check_hdmi_color_format, hdmi_color_format_params, desc);
  */
 static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	const struct color_format_test_param *param = test->param_value;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
@@ -2382,13 +2376,13 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 	struct drm_display_mode *dank;
 	int ret;
 
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420) |
-				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-				12,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -2516,9 +2510,7 @@ static void drm_test_check_broadcast_rgb_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2538,9 +2530,7 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2558,13 +2548,15 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
  */
 static void drm_test_check_bpc_10_value(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    10);
+	hdmi_funcs.max_bpc = 10;
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2582,13 +2574,15 @@ static void drm_test_check_bpc_10_value(struct kunit *test)
  */
 static void drm_test_check_bpc_12_value(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    12);
+	hdmi_funcs.max_bpc = 12;
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2604,15 +2598,17 @@ static void drm_test_check_bpc_12_value(struct kunit *test)
  */
 static void drm_test_check_format_value(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-						    8);
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2626,15 +2622,18 @@ static void drm_test_check_format_value(struct kunit *test)
  */
 static void drm_test_check_tmds_char_value(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
-						    12);
+	hdmi_funcs.max_bpc = 12;
+	hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2668,9 +2667,7 @@ static void drm_test_check_mode_valid(struct kunit *test)
 	struct drm_connector *conn;
 	struct drm_display_mode *preferred;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2693,8 +2690,6 @@ static void drm_test_check_mode_valid_reject_rate(struct kunit *test)
 	struct drm_display_mode *preferred;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-					BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-					8,
 					&reject_100mhz_connector_hdmi_funcs,
 					test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2725,8 +2720,6 @@ static void drm_test_check_mode_valid_reject(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-					BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-					8,
 					&reject_connector_hdmi_funcs,
 					no_edid);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2755,8 +2748,6 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	struct drm_display_mode *preferred;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_100mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2778,15 +2769,15 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
  */
 static void drm_test_check_mode_valid_yuv420_only_max_clock(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_display_mode *dank;
 	struct drm_connector *conn;
 
+	hdmi_funcs.supported_formats = BIT(HDMI_COLORSPACE_RGB) |
+				       BIT(HDMI_COLORSPACE_YUV420);
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB) |
-				BIT(HDMI_COLORSPACE_YUV420),
-				8,
-				&dummy_connector_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -2818,8 +2809,6 @@ drm_test_check_mode_valid_reject_yuv420_only_connector(struct kunit *test)
 	struct drm_connector *conn;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2844,8 +2833,6 @@ drm_test_check_mode_valid_accept_yuv420_also_connector_rgb(struct kunit *test)
 	struct drm_connector *conn;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2894,8 +2881,6 @@ static void drm_test_check_infoframes(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2960,6 +2945,11 @@ static int reject_infoframe_write_infoframe(struct drm_connector *connector,
 }
 
 static const struct drm_connector_hdmi_funcs reject_avi_infoframe_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
 		.write_infoframe = reject_infoframe_write_infoframe,
@@ -2988,8 +2978,6 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_avi_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -3050,6 +3038,11 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
 }
 
 static const struct drm_connector_hdmi_funcs reject_hdr_infoframe_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
 		.write_infoframe = accept_infoframe_write_infoframe,
@@ -3083,8 +3076,6 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_hdr_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz_hdr);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -3172,6 +3163,7 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
  */
 static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = reject_hdr_infoframe_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_commit *state;
@@ -3187,10 +3179,9 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
 	bool replaced;
 	int ret;
 
+	hdmi_funcs.max_bpc = 10;
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				10,
-				&reject_hdr_infoframe_hdmi_funcs,
+				&hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz_hdr);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
@@ -3280,6 +3271,11 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
 }
 
 static const struct drm_connector_hdmi_funcs reject_audio_infoframe_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
 		.write_infoframe = accept_infoframe_write_infoframe,
@@ -3314,8 +3310,6 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_audio_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);

-- 
2.56.0

