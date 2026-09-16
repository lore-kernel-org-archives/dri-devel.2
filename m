Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F60C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F046B10E722;
	Wed, 16 Sep 2026 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N4pDzeaK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB9D10E431;
 Wed, 16 Sep 2026 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789552432; x=1821088432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0Mx7MTphfG67Z1xkRI7f8qtbhYVcxh77JLrM4Ub8Mhs=;
 b=N4pDzeaKOdsJa18VUuhKdWN6aXY14wX9cR0j1KHEmYssX2/ni52YeA7A
 HMld1eW7SJf0clq7GrJ6xtM5kjinw6xJ2mxS3liNu8bw/pcc50XXQN/nA
 LL1qDXJo19SSqdezUlG42PjdXTBM+tJiDJr6AIrVNseoAjJILO8xFQwqF
 7E9R7bOIgewq29zQ3VjVeEhlRnBx/TKo5D29VaF/H4UyZwJI2pzYBdvb1
 sJSNxZ4PwZX47oq3HECObop6IGP9RuzCGecI25KRoPZsQcucYtD/SzldZ
 X3HZzh0VKKIuGcItUW7ICajYlZDsL8NPqabRMq8q2u+5dmafU2I8wqzN4 Q==;
X-CSE-ConnectionGUID: qnWKCO7wTMmKkiLDBTHATg==
X-CSE-MsgGUID: Gii9qAq8TZe7p5MFogruaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="429596"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="429596"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:52 -0700
X-CSE-ConnectionGUID: mQwaF0i6T/K2cxg6TGZArQ==
X-CSE-MsgGUID: lNdnwiKcSOayWuO5zXivfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277415535"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:53:50 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH 2/5] drm/xe/guc: Wake disable waiters after clearing pending
 state
Date: Wed, 16 Sep 2026 15:23:34 +0530
Message-ID: <20260916095337.3104891-3-arvind.yadav@intel.com>
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

disable_scheduling_deregister() waits for any pending scheduling
operation to complete before destroying an exec queue.

For a disable completion, handle_sched_done() can wake the waiter before
clearing pending_disable, or not wake it at all. The waiter can then miss
a completed operation and expire after five seconds. This causes a
spurious GT reset and immediate TDR.

Clear pending_disable before waking the waitqueue on every completion
path. Sample the destroyed state before clearing the pending state, as
required by the existing destroy protocol.

Also wake CT waiters after a suspend completion.
The queue remains alive until deregistration completes, so waking
waiters before sending the deregister request does not release it.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 42 +++++++++++++++++-------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index f3ba8abfc228..ca24a77dfb26 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -3265,26 +3265,32 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
 		if (q->guc->suspend_pending) {
 			clear_exec_queue_pending_disable(q);
 			suspend_fence_signal(q);
+
+			/*
+			 * Publish the cleared state before waking waiters.
+			 */
+			smp_wmb();
+			wake_up_all(&guc->ct.wq);
 		} else {
-			if (exec_queue_banned(q)) {
-				smp_wmb();
-				wake_up_all(&guc->ct.wq);
-			}
-			if (exec_queue_destroyed(q)) {
-				/*
-				 * Make sure to clear the pending_disable only
-				 * after sampling the destroyed state. We want
-				 * to ensure we don't trigger the unregister too
-				 * early with something intending to only
-				 * disable scheduling. The caller doing the
-				 * destroy must wait for an ongoing
-				 * pending_disable before marking as destroyed.
-				 */
-				clear_exec_queue_pending_disable(q);
+			bool destroyed = exec_queue_destroyed(q);
+
+			/*
+			 * Make sure to clear pending_disable only after sampling
+			 * the destroyed state. The caller doing the destroy must
+			 * wait for an ongoing disable before marking the queue
+			 * destroyed.
+			 */
+			clear_exec_queue_pending_disable(q);
+
+			/*
+			 * Publish the cleared state before waking waiters.
+			 */
+			smp_wmb();
+			wake_up_all(&guc->ct.wq);
+
+			/* The queue remains alive until DEREGISTER_DONE. */
+			if (destroyed)
 				deregister_exec_queue(guc, q);
-			} else {
-				clear_exec_queue_pending_disable(q);
-			}
 		}
 	}
 }
-- 
2.43.0

