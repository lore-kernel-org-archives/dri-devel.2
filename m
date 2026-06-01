Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161D2CD6E74
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2203E11377B;
	Mon,  1 Jun 2026 22:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="K3uzFQyx";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A89113789
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780353931;
 bh=W9tdDgg2EQqozZD3LL3IaBrdwUPqaxVbVRoj+UPs6tA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=K3uzFQyxAz0uXPAhkwIzduYktV/go2ZdhRzbBF6tcsUTx2mO1+XKzER2dXLmBtFG7
 TJjgSnMeKzm9ZHpJOZP1tsRf5NxEtaadpnoxbQ4d6DIt/WFwIpn9ArNtjASoQ74F8q
 iqtYFnQEOtNKUU2UWfkOVrIbUIdSLvOxrWUdqul1fD8ElA18k2FpT/mLHzcDBuk2Fu
 7t8hxCRdnN3O556mqp0UtQP+NNI2nkZh/gDjQu9uOu6AUh1rw6RKT9IQkKscsHdaTo
 G0YTfal0ygm3o67xjocWIEw7rcqJUNYWSbi+HoD4jGpFxhx2Un+wdNRJuft4Ktm7CE
 p+IR+yeDi2RMQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C0B817E0B66;
 Tue,  2 Jun 2026 00:45:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Jun 2026 01:44:28 +0300
Subject: [PATCH v7 28/30] drm/tests: hdmi_state_helper: Add HDMI 2.0
 scrambling tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dw-hdmi-qp-scramb-v7-28-445eb54ee1ed@collabora.com>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
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

Cover the newly introduced HDMI 2.0 source-scrambler plumbing in the
drm_hdmi_state_helper code with the following KUnit tests:

- drm_test_check_scrambler_needed_low_rate verifies that a mode with
  TMDS rate <= 340 MHz never sets conn_state->hdmi.scrambler_needed,
  even when both endpoints advertise scrambling support.

- drm_test_check_scrambler_needed_high_rate verifies that a mode with
  TMDS rate > 340 MHz makes the helper set scrambler_needed.

- drm_test_check_scrambler_needed_high_rate_no_adv verifies that a mode
  with TMDS rate > 340 MHz never sets scrambler_needed when source does
  not advertise scrambling support, regardless of sink scrambling
  advertisement.

To match the behaviour drm_bridge_connector_init() applies to bridges
that implement source-scrambling callbacks, the __connector_hdmi_init()
helper now infers connector->hdmi.scrambling_supported from the presence
of .scrambler_enable and .scrambler_disable in the supplied
drm_connector_hdmi_funcs, mirroring how connector capability should be
wired up in real drivers.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 219 +++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index e89e1af7a811..98cd42f429cb 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -20,6 +20,8 @@
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
+#include <linux/hdmi.h>
+
 #include "../drm_crtc_internal.h"
 
 #include <kunit/test.h>
@@ -140,6 +142,29 @@ static const struct drm_connector_hdmi_funcs reject_100mhz_connector_hdmi_funcs
 	},
 };
 
+static int accept_scrambler_enable(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static int accept_scrambler_disable(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static const struct drm_connector_hdmi_funcs scrambler_connector_hdmi_funcs = {
+	.scrambler_enable	 = accept_scrambler_enable,
+	.scrambler_disable	 = accept_scrambler_disable,
+	.avi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.hdmi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+};
+
 static int dummy_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv =
@@ -240,6 +265,8 @@ __connector_hdmi_init(struct kunit *test,
 
 	conn = &priv->connector;
 	conn->ycbcr_420_allowed = !!(formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
+	conn->hdmi.scrambler_supported = hdmi_funcs->scrambler_enable &&
+					 hdmi_funcs->scrambler_disable;
 
 	ret = drmm_connector_hdmi_init(drm, conn,
 				       "Vendor", "Product",
@@ -2198,6 +2225,195 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that a sub-340 MHz TMDS character rate does not set
+ * conn_state->hdmi.scrambler_needed, even when the source
+ * and the sink both support scrambling.
+ */
+static void drm_test_check_scrambler_needed_low_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_info *info;
+	struct drm_display_mode *low_rate_mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&scrambler_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_TRUE(test, conn->hdmi.scrambler_supported);
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.supported);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.scrambling.supported);
+
+	low_rate_mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
+	KUNIT_ASSERT_NOT_NULL(test, low_rate_mode);
+
+	rate = drm_hdmi_compute_mode_clock(low_rate_mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_LT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     low_rate_mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_LE(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that an over-340 MHz TMDS character rate sets
+ * conn_state->hdmi.scrambler_needed when both source
+ * and sink advertise scrambling support.
+ */
+static void drm_test_check_scrambler_needed_high_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_info *info;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&scrambler_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_TRUE(test, conn->hdmi.scrambler_supported);
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.supported);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.scrambling.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	rate = drm_hdmi_compute_mode_clock(preferred, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_GT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
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
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_GT(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that an over-340 MHz TMDS character rate does not set
+ * conn_state->hdmi.scrambler_needed when the source does not
+ * advertise scrambling support, even if the sink does.
+ */
+static void drm_test_check_scrambler_needed_high_rate_no_adv(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_info *info;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	unsigned long long rate;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	info = &conn->display_info;
+	KUNIT_ASSERT_FALSE(test, conn->hdmi.scrambler_supported);
+	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.supported);
+	KUNIT_ASSERT_TRUE(test, info->hdmi.scdc.scrambling.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	rate = drm_hdmi_compute_mode_clock(preferred, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_ASSERT_GT(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
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
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_GT(test, conn_state->hdmi.tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.scrambler_needed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode),
 	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode_vic_1),
@@ -2227,6 +2443,9 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_8bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_10bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_12bpc),
+	KUNIT_CASE(drm_test_check_scrambler_needed_low_rate),
+	KUNIT_CASE(drm_test_check_scrambler_needed_high_rate),
+	KUNIT_CASE(drm_test_check_scrambler_needed_high_rate_no_adv),
 	/*
 	 * TODO: We should have tests to check that a change in the
 	 * format triggers a CRTC mode change just like we do for the

-- 
2.54.0

