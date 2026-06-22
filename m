Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C70CDB479
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1688E10E82E;
	Mon, 22 Jun 2026 18:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="m+2zuXnW";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D4610E829;
 Mon, 22 Jun 2026 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782151852;
 bh=tqT0pOjk/4blrfODbUaT9pxvc1euRo9Lp5l8QbfvCnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m+2zuXnWr88d/ptX7M8Tc1IRnDsWDpEEMee79qtT1CT6OBcoP/EZ1r/474j+BI+uE
 1pKMB/IBgc8hOxCZYf11sFFiwmLQp87XMCdkZ5P0NpJNl/MS03GuQjQ/Ux/++eyygd
 DvV3HveTg/8/NsHDOzmAnD2NnQbfC/xqkuNqd55TfO6oEIRq92Gf6EoHq3hCGtokZu
 AtKAltNFrUTeEZavpFtgLWSMoBzxQojCRp1yeiUSEY05tbh1Dgh2aLejwDCf2Vnz6M
 q63A0e8ZnexgildmVsrK6SupyXTjekmtBuft80PhSmw9KrOK/9ge5Ofpg9KUcDftvd
 8sKxTs2Rci31Q==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v9 29/30] drm/i915/pmu: Convert to raw spinlock
Date: Mon, 22 Jun 2026 20:10:42 +0200
Message-ID: <20260622181044.39335-30-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622181044.39335-1-dev@lankhorst.se>
References: <20260622181044.39335-1-dev@lankhorst.se>
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

The pmu lock needs to be a raw spinlock, because cpuctx->lock from perf
is a raw spinlock too, and otherwise you get the below splat:

<3> [133.631044] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
<3> [133.631048] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
<3> [133.631049] preempt_count: 2, expected: 0
<3> [133.631050] RCU nest depth: 0, expected: 0
<4> [133.631051] 2 locks held by swapper/0/0:
<4> [133.631053]  #0: ffff88845d62e178 (&cpuctx_lock){....}-{2:2}, at: __perf_install_in_context+0x3f/0x390
<4> [133.631062]  #1: ffff88813d822200 (&pmu->lock){+.+.}-{2:2}, at: i915_pmu_enable+0x48/0x390 [i915]
<4> [133.631263] irq event stamp: 8368282
<4> [133.631264] hardirqs last  enabled at (8368281): [<ffffffff81527da9>] tick_nohz_idle_exit+0x99/0x170
<4> [133.631268] hardirqs last disabled at (8368282): [<ffffffff81539c93>] flush_smp_call_function_queue+0x73/0xf0
<4> [133.631273] softirqs last  enabled at (347482): [<ffffffff813d13fb>] __local_bh_enable_ip+0x14b/0x190
<4> [133.631277] softirqs last disabled at (347458): [<ffffffff8154619a>] cgroup_idr_alloc.constprop.0+0x2a/0x130
<4> [133.631283] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G S   U       L      7.1.0-Patchwork_159035v16-g0984dfdee2a4+ #1 PREEMPT_{RT,(lazy)}
<4> [133.631287] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER, [L]=SOFTLOCKUP
<4> [133.631287] Hardware name: Intel Corporation CoffeeLake Client Platform/CoffeeLake S UDIMM RVP, BIOS CNLSFWR1.R00.X220.B00.2103302221 03/30/2021
<4> [133.631289] Call Trace:
<4> [133.631290]  <TASK>
<4> [133.631291]  dump_stack_lvl+0x91/0xf0
<4> [133.631297]  dump_stack+0x10/0x20
<4> [133.631300]  __might_resched+0x174/0x260
<4> [133.631306]  rt_spin_lock+0x63/0x200
<4> [133.631309]  ? i915_pmu_enable+0x48/0x390 [i915]
<4> [133.631484]  i915_pmu_enable+0x48/0x390 [i915]
<4> [133.631656]  i915_pmu_event_add+0x71/0x90 [i915]
<4> [133.631827]  event_sched_in+0x105/0x270
<4> [133.631833]  merge_sched_in+0x2db/0x4e0
<4> [133.631840]  visit_groups_merge.constprop.0.isra.0+0x284/0x440
<4> [133.631845]  ? lock_is_held_type+0xa3/0x130
<4> [133.631851]  ctx_sched_in+0x32f/0x430
<4> [133.631860]  perf_event_sched_in+0x83/0xa0
<4> [133.631866]  ctx_resched+0x1c9/0x320
<4> [133.631874]  __perf_install_in_context+0x266/0x390
<4> [133.631881]  ? __pfx_remote_function+0x10/0x10
<4> [133.631885]  remote_function+0x4f/0x70
<4> [133.631888]  __flush_smp_call_function_queue+0xca/0x6e0
<4> [133.631892]  ? trace_hardirqs_on+0x22/0xf0
<4> [133.631899]  flush_smp_call_function_queue+0x85/0xf0
<4> [133.631904]  do_idle+0x16f/0x2e0
<4> [133.631911]  cpu_startup_entry+0x29/0x30
<4> [133.631914]  rest_init+0x104/0x200
<4> [133.631920]  start_kernel+0xa3a/0xcc0
<4> [133.631926]  ? sme_unmap_bootdata+0x14/0x80
<4> [133.631933]  x86_64_start_reservations+0x18/0x30
<4> [133.631936]  x86_64_start_kernel+0x106/0x150
<4> [133.631938]  ? soft_restart_cpu+0x14/0x14
<4> [133.631943]  common_startup_64+0x13e/0x141
<4> [133.631957]  </TASK>

The testcase that triggers this is perf_pmu.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/i915_pmu.c | 22 +++++++++++-----------
 drivers/gpu/drm/i915/i915_pmu.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 1c3bafda9c708..65771e54b9b51 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -232,7 +232,7 @@ static u64 get_rc6(struct intel_gt *gt)
 		intel_gt_pm_put_async(gt, wakeref);
 	}
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	if (wakeref) {
 		store_sample(pmu, gt_id, __I915_SAMPLE_RC6, val);
@@ -253,7 +253,7 @@ static u64 get_rc6(struct intel_gt *gt)
 	else
 		store_sample(pmu, gt_id, __I915_SAMPLE_RC6_LAST_REPORTED, val);
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 	return val;
 }
@@ -304,7 +304,7 @@ void i915_pmu_gt_parked(struct intel_gt *gt)
 	if (!pmu->registered)
 		return;
 
-	spin_lock_irq(&pmu->lock);
+	raw_spin_lock_irq(&pmu->lock);
 
 	park_rc6(gt);
 
@@ -316,7 +316,7 @@ void i915_pmu_gt_parked(struct intel_gt *gt)
 	if (pmu->unparked == 0)
 		pmu->timer_enabled = false;
 
-	spin_unlock_irq(&pmu->lock);
+	raw_spin_unlock_irq(&pmu->lock);
 }
 
 void i915_pmu_gt_unparked(struct intel_gt *gt)
@@ -326,7 +326,7 @@ void i915_pmu_gt_unparked(struct intel_gt *gt)
 	if (!pmu->registered)
 		return;
 
-	spin_lock_irq(&pmu->lock);
+	raw_spin_lock_irq(&pmu->lock);
 
 	/*
 	 * Re-enable sampling timer when GPU goes active.
@@ -336,7 +336,7 @@ void i915_pmu_gt_unparked(struct intel_gt *gt)
 
 	pmu->unparked |= BIT(gt->info.id);
 
-	spin_unlock_irq(&pmu->lock);
+	raw_spin_unlock_irq(&pmu->lock);
 }
 
 static void
@@ -742,7 +742,7 @@ static void i915_pmu_enable(struct perf_event *event)
 	if (bit == -1)
 		goto update;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	/*
 	 * Update the bitmask of enabled events and increment
@@ -784,7 +784,7 @@ static void i915_pmu_enable(struct perf_event *event)
 		engine->pmu.enable_count[sample]++;
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 
 update:
 	/*
@@ -805,7 +805,7 @@ static void i915_pmu_disable(struct perf_event *event)
 	if (bit == -1)
 		return;
 
-	spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&pmu->lock, flags);
 
 	if (is_engine_event(event)) {
 		u8 sample = engine_event_sample(event);
@@ -838,7 +838,7 @@ static void i915_pmu_disable(struct perf_event *event)
 		pmu->timer_enabled &= pmu_needs_timer(pmu);
 	}
 
-	spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
 }
 
 static void i915_pmu_event_start(struct perf_event *event, int flags)
@@ -1156,7 +1156,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	};
 	int ret = -ENOMEM;
 
-	spin_lock_init(&pmu->lock);
+	raw_spin_lock_init(&pmu->lock);
 	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	init_rc6(pmu);
 
diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
index 5826cc81858c4..52d4b602310a0 100644
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@ -71,7 +71,7 @@ struct i915_pmu {
 	/**
 	 * @lock: Lock protecting enable mask and ref count handling.
 	 */
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	/**
 	 * @unparked: GT unparked mask.
 	 */
-- 
2.53.0

