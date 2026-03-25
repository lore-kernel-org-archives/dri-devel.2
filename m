Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53721109E522
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 23:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F9310E127;
	Wed, 25 Mar 2026 23:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OabhQOt1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A401E10E096;
 Wed, 25 Mar 2026 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774480575; x=1806016575;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+hEtfcAfKnndyNWJv3S23Kf8KA0aD3OFYs2HcDLOaj0=;
 b=OabhQOt1t8dhLCepvzDDIOern3y9Wzwd/EsZZ7t5+d55s9o2OWripNkZ
 /0IYaUld8hpCKiR2OQcX6zZq+g2nUkCGwiTvahDLRLM3/K55i0OO7ClJI
 aRUZgbXVDoHoWDrIirMr4GmDfW6PaOaT7tiAFbsvBElGAFF2mT8jDzwGE
 fE+a6d46Goin2v3OBzAY65EWLYGRGXJeZrjUXLlvrIGFUcq3YuUqkoQX9
 VlQ31cISSUNvOa1LVUu11G54XCFzwKKcqPRh7DeHMNAivLspVern+PSs6
 K5zZRwxOhvZ54m0HY69D6lxulrXpfnG/9fddh+3poGDm95RQmY3kSmTiH Q==;
X-CSE-ConnectionGUID: Jg2Lj5alTxarks1KzoDLgw==
X-CSE-MsgGUID: qhtxKFUUSLiZasccb2eyqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93109629"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="93109629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 16:16:14 -0700
X-CSE-ConnectionGUID: bNeh4jpLSLGisa4c5nFgFg==
X-CSE-MsgGUID: NBF1DPAkTsq7NqiaZmTI1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="229760977"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 16:16:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/gpusvm: Reject VMAs with VM_IO or VM_PFNMAP when creating
 SVM ranges
Date: Wed, 25 Mar 2026 16:16:08 -0700
Message-Id: <20260325231608.25581-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

VMAs marked with VM_IO or VM_PFNMAP are not backed by struct page
objects, which GPUSVM requires in order to operate correctly. In
particular, get_pages() relies on hmm_range_fault() to resolve struct
pages for the target range.

Attempting to create an SVM range on such VMAs results in repeated
get_pages() failures and can lead to an infinite loop inside a driver’s
page‑fault handler. Prevent this by rejecting ranges on VM_IO or
VM_PFNMAP VMAs and returning -EIO.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 4b928fda5b12..7993e85c0566 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1065,6 +1065,11 @@ drm_gpusvm_range_find_or_insert(struct drm_gpusvm *gpusvm,
 		goto err_notifier_remove;
 	}
 
+	if (vas->vm_flags & (VM_IO | VM_PFNMAP)) {
+		err = -EIO;
+		goto err_notifier_remove;
+	}
+
 	range = drm_gpusvm_range_find(notifier, fault_addr, fault_addr + 1);
 	if (range)
 		goto out_mmunlock;
-- 
2.34.1

