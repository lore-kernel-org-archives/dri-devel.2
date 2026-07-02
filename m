Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F10810F426;
	Thu,  2 Jul 2026 14:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l1njuegi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B422210F420
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003615;
 bh=ErNbqFbp7a4/yqeZSy6M5+9biF0lii/908gxc+ojHhA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=l1njuegi+Se0r7l29lVASUMtUQY61RBVLd5ImrY70KhMXltgY7lGOszoOEaqaQCFK
 fHQ0GolzM4WVVF6HbgUYUMQdpmHev2nWbUseffC/s2r6p3n6OHWNa+uNVOuzxrVlIL
 XAy4H93LH28B8C6PvsiA/v1UjpTF32nDRv/RO7JNsU1NoeluptYeDLyeta/qRfMFIn
 22ocxML4/GUNmCDd5iJ314m/VKMLBQjeHVammJAO78DKv8n2ldzDPWsV2le/LeA7FQ
 17b/wWs/D1HSKbyBhqSoJAAVrq9qcpAI7eGOxB1fV/+DOkwajLwKs9vlHqg0liyOft
 5jSat+1EC4H9w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5835617E3670;
 Thu,  2 Jul 2026 16:46:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:45 +0300
Subject: [PATCH v8 32/39] drm/tests: connector: Add HDMI caps-based init
 coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-32-d79890d00b6a@collabora.com>
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

Add KUnit tests for drmm_connector_hdmi_init_with_caps() covering NULL
caps rejection, the max_tmds_char_rate inferred from each advertised
HDMI specification version, and the validation of a driver-provided
max_tmds_char_rate against the version-inferred limit: override below,
accept at, reject above, reject when no version is advertised.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 189 +++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index beb1d50a6646..1fb1d83aec1a 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -1254,6 +1254,188 @@ KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_invalid,
 		  drm_connector_hdmi_init_type_invalid_tests,
 		  drm_connector_hdmi_init_type_desc);
 
+/*
+ * Test that the registration of an HDMI connector with a NULL caps fails.
+ */
+static void drm_test_connector_hdmi_init_null_caps(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 NULL);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
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
+	const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case *param =
+		test->param_value;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = param->ver,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+	};
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs_scrambler,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 &caps);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			param->expected);
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
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_2_0,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+		.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ,
+	};
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs_scrambler,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 &caps);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate equal to the version-inferred limit succeeds.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_at_limit(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_2_0,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+		.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
+	};
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs_scrambler,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 &caps);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate that exceeds the limit inferred from the advertised HDMI
+ * specification version fails.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_exceeds(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_1_4,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+		.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
+	};
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 &caps);
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
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_UNKNOWN,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+		.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
+	};
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 &caps);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
 static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_8),
@@ -1278,6 +1460,13 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 			 drm_connector_hdmi_init_type_valid_gen_params),
 	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_invalid,
 			 drm_connector_hdmi_init_type_invalid_gen_params),
+	KUNIT_CASE(drm_test_connector_hdmi_init_null_caps),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_max_tmds_rate_inferred,
+			 drm_connector_hdmi_init_max_tmds_rate_inferred_gen_params),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_override),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_at_limit),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_exceeds),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_no_version),
 	{ }
 };
 

-- 
2.54.0

