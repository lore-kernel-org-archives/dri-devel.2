Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE95AC531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E415710EF16;
	Thu, 23 Jul 2026 01:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hsGmdzkk";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B164F10EF09
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784770540;
 bh=nEHfiMafnBFlmq9OK6FuWXY863BnWSbh1ndHmtbcBso=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hsGmdzkkWXHnmJTQH93R9f/gIMNwwDR1YYDW5jGD93dRNnQls/eawxmfkmqvKWuDK
 eqTHAJ6JkVMLhR8fan/pNNy0+Rnpjo2gDAzKkTMlT++o17bfcU/GINMTYzYmfG8PYh
 zfSdcwU4w0oVQ9j3tRDKFetINryurqJbya3qu3NclMj6fbTTs5bx8l+GzJ4BC6dub3
 aIbtzK5YtNomMgVDSLoS1KYtTh1CMkyKFX5VDP56gwRMcJso92F+z5iVVHzEJ60OaH
 fVK3INArm1loNgA7xEexSJ39ryX0Xp3yPlYMi8Fndvls9Jg7WQc2qufntLsie/uLRZ
 EHjPYmzHvLt5A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D3BB17E1064;
 Thu, 23 Jul 2026 03:35:40 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 23 Jul 2026 04:35:44 +0300
Subject: [PATCH v9 55/61] drm/tests: hdmi_state_helper: Convert to
 drmm_connector_hdmi_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-dw-hdmi-qp-scramb-v9-55-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

Switch tests over to the new drmm_connector_hdmi_init() signature, where
the vendor, product, supported_formats and max_bpc values previously
passed as arguments are now provided through struct
drm_connector_hdmi_funcs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 330 ++++++++++-----------
 1 file changed, 161 insertions(+), 169 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 4c2a400bc15a..478c4b6c6207 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -124,6 +124,11 @@ static int accept_infoframe_write_infoframe(struct drm_connector *connector,
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
@@ -143,6 +148,11 @@ reject_connector_tmds_char_rate_valid(const struct drm_connector *connector,
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
@@ -163,6 +173,11 @@ reject_100mhz_connector_tmds_char_rate_valid(const struct drm_connector *connect
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
@@ -231,8 +246,6 @@ static const struct drm_encoder_helper_funcs test_encoder_helper_funcs = {
 static
 struct drm_atomic_helper_connector_hdmi_priv *
 __connector_hdmi_init(struct kunit *test,
-		      unsigned int formats,
-		      unsigned int max_bpc,
 		      const struct drm_connector_hdmi_funcs *hdmi_funcs,
 		      const void *edid_data, size_t edid_len)
 {
@@ -273,16 +286,14 @@ __connector_hdmi_init(struct kunit *test,
 	enc->possible_crtcs = drm_crtc_mask(priv->crtc);
 
 	conn = &priv->connector;
-	conn->ycbcr_420_allowed = !!(formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
+	conn->ycbcr_420_allowed = !!(hdmi_funcs->supported_formats &
+				     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 
-	ret = drmm_connector_hdmi_ini2(drm, conn,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(drm, conn,
 				       &dummy_connector_funcs,
 				       hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       NULL,
-				       formats,
-				       max_bpc);
+				       NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
@@ -298,18 +309,14 @@ __connector_hdmi_init(struct kunit *test,
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
@@ -333,9 +340,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -408,9 +413,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -483,9 +486,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -550,9 +551,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -617,9 +616,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -686,9 +683,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -755,9 +750,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -824,9 +817,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -883,6 +874,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
  */
 static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	enum drm_hdmi_broadcast_rgb broadcast_rgb;
 	struct drm_modeset_acquire_ctx ctx;
@@ -895,12 +887,11 @@ static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
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
 
@@ -984,6 +975,7 @@ KUNIT_ARRAY_PARAM(check_broadcast_rgb_cea_mode_yuv420,
  */
 static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
@@ -996,10 +988,9 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
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
 
@@ -1066,6 +1057,7 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
  */
 static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
@@ -1078,10 +1070,9 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
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
 
@@ -1145,6 +1136,7 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
  */
 static void drm_test_check_output_bpc_dvi(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1155,12 +1147,12 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
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
 
@@ -1213,8 +1205,6 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1258,6 +1248,7 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
  */
 static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1267,10 +1258,9 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
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
 
@@ -1313,6 +1303,7 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
  */
 static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1322,10 +1313,9 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
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
 
@@ -1381,9 +1371,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -1438,6 +1426,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1449,10 +1438,9 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
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
 
@@ -1512,6 +1500,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1523,11 +1512,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
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
 
@@ -1588,6 +1577,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1599,12 +1589,12 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
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
 
@@ -1669,6 +1659,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1680,11 +1671,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit
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
 
@@ -1740,6 +1731,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit
  */
 static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1752,10 +1744,9 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
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
 
@@ -1826,6 +1817,7 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
  */
 static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1837,12 +1829,12 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
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
 
@@ -1897,6 +1889,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
  */
 static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1908,10 +1901,9 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
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
 
@@ -1970,6 +1962,7 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
  */
 static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1981,12 +1974,12 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
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
 
@@ -2058,8 +2051,6 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2112,6 +2103,7 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
  */
 static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -2123,12 +2115,12 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
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
 
@@ -2187,9 +2179,7 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm_modeset_acquire_init(&ctx, 0);
@@ -2256,6 +2246,7 @@ struct color_format_test_param {
  */
 static void drm_test_check_hdmi_color_format(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	const struct color_format_test_param *param = test->param_value;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
@@ -2266,13 +2257,13 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
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
 
@@ -2364,6 +2355,7 @@ KUNIT_ARRAY_PARAM_DESC(check_hdmi_color_format, hdmi_color_format_params, desc);
  */
 static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	const struct color_format_test_param *param = test->param_value;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
@@ -2373,13 +2365,13 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
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
 
@@ -2507,9 +2499,7 @@ static void drm_test_check_broadcast_rgb_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2529,9 +2519,7 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2549,13 +2537,15 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
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
@@ -2573,13 +2563,15 @@ static void drm_test_check_bpc_10_value(struct kunit *test)
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
@@ -2595,15 +2587,17 @@ static void drm_test_check_bpc_12_value(struct kunit *test)
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
@@ -2617,15 +2611,18 @@ static void drm_test_check_format_value(struct kunit *test)
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
@@ -2659,9 +2656,7 @@ static void drm_test_check_mode_valid(struct kunit *test)
 	struct drm_connector *conn;
 	struct drm_display_mode *preferred;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2684,8 +2679,6 @@ static void drm_test_check_mode_valid_reject_rate(struct kunit *test)
 	struct drm_display_mode *preferred;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-					BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-					8,
 					&reject_100mhz_connector_hdmi_funcs,
 					test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2716,8 +2709,6 @@ static void drm_test_check_mode_valid_reject(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-					BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-					8,
 					&reject_connector_hdmi_funcs,
 					no_edid);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2746,8 +2737,6 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	struct drm_display_mode *preferred;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_100mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2769,15 +2758,15 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
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
 
@@ -2809,8 +2798,6 @@ drm_test_check_mode_valid_reject_yuv420_only_connector(struct kunit *test)
 	struct drm_connector *conn;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2835,8 +2822,6 @@ drm_test_check_mode_valid_accept_yuv420_also_connector_rgb(struct kunit *test)
 	struct drm_connector *conn;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2885,8 +2870,6 @@ static void drm_test_check_infoframes(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2960,6 +2943,11 @@ static int reject_infoframe_write_infoframe(struct drm_connector *connector,
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
@@ -2988,8 +2976,6 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_avi_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -3059,6 +3045,11 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
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
@@ -3092,8 +3083,6 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_hdr_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz_hdr);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -3190,6 +3179,7 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
  */
 static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = reject_hdr_infoframe_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_commit *state;
@@ -3205,10 +3195,9 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
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
 
@@ -3307,6 +3296,11 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
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
@@ -3341,8 +3335,6 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_audio_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);

-- 
2.55.0

