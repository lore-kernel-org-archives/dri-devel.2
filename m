Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F62C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C700C10EC4D;
	Tue, 22 Sep 2026 10:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m+di67s3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEB910EC4D;
 Tue, 22 Sep 2026 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072287; x=1821608287;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RA389VDHy06e0S5+kuyQlgitBmn87uKou7u/7xF+SCQ=;
 b=m+di67s3HpQ5OV2w7OapAbKebOwik0wLROVeJKhQCE61kBKYV2KMsnam
 R9sih1MGUg6NCr7E/ZfGURYy056RJ03oNbWdWtUY6jn1Sp7zqDmjyPq0P
 nlgTX2hsOmW45+QkJGw1KBGtl8RJ6yMN3l7mRWDyjQBNmO74nVVe/Eund
 O3RVHCdxTkxYCLCop09KYWWMyLYHgEN1F6PDziGF/vhTEzcDwM8iKjVC4
 ggTKf+CZVwYBJ3sCZxAmo1sTRHfQ4KVIjWqu1CF1THNiam/Ina1KbDmeW
 rM+UQmAKCGrYWPt67PxNiNxVT4vd177fPtgvB88071TfgJSKiCCAO61HW g==;
X-CSE-ConnectionGUID: t9GYiZWDT4G7ZouUBF1VAg==
X-CSE-MsgGUID: IgtKUSGwTpuWpGIg1iUQHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322868"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322868"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:07 -0700
X-CSE-ConnectionGUID: pWWtqvZER5SmoZPtoan3uA==
X-CSE-MsgGUID: PNOWJhk5RFqTuVu1S3++OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307983"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:05 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 15/15] drm/xe: Block BO VM access when device I/O is
 unavailable
Date: Tue, 22 Sep 2026 15:47:00 +0530
Message-ID: <20260922101721.1583542-16-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

xe_bo_vm_access() may acquire a runtime PM reference and access a BO
during PCI error recovery, after a permanent wedge or during device
unplug.

Use xe_device_io_get() to protect against unplug, PCI error recovery and
permanent wedging. Keep both protections until the runtime PM reference
has been released.

Return -EIO for a permanent wedge, -ECANCELED during PCI error recovery
and -ENODEV after device unplug.

v2:
 - Replace the runtime-PM scoped guard with explicit get/put calls
   to avoid mixing scope-based and goto-based cleanup. (Sashiko)
 - Replace the private VRAM SRCU lock with the common device I/O gate.
 - Preserve -EIO for BO access after a permanent wedge.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 73dcd397dc13..5372bc07aa4e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2235,9 +2235,18 @@ static int xe_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
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

