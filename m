Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB983CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD7510E3D9;
	Fri,  2 Oct 2026 16:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Jz8yfhif";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3ADA10E3D9
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790957507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vK1CzLr2knng7kaVPyqiq+agR4cUNmjOoYex2Chji+Q=;
 b=Jz8yfhifErqlXa4hVAj3Mbz+L0aVB0P1RBA3BPvGqkZUozHAXcGq1BOh95J6sqzZLpX2Cr
 rGwkMbhywGSukiWfiRd832qTz8yAlRkNt06urmIlgBDlvnLQInDVxIBt7EoWFx8V1hz3C3
 nK8l82NGoL+N3lJXD94LjtiYjpEFTJY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-XmFw0_iROZKMTosCPe3LMg-1; Fri,
 02 Oct 2026 12:11:44 -0400
X-MC-Unique: XmFw0_iROZKMTosCPe3LMg-1
X-Mimecast-MFC-AGG-ID: XmFw0_iROZKMTosCPe3LMg_1790957503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 524681955F1F; Fri,  2 Oct 2026 16:11:42 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D53F180056E; Fri,  2 Oct 2026 16:11:40 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] drm/i915/pmu: convert i915_pmu->lock to raw_spinlock_t from
 spinlock_t
Date: Fri,  2 Oct 2026 12:11:36 -0400
Message-ID: <20261002161137.297365-1-ashelat@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: vbxUwJO9jStkpIMZYqVOIKdO1j_PAq2pVzqiXaXXxg4_1790957503
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

When perf runs event operations, it calls event_function() which takes a
raw_spinlock_t. This can eventually lead to i915_pmu_enable() taking a
spinlock_t, which causes lockdep to throw "Bug: Invalid wait context".
The call chain:

 event_function()
    __perf_ctx_lock()
      raw_spin_lock(&ctx->lock)
    __perf_event_enable()                          // efs->func()
      ctx_resched()
        perf_event_sched_in()
          ctx_sched_in()
            __pmu_ctx_sched_in()
              merge_sched_in()
                group_sched_in()
                  event_sched_in()
                    event->pmu->add()              // = i915_pmu_event_add()
                      i915_pmu_event_start()
                        i915_pmu_enable()
                          spin_lock_irqsave(&pmu->lock)

On systems running an RT kernel, spinlock_t can sleep which can cause a
sleep-in-atomic error.

Fix this by using raw_spinlock_t for i915_pmu->lock instead of
spinlock_t.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 22 +++++++++++-----------
 drivers/gpu/drm/i915/i915_pmu.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 1c3bafda9c70..65771e54b9b5 100644
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
index 5826cc81858c..52d4b602310a 100644
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
2.55.0

