Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3DDD39418
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465FA10E079;
	Thu,  2 Apr 2026 12:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WxKHJvfq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D528910E079
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775134537; x=1806670537;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wOoaJkXFKMTcFzm8BoGPIjGXtcvVCAATVHJDdOpAuHw=;
 b=WxKHJvfqbZFVcr8F+Kx1zWvj5YWFdMXourk5qF0J4fhrvrsVCBJCjeL6
 CTVJhngzow7eagjSj0gIcQEYslpkJrlJQ+QVP4HLY/HY/38tMMfLOiMIe
 Ciq1kQUU7BKawdMa9FevnMY73iPeg1EyLIWb6ZFwqo+7KM+X1VmzBzrHp
 idPQr9ym0/xKFr2yWWFylj5yPjQ8BdaXMejFwZ9QsVqDDs2hEsNjWGd/M
 KgcsPKwObgi27t5GeZTMAjOtmvUeU27uPIVhAMv48EMUbm6eLB9V6fWBv
 l8V+dvV8dPpZbuHlBnHQFLzaMMj7nVJpB05yEL1wS2T2oE5AcLmlA1bsU g==;
X-CSE-ConnectionGUID: +BlK5MyyS/i7Cs1E9QUpgw==
X-CSE-MsgGUID: CYtvC19mSBWfv4/QDFbj0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="63742211"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="63742211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 05:55:36 -0700
X-CSE-ConnectionGUID: 2+LEBX7DTL+CpT3HuIr0FA==
X-CSE-MsgGUID: TxU4xJOqSBmrD6nhG7B/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226136540"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 05:55:34 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Trigger recovery on TDR with OS scheduling
Date: Thu,  2 Apr 2026 14:55:26 +0200
Message-ID: <20260402125526.845210-1-karol.wachowski@linux.intel.com>
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

With OS scheduling mode the driver cannot determine which context
caused the timeout, so context abort cannot be used. Instead of
queuing context_abort_work, directly trigger full device recovery
when a job timeout (TDR) occurs in OS scheduling mode.

Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 83da9b297f37..c1ce8329790e 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -221,6 +221,12 @@ static void ivpu_job_timeout_work(struct work_struct *work)
 
 abort:
 	atomic_set(&vdev->job_timeout_counter, 0);
+
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS) {
+		ivpu_pm_trigger_recovery(vdev, "Job timeout");
+		return;
+	}
+
 	ivpu_jsm_state_dump(vdev);
 	ivpu_dev_coredump(vdev);
 	queue_work(system_percpu_wq, &vdev->context_abort_work);
-- 
2.43.0

