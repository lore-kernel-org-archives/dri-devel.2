Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E0CC6B03
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9196110F2AD;
	Mon, 12 Oct 2026 18:06:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6638910EBEF;
 Mon, 12 Oct 2026 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791828359; x=1823364359;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ccotpIDYhLXpeb1AQWIvA0uHN6PQHXBJzUNBZ+28p9I=;
 b=P4aQE+zlqz+6tfSlgfABsWRlD6rHOfFrMs1OA+Ip+xwB0GJHoBw5gs3S
 EHzMuz1Xer6gQokKfCRcL6qShy/HcByQ8prIMLDs8etevGiwAm7+cxwr0
 JObLpTydM+alyoBtnBHJaUdChNjrcRO4anYaUCq/JuAFPoF5MJ5obfYgl
 E7OT6z516mX3x5t9KaKWgIZSBMMstzPOjJu01rRDzHdp7icO60/jURMpE
 +d+LU86PO3IEJtwNVDh61qcYeAcz/hWbekeZnB1RQUQY+uFe7Db/u+Lv0
 aTZ7kGbJ3FsW+rl4hZfg+1Mf17tw5LuRLa2KH85rP6SrZG1v5gxmahCxp Q==;
X-CSE-ConnectionGUID: /QdFM8sBQtmf9Nnj9b+Xpg==
X-CSE-MsgGUID: ZTpJwogjR3yHwdd3ex6yBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="548317"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="548317"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 11:05:54 -0700
X-CSE-ConnectionGUID: FN0Xnr36S92nZHJSplNFkg==
X-CSE-MsgGUID: c9SZ/SpFQEiYdMlsZNbwnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1281735"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 11:05:53 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 1/2] drm/gem: add helper to detect self-imported PRIME dma-bufs
Date: Mon, 12 Oct 2026 11:05:42 -0700
Message-ID: <20261012180543.1488703-5-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012180543.1488703-4-niranjana.vishwanathapura@intel.com>
References: <20261012180543.1488703-4-niranjana.vishwanathapura@intel.com>
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

