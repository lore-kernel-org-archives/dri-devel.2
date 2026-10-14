Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CC3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49F010EAD0;
	Wed, 14 Oct 2026 19:02:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3601610EAD2;
 Wed, 14 Oct 2026 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792004541; x=1823540541;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jAfeC0qMdrIYDTMb1ug5hhtYKYOkvWzkT6zJBD0q5EE=;
 b=h6kou5HEtjd5LO1gxq42efjdS/XFmPm6Hgslb7Ilrk8Xn2dZTZFSedRr
 PT9sqd6jruofc3ZerDbH1p0363NGpnGGRPE+8x8pJt6iMnc97mSxPO53k
 029C3j983oc71RNasnEteFkvKNXZV2jZcTIwYjWX+/NKTblbHqyt0W6e1
 Ms5zKGYKSbYbpjuTk+sMwX0Zu+xiga6kaLipgwAGK8+8DsBdsh2BEhBJB
 0e+DsmES3FYeemOhn+lbs2+Vn0coxEZgK8GDtKyau/eHyOlXEGV02BF2M
 tYJPwD7TfnA0vpQ+8ThgA7EX1sYUl/KY3Z2NXVANLPHVnp4NjAncilzky A==;
X-CSE-ConnectionGUID: DrKo9gHAS8e+Y+W/H7wpDg==
X-CSE-MsgGUID: ajKncZCeS4e/fdHv9qOjNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="648022"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="648022"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
X-CSE-ConnectionGUID: BBpHx0b7RfG5Hi937O5Cjg==
X-CSE-MsgGUID: MZhhqql3SaKjYAGQiFFDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1941291"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v3 3/6] drm/gem: add drm_gem_prime_dma_buf_to_gem()
 self-import helper
Date: Wed, 14 Oct 2026 12:02:03 -0700
Message-ID: <20261014190200.1700470-11-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
References: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
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

drm_gem_is_prime_exported_dma_buf() is a bool predicate that open-codes
the core PRIME self-import check. Its only caller, the shmem importer,
then repeats the dma_buf->priv lookup and the reference get.

Replace it with drm_gem_prime_dma_buf_to_gem(), a thin wrapper around
drm_gem_prime_self_import() that returns the backing GEM object -- with
a reference taken -- for a core-PRIME self-export, or NULL otherwise.
This consolidates self-import handling onto drm_gem_prime_self_import()
and lets drm_gem_shmem_prime_import_no_map() reuse the object directly.

Unlike the removed predicate, the helper takes a reference on the
returned object; the sole caller already wanted the referenced object.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 14 ++++++--------
 drivers/gpu/drm/drm_prime.c            | 26 +++++++++++++++-----------
 include/drm/drm_prime.h                |  4 ++--
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d654a22a30de..a0e161f2333e 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -954,15 +954,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
 	size_t size;
 	int ret;
 
-	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
-		/*
-		 * Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		obj = dma_buf->priv;
-		drm_gem_object_get(obj);
+	/*
+	 * Importing a dmabuf exported from our own gem increases the refcount
+	 * on the gem itself instead of the f_count of the dmabuf.
+	 */
+	obj = drm_gem_prime_dma_buf_to_gem(dev, dma_buf);
+	if (obj)
 		return obj;
-	}
 
 	attach = dma_buf_attach(dma_buf, dev->dev);
 	if (IS_ERR(attach))
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 7a15c29052eb..d4adc732e7f6 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -933,23 +933,27 @@ EXPORT_SYMBOL(drm_gem_prime_export);
 
 
 /**
- * drm_gem_is_prime_exported_dma_buf -
- * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
+ * drm_gem_prime_dma_buf_to_gem - GEM object backing a self-exported PRIME dma-buf
  * @dev: drm_device to check against
  * @dma_buf: dma-buf object to import
  *
- * Return: true if the DMA-BUF was exported from a GEM object belonging
- * to @dev, false otherwise.
+ * If @dma_buf is a PRIME export of a GEM object that belongs to @dev and uses
+ * the core PRIME dma-buf ops, return that GEM object with an extra reference
+ * taken, so a self-import reuses the GEM object instead of referencing the
+ * dma-buf file. Returns NULL for a foreign dma-buf or one using driver-private
+ * ops; such drivers call drm_gem_prime_self_import() with their own ops.
+ *
+ * The returned object carries a reference the caller must drop with
+ * drm_gem_object_put().
+ *
+ * Return: the referenced GEM object on self-import, or NULL otherwise.
  */
-
-bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
-				       struct dma_buf *dma_buf)
+struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
+						    struct dma_buf *dma_buf)
 {
-	struct drm_gem_object *obj = dma_buf->priv;
-
-	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
+	return drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
 }
-EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
+EXPORT_SYMBOL(drm_gem_prime_dma_buf_to_gem);
 
 /**
  * drm_gem_prime_import_dev - core implementation of the import callback
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index f50f862f0d8b..a012da82069a 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -100,8 +100,8 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
 
 /* helper functions for importing */
-bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
-				       struct dma_buf *dma_buf);
+struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
+						    struct dma_buf *dma_buf);
 
 struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 						struct dma_buf *dma_buf,
-- 
2.43.0

