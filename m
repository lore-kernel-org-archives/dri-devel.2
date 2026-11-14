Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5F606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iQJ/iJSm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660FE10F099;
	Sat, 14 Nov 2026 18:05:16 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618DF10F083
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679465;
 bh=VTBut2vqwoV3MoKcvT6GQaYP+gKhRzrB6Xtx7U7fro0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iQJ/iJSmG9cixrksVRQyNvAyW6ekGou7nyTC0wIj85ZtXgA3ViCxieaf8U8iLgxTT
 eC1bYwLEUFL/A5QWn6UfJZY9hJ1Djs73vPKvJHUN5basavBmx3Z35x2rv0kyI/D4+E
 MYTrTS8d4MZIVRfxgd6dsilPGAljL1hFgLzLrFvJwj7KzecE0mJxYVj2A+a1AsS4UZ
 KBHUvrqhFCnGmV1eeRrCxTpWfFD3g9ZNEmv1xFvhNFAOz1X9RZXipU5a9oGzE3BfCN
 KNP0Nu3tvCwGyWmbeoHGct5p5a/Jzd7pB5q0oKUju+htNs/QArDhIaN+i7OIvqBBLI
 PgyXWa1guOD7w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CCD817E37E7;
 Sat, 14 Nov 2026 19:04:25 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:35 +0200
Subject: [PATCH 11/25] drm/connector: Use the SPD InfoFrame field length
 defines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-11-20e8a33a2286@collabora.com>
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

DRM_CONNECTOR_HDMI_{VENDOR,PRODUCT}_LEN used to size the vendor and
product arrays in struct drm_connector_hdmi.  Those arrays are gone and
both names are now only validated before being copied into the SPD
InfoFrame, hence the limits they have to be checked against are the ones
of the SPD InfoFrame fields themselves.

Switch the remaining users over to
HDMI_SPD_INFOFRAME_{VENDOR,PRODUCT}_LEN and drop the DRM specific
defines, so that the two cannot drift apart.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Robin Räber <robin.raebi@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, dual HDMI
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c            |  4 ++--
 drivers/gpu/drm/tests/drm_connector_test.c | 13 +++++++------
 include/drm/drm_connector.h                |  8 ++++----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 95dd4012580c..355ba53cab6b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -579,8 +579,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (!hdmi_funcs->vendor || !hdmi_funcs->product)
 		return -EINVAL;
 
-	if ((strlen(hdmi_funcs->vendor) > DRM_CONNECTOR_HDMI_VENDOR_LEN) ||
-	    (strlen(hdmi_funcs->product) > DRM_CONNECTOR_HDMI_PRODUCT_LEN))
+	if ((strlen(hdmi_funcs->vendor) > HDMI_SPD_INFOFRAME_VENDOR_LEN) ||
+	    (strlen(hdmi_funcs->product) > HDMI_SPD_INFOFRAME_PRODUCT_LEN))
 		return -EINVAL;
 
 	if (!hdmi_funcs->supported_formats ||
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index d98c6a42ccae..591557c4a8bb 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -771,7 +771,7 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 	priv->hdmi_funcs.product = "Prod";
 
 	KUNIT_ASSERT_LT(test, strlen(priv->hdmi_funcs.product),
-			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+			HDMI_SPD_INFOFRAME_PRODUCT_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -794,7 +794,7 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 	priv->hdmi_funcs.product = "ProductProductPr";
 
 	KUNIT_ASSERT_EQ(test, strlen(priv->hdmi_funcs.product),
-			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+			HDMI_SPD_INFOFRAME_PRODUCT_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -817,7 +817,7 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 	priv->hdmi_funcs.product = "ProductProductProduct";
 
 	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.product),
-			DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+			HDMI_SPD_INFOFRAME_PRODUCT_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -840,7 +840,7 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 	priv->hdmi_funcs.vendor = "Vend";
 
 	KUNIT_ASSERT_LT(test, strlen(priv->hdmi_funcs.vendor),
-			DRM_CONNECTOR_HDMI_VENDOR_LEN);
+			HDMI_SPD_INFOFRAME_VENDOR_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -863,7 +863,7 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 	priv->hdmi_funcs.vendor = "VendorVe";
 
 	KUNIT_ASSERT_EQ(test, strlen(priv->hdmi_funcs.vendor),
-			DRM_CONNECTOR_HDMI_VENDOR_LEN);
+			HDMI_SPD_INFOFRAME_VENDOR_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
@@ -884,7 +884,8 @@ static void drm_test_connector_hdmi_init_vendor_length_too_long(struct kunit *te
 
 	priv->hdmi_funcs = dummy_hdmi_funcs;
 	priv->hdmi_funcs.vendor = "VendorVendor";
-	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.vendor), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+	KUNIT_ASSERT_GT(test, strlen(priv->hdmi_funcs.vendor),
+			HDMI_SPD_INFOFRAME_VENDOR_LEN);
 
 	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
 				       &dummy_funcs,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 262bc4d91a3c..2d9ae3a99329 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1485,15 +1485,15 @@ struct drm_connector_infoframe_funcs {
  * and controller capabilities
  */
 struct drm_connector_hdmi_funcs {
-#define DRM_CONNECTOR_HDMI_VENDOR_LEN	8
 	/**
-	 * @vendor: HDMI Controller Vendor name.
+	 * @vendor: HDMI Controller Vendor name, at most
+	 * HDMI_SPD_INFOFRAME_VENDOR_LEN characters long.
 	 */
 	const char *vendor;
 
-#define DRM_CONNECTOR_HDMI_PRODUCT_LEN	16
 	/**
-	 * @product: HDMI Controller Product name
+	 * @product: HDMI Controller Product name, at most
+	 * HDMI_SPD_INFOFRAME_PRODUCT_LEN characters long.
 	 */
 	const char *product;
 

-- 
2.56.0

