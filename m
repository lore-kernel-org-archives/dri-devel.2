Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E04C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DECD10E2F9;
	Wed, 16 Sep 2026 09:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cdXX6ouD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E463610E8A4;
 Wed, 16 Sep 2026 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789552438; x=1821088438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sva6WVpd0pDoNKxpgtpCwi1QvDuFKi2gSP+Is+AT3Aw=;
 b=cdXX6ouDRKPsNNr9H+xT2YzDCufgyMAlISYBUUMa3IHOkkgFZTuDVprm
 LR6Hcj8qEhj/ZFUgfmkRTyIh2LC/FbyNN2al3tj8nIUmU0Pe7LdJc/Olc
 sOi+5t09v5TpGisNm5znjku1DAziCLL9Z1WxOOFLXwtUCT95ucWmLhD+r
 nKN7103aTORkGrO9I0JDdlNhFGvsjJK1rckAJWhNJ4ltO/EfvvWgrocWe
 CwkTDFJUXnNk4Q48IkfwYlNN8qc9a6ab0463fL4ftD3kWwoyJ9uB2HK4m
 J952jEBo7NBl5In3oCg86FyURic70E62wkNwv6BSZMBCZtxGMIYfVHRxT w==;
X-CSE-ConnectionGUID: SLyvrGzSQiORO0HETCE3AA==
X-CSE-MsgGUID: 0BTRF9NVQgqYI5zvS1lbjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="429605"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="429605"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:58 -0700
X-CSE-ConnectionGUID: 7AZYY5eMQa63QAFcTyeITA==
X-CSE-MsgGUID: nBJz1UtFRi+9wS9zjoQV2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277415582"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:56 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH 5/5] drm/xe/guc: Reset LRC ring pointers before replay
Date: Wed, 16 Sep 2026 15:23:37 +0530
Message-ID: <20260916095337.3104891-6-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916095337.3104891-1-arvind.yadav@intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
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

A GT reset can stop a context after the LRC head has advanced past the
start of the oldest pending job.

The replay path rewinds the software ring tail to the job's recorded
start so the pending jobs are written again. However, it leaves the LRC
head at its saved later position and initializes the LRC tail from that
position.

The hardware and software ring positions can therefore use different
replay starting points.

Before resubmitting the queue, set the software tail and both LRC ring
pointers to the start of the oldest pending job. Update the pointers
while the context is unregistered, before resubmitting pending jobs.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index ca24a77dfb26..878ba94d22e0 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2984,17 +2984,17 @@ static void guc_exec_queue_start(struct xe_exec_queue *q)
 		trace_xe_exec_queue_resubmit(q);
 		if (job) {
 			for (i = 0; i < q->width; ++i) {
+				u32 replay_head = job->ptrs[i].head;
+
 				/*
-				 * The GuC context is unregistered at this point
-				 * time, adjusting software ring tail ensures
-				 * jobs are rewritten in original placement,
-				 * adjusting LRC tail ensures the newly loaded
-				 * GuC / contexts only view the LRC tail
-				 * increasing as jobs are written out.
+				 * A started job may have advanced the saved LRC
+				 * head past its original ring position. Rewind
+				 * both head and tail before rewriting and
+				 * replaying the pending jobs.
 				 */
-				q->lrc[i]->ring.tail = job->ptrs[i].head;
-				xe_lrc_set_ring_tail(q->lrc[i],
-						     xe_lrc_ring_head(q->lrc[i]));
+				q->lrc[i]->ring.tail = replay_head;
+				xe_lrc_set_ring_head(q->lrc[i], replay_head);
+				xe_lrc_set_ring_tail(q->lrc[i], replay_head);
 			}
 		}
 		xe_sched_resubmit_jobs(sched);
-- 
2.43.0

