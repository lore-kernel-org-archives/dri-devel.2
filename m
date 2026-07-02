Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678B6C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A1C10F429;
	Thu,  2 Jul 2026 14:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="c8gYdzJK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA2F10F420
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003617;
 bh=2nxPpRr0flrGE7hSOuNVa4V/V3MS4CEdYR5bHb19ASY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=c8gYdzJKAXWgLpLje16loYg2FHWsu/T9v7OEYO+zIssXLlj+skjbHT/cxaDoh6ZWM
 4vT5y2MgKo65qZy8UEgjtCkpK6+pgsPFHNF7NYW7aB0WcWQ6yhy/TO2kq1iAigB1CI
 s9f/NtXXPvPETVU6W/oVt+rUjLUb7gwlR83L0lcembcUSN4x003RT2YnqmMsXXF0dd
 6VNNR0XDywCbHcGLs35jl3g2B02pGcXn10IL1uhQun4wNkz9C6P6TEBM9jJCeTESkz
 tMU79OTUW3RS7ROdWLDPkrdhe3tHJfWEb88SlsIJ16h4f6MYNVdN1y3e8/uXE4iNlb
 cOp10m4tCiAzA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8720D17E367D;
 Thu,  2 Jul 2026 16:46:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:48 +0300
Subject: [PATCH v8 35/39] drm/tests: hdmi_state_helper: Add
 max_tmds_char_rate fallback tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-35-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
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

Cover the fallback in hdmi_clock_valid() that rejects modes whose TMDS
character rate exceeds connector->hdmi.max_tmds_char_rate when the
driver provides no .tmds_char_rate_valid() callback. Exercise both an
explicit limit set through drm_connector_hdmi_caps and the limit
inferred from caps.supported_hdmi_ver, and confirm that a driver hook
takes precedence over the connector limit.

The connector limit is installed via the new
drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs() helper so it
is in place before mode probing runs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 6a7dd2de002a..b8ae5fad2794 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -174,6 +174,26 @@ static const struct drm_connector_hdmi_funcs reject_100mhz_connector_hdmi_funcs
 	},
 };
 
+static enum drm_mode_status
+accept_connector_tmds_char_rate_valid(const struct drm_connector *connector,
+				      const struct drm_display_mode *mode,
+				      unsigned long long tmds_rate)
+{
+	return MODE_OK;
+}
+
+static const struct drm_connector_hdmi_funcs accept_connector_hdmi_funcs = {
+	.tmds_char_rate_valid	= accept_connector_tmds_char_rate_valid,
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
@@ -2771,6 +2791,103 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, preferred->clock, 25200);
 }
 
+/*
+ * Test that a driver-provided .tmds_char_rate_valid() hook takes precedence
+ * over the connector->hdmi.max_tmds_char_rate fallback: the fallback must
+ * not be consulted when the hook is present.
+ */
+static void
+drm_test_check_mode_valid_driver_hook_overrides_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_1_3,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+		.max_tmds_char_rate = 100ULL * 1000 * 1000,
+	};
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs(test,
+					&caps,
+					&accept_connector_hdmi_funcs,
+					test_edid_hdmi_1080p_rgb_max_200mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 1080);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 148500);
+}
+
+/*
+ * Test that drm_hdmi_connector_mode_valid() falls back to
+ * connector->hdmi.max_tmds_char_rate when the driver provides no
+ * .tmds_char_rate_valid() hook, rejecting modes whose computed TMDS character
+ * rate exceeds the connector limit.
+ */
+static void
+drm_test_check_mode_valid_reject_connector_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_1_3,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+		.max_tmds_char_rate = 100ULL * 1000 * 1000,
+	};
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs(test,
+					&caps,
+					&dummy_connector_hdmi_funcs,
+					test_edid_hdmi_1080p_rgb_max_200mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 640);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 480);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 25200);
+}
+
+/*
+ * Test that the max_tmds_char_rate inferred from caps.supported_hdmi_ver
+ * is applied as a mode-filtering limit: with an HDMI 1.3 connector
+ * (340 MHz inferred cap) and no driver hook, modes whose RGB444/8bpc TMDS
+ * rate exceeds 340 MHz must be filtered out even though the sink itself
+ * advertises a higher limit.
+ */
+static void
+drm_test_check_mode_valid_reject_inferred_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_1_3,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+	};
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+	unsigned long long rate;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs(test,
+					&caps,
+					&dummy_connector_hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	rate = drm_hdmi_compute_mode_clock(preferred, 8,
+					   DRM_OUTPUT_COLOR_FORMAT_RGB444);
+	KUNIT_EXPECT_LE(test, rate, HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+}
+
 /*
  * Test that drm_hdmi_connector_mode_valid() will accept modes that require a
  * 4:2:0 chroma subsampling, even if said mode would violate maximum clock
@@ -2865,6 +2982,9 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_mode_valid_tests[] = {
 	KUNIT_CASE(drm_test_check_mode_valid_reject),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_rate),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_max_clock),
+	KUNIT_CASE(drm_test_check_mode_valid_driver_hook_overrides_max_tmds_char_rate),
+	KUNIT_CASE(drm_test_check_mode_valid_reject_connector_max_tmds_char_rate),
+	KUNIT_CASE(drm_test_check_mode_valid_reject_inferred_max_tmds_char_rate),
 	KUNIT_CASE(drm_test_check_mode_valid_yuv420_only_max_clock),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_yuv420_only_connector),
 	KUNIT_CASE(drm_test_check_mode_valid_accept_yuv420_also_connector_rgb),

-- 
2.54.0

