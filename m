Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2386BC55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D89C10F31D;
	Fri, 31 Jul 2026 16:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="N7Myzy1d";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24BC10F315
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514798;
 bh=wy7odb4Bzb//d8gJuSExcEjuuO+HCRVariqZb2J3yPk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=N7Myzy1dn3sfcKWX03ftfv9R2xoj2i41t4q4D2YUWZfAn8rVWX4Z2J6RMPbnYDIAY
 2P+B4tSNehhtTHV1QLBJKQ1n3uzjoQY7Au73hDY8wsNojXZ0nmrwfoUT7lAWIsmGha
 82BOtbj2ncxRsEkNCRpS8RyI7Se7Vs/HciHAMnb1j83NP9RbQg1G/sipOTzu8W6A6u
 XhTrcZlkf89eoNkFrnDFCMzb0lEtxPvqmuragAgOmdsu6NHX+Z2Tx3jWMhJY0Y9wl2
 7a9s2r4kc3zQJl+ryyTvWQElsikzEKXM3ukzZJYV6tvgNhpjtcK5/kxOyhPu1TweYR
 BgMDMdxERHPsw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 14FDD17E0972;
 Fri, 31 Jul 2026 18:19:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:08 +0300
Subject: [PATCH v10 61/69] drm/tests: connector: Add HDMI
 max_tmds_char_rate init coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-61-294364b2cf15@collabora.com>
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

Add KUnit tests for the new drmm_connector_hdmi_init() extension, which
infers the connector's max_tmds_char_rate from the HDMI specification
version advertised by the driver.  Also validate a driver-capped
max_tmds_char_rate against the version-inferred limit: override below,
accept at, reject above, reject when no version is advertised.

Since HDMI_VERSION_2_0 requires scrambler callbacks to be provided, add
a dummy_hdmi_funcs_scrambler instance for tests that initialize HDMI 2.0
connectors.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 179 +++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index c53ccce21a42..17242d1c1b16 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -54,6 +54,34 @@ static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
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
+static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs_scrambler = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_2_0,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.scrambler_enable = accept_scrambler_enable,
+	.scrambler_disable = accept_scrambler_disable,
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
 static const struct drm_connector_funcs dummy_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
@@ -1244,6 +1272,151 @@ KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_invalid,
 		  drm_connector_hdmi_init_type_invalid_tests,
 		  drm_connector_hdmi_init_type_desc);
 
+/*
+ * Test that the registration of an HDMI connector without an explicit max TMDS
+ * character rate being provided succeeds, and the connector limit is inferred
+ * from the advertised HDMI specification version.
+ */
+struct drm_connector_hdmi_init_max_tmds_rate_inferred_case {
+	const char *desc;
+	enum hdmi_version ver;
+	unsigned long long expected;
+};
+
+static void drm_test_connector_hdmi_init_max_tmds_rate_inferred(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case *params =
+		test->param_value;
+	int ret;
+
+	priv->hdmi_funcs = params->ver < HDMI_VERSION_2_0 ?
+				dummy_hdmi_funcs : dummy_hdmi_funcs_scrambler;
+	priv->hdmi_funcs.supported_hdmi_ver = params->ver;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			params->expected);
+}
+
+static const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case
+drm_connector_hdmi_init_max_tmds_rate_inferred_tests[] = {
+	{ "unknown",	HDMI_VERSION_UNKNOWN,	0 },
+	{ "1.0",	HDMI_VERSION_1_0,	HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.2",	HDMI_VERSION_1_2,	HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.3",	HDMI_VERSION_1_3,	HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.4",	HDMI_VERSION_1_4,	HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ },
+	{ "2.0",	HDMI_VERSION_2_0,	HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ },
+};
+
+static void drm_connector_hdmi_init_max_tmds_rate_inferred_desc(
+	const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case *t,
+	char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_max_tmds_rate_inferred,
+		  drm_connector_hdmi_init_max_tmds_rate_inferred_tests,
+		  drm_connector_hdmi_init_max_tmds_rate_inferred_desc);
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate strictly below the version-inferred limit succeeds, and
+ * the connector limit is overridden.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_override(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_4;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate equal to the version-inferred limit succeeds.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_at_limit(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_2;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate that exceeds the limit inferred from the advertised HDMI
+ * specification version fails.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_off_limit(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_2;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a non-zero max
+ * TMDS character rate without an HDMI specification version fails, as the
+ * version-inferred limit defaults to zero and any positive override would
+ * exceed it.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_no_version(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_UNKNOWN;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
 static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_8),
@@ -1268,6 +1441,12 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 			 drm_connector_hdmi_init_type_valid_gen_params),
 	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_invalid,
 			 drm_connector_hdmi_init_type_invalid_gen_params),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_max_tmds_rate_inferred,
+			 drm_connector_hdmi_init_max_tmds_rate_inferred_gen_params),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_override),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_at_limit),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_off_limit),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_no_version),
 	{ }
 };
 

-- 
2.55.0

