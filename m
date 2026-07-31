Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4408FC55176
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A2110F30D;
	Fri, 31 Jul 2026 16:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gsBsKEyr";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D3E10F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514800;
 bh=kA6nVSOFOk0yymzKaCCJLaqlyDMieIsqeSwOvsCsQw8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gsBsKEyrH+QYLVtyIIhw4WsfchROQj9KLHlsFV16a+zYXPiYch02urhgW+dCB6eRP
 L8PuUyaHvVDzoaFbi2Atg/pHvQohR2mlEfB3FfqZQY7BJJicfFiHSy9Uc8DE1KHctF
 AQqmRplXx6o46QmVkwPp/EAp7ggn1jwXFGFnr5EEWYCLw1psNl2U1A8tcyWi243p0Z
 YgIyL3VYtSsfIGcbnmRk+FImjMHIRZrrSihkWdsy5rxvHxHdSl3N/ejenV2tZL4ZtT
 3F5ikocxfwCKkmgsLTqMJ07Qs2036jCCSqur/DJunzoj5a8zExUaV8qUuAZ3MnGzG3
 MtvgZSJ+fvB+A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E30D17E093E;
 Fri, 31 Jul 2026 18:20:00 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:11 +0300
Subject: [PATCH v10 64/69] drm/tests: hdmi_state_helper: Add
 connector-provided max_tmds_char_rate coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-64-294364b2cf15@collabora.com>
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

Test the hdmi_clock_valid() logic that rejects modes whose TMDS
character rate exceeds connector->hdmi.max_tmds_char_rate.

Exercise both an explicit limit set through drm_connector_hdmi_funcs'
supported_tmds_char_rate and the limit inferred from supported_hdmi_ver.

Also verify that a driver hook can further restrict the connector limit.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index f35dc31326bc..6d648332aa15 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -190,6 +190,32 @@ static const struct drm_connector_hdmi_funcs reject_100mhz_connector_hdmi_funcs
 	},
 };
 
+static enum drm_mode_status
+accept_any_connector_tmds_char_rate_valid(const struct drm_connector *connector,
+					  const struct drm_display_mode *mode,
+					  unsigned long long tmds_rate)
+{
+	return MODE_OK;
+}
+
+static const struct drm_connector_hdmi_funcs reject_over_165mhz_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_3,
+	.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.tmds_char_rate_valid = accept_any_connector_tmds_char_rate_valid,
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
@@ -2753,6 +2779,93 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, preferred->clock, 25200);
 }
 
+/*
+ * Test that the max_tmds_char_rate inferred from caps.supported_hdmi_ver
+ * is applied as a mode-filtering limit: with an HDMI 1.3 connector and no
+ * driver hook, drm_hdmi_connector_mode_valid() will reject modes whose TMDS
+ * character rate exceeds 340 MHz, even though the sink itself advertises
+ * a higher limit (600 MHz).
+ */
+static void
+drm_test_check_mode_valid_reject_inferred_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, &hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 2560);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 1600);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 268500);
+}
+
+/*
+ * Test that a connector-provided max_tmds_char_rate limit (165 MHz) takes
+ * precedence over a permissive .tmds_char_rate_valid() driver hook and
+ * drm_hdmi_connector_mode_valid() will reject modes whose computed TMDS
+ * character exceeds the connector limit.
+ */
+static void
+drm_test_check_mode_valid_connector_max_tmds_char_rate_precedes_driver_hook(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+					&reject_over_165mhz_connector_hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 2048);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 1152);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 162000);
+}
+
+/*
+ * Test that a connector-provided max_tmds_char_rate (165 MHz) can be further
+ * limited by a more restrictive (100 MHz) .tmds_char_rate_valid() driver hook
+ * and drm_hdmi_connector_mode_valid() will reject modes whose computed TMDS
+ * character exceeds the hook limit.
+ */
+static void
+drm_test_check_mode_valid_driver_hook_limits_connector_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = reject_100mhz_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
+	hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, &hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 1440);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 900);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 88750);
+}
+
 /*
  * Test that drm_hdmi_connector_mode_valid() will accept modes that require a
  * 4:2:0 chroma subsampling, even if said mode would violate maximum clock
@@ -2843,6 +2956,9 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_mode_valid_tests[] = {
 	KUNIT_CASE(drm_test_check_mode_valid_reject),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_rate),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_max_clock),
+	KUNIT_CASE(drm_test_check_mode_valid_reject_inferred_max_tmds_char_rate),
+	KUNIT_CASE(drm_test_check_mode_valid_connector_max_tmds_char_rate_precedes_driver_hook),
+	KUNIT_CASE(drm_test_check_mode_valid_driver_hook_limits_connector_max_tmds_char_rate),
 	KUNIT_CASE(drm_test_check_mode_valid_yuv420_only_max_clock),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_yuv420_only_connector),
 	KUNIT_CASE(drm_test_check_mode_valid_accept_yuv420_also_connector_rgb),

-- 
2.55.0

