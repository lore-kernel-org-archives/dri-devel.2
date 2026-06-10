Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F53CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A57E10E70A;
	Wed, 10 Jun 2026 06:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n2JOG30Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A73B10E707;
 Wed, 10 Jun 2026 06:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781071406; x=1812607406;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Z9tggGgYXlOsfk5+OVnZAmo5fEL/nn5W/r1f6Z4h7f0=;
 b=n2JOG30YsfdOEMGUhrYwxKf7XPCaYCXsj6rr/qxOZaA+K+qH7X87JmaZ
 GKZPB/3NKOD6uuX+2EvFbTvz7rFZUGz7oKRp+pDDMKM+sh2RW/baPs2ri
 ODl94fIV504qilKzjwkELS8jo92ALfkkRW9HqYl/vWQGY8LydyQJwdKvi
 d5zYKt0mqaj90bDR5yiX12uUtrazYBro51M3tuuCdbuxhmPthWZB+DH7N
 NEU7D33/38R+ATglAqIf47rxBBriE+XnvoB/ZY/qAwXVPMfPLXmpWw5lb
 mPRgT2YLCFB9/3q8MyjFBaxi4XoX+K6DY2lMdn3naoX7ZtPNpUVFkshNt Q==;
X-CSE-ConnectionGUID: rclVnDddTNOolJet09qjmg==
X-CSE-MsgGUID: 8YVNMOzxRtmX6EWYeyZWmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69389234"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="69389234"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 23:03:25 -0700
X-CSE-ConnectionGUID: 6e29jrx/SzOb5RH5RjT9LQ==
X-CSE-MsgGUID: dramR6GdRIOScJsNgY6SUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="270082569"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.208])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 23:03:22 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, stable@vger.kernel.org,
 Tvrtko Ursulin <tursulin@ursulin.net>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/i915/gem: Fix phys BO pread/pwrite with offset
Date: Wed, 10 Jun 2026 09:03:14 +0300
Message-ID: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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

sg_page() returns struct page pointer not (void *) so the scaling
of pread/pwrite is wrong for phys BO and wrong parts of BO would be
accessed if non-zero offset is used.

Last impacted platform with overlay or cursor planes using phys
mapping was Gen3/945G/Lakeport.

Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: c6790dc22312 ("drm/i915: Wean off drm_pci_alloc/drm_pci_free")
Cc: <stable@vger.kernel.org> # v4.5+
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_phys.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
index e375afbf458e..d53129eb5603 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
@@ -18,6 +18,17 @@
 #include "i915_gem_tiling.h"
 #include "i915_scatterlist.h"
 
+/* Abuse scatterlist to store pointer instead of struct page. */
+static inline void __set_phys_vaddr(struct scatterlist *sg, void *vaddr)
+{
+	sg_assign_page(sg, (struct page *)vaddr);
+}
+
+static inline void *__get_phys_vaddr(struct scatterlist *sg)
+{
+	return (void *)sg_page(sg);
+}
+
 static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 {
 	struct address_space *mapping = obj->base.filp->f_mapping;
@@ -58,7 +69,7 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 	sg->offset = 0;
 	sg->length = obj->base.size;
 
-	sg_assign_page(sg, (struct page *)vaddr);
+	__set_phys_vaddr(sg, vaddr);
 	sg_dma_address(sg) = dma;
 	sg_dma_len(sg) = obj->base.size;
 
@@ -99,7 +110,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 			       struct sg_table *pages)
 {
 	dma_addr_t dma = sg_dma_address(pages->sgl);
-	void *vaddr = sg_page(pages->sgl);
+	void *vaddr = __get_phys_vaddr(pages->sgl);
 
 	__i915_gem_object_release_shmem(obj, pages, false);
 
@@ -139,7 +150,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
 				const struct drm_i915_gem_pwrite *args)
 {
-	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
+	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
 	char __user *user_data = u64_to_user_ptr(args->data_ptr);
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	int err;
@@ -170,7 +181,7 @@ int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
 int i915_gem_object_pread_phys(struct drm_i915_gem_object *obj,
 			       const struct drm_i915_gem_pread *args)
 {
-	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
+	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
 	char __user *user_data = u64_to_user_ptr(args->data_ptr);
 	int err;
 
-- 
2.54.0

