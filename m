Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C10CCA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F3310E4B8;
	Tue, 13 Oct 2026 01:06:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4E010E4B8;
 Tue, 13 Oct 2026 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791853602; x=1823389602;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=oy0/eluge96vGgdo2tJTYq8W1dn6eXEGEWLKadeDFhE=;
 b=FifEltdeHUEjXAXV2vgeWqkVyADcx5HnqMpO272/NALeVNMn6S1bekzs
 sSOlYUsB7bxHHR1/av3gAHckQ3GAqo1nK++3sYVDgfHPJhkPMgGGYnWC4
 6UXzfWdpD4Xhpgkk+/oimWE0jKsZcNt0JqB7mGAjBijR4jz1YLRPMhEzw
 aarEudB2C1/QYi8ktIeiOTxGO2APdaKqg9/ixvY67Ryx1tmVzAXOSGqgP
 VE81QA2SDqroi1NGPWXaiQANafGjiQqLPnlDDdVCxr1s+bW588foc0vo+
 xZlOEYPpOcI2JSChAevovXX4lvl1c4OE0v5cCKtrZ4T0hLM19IxrZVLjP Q==;
X-CSE-ConnectionGUID: wSWOvSZGRriQxvE2KuxD+Q==
X-CSE-MsgGUID: b6FFXT5yTlu6Mi2JiQFDWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="557200"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="557200"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:36 -0700
X-CSE-ConnectionGUID: 246iasQBRMaYd7F5oG2CDg==
X-CSE-MsgGUID: eg2bvAm1R6KbteGGx91apg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1360817"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:19 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
Subject: [PATCH v2 1/6] drm/gem: add helper to detect self-imported PRIME
 dma-bufs
Date: Mon, 12 Oct 2026 18:06:13 -0700
Message-ID: <20261013010614.1516799-9-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
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

From: Farah Kassabri <farah.kassabri@intel.com>

Add drm_gem_prime_self_import() to detect and handle the case where a
PRIME dma-buf being imported was exported by the same DRM device.

When the dma-buf originates from the importing device and uses the
expected dma-buf ops, the helper returns the associated GEM object and
takes an extra reference on it. This allows drivers to bypass the
generic PRIME import path and avoid taking an additional reference on
the dma-buf file.

The helper simplifies self-import handling and avoids duplication of
this pattern across DRM drivers.

Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_prime.c | 48 ++++++++++++++++++++++++++++++-------
 include/drm/drm_prime.h     |  4 ++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..588910c250b8 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -974,15 +974,9 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	int ret;
 
-	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
-		/*
-		 * Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		obj = dma_buf->priv;
-		drm_gem_object_get(obj);
+	obj = drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
+	if (obj)
 		return obj;
-	}
 
 	if (!dev->driver->gem_prime_import_sg_table)
 		return ERR_PTR(-EINVAL);
@@ -1116,3 +1110,41 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
 	dma_buf_put(dma_buf);
 }
 EXPORT_SYMBOL(drm_prime_gem_destroy);
+
+/**
+ * drm_gem_prime_self_import - Attempt to import a dma-buf exported by this DRM device
+ * @dev: DRM device performing the import
+ * @dma_buf: dma-buf to import
+ * @expected_ops: dma-buf ops used by this driver
+ *
+ * If @dma_buf was exported by this DRM device using @expected_ops, return the
+ * corresponding GEM object and take an extra reference on it. In this case,
+ * the import avoids taking a reference on the dma-buf file and instead bumps
+ * the GEM object's refcount directly.
+ *
+ * Returns:
+ * A referenced GEM object on success, or %NULL if the dma-buf was not exported
+ * by this device or does not match @expected_ops.
+ */
+struct drm_gem_object *drm_gem_prime_self_import(struct drm_device *dev,
+						 struct dma_buf *dma_buf,
+						 const struct dma_buf_ops *expected_ops)
+{
+	struct drm_gem_object *obj;
+
+	if (dma_buf->ops != expected_ops)
+		return NULL;
+
+	obj = dma_buf->priv;
+	if (obj->dev != dev)
+		return NULL;
+
+	/*
+	 * Importing dmabuf exported from our own gem increases
+	 * refcount on gem itself instead of f_count of dmabuf.
+	 */
+	drm_gem_object_get(obj);
+
+	return obj;
+}
+EXPORT_SYMBOL(drm_gem_prime_self_import);
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index f50f862f0d8b..d378404f8ab4 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -54,6 +54,7 @@ struct device;
 struct dma_buf_export_info;
 struct dma_buf;
 struct dma_buf_attachment;
+struct dma_buf_ops;
 struct iosys_map;
 
 enum dma_data_direction;
@@ -108,6 +109,9 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 						struct device *attach_dev);
 struct drm_gem_object *drm_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *dma_buf);
+struct drm_gem_object *drm_gem_prime_self_import(struct drm_device *dev,
+						 struct dma_buf *dma_buf,
+						 const struct dma_buf_ops *expected_ops);
 
 void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg);
 
-- 
2.43.0

