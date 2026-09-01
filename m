Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA092C624D7
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677EE10EE87;
	Tue,  1 Sep 2026 18:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NGix7IFy";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EDB10EE7D
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288688;
 bh=FrhjuUNCO81qN+N5ecDEgIGCe7yPo+Baimk/ZGvUvTY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NGix7IFylzprYXGkOGaW2G0REydz1DhDuNPTsROIM8iHaD6S5HP7xPb3YOAVt2IGB
 czFOlP4OH0a5gDtVx7Oh6Q0F4+u7AzVJ/B4DELlNOO0lQdrf7n/ElldA/uoQHwIFk9
 Yg81mcHRMGcbPIdUZunIZBh+LqF02dhuwJNvDCmWyicjoabp5RvsRaVH5jbianOYaT
 pQZcuxgvtP7Z2sG66QeyJivfxJRm5lQ4asVGZL0HATixyH2QrHtkENn5jOnMVQx/Ly
 uq07ejBWG5qkp9F8Zq5ZnMsoPL+c+SwACoI6OXG4uLU4aq681yf8Yv/Fso1mGJ2YAO
 hSdwpI28Zui4w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 223CA17E3C95;
 Tue, 01 Sep 2026 20:51:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:28 +0300
Subject: [PATCH v11 64/74] drm/tests: connector: Add HDMI source-side
 scrambler coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-64-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org
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
the new drmm_connector_hdmi_init() helper.

Connector initialization derives scrambler support from the
driver-provided supported_hdmi_ver capability.  Therefore, connectors
that advertise HDMI 2.0 or later must provide both .scrambler_enable()
and .scrambler_disable() callbacks.  Registration is rejected if either
callback is missing.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 102 +++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 17242d1c1b16..0613568ef5b7 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -1417,6 +1417,104 @@ static void drm_test_connector_hdmi_init_max_tmds_rate_no_version(struct kunit *
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
+/*
+ * Test that the registration of an HDMI connector advertising HDMI 2.0 support
+ * succeeds when the .scrambler_{enable,disable} callbacks are provided.
+ */
+static void drm_test_connector_hdmi_init_scrambler_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs_scrambler,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, drm_connector_hdmi_scrambler_supported(&priv->connector));
+}
+
+/*
+ * Test that the registration of an HDMI connector not advertising HDMI 2.0
+ * support succeeds, and the connector is not reported as scrambling capable.
+ */
+static void drm_test_connector_hdmi_init_scrambler_unsupported(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, drm_connector_hdmi_scrambler_supported(&priv->connector));
+}
+
+enum drm_connector_hdmi_scrambler_cb {
+	SCRAMBLER_CALLBACK_ENABLE,
+	SCRAMBLER_CALLBACK_DISABLE,
+	SCRAMBLER_CALLBACK_ALL,
+};
+
+struct drm_connector_hdmi_init_scrambler_missing_cb_case {
+	const char *desc;
+	enum drm_connector_hdmi_scrambler_cb cb;
+};
+
+/*
+ * Test that the registration of an HDMI connector advertising HDMI 2.0 support
+ * fails when any single .scrambler_* callback is missing.
+ */
+static void drm_test_connector_hdmi_init_scrambler_missing_cb(struct kunit *test)
+{
+	const struct drm_connector_hdmi_init_scrambler_missing_cb_case *params = test->param_value;
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs_scrambler;
+
+	switch (params->cb) {
+	case SCRAMBLER_CALLBACK_ENABLE:
+		priv->hdmi_funcs.scrambler_enable = NULL;
+		break;
+	case SCRAMBLER_CALLBACK_DISABLE:
+		priv->hdmi_funcs.scrambler_disable = NULL;
+		break;
+	case SCRAMBLER_CALLBACK_ALL:
+		priv->hdmi_funcs.scrambler_enable = NULL;
+		priv->hdmi_funcs.scrambler_disable = NULL;
+		break;
+	}
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+static const struct drm_connector_hdmi_init_scrambler_missing_cb_case
+drm_connector_hdmi_init_scrambler_missing_cb_tests[] = {
+	{ "scrambler_enable",	SCRAMBLER_CALLBACK_ENABLE },
+	{ "scrambler_disable",	SCRAMBLER_CALLBACK_DISABLE },
+	{ "scrambler_*",	SCRAMBLER_CALLBACK_ALL },
+};
+
+static void
+drm_connector_hdmi_init_scrambler_missing_cb_desc(const struct drm_connector_hdmi_init_scrambler_missing_cb_case *t,
+						  char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_scrambler_missing_cb,
+		  drm_connector_hdmi_init_scrambler_missing_cb_tests,
+		  drm_connector_hdmi_init_scrambler_missing_cb_desc);
+
 static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_8),
@@ -1447,6 +1545,10 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_at_limit),
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_off_limit),
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_no_version),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_valid),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_unsupported),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_scrambler_missing_cb,
+			 drm_connector_hdmi_init_scrambler_missing_cb_gen_params),
 	{ }
 };
 

-- 
2.55.0

