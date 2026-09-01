Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A70BC624D7
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC8D10EE3B;
	Tue,  1 Sep 2026 18:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EH1WX56Y";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0C110EE1A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288643;
 bh=nHF7ah8DhllkGyPFaZKYG+5+SyGoITGvhAy3lSzzjOc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EH1WX56Y/cRkZ+zfEyid4VoErdk7k3XueFJI1sTp6/Pisyft0WlTAkLN6c8SHI/GY
 OE+0ybb9TxyCbjlBVC4vS4tPhEo69HypcdK4cQzXpa9nDLGaQSUxrHkZsauE/mnBYw
 yRnk0ijF8civJBJ4EIY7D986Wv6YIL9bON8DSkzX2XbmfQ/Iy1Lu9sSRaThdO2aF3s
 EUb5xWxg08zuTc+7vqQ7SFeLp2Il6G93UUWLzxv+miLo/C5D9F6CiCfjEog6k02iYo
 rts91lGLRO1d+uMlj3QCmixqz2QUkhWfpVzNKH9ghy64snPflHE/0Wme7mXnAz2ZAT
 419/81XeIib/w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5593817E0FC6;
 Tue, 01 Sep 2026 20:50:43 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:27 +0300
Subject: [PATCH v11 03/74] drm/display: hdmi: Rename
 drmm_connector_hdmi_init() to *_ini2()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-3-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
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

In preparation for changing the signature of drmm_connector_hdmi_init(),
i.e. dropping the vendor, product, supported_formats and max_bpc
arguments, which are being moved into struct drm_connector_hdmi_funcs,
temporarily rename the helper to drmm_connector_hdmi_ini2().

This lets the new signature be introduced under the original name while
callers are converted incrementally.  The final patch removes *_ini2()
once no callers remain.

This is a mechanical, same-length rename performed with sed:

  $ git grep -l 'drmm_connector_hdmi_init' -- '*.[ch]' \
    | xargs sed -i 's/drmm_connector_hdmi_init/drmm_connector_hdmi_ini2/g'

The transitional name matches the original's length so continuation-line
arguments stay aligned to the opening parenthesis, keeping the diff to
the identifier itself and avoiding re-alignment churn here and in the
later conversions.

No functional change intended.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c     |  2 +-
 drivers/gpu/drm/drm_connector.c                    |  6 ++--
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  2 +-
 drivers/gpu/drm/tests/drm_connector_test.c         | 42 +++++++++++-----------
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  2 +-
 include/drm/drm_connector.h                        |  2 +-
 7 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 00feb73e63d7..d664237936ec 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -1013,7 +1013,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
-		ret = drmm_connector_hdmi_init(drm, connector,
+		ret = drmm_connector_hdmi_ini2(drm, connector,
 					       bridge_connector->bridge_hdmi->vendor,
 					       bridge_connector->bridge_hdmi->product,
 					       &drm_bridge_connector_funcs,
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 0e39431e85b2..5e520cff6094 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -543,7 +543,7 @@ int drmm_connector_init(struct drm_device *dev,
 EXPORT_SYMBOL(drmm_connector_init);
 
 /**
- * drmm_connector_hdmi_init - Init a preallocated HDMI connector
+ * drmm_connector_hdmi_ini2 - Init a preallocated HDMI connector
  * @dev: DRM device
  * @connector: A pointer to the HDMI connector to init
  * @vendor: HDMI Controller Vendor name
@@ -568,7 +568,7 @@ EXPORT_SYMBOL(drmm_connector_init);
  * Returns:
  * Zero on success, error code on failure.
  */
-int drmm_connector_hdmi_init(struct drm_device *dev,
+int drmm_connector_hdmi_ini2(struct drm_device *dev,
 			     struct drm_connector *connector,
 			     const char *vendor, const char *product,
 			     const struct drm_connector_funcs *funcs,
@@ -646,7 +646,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(drmm_connector_hdmi_init);
+EXPORT_SYMBOL(drmm_connector_hdmi_ini2);
 
 /**
  * drm_connector_attach_edid_property - attach edid property.
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 91844a396a2b..d98b6f12a7bc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -654,7 +654,7 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 	drm_connector_helper_add(&hdmi->connector,
 				 &sun4i_hdmi_connector_helper_funcs);
-	ret = drmm_connector_hdmi_init(drm, &hdmi->connector,
+	ret = drmm_connector_hdmi_ini2(drm, &hdmi->connector,
 				       /*
 					* NOTE: Those are likely to be
 					* wrong, but I couldn't find the
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index beb1d50a6646..3368aedd4e66 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -669,7 +669,7 @@ static void drm_test_connector_hdmi_init_valid(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -689,7 +689,7 @@ static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -709,7 +709,7 @@ static void drm_test_connector_hdmi_init_null_vendor(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       NULL, "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -729,7 +729,7 @@ static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", NULL,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -755,7 +755,7 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 
 	KUNIT_ASSERT_LT(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", product_name,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -788,7 +788,7 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 
 	KUNIT_ASSERT_EQ(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", product_name,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -815,7 +815,7 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 
 	KUNIT_ASSERT_GT(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", product_name,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -841,7 +841,7 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 
 	KUNIT_ASSERT_LT(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       vendor_name, "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -873,7 +873,7 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 
 	KUNIT_ASSERT_EQ(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       vendor_name, "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -900,7 +900,7 @@ static void drm_test_connector_hdmi_init_vendor_length_too_long(struct kunit *te
 
 	KUNIT_ASSERT_GT(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       vendor_name, "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -920,7 +920,7 @@ static void drm_test_connector_hdmi_init_bpc_invalid(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -940,7 +940,7 @@ static void drm_test_connector_hdmi_init_bpc_null(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -965,7 +965,7 @@ static void drm_test_connector_hdmi_init_bpc_8(struct kunit *test)
 	uint64_t val;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1006,7 +1006,7 @@ static void drm_test_connector_hdmi_init_bpc_10(struct kunit *test)
 	uint64_t val;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1047,7 +1047,7 @@ static void drm_test_connector_hdmi_init_bpc_12(struct kunit *test)
 	uint64_t val;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1083,7 +1083,7 @@ static void drm_test_connector_hdmi_init_formats_empty(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1103,7 +1103,7 @@ static void drm_test_connector_hdmi_init_formats_no_rgb(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1161,7 +1161,7 @@ static void drm_test_connector_hdmi_init_formats_yuv420_allowed(struct kunit *te
 	params = test->param_value;
 	priv->connector.ycbcr_420_allowed = params->yuv420_allowed;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1182,7 +1182,7 @@ static void drm_test_connector_hdmi_init_type_valid(struct kunit *test)
 	unsigned int connector_type = *(unsigned int *)test->param_value;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1217,7 +1217,7 @@ static void drm_test_connector_hdmi_init_type_invalid(struct kunit *test)
 	unsigned int connector_type = *(unsigned int *)test->param_value;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
@@ -1494,7 +1494,7 @@ static void drm_test_drm_connector_attach_broadcast_rgb_property_hdmi_connector(
 	struct drm_property *prop;
 	int ret;
 
-	ret = drmm_connector_hdmi_init(&priv->drm, connector,
+	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
 				       "Vendor", "Product",
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 353a261d42da..4c2a400bc15a 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -275,7 +275,7 @@ __connector_hdmi_init(struct kunit *test,
 	conn = &priv->connector;
 	conn->ycbcr_420_allowed = !!(formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 
-	ret = drmm_connector_hdmi_init(drm, conn,
+	ret = drmm_connector_hdmi_ini2(drm, conn,
 				       "Vendor", "Product",
 				       &dummy_connector_funcs,
 				       hdmi_funcs,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index ea1f2013b20e..5bb508a87b40 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -542,7 +542,7 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	if (vc4_hdmi->variant->supports_hdr)
 		max_bpc = 12;
 
-	ret = drmm_connector_hdmi_init(dev, connector,
+	ret = drmm_connector_hdmi_ini2(dev, connector,
 				       "Broadcom", "Videocore",
 				       &vc4_hdmi_connector_funcs,
 				       &vc4_hdmi_hdmi_connector_funcs,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c61345e6fb08..f039bb8acf10 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2616,7 +2616,7 @@ int drmm_connector_init(struct drm_device *dev,
 			const struct drm_connector_funcs *funcs,
 			int connector_type,
 			struct i2c_adapter *ddc);
-int drmm_connector_hdmi_init(struct drm_device *dev,
+int drmm_connector_hdmi_ini2(struct drm_device *dev,
 			     struct drm_connector *connector,
 			     const char *vendor, const char *product,
 			     const struct drm_connector_funcs *funcs,

-- 
2.55.0

