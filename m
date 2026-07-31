Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3526C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0047A10F343;
	Fri, 31 Jul 2026 16:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="U7AxCbZC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832A210F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514799;
 bh=0kQcEb8Hkp5EMJTEHb1RclxeTrVhTTx4W2V5Vh+7vis=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=U7AxCbZCHAI1qvMa3sSa+wO+cmbu0LjmRtkiijgm8zvf3L4QzVdGfj3W0KuRRgTzQ
 Ddm4a9p+Il5DyzS9oSPL7LzoTspbXEvMCOSqxWF31VqWU18kV7YhBvV+di/FEiEFQv
 zUvqETU2cqVj/YWjLMbc9giCjDtCd/TsTDHyPYvHR/hITR09fej7Kid8b56XIvj1aQ
 oIZi6AbWSDGwSvneSM9rSH8cZbVa5q4KHCaYLH1KNC+JhTt0pJo/lb7kBysHEabi19
 f6bmCfPvu35UeQrm8eBo+jPCTRHrb2kJqfVejq3piSw7IAjL2L3vGixJHJqSPMHRaG
 wEzXQoUFe2shw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8927D17E09F7;
 Fri, 31 Jul 2026 18:19:59 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:10 +0300
Subject: [PATCH v10 63/69] drm/tests: hdmi_state_helper: Convert to
 drmm_connector_hdmi_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-63-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
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
index 4c2a400bc15a..f35dc31326bc 100644
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
@@ -231,8 +247,6 @@ static const struct drm_encoder_helper_funcs test_encoder_helper_funcs = {
 static
 struct drm_atomic_helper_connector_hdmi_priv *
 __connector_hdmi_init(struct kunit *test,
-		      unsigned int formats,
-		      unsigned int max_bpc,
 		      const struct drm_connector_hdmi_funcs *hdmi_funcs,
 		      const void *edid_data, size_t edid_len)
 {
@@ -273,16 +287,15 @@ __connector_hdmi_init(struct kunit *test,
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
@@ -298,18 +311,14 @@ __connector_hdmi_init(struct kunit *test,
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
@@ -333,9 +342,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -408,9 +415,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -483,9 +488,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -550,9 +553,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -617,9 +618,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -686,9 +685,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -755,9 +752,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -824,9 +819,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -883,6 +876,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
  */
 static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	enum drm_hdmi_broadcast_rgb broadcast_rgb;
 	struct drm_modeset_acquire_ctx ctx;
@@ -895,12 +889,11 @@ static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
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
 
@@ -984,6 +977,7 @@ KUNIT_ARRAY_PARAM(check_broadcast_rgb_cea_mode_yuv420,
  */
 static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
@@ -996,10 +990,9 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
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
 
@@ -1066,6 +1059,7 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
  */
 static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
@@ -1078,10 +1072,9 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
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
 
@@ -1145,6 +1138,7 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
  */
 static void drm_test_check_output_bpc_dvi(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1155,12 +1149,12 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
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
 
@@ -1213,8 +1207,6 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1258,6 +1250,7 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
  */
 static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1267,10 +1260,9 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
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
 
@@ -1313,6 +1305,7 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
  */
 static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1322,10 +1315,9 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
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
 
@@ -1381,9 +1373,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -1438,6 +1428,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1449,10 +1440,9 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
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
 
@@ -1512,6 +1502,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_rgb(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1523,11 +1514,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
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
 
@@ -1588,6 +1579,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_yuv420(struct kunit *test)
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1599,12 +1591,12 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
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
 
@@ -1669,6 +1661,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv422(struct kunit
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1680,11 +1673,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit
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
 
@@ -1740,6 +1733,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback_ignore_yuv420(struct kunit
  */
 static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1752,10 +1746,9 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
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
 
@@ -1826,6 +1819,7 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
  */
 static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1837,12 +1831,12 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
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
 
@@ -1897,6 +1891,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
  */
 static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1908,10 +1903,9 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
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
 
@@ -1970,6 +1964,7 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
  */
 static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -1981,12 +1976,12 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
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
 
@@ -2058,8 +2053,6 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2112,6 +2105,7 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
  */
 static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
@@ -2123,12 +2117,12 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
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
 
@@ -2187,9 +2181,7 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm_modeset_acquire_init(&ctx, 0);
@@ -2256,6 +2248,7 @@ struct color_format_test_param {
  */
 static void drm_test_check_hdmi_color_format(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	const struct color_format_test_param *param = test->param_value;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
@@ -2266,13 +2259,13 @@ static void drm_test_check_hdmi_color_format(struct kunit *test)
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
 
@@ -2364,6 +2357,7 @@ KUNIT_ARRAY_PARAM_DESC(check_hdmi_color_format, hdmi_color_format_params, desc);
  */
 static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
 	const struct color_format_test_param *param = test->param_value;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector_state *conn_state;
@@ -2373,13 +2367,13 @@ static void drm_test_check_hdmi_color_format_420_only(struct kunit *test)
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
 
@@ -2507,9 +2501,7 @@ static void drm_test_check_broadcast_rgb_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2529,9 +2521,7 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2549,13 +2539,15 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
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
@@ -2573,13 +2565,15 @@ static void drm_test_check_bpc_10_value(struct kunit *test)
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
@@ -2595,15 +2589,17 @@ static void drm_test_check_bpc_12_value(struct kunit *test)
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
@@ -2617,15 +2613,18 @@ static void drm_test_check_format_value(struct kunit *test)
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
@@ -2659,9 +2658,7 @@ static void drm_test_check_mode_valid(struct kunit *test)
 	struct drm_connector *conn;
 	struct drm_display_mode *preferred;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init(test);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -2684,8 +2681,6 @@ static void drm_test_check_mode_valid_reject_rate(struct kunit *test)
 	struct drm_display_mode *preferred;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-					BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-					8,
 					&reject_100mhz_connector_hdmi_funcs,
 					test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2716,8 +2711,6 @@ static void drm_test_check_mode_valid_reject(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-					BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-					8,
 					&reject_connector_hdmi_funcs,
 					no_edid);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2746,8 +2739,6 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	struct drm_display_mode *preferred;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_100mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2769,15 +2760,15 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
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
 
@@ -2809,8 +2800,6 @@ drm_test_check_mode_valid_reject_yuv420_only_connector(struct kunit *test)
 	struct drm_connector *conn;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2835,8 +2824,6 @@ drm_test_check_mode_valid_accept_yuv420_also_connector_rgb(struct kunit *test)
 	struct drm_connector *conn;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(HDMI_COLORSPACE_RGB),
-				8,
 				&dummy_connector_hdmi_funcs,
 				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -2885,8 +2872,6 @@ static void drm_test_check_infoframes(struct kunit *test)
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
@@ -3059,6 +3047,11 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
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
@@ -3092,8 +3085,6 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_hdr_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz_hdr);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -3190,6 +3181,7 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
  */
 static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
 {
+	struct drm_connector_hdmi_funcs hdmi_funcs = reject_hdr_infoframe_hdmi_funcs;
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_commit *state;
@@ -3205,10 +3197,9 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
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
 
@@ -3307,6 +3298,11 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
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
@@ -3341,8 +3337,6 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 	int ret;
 
 	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
-				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				8,
 				&reject_audio_infoframe_hdmi_funcs,
 				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);

-- 
2.55.0

