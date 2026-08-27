Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133ABC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55ABE10EF99;
	Thu, 27 Aug 2026 10:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KvdMgCPW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF96D10EF92;
 Thu, 27 Aug 2026 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825936; x=1819361936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5IVKJG61ZRpGvcrack0euFQ9WvdsWjeyMftRGQMMVIk=;
 b=KvdMgCPWHwf+MNVbEndfxSDJdE3H/QfTm6QoGyNBsxCihoB97K/9WfXg
 VCLLL/cakKfZl6Sspl45WJFOgA8YxR6ZV+2Mcbi0/HTgHH0t4tyvqE/QC
 WNGL223+8f3I/aY6q0KWznHJvpAbTsG9nKrvczKqIiU3QpmeNAHRwsg77
 2bIDRUOJ8+1dwK6E4i+K6aebMQS4aMxnQ0IsQspqogKTmfryUG9doMNxM
 k4VVROpDYLONRXs5oxpXaDO/yG0KWsnPoGpGqRovwkAKRn7+FyKSFustF
 UUN1BDObRGVKQavDIkEQ2ap4m05A+4xiy62VCcZuHRruPI3bMs7IowOAz A==;
X-CSE-ConnectionGUID: D3hZQ/ZVRAOhWwC6ui75qw==
X-CSE-MsgGUID: puTPmNnDQneIn5N3nE95TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445885"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445885"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:56 -0700
X-CSE-ConnectionGUID: dxcX0MIZTHezdTYIzWRLOg==
X-CSE-MsgGUID: 7yOugB1cSuiEGbdeNvJ6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057670"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:55 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 13/13] drm/xe: Block BO VM access when device I/O is
 unavailable
Date: Thu, 27 Aug 2026 15:48:01 +0530
Message-ID: <20260827101801.1247654-14-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

Return -EIO when device I/O is blocked. Use drm_dev_enter() to protect
against concurrent unplug and keep that protection until the runtime PM
reference has been released.

Use the same SRCU domain as CPU faults so wedge isolation waits for a BO
access that started before the wedge.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 1eabece56f6c..717d318c7072 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2245,9 +2245,25 @@ static int xe_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 	struct ttm_buffer_object *ttm_bo = vma->vm_private_data;
 	struct xe_bo *bo = ttm_to_xe_bo(ttm_bo);
 	struct xe_device *xe = xe_bo_device(bo);
+	int idx, srcu_idx, ret = -EIO;
 
-	guard(xe_pm_runtime)(xe);
-	return ttm_bo_vm_access(vma, addr, buf, len, write);
+	srcu_idx = srcu_read_lock(&xe->mem_access.vram_userfault.srcu);
+
+	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
+		goto out_srcu;
+
+	/*
+	 * Keep the drm_dev_enter() protection until the runtime PM
+	 * reference has been released.
+	 */
+	scoped_guard(xe_pm_runtime, xe)
+		ret = ttm_bo_vm_access(vma, addr, buf, len, write);
+
+	drm_dev_exit(idx);
+
+out_srcu:
+	srcu_read_unlock(&xe->mem_access.vram_userfault.srcu, srcu_idx);
+	return ret;
 }
 
 /**
-- 
2.43.0

