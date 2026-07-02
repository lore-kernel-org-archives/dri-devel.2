Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB1AC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245A110F427;
	Thu,  2 Jul 2026 14:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Uz/p2Q3V";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D0610F420
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003616;
 bh=CtjDvOeAZOsLs4Pmr/tmwSBx04CYvSQXcT3mxMu5k9U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Uz/p2Q3Vi+VoB7sC8MqJsfFK+5beDxBN/T4i/Dhpb0BnSeH6d5kUwY7mOGxgFJ+0Y
 Dqx8SQs9cc/NopJhk/7HcJn9mDUrABR9Arj7eCPnU6OT7u2Pwg7G/oqrJ+pYZRYeR8
 VOsWZ3VM3SA+6Ve+rWotiQ/1LKws7WlX0WerJr265JnyWx2Pj8m6S+CK5Z5a/3nEdZ
 0Gr9eCLno0+IwLqjlkUOZtl+WTcUTqG2ALmMPpt7nS3m6sedwxNQBmbqe11XaBqMVj
 VFAlFdHDeFxFBoTRYt54Yd154nlrvOZZ59Jv/vd8dhGiGEt6XZ/4oHv2QjJEWL0nnu
 tThlC5ymka4CA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1502017E3676;
 Thu,  2 Jul 2026 16:46:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:46 +0300
Subject: [PATCH v8 33/39] drm/tests: connector: Add HDMI source-side
 scrambler coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-33-d79890d00b6a@collabora.com>
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

Add KUnit tests for the HDMI source-side scrambling validation done by
drmm_connector_hdmi_init_with_caps().

Connector initialization derives the scrambler_supported flag from the
driver-provided supported_hdmi_ver capability. If it indicates
source-side scrambling support, both .scrambler_enable and
.scrambler_disable must be provided. Missing either callback is
rejected. If source-side scrambling is not supported, the callbacks are
ignored.

Test the valid and invalid callback combinations for both supported and
unsupported scrambling configurations.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 141 +++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 1fb1d83aec1a..98ccfaa0ee36 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -47,6 +47,41 @@ static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
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
+static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs_scrambler_partial = {
+	.scrambler_enable = accept_scrambler_enable,
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
@@ -1436,6 +1471,108 @@ static void drm_test_connector_hdmi_init_max_tmds_rate_no_version(struct kunit *
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
+/*
+ * Test that the registration of an HDMI connector advertising source-side
+ * scrambling support succeeds when the .scrambler_{enable|disable} callbacks
+ * are provided.
+ */
+static void drm_test_connector_hdmi_init_scrambler_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_2_0,
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
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.scrambler_supported, true);
+}
+
+/*
+ * Test that the registration of an HDMI connector advertising source-side
+ * scrambling support fails when the .scrambler_{enable|disable} callbacks
+ * are not provided.
+ */
+static void drm_test_connector_hdmi_init_scrambler_no_callbacks(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_2_0,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
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
+ * Test that the registration of an HDMI connector advertising source-side
+ * scrambling support fails when only one of the .scrambler_{enable|disable}
+ * callbacks are provided.
+ */
+static void drm_test_connector_hdmi_init_scrambler_partial_callbacks(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_2_0,
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+	};
+	int ret;
+
+	ret = drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
+						 "Vendor", "Product",
+						 &dummy_funcs,
+						 &dummy_hdmi_funcs_scrambler_partial,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 &priv->ddc,
+						 &caps);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+/*
+ * Test that the registration of an HDMI connector not advertising source-side
+ * scrambling support succeeds, even when the .scrambler_{enable|disable}
+ * callbacks are provided, i.e. they are ignored.
+ */
+static void drm_test_connector_hdmi_init_scrambler_ignored_callbacks(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_hdmi_ver = HDMI_VERSION_1_4,
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
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.scrambler_supported, false);
+}
+
 static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_8),
@@ -1467,6 +1604,10 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_at_limit),
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_exceeds),
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_no_version),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_valid),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_no_callbacks),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_partial_callbacks),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_ignored_callbacks),
 	{ }
 };
 

-- 
2.54.0

