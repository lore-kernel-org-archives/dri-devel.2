Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E1606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gxnZqmXR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C17112048;
	Wed, 18 Nov 2026 21:46:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3D1112050
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038368; x=1826574368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5PqoFVbFlBEYzFDuC+QHDW6XmoKgmXhwTSWYvwecQkA=;
 b=gxnZqmXR7DbcVAv1nESOTvTXWTLSufh6Qbb80mwW0fjUhEeSi2cn0j5p
 B58021lMla0lE0QSlwtkSxTMc9WVCcZccdiBFHBTBGs8jTqiYlN78m9wJ
 A2ufl4QK6pWGSK2oFYTiTbicotifPLDZ7Hiwa/CWk+YhuxnnaBLQx+PAb
 m9FUJVC37gNffcGUgxP5gnOvtM6tnowoIFiy5nmSHczcmp6BB8o2KwomH
 lzMGe0Q4L3zc6an0CVFgmyy14WEj4ArQ/+VLIXwamSRk3UQepGaEZ69cr
 szxP2aZ0Us66IKfz4cyAxo6Vqr6cKhgEHgMHZQ3nxSZJX82xM3xH1mLDu w==;
X-CSE-ConnectionGUID: kWxhaNddQYySUQnqX1er9g==
X-CSE-MsgGUID: 5cxx6pFnQJC1o3pxqo9nxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3758173"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3758173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:07 -0800
X-CSE-ConnectionGUID: AFn9ZiSmTjCb4I+mR59j3Q==
X-CSE-MsgGUID: H5Q5mgDSR8iM1B5/LC0+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10647087"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:07 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 08/20] drm/armada: Fix sparse __iomem address space warnings
Date: Wed, 18 Nov 2026 23:45:05 +0200
Message-ID: <20261118214518.29317-9-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The gem object keeps a single void *addr that holds either a
page_address() pointer for page backed objects, or an ioremap_wc()
mapping for linear ones. Sparse complains about the address space
mismatches when the ioremap_wc() result is stored in it, when it is
passed to iounmap(), and when it is assigned to screen_base.

Splitting the pointer in two would be a lot of churn for little gain,
so just cast around the __iomem annotation at those three places.
The casts are consistent with how the pointer is used: iounmap() is
only called for linear objects, and the fbdev framebuffer is always
a linear object mapped through armada_gem_map_object().

No functional change.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/armada/armada_fbdev.c | 2 +-
 drivers/gpu/drm/armada/armada_gem.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index f35afec2125f..073d7883d988 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -95,7 +95,7 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
 	info->fix.smem_start = obj->phys_addr;
 	info->fix.smem_len = obj->obj.size;
 	info->screen_size = obj->obj.size;
-	info->screen_base = ptr;
+	info->screen_base = (void __iomem __force *)ptr;
 	fbh->funcs = &armada_fbdev_helper_funcs;
 	fbh->fb = &dfb->fb;
 
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 8a8f4da6f44f..3503f633a8b2 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -61,7 +61,7 @@ void armada_gem_free_object(struct drm_gem_object *obj)
 		mutex_unlock(&priv->linear_lock);
 		kfree(dobj->linear);
 		if (dobj->addr)
-			iounmap(dobj->addr);
+			iounmap((void __iomem __force *)dobj->addr);
 	}
 
 	if (dobj->obj.import_attach) {
@@ -183,7 +183,8 @@ armada_gem_map_object(struct drm_device *dev, struct armada_gem_object *dobj)
 {
 	/* only linear objects need to be ioremap'd */
 	if (!dobj->addr && dobj->linear)
-		dobj->addr = ioremap_wc(dobj->phys_addr, dobj->obj.size);
+		dobj->addr = (void __force *)ioremap_wc(dobj->phys_addr,
+							dobj->obj.size);
 	return dobj->addr;
 }
 
-- 
2.56.0

