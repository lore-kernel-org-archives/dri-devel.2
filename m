Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AF606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AGDULavA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E86B10F096;
	Sat, 14 Nov 2026 18:04:47 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BEAB10E5D7
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679461;
 bh=TOwfrjb5a8voVgttZd5owHGILFcRqRXxlCE7Ed2Acfc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AGDULavA77Y8TQ1g1neJZi28ecSjjGR5vaBJAfE5AK5XYGh+ztIZfKm+DRvBJRWaR
 9LDILuSJ7uf2AEbleaVoZww0rrCYpKYfClSZW11PXoFV8VYnlt7VUG5EnHehzQf9QZ
 l87oEGquAKCvBhcKQtH/zrdpDMYqg343VUp9fs9yehW6EtZIBRxm7N4o1LwNKzhzHO
 QcnNnQAsNeCn+1Vg721V6602vksYdkr/AGw5HdJdtFvCMr4CC/hgC/2tMknadOtNd9
 X09ONHT3wlxW7YuptJMm+Y2xIQid2qlxFhR44mHRxVanplSZpgxzGZTBxXwHKQtTtt
 TmZzlq2SKI1yw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E8D4D17E125C;
 Sat, 14 Nov 2026 19:04:20 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:29 +0200
Subject: [PATCH 05/25] drm/tests: connector: Convert to
 drmm_connector_hdmi_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-5-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch tests over to the new drmm_connector_hdmi_init() signature, where
the vendor, product, supported_formats and max_bpc values previously
passed as arguments are now provided through struct
drm_connector_hdmi_funcs.

As a consequence, the tests exercising those values can no longer share
the static dummy_hdmi_funcs and need a modified copy of their own.
Since the connector retains a pointer to it, such a copy must not be
placed on the stack, which is gone by the time the DRM-managed actions
release the connector.  Keep it in struct drm_connector_init_priv
instead: it embeds the DRM device and is only freed via
managed.final_kfree, i.e. once drm_dev_release() has run all DRM-managed
actions.

Note that a kunit_kzalloc() buffer would not be suitable, as KUnit
releases its resources in reverse order, hence one allocated by a test
would be freed before the DRM device allocated by the suite .init().

Since struct drm_connector_hdmi_funcs is now mandatory, as it carries
the HDMI controller capabilities, also verify that registering an HDMI
connector without it fails.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 269 +++++++++++++++--------------
 1 file changed, 137 insertions(+), 132 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 2856294bafda..354e3088cf0f 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -23,6 +23,8 @@ struct drm_connector_init_priv {
 	struct drm_device drm;
 	struct drm_connector connector;
 	struct i2c_adapter ddc;
+	/* Mutable copy of a static instance for test-specific overrides */
+	struct drm_connector_hdmi_funcs hdmi_funcs;
 };
 
 static int accept_infoframe_clear_infoframe(struct drm_connector *connector)
@@ -37,6 +39,11 @@ static int accept_infoframe_write_infoframe(struct drm_connector *connector,
 }
 
 static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.avi = {
 		.clear_infoframe = accept_infoframe_clear_infoframe,
 		.write_infoframe = accept_infoframe_write_infoframe,
@@ -669,14 +676,11 @@ static void drm_test_connector_hdmi_init_valid(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
@@ -689,17 +693,31 @@ static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       NULL,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/*
+ * Test that the registration of an HDMI connector without any HDMI
+ * functions and capabilities fails.
+ */
+static void drm_test_connector_hdmi_init_null_hdmi_funcs(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       NULL,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
 /*
  * Test that the registration of an HDMI connector with a NULL vendor
  * fails.
@@ -709,14 +727,14 @@ static void drm_test_connector_hdmi_init_null_vendor(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       NULL, "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.vendor = NULL;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -729,14 +747,14 @@ static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", NULL,
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.product = NULL;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -750,19 +768,19 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
 		'P', 'r', 'o', 'd',
 	};
-	const char *product_name = "Prod";
 	int ret;
 
-	KUNIT_ASSERT_LT(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.product = "Prod";
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", product_name,
+	KUNIT_ASSERT_LT(test, strlen(priv->hdmi_funcs.product),
+			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
 			   priv->connector.hdmi.product,
@@ -783,19 +801,19 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 		'P', 'r', 'o', 'd', 'u', 'c', 't',
 		'P', 'r',
 	};
-	const char *product_name = "ProductProductPr";
 	int ret;
 
-	KUNIT_ASSERT_EQ(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.product = "ProductProductPr";
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", product_name,
+	KUNIT_ASSERT_EQ(test, strlen(priv->hdmi_funcs.product),
+			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
 			   priv->connector.hdmi.product,
@@ -810,19 +828,19 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const char *product_name = "ProductProductProduct";
 	int ret;
 
-	KUNIT_ASSERT_GT(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.product = "ProductProductProduct";
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", product_name,
+	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.product),
+			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -836,19 +854,19 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
 		'V', 'e', 'n', 'd',
 	};
-	const char *vendor_name = "Vend";
 	int ret;
 
-	KUNIT_ASSERT_LT(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.vendor = "Vend";
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       vendor_name, "Product",
+	KUNIT_ASSERT_LT(test, strlen(priv->hdmi_funcs.vendor),
+			DRM_CONNECTOR_HDMI_VENDOR_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
 			   priv->connector.hdmi.vendor,
@@ -868,19 +886,19 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 		'V', 'e', 'n', 'd', 'o', 'r',
 		'V', 'e',
 	};
-	const char *vendor_name = "VendorVe";
 	int ret;
 
-	KUNIT_ASSERT_EQ(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.vendor = "VendorVe";
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       vendor_name, "Product",
+	KUNIT_ASSERT_EQ(test, strlen(priv->hdmi_funcs.vendor),
+			DRM_CONNECTOR_HDMI_VENDOR_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
 			   priv->connector.hdmi.vendor,
@@ -895,19 +913,17 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 static void drm_test_connector_hdmi_init_vendor_length_too_long(struct kunit *test)
 {
 	struct drm_connector_init_priv *priv = test->priv;
-	const char *vendor_name = "VendorVendor";
 	int ret;
 
-	KUNIT_ASSERT_GT(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.vendor = "VendorVendor";
+	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.vendor), DRM_CONNECTOR_HDMI_VENDOR_LEN);
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       vendor_name, "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -920,14 +936,14 @@ static void drm_test_connector_hdmi_init_bpc_invalid(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.max_bpc = 9;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       9);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -940,14 +956,14 @@ static void drm_test_connector_hdmi_init_bpc_null(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.max_bpc = 0;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       0);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -965,14 +981,11 @@ static void drm_test_connector_hdmi_init_bpc_8(struct kunit *test)
 	uint64_t val;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, connector,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	prop = connector->max_bpc_property;
@@ -1006,14 +1019,14 @@ static void drm_test_connector_hdmi_init_bpc_10(struct kunit *test)
 	uint64_t val;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.max_bpc = 10;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       10);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	prop = connector->max_bpc_property;
@@ -1047,14 +1060,14 @@ static void drm_test_connector_hdmi_init_bpc_12(struct kunit *test)
 	uint64_t val;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.max_bpc = 12;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       12);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	prop = connector->max_bpc_property;
@@ -1083,14 +1096,14 @@ static void drm_test_connector_hdmi_init_formats_empty(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_formats = 0;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       0,
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -1103,14 +1116,14 @@ static void drm_test_connector_hdmi_init_formats_no_rgb(struct kunit *test)
 	struct drm_connector_init_priv *priv = test->priv;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -1161,14 +1174,14 @@ static void drm_test_connector_hdmi_init_formats_yuv420_allowed(struct kunit *te
 	params = test->param_value;
 	priv->connector.ycbcr_420_allowed = params->yuv420_allowed;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_formats = params->supported_formats;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
-				       &dummy_hdmi_funcs,
+				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       params->supported_formats,
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, params->expected_result);
 }
 
@@ -1182,14 +1195,11 @@ static void drm_test_connector_hdmi_init_type_valid(struct kunit *test)
 	unsigned int connector_type = *(unsigned int *)test->param_value;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
 				       connector_type,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
@@ -1217,14 +1227,11 @@ static void drm_test_connector_hdmi_init_type_invalid(struct kunit *test)
 	unsigned int connector_type = *(unsigned int *)test->param_value;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, &priv->connector,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
 				       connector_type,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
@@ -1266,6 +1273,7 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_formats_yuv420_allowed,
 			 drm_connector_hdmi_init_formats_yuv420_allowed_gen_params),
 	KUNIT_CASE(drm_test_connector_hdmi_init_null_ddc),
+	KUNIT_CASE(drm_test_connector_hdmi_init_null_hdmi_funcs),
 	KUNIT_CASE(drm_test_connector_hdmi_init_null_product),
 	KUNIT_CASE(drm_test_connector_hdmi_init_null_vendor),
 	KUNIT_CASE(drm_test_connector_hdmi_init_product_length_exact),
@@ -1494,14 +1502,11 @@ static void drm_test_drm_connector_attach_broadcast_rgb_property_hdmi_connector(
 	struct drm_property *prop;
 	int ret;
 
-	ret = drmm_connector_hdmi_ini2(&priv->drm, connector,
-				       "Vendor", "Product",
+	ret = drmm_connector_hdmi_init(&priv->drm, connector,
 				       &dummy_funcs,
 				       &dummy_hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       &priv->ddc,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	ret = drm_connector_attach_broadcast_rgb_property(connector);

-- 
2.56.0

