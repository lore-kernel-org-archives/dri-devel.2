Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D8610F9306
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 22:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9605210EBD8;
	Tue, 31 Mar 2026 22:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="esdDgrvC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A74010EBD8;
 Tue, 31 Mar 2026 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774995525; x=1806531525;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wUdaIIELWJl+i7uH46Ifi81pzzNyIffVW8w36LxytFw=;
 b=esdDgrvCmxvga0NPVS0jm53qJelONBCjpCSjoRI9b6pywYs84qGgXmo+
 3JVt6aqTSArztaZr64bpk6SEDfGNK54pQTnbmSFFj/4RuvwC637Ql3zXW
 yLjlDYoufuptKoGXh3brDvMW/7vBZjtzmonH0/zfPPBzYT4fmEllQYn07
 rLLY/WcKSsDGQzdVPkU7xdPBFo70jsGrThoXa/un3t3VO2jXivG/mE9sx
 dV0gCx4jqgR68DTF6VQ8ckS80beDqTYejKF+TS7SlaF5w4GJQK1HpbluH
 Xs5Sqb8PLQ6UmuWqFwL2lVSj2LOB9A6bD4QLMAvL/g8bB66yjVpE0R4BB Q==;
X-CSE-ConnectionGUID: wQAxIRE9Q3OXmyCsvQwAyw==
X-CSE-MsgGUID: LJgOpHjRSrWd6l7qI9O0KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87416324"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="87416324"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 15:18:45 -0700
X-CSE-ConnectionGUID: auU7s6NqTF+xcTm0JNyBkA==
X-CSE-MsgGUID: thBuCzoaRAiTE/lR+URFNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="225668430"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 15:18:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] workqueue: Add pool_workqueue to pending_pwqs list when
 unplugging multiple inactive works
Date: Tue, 31 Mar 2026 15:18:39 -0700
Message-Id: <20260331221839.1033423-1-matthew.brost@intel.com>
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

In unplug_oldest_pwq(), the first inactive pool_workqueue is activated
correctly. However, if multiple inactive works exist on the same
pool_workqueue, subsequent works fail to activate because
wq_node_nr_active.pending_pwqs is empty — the list insertion is skipped
when the pool_workqueue is plugged.

Fix this by checking for additional inactive works in
unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
accordingly.

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
 kernel/workqueue.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b77119d71641..b2cdb44ccb56 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
 	raw_spin_lock_irq(&pwq->pool->lock);
 	if (pwq->plugged) {
 		pwq->plugged = false;
-		if (pwq_activate_first_inactive(pwq, true))
+		if (pwq_activate_first_inactive(pwq, true)) {
+			if (!list_empty(&pwq->inactive_works)) {
+				struct worker_pool *pool = pwq->pool;
+				struct wq_node_nr_active *nna =
+					wq_node_nr_active(wq, pool->node);
+
+				raw_spin_lock(&nna->lock);
+				if (list_empty(&pwq->pending_node))
+					list_add_tail(&pwq->pending_node,
+						      &nna->pending_pwqs);
+				raw_spin_unlock(&nna->lock);
+			}
 			kick_pool(pwq->pool);
+		}
 	}
 	raw_spin_unlock_irq(&pwq->pool->lock);
 }
-- 
2.34.1

