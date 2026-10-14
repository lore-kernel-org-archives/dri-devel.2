Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC20CC6B30
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746DA10EB29;
	Wed, 14 Oct 2026 19:34:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1206910EABC;
 Wed, 14 Oct 2026 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006474; x=1823542474;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Iwh7uOTx6HaYkcmFIfsKFTWjwAsFlKEZTYP8SOlXVas=;
 b=CWzynazYrjl0ngbJWaAJhT+DIO7HNmml3dmZxfLWczJQNHdYJgPE7Krw
 h992CcbXrSZFOr1nnqIkA15brptPRZ8d8Bb3ozvDcyoic1NIzSqTFV5he
 pDGXXMJmVea0xW+Vsm8OUFXFFr1LS1dU49SLgOg/jY8a+MXoedLzh8Qj7
 x++cI4BNVg0e752KwQU4Vjnm+cEqp/tE6BSivmj36OJP8eL8VmJ/Ysam9
 4s3FWhVAxcC4t/EMLvv0UkcLyYuGKw7Tn2d/wmxp95zcFKykXLEulaPP8
 UbTAjdduOO0zdYeFw8QMLQxIcvqQ9DAVkg1AhSuetsMoZUAkQ0kJsKzNU Q==;
X-CSE-ConnectionGUID: 5+3wlNDBSXup0/HN1mbbWw==
X-CSE-MsgGUID: kdS8WPPhQ/uOrljojBW5nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653858"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653858"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:28 -0700
X-CSE-ConnectionGUID: 8jJIwGtyQI6K7fq7++3sGw==
X-CSE-MsgGUID: Xsv/dCAWS1eCM51y6M5Pmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270492"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 02/12] drm/xe/dma-buf: Use drm helper to detect dma-buf
 self-import
Date: Wed, 14 Oct 2026 12:34:22 -0700
Message-ID: <20261014193421.1705112-16-niranjana.vishwanathapura@intel.com>
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

