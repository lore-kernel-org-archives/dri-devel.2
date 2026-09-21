Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7635DC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6B610EACB;
	Mon, 21 Sep 2026 15:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="G+B2F0LC";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C66910EADA;
 Mon, 21 Sep 2026 15:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790006045; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O4zW6rsjXoT/RAEKLIvZfdnRV+vrsEP6vfeO73PYNVWv/9llMXjEId8S7j0flsA6/JnMFVolmRdALqsYueP2i4JEG5fk+jjB1qgcs/9XY7Y6v2WRt4XPMt4wxOxvUsPl5A7LUoWdVfSp/DsU8BLiHtN9ixqNKR1s/KAjhFI7gmg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790006045;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lYDlZpW716irxW3KFrd93W0EhzCkGRb/29feCpRb1eY=; 
 b=IP6wZmEq6n+N11MZ4ZV2wxYoB5kLHL7+I9TNQY+gepToMTJ6UFnVfwZ4Fe/LFasZWVZlixyNClHxut0FuCRyhRgg4wC/GntFlUnpY0VQ6kwMmIOB7dthk7XgaOSLN1edP2NmEYrUnTzRiw1TtoXd+yU2S4t6QXJ4rDaXAHswAn8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006045; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=lYDlZpW716irxW3KFrd93W0EhzCkGRb/29feCpRb1eY=;
 b=G+B2F0LCohAZfH2LeUDdoMneUGn9Deww9EF/0LaeVz/aW5sQNdEA4efK1dsw8/YE
 Qyfl/0A898XIXegGCj3GTfIhJjH9F0vLTtOW5X81Mfx1Kxuyfe+ruIoOswgivcEGNgf
 MkqVA/7ErHON2xBklu7InSvS9S9xjMUACIvoSKHM=
Received: by smtp.zohomail.com with SMTPS id 1790006044663940.059291944602;
 Mon, 21 Sep 2026 08:54:04 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:48 +0200
Subject: [PATCH RFC 22/25] drm/tests: hdmi: Add "Game Mode" VRR tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-22-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

Add a few tests to verify "Game Mode" VRR functionality.

One test checks that hdmi_validate_vrr succeeds if the sink is VRR
capable and VRR is enabled.

Another test checks that hdmi_validate_vrr fails if the sink isn't VRR
capable, but VRR is nevertheless enabled.

Yet another test checks that flush/vsync have cur_vtotal bounce between
base_vtotal and max_vtotal.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 264 +++++++++++++++++++++
 drivers/gpu/drm/tests/drm_kunit_edid.h             | 139 +++++++++++
 2 files changed, 403 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index b2e347863a77..1486c16c2f78 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -7,6 +7,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_connector.h>
@@ -3423,11 +3424,274 @@ static struct kunit_suite drm_atomic_helper_connector_hdmi_infoframes_test_suite
 	.test_cases	= drm_atomic_helper_connector_hdmi_infoframes_tests,
 };
 
+/*
+ * Check that on a VRR-capable sink with VRR enabled, an atomic commit works.
+ */
+static void drm_test_check_hdmi_vrr(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_GE(test, crtc_state->vrr_state.base_vtotal, preferred->crtc_vtotal);
+	KUNIT_EXPECT_GE(test, crtc_state->vrr_state.max_vtotal, preferred->crtc_vtotal);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a sink that's not VRR capable, enabling VRR and doing an atomic
+ * commit fails.
+ */
+static void drm_test_check_hdmi_vrr_sink_fail(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.vrr_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that the drm_crtc_helper_vrr_flush() and drm_crtc_helper_vrr_vsync()
+ * helpers return the expected values on a VRR-capable sink with VRR enabled.
+ */
+static void drm_test_check_hdmi_vrr_flush_vsync(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal, preferred->crtc_vtotal);
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.max_vtotal,
+			preferred->crtc_vtotal * (drm_mode_vrefresh(preferred) / 30));
+
+	KUNIT_EXPECT_TRUE(test, drm_crtc_helper_vrr_flush(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.base_vtotal);
+
+	/*
+	 * Invoking drm_crtc_helper_vrr_flush() again should not change
+	 * cur_vtotal, meaning it should return false.
+	 */
+	KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.base_vtotal);
+
+	KUNIT_EXPECT_TRUE(test, drm_crtc_helper_vrr_vsync(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.max_vtotal);
+
+	/* Same as above, double invocation should leave it unchanged. */
+
+	KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_vsync(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.max_vtotal);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
+	KUNIT_CASE(drm_test_check_hdmi_vrr),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_sink_fail),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_flush_vsync),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_helper_connector_hdmi_vrr_test_suite = {
+	.name		= "drm_atomic_helper_connector_hdmi_vrr",
+	.test_cases	= drm_atomic_helper_connector_hdmi_vrr_tests,
+};
+
 kunit_test_suites(
 	&drm_atomic_helper_connector_hdmi_check_test_suite,
 	&drm_atomic_helper_connector_hdmi_reset_test_suite,
 	&drm_atomic_helper_connector_hdmi_mode_valid_test_suite,
 	&drm_atomic_helper_connector_hdmi_infoframes_test_suite,
+	&drm_atomic_helper_connector_hdmi_vrr_test_suite,
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.h b/drivers/gpu/drm/tests/drm_kunit_edid.h
index 28b4df93a555..10175c9e1b2e 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.h
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.h
@@ -13,4 +13,143 @@ extern const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[256];
 extern const unsigned char test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz[256];
 extern const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[256];
 
+/*
+ * Max resolution: 3840x2160@60Hz with YUV420
+ * Max BPC:        16 for all modes
+ * Max TMDS clock: <340MHz, so set to 0
+ * VRR range: 30Hz to 120Hz
+ * CinemaVRR flag is set
+ *
+ * edid-decode (hex):
+ *
+ * 00 ff ff ff ff ff ff 00 31 d8 43 00 00 00 00 00
+ * 01 24 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
+ * 0f 50 54 20 00 00 01 01 01 01 01 01 01 01 01 01
+ * 01 01 01 01 01 01 04 74 80 18 71 38 2d 40 58 2c
+ * 45 00 c0 1c 32 00 00 1e 04 74 00 30 f2 70 5a 80
+ * b0 58 8a 00 c0 1c 32 00 00 1e 00 00 00 fc 00 54
+ * 65 73 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd
+ * 00 18 78 18 87 22 00 0a 20 20 20 20 20 20 01 7e
+ *
+ * 02 03 29 31 42 3f 5f 6d 03 0c 00 10 00 78 00 20
+ * 00 00 00 20 61 6d d8 5d c4 01 00 80 07 10 1e 78
+ * 00 00 00 e2 0e 61 e2 00 ed 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 68
+ *
+ * ----------------
+ *
+ * Block 0, Base EDID:
+ *  EDID Structure Version & Revision: 1.3
+ *  Vendor & Product Identification:
+ *    Manufacturer: LNX
+ *    Model: 67
+ *    Made in: week 1 of 2026
+ *  Basic Display Parameters & Features:
+ *    Digital display
+ *    Maximum image size: 96 cm x 54 cm
+ *    Gamma: 2.20
+ *    RGB color display
+ *    Default (sRGB) color space is primary color space
+ *    First detailed timing is the preferred timing
+ *    Supports GTF timings within operating range
+ *  Color Characteristics:
+ *    Red  : 0.6396, 0.3300
+ *    Green: 0.2998, 0.5996
+ *    Blue : 0.1503, 0.0595
+ *    White: 0.3125, 0.3291
+ *  Established Timings I & II:
+ *    DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz     25.175000 MHz
+ *  Standard Timings: none
+ *  Detailed Timing Descriptors:
+ *    DTD 1:  1920x1080  120.000000 Hz  16:9    135.000 kHz    297.000000 MHz (960 mm x 540 mm)
+ *                 Hfront   88 Hsync  44 Hback  148 Hpol P
+ *                 Vfront    4 Vsync   5 Vback   36 Vpol P
+ *    DTD 2:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz (960 mm x 540 mm)
+ *                 Hfront  176 Hsync  88 Hback  296 Hpol P
+ *                 Vfront    8 Vsync  10 Vback   72 Vpol P
+ *    Display Product Name: 'Test EDID'
+ *    Display Range Limits:
+ *      Monitor ranges (GTF): 24-120 Hz V, 24-135 kHz H, max dotclock 340 MHz
+ *  Extension blocks: 1
+ * Checksum: 0x7e
+ *
+ * ----------------
+ *
+ * Block 1, CTA-861 Extension Block:
+ *  Revision: 3
+ *  Supports YCbCr 4:4:4
+ *  Supports YCbCr 4:2:2
+ *  Native detailed modes: 1
+ *  Video Data Block:
+ *    VIC  63:  1920x1080  120.000000 Hz  16:9    135.000 kHz    297.000000 MHz
+ *    VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
+ *  Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
+ *    Source physical address: 1.0.0.0
+ *    DC_48bit
+ *    DC_36bit
+ *    DC_30bit
+ *    DC_Y444
+ *    Maximum TMDS clock: 0 MHz
+ *    Extended HDMI video details:
+ *  Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8:
+ *    Version: 1
+ *    SCDC Present
+ *    Supports 16-bits/component Deep Color 4:2:0 Pixel Encoding
+ *    Supports 12-bits/component Deep Color 4:2:0 Pixel Encoding
+ *    Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
+ *    Supports media rates below VRRmin (CinemaVRR, deprecated)
+ *    VRRmin: 30 Hz
+ *    VRRmax: 120 Hz
+ *  YCbCr 4:2:0 Video Data Block:
+ *    VIC  97:  3840x2160   60.000000 Hz  16:9    135.000 kHz    594.000000 MHz
+ *  Video Capability Data Block:
+ *    YCbCr quantization: Selectable (via AVI YQ)
+ *    RGB quantization: Selectable (via AVI Q)
+ *    PT scan behavior: Always Underscanned
+ *    IT scan behavior: Supports both over- and underscan
+ *    CE scan behavior: Always Overscanned
+ * Checksum: 0x68  Unused space in Extension Block: 86 bytes
+ *
+ * ----------------
+ *
+ * edid-decode 1.32.0
+ *
+ * Warnings:
+ *
+ * Block 1, CTA-861 Extension Block:
+ *  *** v- pretty sure this one's a bug in edid-decode ***
+ *  IT Video Formats are overscanned by default, but normally this should be underscanned.
+ *  Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8: CinemaVRR is deprecated and must be cleared.
+ *
+ * EDID conformity: PASS
+ */
+static const unsigned char test_edid_hdmi_vrr[] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x43, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x24, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
+	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
+	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x74, 0x80, 0x18, 0x71, 0x38,
+	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0xc0, 0x1c, 0x32, 0x00, 0x00, 0x1e,
+	0x04, 0x74, 0x00, 0x30, 0xf2, 0x70, 0x5a, 0x80, 0xb0, 0x58, 0x8a, 0x00,
+	0xc0, 0x1c, 0x32, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00, 0xfc, 0x00, 0x54,
+	0x65, 0x73, 0x74, 0x20, 0x45, 0x44, 0x49, 0x44, 0x0a, 0x20, 0x20, 0x20,
+	0x00, 0x00, 0x00, 0xfd, 0x00, 0x18, 0x78, 0x18, 0x87, 0x22, 0x00, 0x0a,
+	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x01, 0x7e, 0x02, 0x03, 0x29, 0x31,
+	0x42, 0x3f, 0x5f, 0x6d, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x00, 0x20,
+	0x00, 0x00, 0x00, 0x20, 0x61, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x00, 0x80,
+	0x07, 0x10, 0x1e, 0x78, 0x00, 0x00, 0x00, 0xe2, 0x0e, 0x61, 0xe2, 0x00,
+	0xed, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x68
+};
+
 #endif // DRM_KUNIT_EDID_H_

-- 
2.55.0

