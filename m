Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8036C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5DB10F213;
	Thu,  2 Jul 2026 08:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="PpsthrbU";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDF510F202;
 Thu,  2 Jul 2026 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782979719;
 bh=Q8sFpW0LaWK/Smzuxt/7dTEculaPVCfQO31xaLLhI2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PpsthrbU6IEXagjax8vwKouEc8/UbpbvPw9uNU21BBif3JyOKyIOLeAtoGRGEXbN3
 Tq6UW1GjPGHNBW2evH1BHRo6Rb2e83DW0EPbyP4AjT0adVHicjPfY1VHUYS/YlpiaN
 FOi5YJivjlBe0UA6xpY1YzHaXMDi1onsBU9yhk50YyI9gb00fGkL2LiWwad2n8f1UK
 6Kc3X75COHUjbWkjA3x9vvA29DAqb1N3+0YTzOR4IiirgXwTcMC9z6WUnLOAd5MIp0
 vzvNbwi0H5VtYMTkjKMU94GRxAGnlPC/2/5iNyWsESF+izBtKUTAWhBUC5oDH08wuj
 GO7YsZl1fC/yA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 1/7] drm/i915/gt: Use spin_lock_irq() instead of
 local_irq_disable() + spin_lock()
Date: Thu,  2 Jul 2026 10:09:07 +0200
Message-ID: <20260702080913.434121-2-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702080913.434121-1-dev@lankhorst.se>
References: <20260702080913.434121-1-dev@lankhorst.se>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

execlists_dequeue() is invoked from a function which uses
local_irq_disable() to disable interrupts so the spin_lock() behaves
like spin_lock_irq().
This breaks PREEMPT_RT because local_irq_disable() + spin_lock() is not
the same as spin_lock_irq().

execlists_dequeue_irq() and execlists_dequeue() has each one caller
only. If intel_engine_cs::active::lock is acquired and released with the
_irq suffix then it behaves almost as if execlists_dequeue() would be
invoked with disabled interrupts. The difference is the last part of the
function which is then invoked with enabled interrupts.
I can't tell if this makes a difference. From looking at it, it might
work to move the last unlock at the end of the function as I didn't find
anything that would acquire the lock again.

Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 .../drm/i915/gt/intel_execlists_submission.c    | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 1359fc9cb88ef..e11db81dca9c5 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -1300,7 +1300,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	 * and context switches) submission.
 	 */
 
-	spin_lock(&sched_engine->lock);
+	spin_lock_irq(&sched_engine->lock);
 
 	/*
 	 * If the queue is higher priority than the last
@@ -1400,7 +1400,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 				 * Even if ELSP[1] is occupied and not worthy
 				 * of timeslices, our queue might be.
 				 */
-				spin_unlock(&sched_engine->lock);
+				spin_unlock_irq(&sched_engine->lock);
 				return;
 			}
 		}
@@ -1426,7 +1426,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 
 		if (last && !can_merge_rq(last, rq)) {
 			spin_unlock(&ve->base.sched_engine->lock);
-			spin_unlock(&engine->sched_engine->lock);
+			spin_unlock_irq(&engine->sched_engine->lock);
 			return; /* leave this for another sibling */
 		}
 
@@ -1588,7 +1588,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	 */
 	sched_engine->queue_priority_hint = queue_prio(sched_engine);
 	i915_sched_engine_reset_on_empty(sched_engine);
-	spin_unlock(&sched_engine->lock);
+	spin_unlock_irq(&sched_engine->lock);
 
 	/*
 	 * We can skip poking the HW if we ended up with exactly the same set
@@ -1614,13 +1614,6 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	}
 }
 
-static void execlists_dequeue_irq(struct intel_engine_cs *engine)
-{
-	local_irq_disable(); /* Suspend interrupts across request submission */
-	execlists_dequeue(engine);
-	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
-}
-
 static void clear_ports(struct i915_request **ports, int count)
 {
 	memset_p((void **)ports, NULL, count);
@@ -2475,7 +2468,7 @@ static void execlists_submission_tasklet(struct tasklet_struct *t)
 	}
 
 	if (!engine->execlists.pending[0]) {
-		execlists_dequeue_irq(engine);
+		execlists_dequeue(engine);
 		start_timeslice(engine);
 	}
 
-- 
2.53.0

