Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135AC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441EA10F331;
	Fri, 31 Jul 2026 16:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mvemhppV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B94810F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514802;
 bh=MH/ZHTbxAU/pfRYI8iynv05E3beofFeSEJS/oxNVJv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mvemhppV2VEH18QNjNAF2n+Rb8qZb/hZ7IifFbqEYd3cOKS2FcPuVuiVvkJRc8wRR
 XWjhjyqirGUOrGcETm247YpEvOfrAJze3yAq2i3oQaumGrJu4QV+G805e8kbXGPcoz
 WFUh/YWkI2WyF0nP7lBMJZNmhZz0LWbnTCrw4c8My4N8KER5ce/LJV6/883XijFnKn
 SrWYiar2HkrnTRLW+Ycowr2vLoDNarPAHaAtDGdhy+stM7kZZNsZ0wjrowtG/do8dq
 G1D/ceVGXENgDDIyWnEFWugjSr1cGCDq/BQiieFoCzZwdl8rNMg/nJsJ5Ubr9TupI1
 DUX9U0D/qHsag==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 441B917E0B79;
 Fri, 31 Jul 2026 18:20:02 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:14 +0300
Subject: [PATCH v10 67/69] drm/connector: Drop redundant hdmi
 vendor/product fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-67-294364b2cf15@collabora.com>
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
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Diederik de Haas <diederik@cknow-tech.com>
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

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, vendor and product are provided through struct
drm_connector_hdmi_funcs, a reference to which is already stored in
drm_connector_hdmi.

Drop the redundant fields from drm_connector_hdmi and point its users to
hdmi.funcs->vendor and hdmi.funcs->product instead.

This allows simplifying the related connector registration tests by
getting rid of the now unnecessary KUNIT_EXPECT_MEMEQ() checks.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +--
 drivers/gpu/drm/drm_connector.c                 |  4 ---
 drivers/gpu/drm/tests/drm_connector_test.c      | 41 +++----------------------
 include/drm/drm_connector.h                     | 14 ++-------
 4 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 04c9e06b9dc1..83a8fcb41343 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -784,8 +784,8 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 		return 0;
 
 	ret = hdmi_spd_infoframe_init(frame,
-				      connector->hdmi.vendor,
-				      connector->hdmi.product);
+				      connector->hdmi.funcs->vendor,
+				      connector->hdmi.funcs->product);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b2e8d99c0e9a..f5f38dc4bfa6 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -656,10 +656,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 		connector->hdmi.max_tmds_char_rate = hdmi_funcs->supported_tmds_char_rate;
 	}
 
-	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
-	strtomem_pad(connector->hdmi.vendor, hdmi_funcs->vendor, 0);
-	strtomem_pad(connector->hdmi.product, hdmi_funcs->product, 0);
-
 	/*
 	 * drm_connector_attach_max_bpc_property() requires the
 	 * connector to have a state.
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 3d8500ad8be9..42f804500de6 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -771,14 +771,11 @@ static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
 
 /*
  * Test that the registration of a connector with a valid, shorter than
- * the max length, product name succeeds, and is stored padded with 0.
+ * the max length, product name succeeds.
  */
 static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
-		'P', 'r', 'o', 'd',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -793,25 +790,15 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.product,
-			   expected_product,
-			   sizeof(priv->connector.hdmi.product));
 }
 
 /*
  * Test that the registration of a connector with a valid, at max
- * length, product name succeeds, and is stored padded without any
- * trailing \0.
+ * length, product name succeeds.
  */
 static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
-		'P', 'r', 'o', 'd', 'u', 'c', 't',
-		'P', 'r', 'o', 'd', 'u', 'c', 't',
-		'P', 'r',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -826,10 +813,6 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.product,
-			   expected_product,
-			   sizeof(priv->connector.hdmi.product));
 }
 
 /*
@@ -857,14 +840,11 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 
 /*
  * Test that the registration of a connector with a vendor name smaller
- * than the maximum length succeeds, and is stored padded with zeros.
+ * than the maximum length succeeds.
  */
 static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
-		'V', 'e', 'n', 'd',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -879,24 +859,15 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.vendor,
-			   expected_vendor,
-			   sizeof(priv->connector.hdmi.vendor));
 }
 
 /*
  * Test that the registration of a connector with a vendor name at the
- * maximum length succeeds, and is stored padded without the trailing
- * zero.
+ * maximum length succeeds.
  */
 static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
-		'V', 'e', 'n', 'd', 'o', 'r',
-		'V', 'e',
-	};
 	int ret;
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
@@ -911,10 +882,6 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.vendor,
-			   expected_vendor,
-			   sizeof(priv->connector.hdmi.vendor));
 }
 
 /*
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ad8d1611e84..f7627de624de 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1418,11 +1418,13 @@ struct drm_connector_infoframe_funcs {
  * and controller capabilities
  */
 struct drm_connector_hdmi_funcs {
+#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
 	/**
 	 * @vendor: HDMI Controller Vendor name.
 	 */
 	const char *vendor;
 
+#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
 	/**
 	 * @product: HDMI Controller Product name
 	 */
@@ -2123,18 +2125,6 @@ struct drm_connector_hdmi_audio {
  * struct drm_connector_hdmi - DRM Connector HDMI-related structure
  */
 struct drm_connector_hdmi {
-#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
-	/**
-	 * @vendor: HDMI Controller Vendor Name
-	 */
-	unsigned char vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] __nonstring;
-
-#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
-	/**
-	 * @product: HDMI Controller Product Name
-	 */
-	unsigned char product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] __nonstring;
-
 	/**
 	 * @supported_formats: Bitmask of @drm_output_color_format
 	 * supported by the controller.

-- 
2.55.0

