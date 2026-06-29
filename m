Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1309DC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7057F10E029;
	Mon, 29 Jun 2026 06:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F2gMnST/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D39810E029;
 Mon, 29 Jun 2026 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782713741; x=1814249741;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1b37EG7sQryQRTSZQ7FrV6NS8S5kwf8jEN/eOvmdz7w=;
 b=F2gMnST/WZdS+GH7ZJ4A+uB6NqmRxKa5AgrSDkc7X5m5z4eWZKb6QwOO
 Vk40J1SMeuOjtaUvMM9j1aZlBro4RaCTkyQzimCPMnRrFNyK3H/CrlL01
 +s+5wOLKkbm9HIDQ6ZjEqyJPM1MUK+rsWcRosddwrBrz6cYdr1EVB2y6G
 VLd7kBV0EEW6bijd27CrpfGo4Rif/m3LG4VBlh1zkEn+MR/SUubsIXKk4
 muOusaVNj2ZzUnUf5Vzh6yEcCRzr4o7SjoB5Rg0/mZroxTO20O4GZS2uF
 8URm9S38v1GCLFI4v/qNnroqRNO8JFVVu8hqwsRd5gEn85xuM86djIHzC A==;
X-CSE-ConnectionGUID: TC0iPx49TJOz56r+OmaXmg==
X-CSE-MsgGUID: euxHW1JBQJeRONIK+6aI6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="93976200"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="93976200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 23:15:40 -0700
X-CSE-ConnectionGUID: wqa5L+GpSdim/dIaX8WW0w==
X-CSE-MsgGUID: sgpKKP0lTpuIRvbKGfWuaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="255825405"
Received: from unknown (HELO shwdecgfx001.sh.intel.com) ([10.239.83.181])
 by orviesa004.jf.intel.com with ESMTP; 28 Jun 2026 23:15:38 -0700
From: "Chen, Junjia" <junjia.chen@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, "Chen, Junjia" <junjia.chen@intel.com>,
	Chen@freedesktop.org
Subject: [PATCH] drm/xe: Add creator TID to sched job trace points
Date: Mon, 29 Jun 2026 14:15:27 +0800
Message-ID: <20260629061527.146714-1-junjia.chen@intel.com>
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

Capture the creating task pid when a scheduler job is allocated
and emit it in the sched job trace events alongside the
exec queue pointer.

This makes it easier to correlate queue activity back to
the userspace thread that submitted the work.

Signed-off-by: Chen, Junjia <junjia.chen@intel.com>
---
 drivers/gpu/drm/xe/xe_sched_job.c       |  2 ++
 drivers/gpu/drm/xe/xe_sched_job_types.h |  3 +++
 drivers/gpu/drm/xe/xe_trace.h           | 12 +++++++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
index b64e6a434807..1356755cd180 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -7,6 +7,7 @@
 
 #include <uapi/drm/xe_drm.h>
 #include <linux/dma-fence-chain.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 
 #include "xe_device.h"
@@ -111,6 +112,7 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
 
 	job->q = q;
 	job->sample_timestamp = U64_MAX;
+	job->creator_tid = task_pid_nr(current);
 	kref_init(&job->refcount);
 	xe_exec_queue_get(job->q);
 
diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
index 0490b1247a6e..f2ad94105b37 100644
--- a/drivers/gpu/drm/xe/xe_sched_job_types.h
+++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
@@ -7,6 +7,7 @@
 #define _XE_SCHED_JOB_TYPES_H_
 
 #include <linux/kref.h>
+#include <linux/types.h>
 
 #include <drm/gpu_scheduler.h>
 
@@ -59,6 +60,8 @@ struct xe_sched_job {
 	u32 lrc_seqno;
 	/** @migrate_flush_flags: Additional flush flags for migration jobs */
 	u32 migrate_flush_flags;
+	/** @creator_tid: task pid that created this job */
+	pid_t creator_tid;
 	/** @sample_timestamp: Sampling of job timestamp in TDR */
 	u64 sample_timestamp;
 	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
diff --git a/drivers/gpu/drm/xe/xe_trace.h b/drivers/gpu/drm/xe/xe_trace.h
index dfd87f03c4fd..a3115d6e4c6a 100644
--- a/drivers/gpu/drm/xe/xe_trace.h
+++ b/drivers/gpu/drm/xe/xe_trace.h
@@ -258,8 +258,10 @@ DECLARE_EVENT_CLASS(xe_sched_job,
 
 		    TP_STRUCT__entry(
 			     __string(dev, __dev_name_eq(job->q))
+			     __field(struct xe_exec_queue *, q)
 			     __field(u32, seqno)
 			     __field(u32, lrc_seqno)
+			     __field(pid_t, creator_tid)
 			     __field(u8, gt_id)
 			     __field(u16, guc_id)
 			     __field(u32, guc_state)
@@ -271,8 +273,10 @@ DECLARE_EVENT_CLASS(xe_sched_job,
 
 		    TP_fast_assign(
 			   __assign_str(dev);
+			   __entry->q = job->q;
 			   __entry->seqno = xe_sched_job_seqno(job);
 			   __entry->lrc_seqno = xe_sched_job_lrc_seqno(job);
+			   __entry->creator_tid = job->creator_tid;
 			   __entry->gt_id = job->q->gt->info.id;
 			   __entry->guc_id = job->q->guc->id;
 			   __entry->guc_state =
@@ -283,9 +287,11 @@ DECLARE_EVENT_CLASS(xe_sched_job,
 			   __entry->batch_addr = (u64)job->ptrs[0].batch_addr;
 			   ),
 
-		    TP_printk("dev=%s, fence=%p, seqno=%u, lrc_seqno=%u, gt=%u, guc_id=%d, batch_addr=0x%012llx, guc_state=0x%x, flags=0x%x, error=%d",
-			      __get_str(dev), __entry->fence, __entry->seqno,
-			      __entry->lrc_seqno, __entry->gt_id, __entry->guc_id,
+		    TP_printk("dev=%s, q=%p, fence=%p, seqno=%u, lrc_seqno=%u, creator_tid=%d, gt=%u, guc_id=%d, batch_addr=0x%012llx, guc_state=0x%x, flags=0x%x, error=%d",
+			      __get_str(dev), __entry->q, __entry->fence,
+			      __entry->seqno, __entry->lrc_seqno,
+			      __entry->creator_tid,
+			      __entry->gt_id, __entry->guc_id,
 			      __entry->batch_addr, __entry->guc_state,
 			      __entry->flags, __entry->error)
 );
-- 
2.43.0

