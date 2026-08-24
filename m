Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3DDC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9E110E55B;
	Mon, 24 Aug 2026 15:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KHa+RDi5";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694E710E558
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:35:51 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so647144966b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787585750; x=1788190550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MBR6d94THkkReePXuJjZ6x5N9bPpPVrN1tis5l/KU/8=;
 b=KHa+RDi5p2kv/YY4C6zeiX9N72DHo3H9USdzWXv8BZ/LdM4ZsfPjmWVRqAcJxYhgmt
 t3CLQ9zC/zINzg/XFbc3EN56mDggoO5RxUfTR5sqiR+LF3alqEAYRLgwL6Yzyd9CmZ6H
 zjTI028+fWWL4n5CPseaGLu89jgsy+T05oYvJHKJee5c+hFVEqRWK9QXaFuryr/k+9hW
 D+dmicg7kWZqDFwXi/rw+JWUjeb/LLy5NyPqH4h8cTmY/hG2G02vOHf/f5YD4CRP49ES
 nbc6RFDj3oE0srHD/pHuAvqd5el5IzMLiZORkKMGN94CU3eeczSblxVzSCVWNL9ACE2M
 2Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585750; x=1788190550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MBR6d94THkkReePXuJjZ6x5N9bPpPVrN1tis5l/KU/8=;
 b=BFAwxlZVDT3GuIaf/GIkTtVD9GuIHh6OlF0YgfhGeiEFkwgFbfO2KURSuT7776KmUr
 14++M5lgmZw/wBU3jBgkUUm+qOKfn5EIPDEe8JrGMlc9XaCbduFbRyRk5qBETTVz3A8Y
 4BO22gltyIgSWuUI2nnzDoF6bECcvA7kWN9cn+0cYkPe4zsPjV+Up4opfTFBKrHqL0eg
 AJTGPQ+IWHJavyuAwPPo4Q0jPKdyFWOIarI5Wy29T1jQvemxUIrHgnsUiJaWL2jVwGiv
 fHM/a9nxyDq4NXv7xn2qN+oLruh7IuOzg0+bg9f2h+qi7AT+AWxMyskvNDIj4O1dutK9
 NnJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6LwnMBvXGoxcgd/w0jg/Zb5vX4bTSMC3HTOk9rtAAWDFchJ/MDMHbx9uwJE0dIgZytrxztx0pZpg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYkiSk1pbQlpVewsJH9Mgn2G7Ay4IV2C7I8AMVv7/wHPiMUc9A
 Yw4PT9rOxTiKxY85uEZTWGkicEqecE3sJSvPJtzIK83LTQLY4ccitxz5
X-Gm-Gg: AR+sD13WPAvFkf08fDGgbr581QlkMwMu1xQqpIaymK6oYdPQ1Zd8OEZskP8x1ugJm8o
 NYXi3lAiyl7Cd8e1NWFULa4E7g+me7EuGdQAXLbnJl/HnQDm73ityAUuKLD34HTmdZLjMOI2LXc
 mSjq7ZOXw9r5FlDcmj3CU/mZTSJ0Ol7yPVYIfNQzZPljuhgHIs+sA/Y0vlP7oA5XaZeLIKgUWfA
 440fXmlCFtILKfB2sc2/IM43iOeCih67vRmruShV7tZofhR/toJm3eXHAPeWTx6xjyqasV3b0+q
 MilCOnYVPu63fAcTdZFivOkdRIR4aJLE+UfbXwczwqBahLfRDA6ACfsdR4o3JAtp2d+21zJwp/+
 ZyG4RVPj//3yGy+D5mmszqLAnHW8Q9BGpflj0QQ+2Uy54DdSkpwJpZXA6UEx3R0HLd/sSisLS+C
 /qpLL+sumhyuag+4uxAba0y5f7ZgyxIBs2claYk+YQxgiU2VZhp0gc9DjBm8aUcR2CuAnBRrN6L
 uRg6aWusLp3sWAU2OSNmdn8YlNZnYFZRD/onVxQBb+QUVa9ZylaeK063C0ZXffq77atcz3WvOoF
 r/Qgm8v8Qa8C2geY/o803anlTUbiHkXvapo6irthPQ==
X-Received: by 2002:a17:907:94d0:b0:c24:8a09:8195 with SMTP id
 a640c23a62f3a-c249238cd91mr1833789266b.3.1787585749547; 
 Mon, 24 Aug 2026 08:35:49 -0700 (PDT)
Received: from horsehead.monster-haddock.ts.net
 (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1298978666b.6.2026.08.24.08.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:35:48 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH v3 1/1] drm/amdgpu: fall back to MMIO TLB invalidation
 when KIQ is unresponsive
Date: Mon, 24 Aug 2026 17:35:42 +0200
Message-ID: <20260824153542.491012-2-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824153542.491012-1-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260824153542.491012-1-pisarevden@gmail.com>
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

- gmc_v9_0_flush_gpu_tlb() falls back to gmc_v9_0_flush_gpu_tlb_mmio()
  (the former pre-KIQ MMIO code, extracted into a helper with irqsave
  locking since it is reachable at runtime) when the KIQ submit fails,
  so the invalidation is no longer dropped

- after AMDGPU_KIQ_FLUSH_MAX_FAIL (3) consecutive failures the KIQ
  path is skipped entirely for bare metal process context, so wedged
  systems stop paying the 5 s retry window per flush

- the MMIO fallback holds the GC block awake with
  amdgpu_gfx_off_ctrl() across the direct register access (it may
  sleep, hence process context only) and is restricted to bare metal;
  SR-IOV VFs and interrupt contexts never take it - they keep
  attempting KIQ exactly as before this patch, with failures logged,
  because they have no MMIO alternative

- the counter resets on every success and in gmc_v9_0_hw_fini(); every
  suspend/resume cycle re-arms the KIQ path; nothing is disabled
  proactively

Known limitation / open question: a KIQ command that already timed out
stays queued in the ring; if the ring recovers late it could emit a
duplicate invalidation concurrently with a CPU MMIO flush. The
invalidation engine serializes requests internally, so the expected
worst case is a lost flush request caught by the existing ACK timeout
("Timeout waiting for VM flush ACK!") rather than silent corruption;
once latched this path submits no new KIQ commands, bounding the
window. Reviewer input on whether a fence (or a dedicated invalidate
engine for the MMIO path) is required would be welcome.

Changes since v2 (sashiko-bot review):
- VFs and IRQ contexts are no longer silently dropped once the latch
  is set: they keep submitting to KIQ with per-failure logging,
  matching pre-patch behavior exactly; the latch now only reroutes
  bare metal process context to MMIO

Changes since v1 (sashiko-bot review):
- hold GFXOFF off around runtime MMIO access (was: unguarded)
- per-KIQ-instance failure counter instead of a global one
- invalidate_lock taken irqsave in the extracted MMIO helper
- MES path errors propagated instead of hardcoded success
- threshold warning no longer promises a fallback gmc_v10/v11/v12 do
  not implement

gmc_v10/v11/v12 call sites are unchanged and compile-safe (int return
used as statement). The sibling PASID path
(amdgpu_gmc_flush_gpu_tlb_pasid) already has an -ETIME/MMIO split;
this brings the per-VMID path in line with it.

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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++-----
 5 files changed, 114 insertions(+), 33 deletions(-)

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
index 8a5c44810..3f04a25b1 100644
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
@@ -878,6 +866,82 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
+	u32 inv_req, inst;
+	const unsigned int eng = 17;
+	struct amdgpu_vmhub *hub;
+	bool latched, can_mmio;
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
+	latched = atomic_read(&adev->gfx.kiq[inst].flush_failures) >=
+			AMDGPU_KIQ_FLUSH_MAX_FAIL;
+	/* Direct register access requires process context (holding
+	 * GFXOFF off may sleep) and bare metal (VFs lack the
+	 * privileges for direct GMC invalidation writes)
+	 */
+	can_mmio = !in_interrupt() && !amdgpu_sriov_vf(adev);
+
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
+	 */
+	if (adev->gfx.kiq[inst].ring.sched.ready &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Once latched, KIQ is only attempted by callers that have
+		 * no MMIO alternative (IRQ context, VFs); bare metal
+		 * process context goes straight to the MMIO fallback
+		 */
+		if (!latched || !can_mmio) {
+			if (!amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack,
+							      inv_req,
+							      1 << vmid, inst))
+				return;
+			/* KIQ submit failed; error already logged above */
+		}
+
+		/*
+		 * MMIO fallback: the invalidation must not be silently
+		 * dropped when KIQ is unresponsive.
+		 */
+		if (can_mmio) {
+			amdgpu_gfx_off_ctrl(adev, false);
+			gmc_v9_0_flush_gpu_tlb_mmio(adev, hub, vmid, vmhub,
+						    inv_req);
+			amdgpu_gfx_off_ctrl(adev, true);
+		}
+		/* IRQ context / VF: flush dropped as before this patch;
+		 * the failure was logged in
+		 * amdgpu_gmc_fw_reg_write_reg_wait()
+		 */
+		return;
+	}
+
+	gmc_v9_0_flush_gpu_tlb_mmio(adev, hub, vmid, vmhub, inv_req);
+}
+
 /**
  * gmc_v9_0_flush_gpu_tlb_pasid - tlb flush via pasid
  *
@@ -2237,6 +2301,13 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
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

