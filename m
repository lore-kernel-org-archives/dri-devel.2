Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1363DC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A0410ED1C;
	Wed,  5 Aug 2026 06:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJPk3UJG";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CD510ED1C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 06:45:47 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so695032a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785912347; x=1786517147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3IeHonVU+uKZ8ZJ0JwyJk4mskUUQ64nNqMUIv81MkYQ=;
 b=PJPk3UJGYSTMbSViDvcyirOYDyzsijwjbYCuirXLG1mi3IoXzflQ1pdF1Hbqr86A7v
 mOGS3RZlx0bI7Ncl37hLdWxKwgtP2Fr/C1z7Cg6JEyOB3Ue6PEeAfcl0W+NRp1QIPMB4
 8vWgEb010HpRdwhKKSeYUzeDaFlej2+Y7uJmSgz/RmNgBzfdXL+se/+z5+ipXN8ZZ8sT
 VLlT9MdPLq/gj+nGpW5XZ6NMYf3gB6/X99CtAnK6GTqaOKo4cO9rLyLkeZxHuC/GyprG
 GJCyhDNt1THRUcnk+fW5KuXrzyShr+WXAB+7opCxdEAM4TiK5UtveVw1sHS7dRjokTqH
 JPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785912347; x=1786517147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3IeHonVU+uKZ8ZJ0JwyJk4mskUUQ64nNqMUIv81MkYQ=;
 b=sooZ6gwRv3uf9DaqolJuR0Mx+GlwG6Axz6ZvGTjy3TWe/a+c50eT5ZNGoZWM0MqzCI
 JBg9xWLKQSKqIMuDIUTtGd6JTRQgUCbz2mPu7TjESVdwjTtS7AlfAXdWsJEJM6PKHxTh
 qRfH+JyQduPd5aDcIQ2co6a5nE1zLGrmhtGLpBCq3JRX1V5EuS34u9zH5woE7hp4V5Fy
 5Lht8Fj2Ob1gLNyreFApXZtxvYANkYSwjwdAGpBwwdrQ6rlucUifR8+8HoXF4gihVs6r
 JlWpK88vKfahIOYFBS1Y2xmRGk1MjyoQbY2FEhXGhPc20J9r6hvBWRZWj+3EcAO6NwVX
 10IA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2DfYRi3hwvXofSTLj8nKUmbaC0u2/H0o0GIxuU3QR7R21wmJQAEZz5SfwGxZluA8JGi6GmwZsQ0E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwST1bL4uOLLInpjTfbK4iSAUIPpTakKKkGC/rsnhc0Vy35UE7F
 Bf2RWUgP7jkBdxftQPbHLoYfOy+TArXRXk/33kWfT5v4EcmF6Dand23M
X-Gm-Gg: AR+sD10cwpYwvyME96zsruPa7ov99aTGSnMWSYaJ/iE48fz8VnaHM42uzsfFYEaRB51
 76xwhKlhx+F8Ra8/M2Rq9w27xRt1JoaBkQS9fwhIYt0V+H0Ojqch1muO/CttHeTrv+YOdXIdbB9
 JNf8AQxdK1HDPwmG8dMPC8rOE23GoO/wdU3pWuPD0gyZxWdhuj931Ggb4S2Ws10Us1+aMnjA9Lt
 QUrdDjapzm/jYo0P6kK7G5jJBu+tWF44WQj1TQ2td//f/wEVovyjlpR5/pV0XHJry3DXWPUbyqg
 6DfUD7eYirl0+q7jZW9wcYhK5AQLXG1Iz8ELP1n0uE9zL7XSB5OOIlJA7tObjFw2jXjlgicZqHf
 urqCHX7rlE0+2MyxiAn0TrkarVb3bsPISNTluHYaFUCeC6xUvDeQF16LJTZUTV2zFFEopURLDgp
 DQdHokTEU3dV6K986E780e/gllP0ZsAy13Lp3q2ynYaiBe/wqmfeYLuKBE3qYaVaFWSnfboakFd
 aPeekHg5SPc0xD4Otb4
X-Received: by 2002:a17:90b:3c06:b0:38d:e658:595a with SMTP id
 98e67ed59e1d1-3903c54f1fdmr4635061a91.2.1785912346774; 
 Tue, 04 Aug 2026 23:45:46 -0700 (PDT)
Received: from liuweife-desk2.sh.intel.com ([192.55.55.42])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm10399086c88.14.2026.08.04.23.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 23:45:46 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: matthew.brost@intel.com, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, dri-devel@lists.freedesktop.org,
 Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH] drm/i915: Make suspend idle wait uninterruptible
Date: Wed,  5 Aug 2026 14:45:39 +0800
Message-ID: <20260805064539.1034880-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.55.0
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

wait_for_suspend() only handles -ETIME from the GT idle wait. However,
the wait can also be interrupted by a pending signal while retiring
requests or waiting for GuC messages, e.g., during the reboot process
invoked by init. This skips the wedge and cleanup path and may leave
suspend waiting indefinitely for a leaked wakeref.

Make only the suspend idle wait uninterruptible while preserving its
existing timeout. Other callers remain interruptible, and the GT is
still wedged only when the timeout expires.

Cc: Matthew Brost <matthew.brost@intel.com>
Assisted-by: OpenCode:GPT-5.6-Sol
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_gt.c            | 24 +++++++++++++++----
 drivers/gpu/drm/i915/gt/intel_gt.h            |  1 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.c         |  3 ++-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c   |  8 ++++---
 drivers/gpu/drm/i915/gt/intel_gt_requests.h   | 13 ++++++++--
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |  3 ++-
 .../gpu/drm/i915/gt/uc/intel_guc_submission.c |  5 ++--
 drivers/gpu/drm/i915/gt/uc/intel_uc.h         |  6 +++--
 8 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index 5c7f862f7100..5eaa52f535d4 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -659,7 +659,9 @@ static void __intel_gt_disable(struct intel_gt *gt)
 	GEM_BUG_ON(intel_gt_pm_is_awake(gt));
 }
 
-int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
+static int __intel_gt_wait_for_idle(struct intel_gt *gt,
+				    bool interruptible,
+				    long timeout)
 {
 	long remaining_timeout;
 
@@ -667,10 +669,11 @@ int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
 	if (!intel_gt_pm_is_awake(gt))
 		return 0;
 
-	while ((timeout = intel_gt_retire_requests_timeout(gt, timeout,
-							   &remaining_timeout)) > 0) {
+	while ((timeout = __intel_gt_retire_requests_timeout(gt, interruptible,
+							     timeout,
+							     &remaining_timeout)) > 0) {
 		cond_resched();
-		if (signal_pending(current))
+		if (interruptible && signal_pending(current))
 			return -EINTR;
 	}
 
@@ -680,7 +683,18 @@ int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
 	if (remaining_timeout < 0)
 		remaining_timeout = 0;
 
-	return intel_uc_wait_for_idle(&gt->uc, remaining_timeout);
+	return intel_uc_wait_for_idle(&gt->uc, interruptible,
+				      remaining_timeout);
+}
+
+int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
+{
+	return __intel_gt_wait_for_idle(gt, true, timeout);
+}
+
+int intel_gt_wait_for_idle_uninterruptible(struct intel_gt *gt, long timeout)
+{
+	return __intel_gt_wait_for_idle(gt, false, timeout);
 }
 
 int intel_gt_init(struct intel_gt *gt)
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
index 998ca029b73a..6c7e5415f1dc 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt.h
@@ -143,6 +143,7 @@ void intel_gt_driver_release(struct intel_gt *gt);
 void intel_gt_driver_late_release_all(struct drm_i915_private *i915);
 
 int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout);
+int intel_gt_wait_for_idle_uninterruptible(struct intel_gt *gt, long timeout);
 
 void intel_gt_check_and_clear_faults(struct intel_gt *gt);
 i915_reg_t intel_gt_perf_limit_reasons_reg(struct intel_gt *gt);
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
index c7f59d60fac6..9fe31aa07ae8 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.c
@@ -315,7 +315,8 @@ static void wait_for_suspend(struct intel_gt *gt)
 	if (!intel_gt_pm_is_awake(gt))
 		return;
 
-	if (intel_gt_wait_for_idle(gt, I915_GT_SUSPEND_IDLE_TIMEOUT) == -ETIME) {
+	if (intel_gt_wait_for_idle_uninterruptible(gt,
+						   I915_GT_SUSPEND_IDLE_TIMEOUT) == -ETIME) {
 		/*
 		 * Forcibly cancel outstanding work and leave
 		 * the gpu quiet.
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index 93298820bee2..b37e8f1d0b5c 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -130,8 +130,10 @@ void intel_engine_fini_retire(struct intel_engine_cs *engine)
 	GEM_BUG_ON(engine->retire);
 }
 
-long intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout,
-				      long *remaining_timeout)
+long __intel_gt_retire_requests_timeout(struct intel_gt *gt,
+					bool interruptible,
+					long timeout,
+					long *remaining_timeout)
 {
 	struct intel_gt_timelines *timelines = &gt->timelines;
 	struct intel_timeline *tl, *tn;
@@ -159,7 +161,7 @@ long intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout,
 				mutex_unlock(&tl->mutex);
 
 				timeout = dma_fence_wait_timeout(fence,
-								 true,
+								 interruptible,
 								 timeout);
 				dma_fence_put(fence);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.h b/drivers/gpu/drm/i915/gt/intel_gt_requests.h
index d2969f68dd64..9242f85f4040 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.h
@@ -12,8 +12,17 @@ struct intel_engine_cs;
 struct intel_gt;
 struct intel_timeline;
 
-long intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout,
-				      long *remaining_timeout);
+long __intel_gt_retire_requests_timeout(struct intel_gt *gt,
+					bool interruptible,
+					long timeout,
+					long *remaining_timeout);
+static inline long
+intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout,
+				 long *remaining_timeout)
+{
+	return __intel_gt_retire_requests_timeout(gt, true, timeout,
+						    remaining_timeout);
+}
 static inline void intel_gt_retire_requests(struct intel_gt *gt)
 {
 	intel_gt_retire_requests_timeout(gt, 0, NULL);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
index 053780f562c1..b5f4fddf5c1d 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -509,7 +509,8 @@ static inline void intel_guc_disable_msg(struct intel_guc *guc, u32 mask)
 	spin_unlock_irq(&guc->irq_lock);
 }
 
-int intel_guc_wait_for_idle(struct intel_guc *guc, long timeout);
+int intel_guc_wait_for_idle(struct intel_guc *guc, bool interruptible,
+			    long timeout);
 
 int intel_guc_deregister_done_process_msg(struct intel_guc *guc,
 					  const u32 *msg, u32 len);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 788e59cdfac9..aa74208c2b4e 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -680,14 +680,15 @@ int intel_guc_wait_for_pending_msg(struct intel_guc *guc,
 	return (timeout < 0) ? timeout : 0;
 }
 
-int intel_guc_wait_for_idle(struct intel_guc *guc, long timeout)
+int intel_guc_wait_for_idle(struct intel_guc *guc, bool interruptible,
+			    long timeout)
 {
 	if (!intel_uc_uses_guc_submission(&guc_to_gt(guc)->uc))
 		return 0;
 
 	return intel_guc_wait_for_pending_msg(guc,
 					      &guc->outstanding_submission_g2h,
-					      true, timeout);
+					      interruptible, timeout);
 }
 
 static int guc_context_policy_init_v70(struct intel_context *ce, bool loop);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc.h b/drivers/gpu/drm/i915/gt/uc/intel_uc.h
index 014bb7d83689..b62fe3b96b64 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc.h
@@ -96,9 +96,11 @@ uc_state_checkers(gsc, gsc_uc);
 #undef uc_state_checkers
 #undef __uc_state_checker
 
-static inline int intel_uc_wait_for_idle(struct intel_uc *uc, long timeout)
+static inline int intel_uc_wait_for_idle(struct intel_uc *uc,
+					 bool interruptible,
+					 long timeout)
 {
-	return intel_guc_wait_for_idle(&uc->guc, timeout);
+	return intel_guc_wait_for_idle(&uc->guc, interruptible, timeout);
 }
 
 #define intel_uc_ops_function(_NAME, _OPS, _TYPE, _RET) \
-- 
2.55.0

