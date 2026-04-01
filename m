Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12B910F92EC
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A67910EB28;
	Wed,  1 Apr 2026 01:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H4VzPbGC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2213C10EA95;
 Wed,  1 Apr 2026 01:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775005666; x=1806541666;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GLAKlABRqthQzbsSCazQZWFbmhY4kPHJe9oDq89F8xc=;
 b=H4VzPbGC3nk0Zd4xywom4eF9TRpSjP+KUnUG1a6DBxRmmjZxt1wSYGLX
 0otkpLXTOGHvPqWwx1f95RxsfSCayCxp1mCw9m6nlFKolFLpATcJjevXq
 ayAVDCEenxMhoAIU4w5s1sqcGsenRGuOMk0dU7K1EH1AwUh+hnkzCbnU5
 m+nH0jKzN5xz3qR/AyUzbHFfLu+8u/abBBjAsCeDLNp/gxS1PI7lBgU4i
 VJqp/cK3rgSGj2v4cta5LwKRdWzUkBEFOYRw0CVJi3/AuLVivYzH8tDuq
 gEyGIbv8uCUglRhZ+UDfOXuavqjDrnraic3eRYO6o/g4avj7z12yQV2oG A==;
X-CSE-ConnectionGUID: ZtjNyDjKSS2CuFA8/OR3NA==
X-CSE-MsgGUID: JBY7h6IoQSKG5snMyg6BRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75918651"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="75918651"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 18:07:46 -0700
X-CSE-ConnectionGUID: B1AUn3utTvWGeRd8hOwkcg==
X-CSE-MsgGUID: i2ctNmmjTXeAUvQ400KjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="222132370"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 18:07:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list when
 unplugging multiple inactive works
Date: Tue, 31 Mar 2026 18:07:39 -0700
Message-Id: <20260401010739.1053192-1-matthew.brost@intel.com>
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

In unplug_oldest_pwq(), the first inactive work item on the
pool_workqueue is activated correctly. However, if multiple inactive
works exist on the same pool_workqueue, subsequent works fail to
activate because wq_node_nr_active.pending_pwqs is empty — the list
insertion is skipped when the pool_workqueue is plugged.

Fix this by checking for additional inactive works in
unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
accordingly.

v2:
 - Use pwq_activate_first_inactive(pwq, false) rather than open coding
   list operations (Tejun)

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

This bug was first reported by Google, where the Xe driver appeared to
hang due to a fencing signal not completing. We traced the issue to work
items not being scheduled, and it can be trivially reproduced on drm-tip
with the following commands:

shell0:
for i in {1..100}; do echo "Run $i"; xe_exec_threads --r \
threads-rebind-bindexecqueue; done

shell1:
for i in {1..1000}; do echo "toggle $i"; echo f > \
/sys/devices/virtual/workqueue/cpumask; echo ff > \
/sys/devices/virtual/workqueue/cpumask; echo fff > \
/sys/devices/virtual/workqueue/cpumask ; echo ffff > \
/sys/devices/virtual/workqueue/cpumask; sleep .1; done
---
 kernel/workqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b77119d71641..bee3f37fffde 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,8 +1849,17 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
 	raw_spin_lock_irq(&pwq->pool->lock);
 	if (pwq->plugged) {
 		pwq->plugged = false;
-		if (pwq_activate_first_inactive(pwq, true))
+		if (pwq_activate_first_inactive(pwq, true)) {
+			/*
+			 * pwq is unbound. Additional inactive work_items need
+			 * to reinsert the pwq into nna->pending_pwqs, which
+			 * was skipped while pwq->plugged was true. See
+			 * pwq_tryinc_nr_active() for additional details.
+			 */
+			pwq_activate_first_inactive(pwq, false);
+
 			kick_pool(pwq->pool);
+		}
 	}
 	raw_spin_unlock_irq(&pwq->pool->lock);
 }
-- 
2.34.1

