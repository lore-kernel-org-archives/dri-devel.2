Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D16606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+SRifPz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0521C10E1E1;
	Thu,  5 Nov 2026 13:54:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0465010E028;
 Thu,  5 Nov 2026 13:54:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE12C402D8;
 Thu,  5 Nov 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793886866;
 b=V6Nab8cBiXcPHod7306HzbW2wkz/NHl3d8aStSwgLkFfCWCpmDj+Pj2Kiw+6daPvB7ha
 mBjVGICcs6ha0VIBLxFr1iu86Y9t0IG85yZRY65TE1pyVkJ+0kQDSjZaaJVQACDKPyyLJ
 kyXLM5Eu36gr42572AP8igfQSZQReXM7LyCyyvgSz2GgA84zMx29lyfAGeX/tShLRiHOn
 hO1K6UoPn/xbWkh2VGut2WJvBLdp9YVmAeOdKX/3RFYz02SctCrSewY2w7HpljXnJoOI5
 2gp7ZrCtKez2Sp0Itx0TBnmn6YEbr/iY6UsSXSjvXuMQYS3jbsuLE5EGZQwR1QkA7NA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793886866;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=yMKZ6JiHI9ZTgYnHPLIQ97E5yoAApQzdZxRBIG0Zxlw=;
 b=1VH0bwH1/Am+DeU9azMcrRxJB6p2jRR2clm3Zb9wwxGEjXmkgIC5tZXDzEWa6J0OgtQ2
 zSXsRW1PqGZu7InnWpya8qxqkrXA7FGirHkSnY9YP8pfEcromSEMa2jCAuf0n1ig2Z2AH
 48LS5YPIGL3cDyqWd3kcs5q8NWzakE5wiebSY536qxuHEJFQ8mctaKiMsTZ2Kqns+7KQj
 jhtkWtrPFYIojP48wMvwnwNfxnslNWiBybnz8uxmWrXq4tWA/QoVqbv+h7ElVUOuF5bid
 7m6MoWTg+qQV89NkA+OeOFNWW0AP3Cht+6cx9W2+Xrhjl/6kpnxh8EayIqMYcGIzw8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D0FF01F000C1;
 Thu,  5 Nov 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793886866;
 bh=yMKZ6JiHI9ZTgYnHPLIQ97E5yoAApQzdZxRBIG0Zxlw=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=f+SRifPzxJvnNJj1h4cE3y3b06TmiN8uzF4q1SwXKEP+TiB4b7xzvw8ew610k058y
 fF1cG/PN/1EF/t6PGShdfYWCeVbmNCcpPPkiHXUkG0x3DcpP4bB+yDVRToydTyH90l
 1fLlGZKDG/kjzx05WtNnjUPIEp9eW2o6y8sR5Db41OAUynXKqYLb2VH+lVGHkGagFZ
 udXBYlqSppB8bq0AzTmPZ/lZrmbYV9WLxQarrCmQzB+c8R8Kb9Xj1o2y4lfoTERhsZ
 uK0+oxLucW+epnfzoYunvSnoFxjNEEPwMDIn74t5bAh2TDRy+574o/PLFCmiLdJNqc
 HQNhTnmXMllbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3039F4729B;
 Thu,  5 Nov 2026 13:54:25 +0000 (UTC)
From: Shivam Kalra via B4 Relay <devnull+shivamkalra98.zohomail.in@kernel.org>
Date: Thu, 05 Nov 2026 19:24:20 +0530
Subject: [PATCH] drm/amdgpu: Don't report stale or empty vm_fault info in
 devcoredump
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-amdgpu-devcoredump-fault-info-v1-1-27c8165bfada@zohomail.in>
X-B4-Tracking: v=1; b=H4sIAIuK7GoC/yXMQQ7CIBAF0Ks0s3aSQsSoVzEuKHzqGAsESmPS9
 O5WXb7NW6miCCpdu5UKFqmS4g516Mg9bBzB4neT7vVJqd6wnfyYG3ssLhX4NmUOtr1mlhgSB3c
 5D0cYBaNpP3JBkPfvv93/rm14ws3flLbtA9Mg+5SBAAAA
X-Change-ID: 20261105-amdgpu-devcoredump-fault-info-fc98b4e51e52
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Shivam Kalra <shivamkalra98@zohomail.in>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793886864; l=9011;
 i=shivamkalra98@zohomail.in; s=20260402; h=from:subject:message-id;
 bh=pxJdK58/DE/CF4k68X1Ta99ypQMPKDBtaSO5Tn3JsCA=;
 b=OE30HWXc+saro0yTGSUaaaSebrlZ9EurHBZcEc2AhuW9pQxNJyOKpk8CGsD3YM9nHfv/Lend9
 L8u8R2METOvCWn0rlnGZdvv3YtgIa2Bm3c3ypDizJQevNwVFlI2svFU
X-Developer-Key: i=shivamkalra98@zohomail.in; a=ed25519;
 pk=U8kQSxcte8P8iZ6zB7phIj+Yl+i/5ntifBGuclgypx8=
X-Endpoint-Received: by B4 Relay for shivamkalra98@zohomail.in/20260402
 with auth_id=716
X-Original-From: Shivam Kalra <shivamkalra98@zohomail.in>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: shivamkalra98@zohomail.in
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shivam Kalra <shivamkalra98@zohomail.in>

amdgpu_devcoredump_format() reads adev->vm_manager.fault_info unlocked
from the deferred worker and prints the page fault section
unconditionally. This races with new faults, emits a misleading address
0x0 / status 0x0 block when no fault occurred, and repeats stale faults
on subsequent non-fault timeouts.

Add amdgpu_vm_take_fault_info() to atomically snapshot and clear the
global fault cache under amdgpu_pasid_lock(). Call it before the slow
dump_ip_state() loop in amdgpu_job_do_core_dump() (or in
amdgpu_coredump() for non-job resets), store the snapshot in struct
amdgpu_coredump_info, and only print the fault section when
fault_info.status != 0.

Link: https://lore.kernel.org/amd-gfx/20250521094912.6714-2-pierre-eric.pelloux-prayer@amd.com/
Suggested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
---
Tested on Rembrandt / Yellow Carp (gfx1033) using IGT amd_deadlock:

1. amdgpu-gfx-illegal-reg-access (no VM fault): no fault block emitted
2. amdgpu-gfx-illegal-mem-access (VM fault): fault emitted (status 0x640c51)
3. amdgpu-gfx-illegal-reg-access (post-fault): stale fault cleared, no fault emitted

Note: Captures and clears fault_info under amdgpu_pasid_lock() before 
dump_ip_state() per Christian Konig's review on v1.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 24 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  2 ++
 6 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 30a8b4c5591d..d93b426a87bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -30,7 +30,8 @@
 
 #ifndef CONFIG_DEV_COREDUMP
 void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
-		     bool vram_lost, struct amdgpu_job *job)
+		     bool vram_lost, struct amdgpu_job *job,
+		     const struct amdgpu_vm_fault_info *fault_info)
 {
 }
 void amdgpu_coredump_init(struct amdgpu_device *adev)
@@ -418,11 +419,15 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	}
 
 	/* Add page fault information */
-	fault_info = &coredump->adev->vm_manager.fault_info;
-	drm_printf(&p, "\n[%s] Page fault observed\n",
-		   fault_info->vmhub ? "mmhub" : "gfxhub");
-	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
-	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
+	fault_info = &coredump->fault_info;
+	if (fault_info->status != 0) {
+		drm_printf(&p, "\n[%s] Page fault observed\n",
+			   fault_info->vmhub ? "mmhub" : "gfxhub");
+		drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
+			   fault_info->addr);
+		drm_printf(&p, "Protection fault status register: 0x%x\n\n",
+			   fault_info->status);
+	}
 
 	/* dump the ip state for each ip */
 	drm_printf(&p, "IP Dump\n");
@@ -542,7 +547,8 @@ static void amdgpu_devcoredump_deferred_work(struct work_struct *work)
 }
 
 void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
-		     bool vram_lost, struct amdgpu_job *job)
+		     bool vram_lost, struct amdgpu_job *job,
+		     const struct amdgpu_vm_fault_info *fault_info)
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	struct amdgpu_coredump_info *coredump;
@@ -565,6 +571,10 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
+	if (fault_info)
+		coredump->fault_info = *fault_info;
+	else
+		amdgpu_vm_take_fault_info(adev, &coredump->fault_info);
 
 	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index cb874d8c3394..85d476828473 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -50,6 +50,7 @@ struct amdgpu_coredump_info {
 
 	bool                            skip_vram_check;
 	bool                            reset_vram_lost;
+	struct amdgpu_vm_fault_info     fault_info;
 	struct amdgpu_ring              *ring;
 
 	struct amdgpu_coredump_ring	*rings;
@@ -69,7 +70,8 @@ struct amdgpu_coredump_info {
 #endif
 
 void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
-		     bool vram_lost, struct amdgpu_job *job);
+		     bool vram_lost, struct amdgpu_job *job,
+		     const struct amdgpu_vm_fault_info *fault_info);
 void amdgpu_coredump_init(struct amdgpu_device *adev);
 void amdgpu_coredump_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bcaa59da2369..95fded3757f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5218,7 +5218,8 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
 				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
-					amdgpu_coredump(tmp_adev, false, vram_lost, reset_context->job);
+					amdgpu_coredump(tmp_adev, false, vram_lost,
+							reset_context->job, NULL);
 
 				if (vram_lost) {
 					dev_info(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9cc210198fa4..c808f59dbe05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -36,8 +36,15 @@
 static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
 				    struct amdgpu_job *job)
 {
+	struct amdgpu_vm_fault_info fault_info;
 	int i;
 
+	/*
+	 * The IP state dump below can take seconds.  Take the snapshot before
+	 * it, while holding the same lock as the interrupt handler.
+	 */
+	amdgpu_vm_take_fault_info(adev, &fault_info);
+
 	dev_info(adev->dev, "Dumping IP State\n");
 	for (i = 0; i < adev->num_ip_blocks; i++)
 		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
@@ -45,7 +52,7 @@ static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
 				->dump_ip_state((void *)&adev->ip_blocks[i]);
 	dev_info(adev->dev, "Dumping IP State Completed\n");
 
-	amdgpu_coredump(adev, true, false, job);
+	amdgpu_coredump(adev, true, false, job, &fault_info);
 }
 
 static void amdgpu_job_core_dump(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2bd07007def4..ac9bf1991e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3274,6 +3274,28 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	amdgpu_pasid_unlock(flags);
 }
 
+/**
+ * amdgpu_vm_take_fault_info - snapshot and clear the global fault cache
+ * @adev: amdgpu device pointer
+ * @fault_info: destination for the fault information
+ *
+ * The fault cache is updated by amdgpu_vm_update_fault_cache() under the
+ * PASID lock.  Take the snapshot and clear the cache in the same critical
+ * section so that a fault arriving after the snapshot is not overwritten,
+ * and a consumed fault is not reported again in a later timeout.
+ */
+void amdgpu_vm_take_fault_info(struct amdgpu_device *adev,
+			       struct amdgpu_vm_fault_info *fault_info)
+{
+	unsigned long flags;
+
+	amdgpu_pasid_lock(&flags);
+	*fault_info = adev->vm_manager.fault_info;
+	memset(&adev->vm_manager.fault_info, 0,
+	       sizeof(adev->vm_manager.fault_info));
+	amdgpu_pasid_unlock(flags);
+}
+
 void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
 			       struct amdgpu_task_info *task_info)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1a..f89596ce3879 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -575,6 +575,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_take_fault_info(struct amdgpu_device *adev,
+			       struct amdgpu_vm_fault_info *fault_info);
 void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
 				 struct dma_fence **fence);

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261105-amdgpu-devcoredump-fault-info-fc98b4e51e52

Best regards,
--  
Shivam Kalra <shivamkalra98@zohomail.in>


