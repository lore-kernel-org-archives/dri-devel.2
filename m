Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC65CC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102F510EB14;
	Wed, 14 Oct 2026 19:34:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACCB10EB14;
 Wed, 14 Oct 2026 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006484; x=1823542484;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ROA1y4Imn26ZihDZLCfKrfYBY8+UGFyYCXdsoVuYKlM=;
 b=lv1qWJ8lYJZaKtH5y/jeGVCXCmBw8PzjrazmLWm9ylcjTMPfvI2aRgct
 NOZoqIS16ZZ9ol3c/AjKRtgSSHsIEH0zyF4pHeWwR+Lh1K99nhIkT3jtR
 SHT2K4oecAOvfsAelyPVztlDWvqwdN2N0oYv++vo2Qzid+SvjQ5sEYyvG
 Gx/dSGB6VGfkH0GG86ag4SlOWK2IKM8RXqd/QJe3r0et1GINX10JJ3b/U
 LqqxEKaEbHpExgYfe/EAXV/tkvbOXsk4eEm+bjF0gxLH9DVdkMfEKdXLl
 sSsmAATLn/rHxLffNmwoI46G0MdMRN20KxPdYAnBzd23yGBSIT2b0mJqd A==;
X-CSE-ConnectionGUID: CTHri4QFSjqgR+9LGH5NbA==
X-CSE-MsgGUID: +/4uoyr2SuSGxnhiPDvs+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653873"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653873"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: pGQEQ+ylTVeFI2wpAQ6DdQ==
X-CSE-MsgGUID: HUxWcZEsTEuz0jaVdWfPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270514"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 08/12] drm/omapdrm: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:28 -0700
Message-ID: <20261014193421.1705112-22-niranjana.vishwanathapura@intel.com>
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

Replace the open-coded self-import check with the drm core helper
drm_gem_prime_self_import(), which performs the same ops and device
match and returns the backing GEM object with a reference.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
index 30cf1cdc1aa3..fd479dc3c01e 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
@@ -102,17 +102,9 @@ struct drm_gem_object *omap_gem_prime_import(struct drm_device *dev,
 	struct sg_table *sgt;
 	int ret;
 
-	if (dma_buf->ops == &omap_dmabuf_ops) {
-		obj = dma_buf->priv;
-		if (obj->dev == dev) {
-			/*
-			 * Importing dmabuf exported from out own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			drm_gem_object_get(obj);
-			return obj;
-		}
-	}
+	obj = drm_gem_prime_self_import(dev, dma_buf, &omap_dmabuf_ops);
+	if (obj)
+		return obj;
 
 	attach = dma_buf_attach(dma_buf, dev->dev);
 	if (IS_ERR(attach))
-- 
2.43.0

