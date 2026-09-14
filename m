Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C87C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBA210EC05;
	Mon, 14 Sep 2026 08:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d+qLVvmA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C729F10EC05
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789374612; x=1820910612;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7htPmJ+8L6Q33vIftc7WP97VIExvIeWJtVPZnYwNlWE=;
 b=d+qLVvmAnQ9JuCz4rm58rrphgLBk9l6ajLJMlyqBFEZFLWst6dyI1f0t
 0rAMKw2GWtwm5fyl1D5XpEqFzlKLEBVtDrmYz271w9A+n+cQHxjPJekgQ
 ug8xEhi2ScPDLywjwGduFImloYn9Jj7LTaRiRPBvvCVH6uN6sm2CzHXfe
 ogfMVTxKXSVPTMHVlDZsvzZUcyTM66ImddQE0PybowCZQ009FI8G11Lud
 UPPrYZ3RouPtjNyScn1XYNOQhCeZtT4I4pJxkP5YVOFAnp0SYObRk+DZn
 ZOWRJelilKoh14pv7DYDHy0aCH1+LLH8lqvjkGUgFdlh0+SdwCxui8dB3 A==;
X-CSE-ConnectionGUID: 90O5AbXuREekAl9w5PMqdw==
X-CSE-MsgGUID: cFnmkBqSQui61oNgrwtaWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="112493965"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="112493965"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:30:12 -0700
X-CSE-ConnectionGUID: UU8bHpnlTk2Ky78GiQ8BZw==
X-CSE-MsgGUID: lpIw28vdSIaHFx6i1Jtbow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="276736370"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:30:10 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Jozef Wludzik <jozef.wludzik@intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Synchronize context abort work with device reset
Date: Mon, 14 Sep 2026 10:30:06 +0200
Message-ID: <20260914083006.892645-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

From: Jozef Wludzik <jozef.wludzik@intel.com>

Acquire pm->reset_lock in ivpu_context_abort_work_fn() to prevent it
from running concurrently with a device reset. If the lock cannot be
acquired immediately, skip the abort work to avoid racing with reset.
The device power management is disabled during reset.

Signed-off-by: Jozef Wludzik <jozef.wludzik@intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index fa04f79e8f7b..245512bab523 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -1311,9 +1311,12 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 	unsigned long ctx_id;
 	unsigned long id;
 
-	if (drm_WARN_ON(&vdev->drm, pm_runtime_get_if_active(vdev->drm.dev) <= 0))
+	if (!down_read_trylock(&vdev->pm->reset_lock))
 		return;
 
+	if (drm_WARN_ON(&vdev->drm, pm_runtime_get_if_active(vdev->drm.dev) <= 0))
+		goto unlock;
+
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
 		if (reset_engine_and_mark_faulty_contexts(vdev))
 			goto runtime_put;
@@ -1354,4 +1357,6 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 
 runtime_put:
 	pm_runtime_put_autosuspend(vdev->drm.dev);
+unlock:
+	up_read(&vdev->pm->reset_lock);
 }
-- 
2.43.0

