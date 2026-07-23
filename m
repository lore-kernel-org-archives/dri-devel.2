Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18406C44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449D410EEFE;
	Thu, 23 Jul 2026 00:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rkf4/FNy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9535410EEFA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=HA/Vtufn/7h+wNv3Nf/1V5YLYHfsXC7C0diHCDG7/9Y=; b=
 rkf4/FNyEfGpf1ZMwHDNoiceIapaj5Onk+X/CBW44qKGz9cQYhfqRb2/xOZgNAFXoHo6Ll93yBGIe
 KOfVlA7/j2YXkA4qOoSJxsfWI1fTfDpBRz+X3HknR1bQ+N0SBq3DFFEAUcUtOLZVH4lfXkAOnynXu
 Khdxa7cw4hd6zM00CzusTivwCSWGEKERPge55a1/hUGWMET87PMmrW1aDn9aYMB+WntYcqQnwkegq
 vCl2t/NUqEUnNYut11G2ei6kcvNpCA7mr7T628cWI4rFPF3c4WLe5+ze3OzwIvBCRIDjN+5eIRD4w
 i78N/nHO3nxDtm4ZLDBjeWPhhwdFbkApyA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmhNX-003EEc-DF; Thu, 23 Jul 2026 02:33:35 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v8 8/8] drm: writeback: drop excess connector initialization
 functions
Date: Wed, 22 Jul 2026 17:32:03 -0700
Message-ID: <20260723003205.330362-9-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723003205.330362-1-John.Harrison@Igalia.com>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Now as all drivers have been converted to
drmm_writeback_connector_init(), drop drm_writeback_connector_init() and
drm_writeback_connector::encoder field, they are unused now.

v2: Also drop drm_writeback_connector_init_with_encoder as it too is
no longer in use. Update a bunch of documentation comments to refer to
the new interface name.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/drm_writeback.c | 107 --------------------------------
 include/drm/drm_mode_config.h   |   6 +-
 include/drm/drm_writeback.h     |  26 +-------
 3 files changed, 4 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index b4a002e6d043..ae4b74db6ed3 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -148,61 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static const struct drm_encoder_funcs drm_writeback_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
-/**
- * drm_writeback_connector_init - Initialize a writeback connector and its properties
- * @dev: DRM device
- * @wb_connector: Writeback connector to initialize
- * @con_funcs: Connector funcs vtable
- * @enc_helper_funcs: Encoder helper funcs vtable to be used by the internal encoder
- * @formats: Array of supported pixel formats for the writeback engine
- * @n_formats: Length of the formats array
- * @possible_crtcs: possible crtcs for the internal writeback encoder
- *
- * This function creates the writeback-connector-specific properties if they
- * have not been already created, initializes the connector as
- * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
- * values. It will also create an internal encoder associated with the
- * drm_writeback_connector and set it to use the @enc_helper_funcs vtable for
- * the encoder helper.
- *
- * Drivers should always use this function instead of drm_connector_init() to
- * set up writeback connectors.
- *
- * Returns: 0 on success, or a negative error code
- */
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs)
-{
-	int ret = 0;
-
-	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
-
-	wb_connector->encoder.possible_crtcs = possible_crtcs;
-
-	ret = drm_encoder_init(dev, &wb_connector->encoder,
-			       &drm_writeback_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
-	if (ret)
-		return ret;
-
-	ret = drm_writeback_connector_init_with_encoder(dev, wb_connector, &wb_connector->encoder,
-			con_funcs, formats, n_formats);
-
-	if (ret)
-		drm_encoder_cleanup(&wb_connector->encoder);
-
-	return ret;
-}
-EXPORT_SYMBOL(drm_writeback_connector_init);
-
 static void delete_writeback_properties(struct drm_device *dev)
 {
 	if (dev->mode_config.writeback_pixel_formats_property) {
@@ -295,58 +240,6 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	return ret;
 }
 
-/**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
- * a custom encoder
- *
- * @dev: DRM device
- * @wb_connector: Writeback connector to initialize
- * @enc: handle to the already initialized drm encoder
- * @con_funcs: Connector funcs vtable
- * @formats: Array of supported pixel formats for the writeback engine
- * @n_formats: Length of the formats array
- *
- * This function creates the writeback-connector-specific properties if they
- * have not been already created, initializes the connector as
- * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
- * values.
- *
- * This function assumes that the drm_writeback_connector's encoder has already been
- * created and initialized before invoking this function.
- *
- * In addition, this function also assumes that callers of this API will manage
- * assigning the encoder helper functions, possible_crtcs and any other encoder
- * specific operation.
- *
- * Drivers should always use this function instead of drm_connector_init() to
- * set up writeback connectors if they want to manage themselves the lifetime of the
- * associated encoder.
- *
- * Returns: 0 on success, or a negative error code
- */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-					      struct drm_writeback_connector *wb_connector,
-					      struct drm_encoder *enc,
-					      const struct drm_connector_funcs *con_funcs,
-					      const u32 *formats, int n_formats)
-{
-	struct drm_connector *connector = &wb_connector->base;
-	int ret;
-
-	ret = drm_connector_init(dev, connector, con_funcs,
-				 DRM_MODE_CONNECTOR_WRITEBACK);
-	if (ret)
-		return ret;
-
-	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
-					     n_formats);
-	if (ret)
-		drm_connector_cleanup(connector);
-
-	return ret;
-}
-EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
-
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
  * @dev: DRM device
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index d8f5b7e9673e..d7e88753624d 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -870,7 +870,7 @@ struct drm_mode_config {
 	/**
 	 * @writeback_fb_id_property: Property for writeback connectors, storing
 	 * the ID of the output framebuffer.
-	 * See also: drm_writeback_connector_init()
+	 * See also: drmm_writeback_connector_init()
 	 */
 	struct drm_property *writeback_fb_id_property;
 
@@ -878,7 +878,7 @@ struct drm_mode_config {
 	 * @writeback_pixel_formats_property: Property for writeback connectors,
 	 * storing an array of the supported pixel formats for the writeback
 	 * engine (read-only).
-	 * See also: drm_writeback_connector_init()
+	 * See also: drmm_writeback_connector_init()
 	 */
 	struct drm_property *writeback_pixel_formats_property;
 	/**
@@ -886,7 +886,7 @@ struct drm_mode_config {
 	 * fd pointer representing the outgoing fences for a writeback
 	 * connector. Userspace should provide a pointer to a value of type s32,
 	 * and then cast that pointer to u64.
-	 * See also: drm_writeback_connector_init()
+	 * See also: drmm_writeback_connector_init()
 	 */
 	struct drm_property *writeback_out_fence_ptr_property;
 
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index c380a7b8f55a..0dda8dbd0118 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -24,23 +24,12 @@ struct drm_writeback_connector {
 	 */
 	struct drm_connector base;
 
-	/**
-	 * @encoder: Internal encoder used by the connector to fulfill
-	 * the DRM framework requirements. The users of the
-	 * @drm_writeback_connector control the behaviour of the @encoder
-	 * by passing the @enc_funcs parameter to drm_writeback_connector_init()
-	 * function.
-	 * For users of drm_writeback_connector_init_with_encoder(), this field
-	 * is not valid as the encoder is managed within their drivers.
-	 */
-	struct drm_encoder encoder;
-
 	/**
 	 * @pixel_formats_blob_ptr:
 	 *
 	 * DRM blob property data for the pixel formats list on writeback
 	 * connectors
-	 * See also drm_writeback_connector_init()
+	 * See also drmm_writeback_connector_init()
 	 */
 	struct drm_property_blob *pixel_formats_blob_ptr;
 
@@ -148,19 +137,6 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs);
-
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-				struct drm_writeback_connector *wb_connector,
-				struct drm_encoder *enc,
-				const struct drm_connector_funcs *con_funcs, const u32 *formats,
-				int n_formats);
-
 int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_writeback_connector *wb_connector,
 				  const struct drm_connector_funcs *con_funcs,
-- 
2.43.0

