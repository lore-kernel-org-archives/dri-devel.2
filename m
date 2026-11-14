Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9303606A8AA
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pwgOuMyK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E477D10F08C;
	Sat, 14 Nov 2026 18:04:46 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6F910E6F2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679463;
 bh=azWlnHGp4hRPG9/J9nYSuLCWljenmOzEKW2cN+vasbQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pwgOuMyKT33fSWkPMxB8n4awjbXtKvdNVyMKP3O7oCRNLfYhwbzg2zKPcHGDjy3bN
 e7VMpVLrbNVcZ0BtYELjPzcrXbTHIaEM6sHW2DssEG94Z22DEeZpVYinR/fmOOXEBT
 iSCdB09dxBp63wJDwvpq6yumNZmUT1ICWJL1OaNu+ACmwwdoi7utUIuuWW1bRsXj/c
 IYLHlaGBH2NsoFNzBqT3ifsQj/q3ydq6MiWwb8/UG3UYqFk6P3Q/3IXyeN3a7dkS8e
 gKAkz3KHJNtgU6h6g7j08a0z9yOaIZuRR/Mex2RkDBPxduD7+X0vhLxIDCGSEwCJjd
 uMykeN2jQMyUQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3ECCC17E152A;
 Sat, 14 Nov 2026 19:04:23 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:32 +0200
Subject: [PATCH 08/25] drm/connector: Drop redundant hdmi vendor/product fields
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-8-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 =?utf-8?q?Robin_R=C3=A4ber?= <robin.raebi@gmail.com>, 
 Igor Paunovic <royalnet026@gmail.com>
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

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, vendor and product are provided through struct
drm_connector_hdmi_funcs, a reference to which is already stored in
drm_connector_hdmi.

Drop the redundant fields from drm_connector_hdmi and point its users to
hdmi.funcs->vendor and hdmi.funcs->product instead.

The connector registration tests used to verify that both names were
stored zero-padded and without any trailing NUL, as the SPD InfoFrame
requires.  That will be covered by dedicated SPD InfoFrame tests, hence
drop the KUNIT_EXPECT_MEMEQ() checks on the removed fields.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Tested-by: Robin Räber <robin.raebi@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, dual HDMI
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +--
 drivers/gpu/drm/drm_connector.c                 |  4 ---
 drivers/gpu/drm/tests/drm_connector_test.c      | 41 +++----------------------
 include/drm/drm_connector.h                     | 14 ++-------
 4 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index f533d5a7aab9..0e282abb118d 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -785,8 +785,8 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 		return 0;
 
 	ret = hdmi_spd_infoframe_init(frame,
-				      connector->hdmi.vendor,
-				      connector->hdmi.product);
+				      connector->hdmi.funcs->vendor,
+				      connector->hdmi.funcs->product);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index bb508ec7a8cd..b1b7662c575b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -646,10 +646,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
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
index 354e3088cf0f..d98c6a42ccae 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -760,14 +760,11 @@ static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
 
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
@@ -782,25 +779,15 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
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
@@ -815,10 +802,6 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_MEMEQ(test,
-			   priv->connector.hdmi.product,
-			   expected_product,
-			   sizeof(priv->connector.hdmi.product));
 }
 
 /*
@@ -846,14 +829,11 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 
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
@@ -868,24 +848,15 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
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
@@ -900,10 +871,6 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
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
index 241d20a587e5..c75bf65532d4 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1485,11 +1485,13 @@ struct drm_connector_infoframe_funcs {
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
@@ -2178,18 +2180,6 @@ struct drm_connector_hdmi_audio {
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
2.56.0

