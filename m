Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD66DCD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A02810ED0D;
	Thu, 11 Jun 2026 07:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="jKPjRkoX";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C148210ED0D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:18:17 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B4uwe71323753; Thu, 11 Jun 2026 08:17:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=UZ+HzQ1yycYdWLc1plUtCq1
 C/VvhCEsljuswd8seHkg=; b=jKPjRkoXFeLxhKNxX3ibYQNgMEzvObB2LieYtGT
 1sq+GeTSWbhzRkP7l5V5lpyYnCz05c5f0bntnPEUiPPKZk8PwlIDfAkagvPUxqqA
 UIqUyT38Y449SNEEWvsPd+MYjIli4RvVFjkuKxAQK5ZdAAT1TDln74jfBOVc6qTU
 9/FMMyVaQl08GJExY46L2GWkykoLiXyMOAgKHRQ9vpKiZ17M8BG7e+0BxaVffRla
 k4JrEfwZTBbq/EQw19cNcjuIXWYn9NEBntUjdwZ6oWWiP8BCtUgfSCbDKlop7GT8
 rzuOqF8Toe/DWtF0ZRalQzjQD8rlml5cvIYd774ae58TgSA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4eqdyxgdtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 08:17:59 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 08:17:55 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Thu, 11 Jun 2026 12:47:46 +0530
Subject: [PATCH v3] drm/imagination: Fix double call to drm_sched_entity_fini()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260611-b4-sched_fix-v3-1-693beb50ea01@imgtec.com>
X-B4-Tracking: v=1; b=H4sIABlhKmoC/3WMQQ6CMBAAv0J6tqYt0Ion/2GMaZcF9gA1LWk0h
 L9bOKmJx5lkZmERA2Fk52JhARNF8lOG8lAwGOzUI6c2M1NCaaGl4K7iEQZs7x09uYXSNUp0lak
 dy8kjYNb77nrLPFCcfXjt9yQ3+2eUJJcc6sYYq1G4Ci409jPCEfzItlNSn7X8qVWupbFN6fCkO
 2i/6nVd3+So25bnAAAA
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781162275; l=8033;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=bJDZDaIeE1DGyLFLGjrkzPDAyBRKuJ4CqJ124cNaRZs=;
 b=aZisCqLtwFD4L2Ls8+iZt9EjLB9yqPIVAIzEj1OKJgVNaOGJG8Qh7vUlUmyqVFpkgieYLRjK2
 jOON3jPNca+DbewwovsRoIB27SldPTOsCaORQCSkyL7qKDAh/PfTZxK
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MCBTYWx0ZWRfX6fny+LBIoBim
 4786uyG6v9ZFbeBOR45K4S43xFR10xckkU3k4apu5pTjecEL+1f3oouFAYjvkoQda91gVXEcZ6w
 WbEkn6o7GZi76yxyn6GXylDe9i0Sf3S91Dm9NfNeiS5CxX083Q7MFS18OeI2QWUq/6eJAFkMQ10
 Ee1PqdnORwStIdui+LoyWyipokY34sNU+HI/6qZYIB3epZBgqzmWW1ypAPCFykavWcYMHsz2O+4
 wMDjOMbabzhEYZvStF0QvV0J/DuVN5JW68k1QOu8s1iidtPcw7l8rlZumb75DbUEySZg4TyMdeq
 b212gdy3+5GluIRoYn+h3OtErGE1MFKc7/U9lA2nPZuDBJx7jCYRaW2IYOjZuw+xHNC7EDmPQQu
 5lzrqZI1IU34np72av07DWVbbqK4kxLlCkujP+wBLam3gE12Xyt7m5C/4XodG6wfZim2q+5wqpx
 2DLjuLHme1LOaEDPAGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MCBTYWx0ZWRfX86wUafmLuUyd
 2HxNEuuMZl0ZUoAwig4N1wfHuj7wbQm5ZpdHJOO4x4DSMu3balyxsg2xsXxH8KUgkXebWmrbc6z
 CeAxkxcW9Dbje92Q1bqUKvWvWxJDjk4=
X-Proofpoint-GUID: sK0RSQOFqr8uyzWHbIhhLtinMDQKb_ef
X-Proofpoint-ORIG-GUID: sK0RSQOFqr8uyzWHbIhhLtinMDQKb_ef
X-Authority-Analysis: v=2.4 cv=T728ifKQ c=1 sm=1 tr=0 ts=6a2a6127 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=Wf2FQp8mk3ujYxj49eQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

Call sequence of double call:
pvr_context_destroy
  pvr_context_kill_queues
    pvr_queue_kill
      drm_sched_entity_destroy
        drm_sched_entity_fini // here
  pvr_context_put
    kref_put(..., pvr_context_release)
      pvr_context_destroy_queues
        pvr_queue_destroy
          drm_sched_entity_fini // here

Call to drm_sched_entity_destroy() from pvr_context_kill_queues() calls
drm_sched_entity_flush() + drm_sched_entity_fini().
drm_sched_entity_flush() ensures all pending jobs are completed and
drm_sched_entity_fini() ensures no further submission is allowed as
per expectation from pvr_context_kill_queues(). Drop the extra
call to drm_sched_entity_fini().

Stack trace for issue with addition of refcounting for DRM entity
stats in commit fd177135f0e6 ("drm/sched: Account entity GPU time"):
[  789.490527] ------------[ cut here ]------------
[  789.490559] refcount_t: underflow; use-after-free.
[  789.490657] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xf4/0x144, CPU#0: kworker/u16:1/440
[  789.490695] Modules linked in: powervr drm_gpuvm drm_exec gpu_sched drm_shmem_helper xhci_plat_hcd xhci_hcd dwc3 usbcore usb_common snd_soc_simple_card snd_soc_simple_card_utils sa2ul sha512 sha256 dwc3_am62 sha1 authenc rti_wdt libsha512 at24 sch_fq_codel fuse dm_mod ipv6
[  789.490798] CPU: 0 UID: 0 PID: 440 Comm: kworker/u16:1 Not tainted 7.0.0-rc7-02049-g5e2c0700091b #22 PREEMPT
[  789.490809] Hardware name: Texas Instruments AM625 SK (DT)
[  789.490815] Workqueue: powervr-sched pvr_queue_fence_release_work [powervr]
[  789.490868] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  789.490876] pc : refcount_warn_saturate+0xf4/0x144
[  789.490884] lr : refcount_warn_saturate+0xf4/0x144
[  789.490892] sp : ffff8000822cbcc0
[  789.490895] x29: ffff8000822cbcc0 x28: 0000000000000000 x27: 0000000000000000
[  789.490909] x26: 0000000000000000 x25: ffff800081b1e338 x24: ffff000004541405
[  789.490922] x23: ffff000004bea950 x22: ffff00000042e400 x21: ffff000007123e30
[  789.490935] x20: ffff000007123000 x19: ffff000007a80d50 x18: fffffffffffe7768
[  789.490948] x17: 74736574202c6e6f x16: 697461746e656d65 x15: ffff800081b269f0
[  789.490962] x14: 0000000000000030 x13: ffff800081b26a70 x12: 0000000000000211
[  789.490975] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff8000822cbb30
[  789.490988] x8 : ffff0000014e7bb0 x7 : ffff00007725e780 x6 : 0000000372a05f49
[  789.491001] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000010
[  789.491013] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000014e7000
[  789.491027] Call trace:
[  789.491032]  refcount_warn_saturate+0xf4/0x144 (P)
[  789.491043]  drm_sched_entity_fini+0x164/0x18c [gpu_sched]
[  789.491081]  pvr_queue_destroy+0x64/0x134 [powervr]
[  789.491110]  pvr_context_destroy_queues+0x34/0x64 [powervr]
[  789.491138]  pvr_context_release+0x70/0xac [powervr]
[  789.491166]  pvr_context_put.part.0+0x5c/0x7c [powervr]
[  789.491193]  pvr_context_put+0x14/0x24 [powervr]
[  789.491221]  pvr_queue_fence_release_work+0x20/0x38 [powervr]
[  789.491249]  process_one_work+0x160/0x4c4
[  789.491264]  worker_thread+0x188/0x310
[  789.491276]  kthread+0x130/0x13c
[  789.491287]  ret_from_fork+0x10/0x20
[  789.491300] ---[ end trace 0000000000000000 ]---

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
References: fd177135f0e6 ("drm/sched: Account entity GPU time")
---
Changes in v3:
- Fixed a typo.
- Handled missing memory leak for RENDER_CONTEXT.
- Link to v2: https://lore.kernel.org/r/20260611-b4-sched_fix-v2-1-17a93be86fcd@imgtec.com

Changes in v2:
- Fixed memory leak identified in following error path handling of pvr_context_create():
- pvr_context_create()
-   ...
-   err_destroy_queues:
-     pvr_context_destroy_queues()
-       pvr_queue_destroy()
- Link to v1: https://lore.kernel.org/r/20260610-b4-sched_fix-v1-1-c5977a6e0b4c@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_context.c | 41 +++++++++++++++++++++++++------
 drivers/gpu/drm/imagination/pvr_queue.c   |  4 ---
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index eba4694400b5..e2e30908dfce 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -161,22 +161,47 @@ ctx_fw_data_init(void *cpu_ptr, void *priv)
 /**
  * pvr_context_destroy_queues() - Destroy all queues attached to a context.
  * @ctx: Context to destroy queues on.
+ * @queue_entity_fini: Corresponding queues of context to be released for
+ *                     failure path in context creation.
  *
  * Should be called when the last reference to a context object is dropped.
  * It releases all resources attached to the queues bound to this context.
  */
-static void pvr_context_destroy_queues(struct pvr_context *ctx)
+static void pvr_context_destroy_queues(struct pvr_context *ctx, bool queue_entity_fini)
 {
 	switch (ctx->type) {
 	case DRM_PVR_CTX_TYPE_RENDER:
-		pvr_queue_destroy(ctx->queues.fragment);
-		pvr_queue_destroy(ctx->queues.geometry);
+		if (ctx->queues.fragment) {
+			if (queue_entity_fini)
+				drm_sched_entity_fini(&ctx->queues.fragment->entity);
+
+			pvr_queue_destroy(ctx->queues.fragment);
+		}
+
+		if (ctx->queues.geometry) {
+			if (queue_entity_fini)
+				drm_sched_entity_fini(&ctx->queues.geometry->entity);
+
+			pvr_queue_destroy(ctx->queues.geometry);
+		}
 		break;
+
 	case DRM_PVR_CTX_TYPE_COMPUTE:
-		pvr_queue_destroy(ctx->queues.compute);
+		if (ctx->queues.compute) {
+			if (queue_entity_fini)
+				drm_sched_entity_fini(&ctx->queues.compute->entity);
+
+			pvr_queue_destroy(ctx->queues.compute);
+		}
 		break;
+
 	case DRM_PVR_CTX_TYPE_TRANSFER_FRAG:
-		pvr_queue_destroy(ctx->queues.transfer);
+		if (ctx->queues.transfer) {
+			if (queue_entity_fini)
+				drm_sched_entity_fini(&ctx->queues.transfer->entity);
+
+			pvr_queue_destroy(ctx->queues.transfer);
+		}
 		break;
 	}
 }
@@ -240,7 +265,7 @@ static int pvr_context_create_queues(struct pvr_context *ctx,
 	return -EINVAL;
 
 err_destroy_queues:
-	pvr_context_destroy_queues(ctx);
+	pvr_context_destroy_queues(ctx, true);
 	return err;
 }
 
@@ -349,7 +374,7 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 	pvr_fw_object_destroy(ctx->fw_obj);
 
 err_destroy_queues:
-	pvr_context_destroy_queues(ctx);
+	pvr_context_destroy_queues(ctx, true);
 
 err_free_ctx_id:
 	/*
@@ -384,7 +409,7 @@ pvr_context_release(struct kref *ref_count)
 	spin_unlock(&pvr_dev->ctx_list_lock);
 
 	xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
-	pvr_context_destroy_queues(ctx);
+	pvr_context_destroy_queues(ctx, false);
 	pvr_fw_object_destroy(ctx->fw_obj);
 	kfree(ctx->data);
 	pvr_vm_context_put(ctx->vm_ctx);
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 7ed60e1c1a86..15cd8adc7528 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1445,15 +1445,11 @@ void pvr_queue_kill(struct pvr_queue *queue)
  */
 void pvr_queue_destroy(struct pvr_queue *queue)
 {
-	if (!queue)
-		return;
-
 	mutex_lock(&queue->ctx->pvr_dev->queues.lock);
 	list_del_init(&queue->node);
 	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
 
 	drm_sched_fini(&queue->scheduler);
-	drm_sched_entity_fini(&queue->entity);
 
 	if (WARN_ON(queue->last_queued_job_scheduled_fence))
 		dma_fence_put(queue->last_queued_job_scheduled_fence);

---
base-commit: 61de054a772a1feda6364931ab1baf9038abf1c8
change-id: 20260610-b4-sched_fix-ac3b920f475b

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

