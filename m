Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D755606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BVk35sNo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AAD10FD41;
	Wed, 21 Oct 2026 10:04:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B9110F9C0;
 Wed, 21 Oct 2026 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577058; x=1824113058;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TeDHIUi6SwchsWtnYYAUs68mf84iOLspx7frKvdfz1M=;
 b=BVk35sNoVY8a0v4Jqn55/JICVtSr6oXOO8LnyhjPAgaNStGvSP5OAZZR
 kmbtqJyXX6SDrqKbvGBfx3GX4IDNRwA4HZh974sbQeW0bJr5d0gZ/I/zF
 M8FvIBT+NzPaLsFE1liMOz9atI4jiv8KnuqZITH5mqcWebOa1lpzEcwsY
 jx7nsR+1GaEM+JvvFSLdHy3w5QUhTzNUbd3JQTlVYPpisPwIf90cwvK63
 GgSTqy1wEzgdS0hS0xBu6GMODlileFvTH9j+tBkWIQWWHiQvrHREy/SXW
 HA4AbbD2rD+p64wZlXfm55NtqWtZLcZHjTtlknpdA7y7cXIE2u41Ycbou w==;
X-CSE-ConnectionGUID: ncDFrzvDSauN3MztG5zv0w==
X-CSE-MsgGUID: xUlOoLkhTwOtRmg6Wk+Cag==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290331"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290331"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:18 -0700
X-CSE-ConnectionGUID: ueKd+D6ZRpGht9i97jM4EQ==
X-CSE-MsgGUID: xTjXPiF+Sgm5rIKEhaEXjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382170"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:16 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 17/17] drm/xe: Block BO VM access when device I/O is
 unavailable
Date: Wed, 21 Oct 2026 15:33:18 +0530
Message-ID: <20261021100322.1014449-18-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_bo_vm_access() may acquire a runtime PM reference and access a BO
during PCI error recovery, after a permanent wedge or during device
unplug.

Use xe_device_io_get() to protect against unplug, PCI error recovery and
permanent wedging. Keep the device I/O gate held until the runtime
PM reference has been released.

Return -EIO for a permanent wedge, -ECANCELED during PCI error recovery
and -ENODEV after device unplug.

v2:
 - Replace the runtime-PM scoped guard with explicit get/put calls
   to avoid mixing scope-based and goto-based cleanup. (Sashiko)
 - Replace the private VRAM SRCU lock with the common device I/O gate.
 - Preserve -EIO for BO access after a permanent wedge.

v3:
 - Combine unplug and blocked-device protection through the common DRM
   device SRCU helper.
 - Return -ENODEV after unplug and -ECANCELED during PCI recovery, while
   preserving -EIO for a permanent wedge.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 2b3c000b7f94..ff8a7f582b86 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2330,9 +2330,18 @@ static int xe_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 	struct ttm_buffer_object *ttm_bo = vma->vm_private_data;
 	struct xe_bo *bo = ttm_to_xe_bo(ttm_bo);
 	struct xe_device *xe = xe_bo_device(bo);
+	int idx, ret;
 
-	guard(xe_pm_runtime)(xe);
-	return ttm_bo_vm_access(vma, addr, buf, len, write);
+	ret = xe_device_io_get(xe, &idx);
+	if (ret)
+		return ret == -ECANCELED && xe_device_wedged(xe) ? -EIO : ret;
+
+	xe_pm_runtime_get(xe);
+	ret = ttm_bo_vm_access(vma, addr, buf, len, write);
+	xe_pm_runtime_put(xe);
+
+	xe_device_io_put(idx);
+	return ret;
 }
 
 /**
-- 
2.43.0

