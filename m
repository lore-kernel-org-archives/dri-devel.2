Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C98CCA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CCD10E6D4;
	Tue, 13 Oct 2026 01:06:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD6510E6F1;
 Tue, 13 Oct 2026 01:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791853607; x=1823389607;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Iwh7uOTx6HaYkcmFIfsKFTWjwAsFlKEZTYP8SOlXVas=;
 b=QhatGBhIIr182buQszmE42ZEQoh3wGyaAv+L80zQhmx6VE0eLTojEYkD
 xk3yY9+LZjwdwT/6Tukx6/uK5M1l9WIFMderZDUMyJNslCYKH0fllAxyd
 +abn/SPDLI8PsOkJBRq4iX56WUkd/c+DrdWRM5Rf0z/Pw6126QtW52dcU
 sR3fXJ8DkQ3rmVDk1BEB+2hOiUo83UqhonxMV+TbvxqwHNEWXdOq+T81m
 5sAcvlRz5TzaBsLNqxLrAhE8dHpuXe+QVwP/ZX++IJ5KJOSi1r1sl0q0q
 8xN7mzOOFO2ha2NtnHnqjRJjaNXD4/ioHGD2D17POzW1CEhgYJZMWTFek g==;
X-CSE-ConnectionGUID: DFrk7nfnSSq/tyzCu7bXEw==
X-CSE-MsgGUID: 0bk1K18nQraMbx0tGEBPaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="557201"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="557201"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:36 -0700
X-CSE-ConnectionGUID: aB7g1L9jRBCOe6niGIZqOQ==
X-CSE-MsgGUID: RSHWKmYfQuirUvZqtfuJWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1360819"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:06:19 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
Subject: [PATCH v2 2/6] drm/xe/dma-buf: Use drm helper to detect dma-buf
 self-import
Date: Mon, 12 Oct 2026 18:06:14 -0700
Message-ID: <20261013010614.1516799-10-niranjana.vishwanathapura@intel.com>
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

Instead of driver-specific code, use the new drm helper
drm_gem_prime_self_import() to detect self-import of a dma-buf in Xe.

Expose the helper within Xe as xe_dma_buf_to_gem() for future use.

Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 23 +++++++++++++----------
 drivers/gpu/drm/xe/xe_dma_buf.h |  2 ++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 6a85b292dee7..4e1b447f4235 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -239,6 +239,12 @@ static const struct dma_buf_ops xe_dmabuf_ops = {
 	.vunmap = drm_gem_dmabuf_vunmap,
 };
 
+struct drm_gem_object *xe_dma_buf_to_gem(struct drm_device *dev,
+					 struct dma_buf *dma_buf)
+{
+	return drm_gem_prime_self_import(dev, dma_buf, &xe_dmabuf_ops);
+}
+
 struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 {
 	struct xe_bo *bo = gem_to_xe_bo(obj);
@@ -372,17 +378,14 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
 
-	if (dma_buf->ops == &xe_dmabuf_ops) {
-		obj = dma_buf->priv;
-		if (obj->dev == dev &&
-		    !XE_TEST_ONLY(test && test->force_different_devices)) {
-			/*
-			 * Importing dmabuf exported from out own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			drm_gem_object_get(obj);
+	obj = xe_dma_buf_to_gem(dev, dma_buf);
+	if (obj) {
+		if (!XE_TEST_ONLY(test && test->force_different_devices))
 			return obj;
-		}
+
+		/* Test only: force different devices */
+		drm_gem_object_put(obj);
+		obj = NULL;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.h b/drivers/gpu/drm/xe/xe_dma_buf.h
index 861dd28a862c..d0c7893a5a6f 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.h
+++ b/drivers/gpu/drm/xe/xe_dma_buf.h
@@ -8,6 +8,8 @@
 
 #include <drm/drm_gem.h>
 
+struct drm_gem_object *xe_dma_buf_to_gem(struct drm_device *dev,
+					 struct dma_buf *dma_buf);
 struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags);
 struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 					   struct dma_buf *dma_buf);
-- 
2.43.0

