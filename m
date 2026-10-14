Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E79C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A0810EAE1;
	Wed, 14 Oct 2026 19:34:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D564F10E649;
 Wed, 14 Oct 2026 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006470; x=1823542470;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=an4pLyEOVCy5aeTCpWruN6pFn0fn3dn/oCJv4LR/2gM=;
 b=Leeptwwrr5bYG3Z6KerJck/pxtYJnNRk6ZzST+V2sTV8uwi1DzQ2FZuZ
 HT+ANvLsXOezZ509j2Unik2vSFG1YYeh4DiOQY2ABPnj8j5X5PNi6lqJg
 kHr3ZC9ufmuOlSWPgcReqUjH4CBPdDJr6L/A/jW41GsFJRAjnvdRWDSvE
 neSdptQoIW/H9xSG/cywc0TVHGmBW6LlcibYIsfWSOAZvHnMVEsi+OVya
 OFEBgcuGnZoAQ6OLA2/xhimO+3akzAGAWCzAUpm4E860omoS3BgjqtwPu
 C43IqfN1nU3ioxkGM9hZaZaj57RautgcyvLbnwNxfNU3C7Tv4nc2ojqr+ Q==;
X-CSE-ConnectionGUID: paLiAIVBTwOYJOJt38xGJw==
X-CSE-MsgGUID: J6vsRZAoS7SFoqJnFwpP6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653856"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653856"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:28 -0700
X-CSE-ConnectionGUID: F0H6Iao+QG2J7nOC1+Bx8Q==
X-CSE-MsgGUID: j8nkRXAvQSKSnEK2YaTtGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270487"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:28 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 01/12] drm/gem: add helper to detect self-imported PRIME
 dma-bufs
Date: Wed, 14 Oct 2026 12:34:21 -0700
Message-ID: <20261014193421.1705112-15-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
References: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
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

v2: Move drm_gem_prime_self_import() to drm_gem.h as a static inline
    helper routine

Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_prime.c | 10 ++-------
 include/drm/drm_gem.h       | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..7a15c29052eb 100644
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
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 885244e375d3..238ec08f0d81 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -646,6 +646,48 @@ static inline bool drm_gem_is_imported(const struct drm_gem_object *obj)
 	return !!obj->import_attach;
 }
 
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
+ * Comparing @dma_buf->ops against @expected_ops is plumbing: dma-buf has no
+ * first-class exporter identifier, so the ops pointer is used as a stand-in to
+ * recognise a buffer this driver exported. A dedicated exporter identity would
+ * let this be done without reaching into @dma_buf->ops.
+ *
+ * Returns:
+ * A referenced GEM object on success, or %NULL if the dma-buf was not exported
+ * by this device or does not match @expected_ops.
+ */
+static inline struct drm_gem_object *
+drm_gem_prime_self_import(struct drm_device *dev, struct dma_buf *dma_buf,
+			  const struct dma_buf_ops *expected_ops)
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
+	 * Importing dmabuf exported from the driver's own gem increases
+	 * refcount on gem itself instead of f_count of dmabuf.
+	 */
+	drm_gem_object_get(obj);
+
+	return obj;
+}
+
 #ifdef CONFIG_LOCKDEP
 #define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
 	lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
-- 
2.43.0

