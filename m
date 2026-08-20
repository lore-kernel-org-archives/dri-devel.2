Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55557C5DF88
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A58A10F003;
	Thu, 20 Aug 2026 10:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sb1dN9/b";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2C010EFF0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:57:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-482938466a7so1800649f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787223449; x=1787828249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6vW9ld8Q7uobfbuxJfABp8mlFR5KPp0lNPptjS3cwDc=;
 b=sb1dN9/b4XH9t1fBYDzKXZNVvrIqtSCFiiBcnYsUf/tWxd701x9aGxDvqOTAgbk23h
 oN4lTN9yc5voaTE7NE0hmlEGgnyc5KL72nE0IcGilTzBSS5F/lcF4+8cr7DbJVNU7LA/
 rFu5V9g3W+gOULSrelhoxBHjJj2aM/zbWLbfQNlvW/N9DFKQ9k73osFb1bnL8Hc2dEsf
 1qHymqamZ9UcZxNCo3VRB89kD9vlVhYfblx73qDle5oso6dRUmTq0BBet7yAvEu0iqt1
 NKnbFyF7qfZdUWJ9tyfMU/tVAe6BQq/rUntUROnndL2pVX56XOCEkODi3GRIve+WPJ1T
 MQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223449; x=1787828249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6vW9ld8Q7uobfbuxJfABp8mlFR5KPp0lNPptjS3cwDc=;
 b=AxK9iJl3ams5STUNvZ4OrHXbgapWQLHb4qJxVCxThCIEJg4hdy904nnlqnTQQJkeZx
 wCY/wOTgGVwHt2CyTqAN0xq1TYSWmn82t837CN1BcruwQsgruMaXhlPRfkT4y6XZsUMV
 4ntn9IfVsQEwzk4DpIBGrHh6QmkqnpQoIQtkVtk32IGWs5WMCmwOj21v8q94cfbhZX6p
 vZAfebqt9hQ6dTnlqY7hehueIcKxRPYSkWp8GNWsHzXhoZTYjCFErIflCVAN3XR4zGxv
 UrnveuSNCh6xG1Ibj5vPXWqIgONWENGuKGGhWN67YR0vKza1ymGKgdkXSNY1Ca90nJrA
 d3LQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUootfroqXhaEm43SlCnqOOIdOUyI2nvacFnzhBc5Zo1mY0uemspFouyeqNmKvgyIn5Oi5s7CzXDo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcOSVRpIvafEGies/dyO6ObiXTMxjFYf9fU1DHTPxMkgKV6BcO
 y7+S6zSHA04N/zPIgOGSYqGKGJkWuPv+0UJ2xkmISE64nPT/lGrPoqDJjitwjdbVv5E=
X-Gm-Gg: AR+sD10zAKqOK/H47EhH7XYyRZGZXgnK/KrUZR3IkXM7ywq0uVYhQ2BE2s54Ta9lCYt
 Y9fNTlwgCNSTD1mAI13gx+abV+JqGxwVJtiI/xeZXsF/vJEaESM35xG4FJqwz5GLYHUNSsawisB
 kQez7rpMrIgQrms4CjzA4nW+RiETszp09z3fKGvp+q6cRmK3legB5RLqFWhJQ9rrNZioKRoWGgQ
 k3sw8d8jBpjpMaJMOI6U4qntIT8Xn86SCMrCg0KtguAMe5p16QcW0NqkW751aAQtPP8JIPuKth9
 z+QKTJSBfEiVzK/0h4/3uxuV19CeJTeRrB9nCMTR76FGTqHzVx4+fHih5rEqEHN2EUncIfvnl/Q
 jxVoPWa4cC7zWLMbMrBl1g9VZcDNNRpvfPjLG9qEtsvhcfQsbU+qdglojNp90emkI1eytSA0cMa
 xa2HndW7qCgmLmjL8Y+CG9YvpaU3wLsTqZx3/bo6AvQD1P6VMh7fFUeIrOAu2Z3bs7rQyshQ8jG
 j8M8EzZJv2uojXHheVEGN+5HBrerxuh29YnEHt2ukdSGeyqG+3ayqNrtUjkkPJZNWPdEwHutmCC
 aMH2Iw==
X-Received: by 2002:a05:600c:a30f:b0:499:b01e:911c with SMTP id
 5b1f17b1804b1-499b01e9125mr89248005e9.2.1787223448742; 
 Thu, 20 Aug 2026 03:57:28 -0700 (PDT)
Received: from horsehead.lan (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b4568a65sm13872775e9.2.2026.08.20.03.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:57:28 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH v2 1/1] drm/amdgpu: fall back to MMIO TLB invalidation
 when KIQ is unresponsive
Date: Thu, 20 Aug 2026 12:57:16 +0200
Message-ID: <20260820105716.148732-2-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820105716.148732-1-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260820105716.148732-1-pisarevden@gmail.com>
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

After resume from S4 (hibernation) on gmc_v9 parts with GFXOFF
(observed on Cezanne / Ryzen 7 PRO 5850U, kernel 7.1.8), KIQ-based TLB
flushes start failing at the moment of the thaw and keep failing for
hours of normal desktop use:

  amdgpu 0000:07:00.0: failed to write reg 28b4 wait reg 28c6
  amdgpu 0000:07:00.0: failed to write reg 1a6f4 wait reg 1a706

(80-140 errors/hour measured over 9+ hours; bugzilla 219492). The KIQ
ring stays sched.ready throughout, so readiness does not reflect the
state of the hardware in this failure mode.

Two problems follow from the current code: every failed flush burns
the full ~5 s KIQ retry window before erroring out (desktop-wide
sluggishness), and the invalidation is then silently dropped (stale
TLBs - correctness).

Make the failure observable and self-healing:

- amdgpu_gmc_fw_reg_write_reg_wait() returns 0/-ETIME, propagates MES
  errors, and counts consecutive failures per KIQ instance

- gmc_v9_0_flush_gpu_tlb() falls back to a new
  gmc_v9_0_flush_gpu_tlb_mmio() helper (the former pre-KIQ MMIO code,
  now with irqsave locking since it is reachable at runtime) when the
  KIQ submit fails, so the invalidation is no longer dropped

- after AMDGPU_KIQ_FLUSH_MAX_FAIL (3) consecutive failures the KIQ
  path is skipped entirely until the counter resets, so wedged systems
  stop paying the 5 s retry window per flush

- the MMIO fallback is restricted to process context on bare metal:
  amdgpu_gfx_off_ctrl() is used to hold the GC block awake across the
  direct register access (it may sleep), and SR-IOV VFs keep
  proxying through KIQ as before

- the counter resets on every success and in gmc_v9_0_hw_fini(); every
  suspend/resume cycle re-arms the KIQ path; nothing is disabled
  proactively

Changes since v1 (addressing the sashiko-bot review):
- hold GFXOFF off around runtime MMIO access (was: unguarded - could
  hit power-gated registers)
- per-KIQ-instance failure counter instead of a global one (multi-XCC
  cross-talk)
- invalidate_lock is now taken irqsave (the path is runtime-reachable)
- VFs and interrupt context never take the runtime MMIO fallback
- MES path errors are propagated instead of hardcoded success
- reworded the threshold warning to not promise a fallback that
  gmc_v10/v11/v12 do not implement

Known limitation / open question: a KIQ command that already timed out
stays queued in the ring; if the ring recovers late it could emit a
duplicate invalidation concurrently with a CPU MMIO flush. The command
is semantically an idempotent invalidate, but reviewer input on
whether the req/ack handshake needs protection here is welcome.

gmc_v10/v11/v12 call sites are unchanged and compile-safe (int return
used as statement). They can get the same fallback once the approach
is agreed for gmc_v9.

The sibling PASID path (amdgpu_gmc_flush_gpu_tlb_pasid) already has an
-ETIME/MMIO split; this brings the per-VMID path in line with it.

Root-cause note: with GFXOFF held off across the S4 cycle (debugfs
amdgpu_gfxoff), zero errors occur across resume and 30 min of use vs
~70-140 in the control arm; the wedge forms in the S4 resume window
while GFXOFF is allowed, consistent with the existing semaphore
workaround comment in gmc_v9_0.c.

Signed-off-by: Denis Pisarev <pisarevden@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 111 ++++++++++++++++++------
 5 files changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7b09410d6..cd5d9e56e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -360,6 +360,8 @@ enum amdgpu_kiq_irq {
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
+/* consecutive KIQ TLB flush failures before falling back to MMIO */
+#define AMDGPU_KIQ_FLUSH_MAX_FAIL 3
 
 /*
  * BIOS.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 54c1eb9c4..e2aceb99c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -167,6 +167,8 @@ struct amdgpu_kiq {
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
 	void			*mqd_backup;
+	/* consecutive TLB flush reg access failures on this instance */
+	atomic_t		flush_failures;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5d6149ba7..49d3d6651 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -874,7 +874,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	return r;
 }
 
-void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+int amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
 				      uint32_t xcc_inst)
@@ -886,9 +886,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	uint32_t seq;
 
 	if (adev->mes.ring[MES_PIPE_INST(xcc_inst, 0)].sched.ready) {
-		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
-					      ref, mask, xcc_inst);
-		return;
+		return amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
+						     ref, mask, xcc_inst);
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -919,13 +918,20 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq;
 
-	return;
+	atomic_set(&adev->gfx.kiq[xcc_inst].flush_failures, 0);
+	return 0;
 
 failed_undo:
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
-	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
+	if (atomic_inc_return(&adev->gfx.kiq[xcc_inst].flush_failures) ==
+			AMDGPU_KIQ_FLUSH_MAX_FAIL)
+		dev_warn(adev->dev,
+			 "KIQ reg access keeps failing, MMIO fallback recommended\n");
+	dev_err_ratelimited(adev->dev,
+			    "failed to write reg %x wait reg %x\n", reg0, reg1);
+	return -ETIME;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index ddb0d500e..303e0ee98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -447,7 +447,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst);
-void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+int amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
 				      uint32_t xcc_inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8a5c44810..11fc9085e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -764,27 +764,28 @@ static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
  */
 
 /**
- * gmc_v9_0_flush_gpu_tlb - tlb flush with certain type
+ * gmc_v9_0_flush_gpu_tlb_mmio - tlb flush via direct MMIO
  *
  * @adev: amdgpu_device pointer
+ * @hub: vmhub to flush
  * @vmid: vm instance to flush
  * @vmhub: which hub to flush
- * @flush_type: the flush type
+ * @inv_req: invalidation request payload
  *
- * Flush the TLB for the requested page table using certain type.
+ * Direct CPU access to the invalidation engine. Callers must ensure
+ * the target block cannot power gate across the access (GFXOFF needs
+ * to be held off at runtime) and must hold no other locks.
  */
-static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
+static void gmc_v9_0_flush_gpu_tlb_mmio(struct amdgpu_device *adev,
+					struct amdgpu_vmhub *hub,
+					uint32_t vmid, uint32_t vmhub,
+					u32 inv_req)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
-	u32 j, inv_req, tmp, sem, req, ack, inst;
 	const unsigned int eng = 17;
-	struct amdgpu_vmhub *hub;
-
-	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
+	unsigned long flags;
+	u32 j, tmp, sem, req, ack, inst;
 
-	hub = &adev->vmhub[vmhub];
-	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
 	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
@@ -794,21 +795,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	else
 		inst = vmhub;
 
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if (adev->gfx.kiq[inst].ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-						 1 << vmid, inst);
-		return;
-	}
-
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
-	spin_lock(&adev->gmc.invalidate_lock);
+	spin_lock_irqsave(&adev->gmc.invalidate_lock, flags);
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -870,7 +858,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC, inst));
 	}
 
-	spin_unlock(&adev->gmc.invalidate_lock);
+	spin_unlock_irqrestore(&adev->gmc.invalidate_lock, flags);
 
 	if (j < adev->usec_timeout)
 		return;
@@ -878,6 +866,70 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
 }
 
+/**
+ * gmc_v9_0_flush_gpu_tlb - tlb flush with certain type
+ *
+ * @adev: amdgpu_device pointer
+ * @vmid: vm instance to flush
+ * @vmhub: which hub to flush
+ * @flush_type: the flush type
+ *
+ * Flush the TLB for the requested page table using certain type.
+ */
+static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+					uint32_t vmhub, uint32_t flush_type)
+{
+	u32 inv_req;
+	const unsigned int eng = 17;
+	struct amdgpu_vmhub *hub;
+	u32 inst;
+
+	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
+
+	hub = &adev->vmhub[vmhub];
+	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = 0;
+	else
+		inst = vmhub;
+
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
+	 */
+	if (adev->gfx.kiq[inst].ring.sched.ready &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		if (atomic_read(&adev->gfx.kiq[inst].flush_failures) <
+				AMDGPU_KIQ_FLUSH_MAX_FAIL) {
+			if (!amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack,
+							      inv_req,
+							      1 << vmid, inst))
+				return;
+			/* KIQ submit failed; error already logged */
+		}
+
+		/*
+		 * MMIO fallback: invalidation must not be silently dropped
+		 * when KIQ is unresponsive. Direct register access is only
+		 * safe in process context (amdgpu_gfx_off_ctrl may sleep)
+		 * and on bare metal; SR-IOV VFs must keep proxying through
+		 * KIQ.
+		 */
+		if (in_interrupt() || amdgpu_sriov_vf(adev))
+			return;
+
+		amdgpu_gfx_off_ctrl(adev, false);
+		gmc_v9_0_flush_gpu_tlb_mmio(adev, hub, vmid, vmhub, inv_req);
+		amdgpu_gfx_off_ctrl(adev, true);
+		return;
+	}
+
+	gmc_v9_0_flush_gpu_tlb_mmio(adev, hub, vmid, vmhub, inv_req);
+}
+
 /**
  * gmc_v9_0_flush_gpu_tlb_pasid - tlb flush via pasid
  *
@@ -2237,6 +2289,13 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	/* KIQ instances are re-initialized on the next resume; re-arm
+	 * the MMIO fallback logic
+	 */
+	for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++)
+		atomic_set(&adev->gfx.kiq[i].flush_failures, 0);
 
 	gmc_v9_0_gart_disable(adev);
 
-- 
2.55.0

