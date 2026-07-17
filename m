Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887D6C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1C410F3E5;
	Fri, 17 Jul 2026 06:12:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C1110E433
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:12:18 +0000 (UTC)
X-UUID: 72aafdb081a611f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:93c63c19-4f15-4f34-a6a0-462c53edae74, IP:15,
 URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:35
X-CID-INFO: VERSION:1.3.12, REQID:93c63c19-4f15-4f34-a6a0-462c53edae74, IP:15,
 UR
 L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:35
X-CID-META: VersionHash:e7bac3a, CLOUDID:721a6ca8d6ddc208a3b01dfc076c853e,
 BulkI
 D:260717141214NVJNOZGS,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
 |102|127|136|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82|11|
 1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
 :NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 72aafdb081a611f1aa26b74ffac11d73-20260717
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1695528468; Fri, 17 Jul 2026 14:12:11 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 5/5] accel/ethosu: fix job completion fence cleanup
Date: Fri, 17 Jul 2026 14:11:45 +0800
Message-ID: <20260717061145.1478139-6-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
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

ethosu_ioctl_submit_job() allocates done_fence before validating buffer
handles. Errors after allocation call ethosu_job_err_cleanup(), which frees
the job but leaks the uninitialized fence.

A scheduler dependency error also lets ethosu_job_run() return before
dma_fence_init(). Normal cleanup then passes a zeroed refcount to
dma_fence_put().

Release done_fence in the common cleanup path and use
dma_fence_was_initialized() to distinguish initialized fences from raw
allocations.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
Changes in v2:
- Renumber from patch 3/3 to 5/5; no code changes.

Sashiko reports:

> drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
>         unsigned int i;
>
>         for (i = 0; i < job->region_cnt; i++)
>                 drm_gem_object_put(job->region_bo[i]);
>
>         drm_gem_object_put(job->cmd_bo);
>
>         kfree(job);
> }
>
> This is a pre-existing issue, but was not introduced by this patch.
>
> ethosu_ioctl_submit_job() allocates done_fence. If a subsequent
> validation fails, the error path calls ethosu_job_err_cleanup().
>
> This function frees the job structure but misses freeing job->done_fence.
>
> Can an unprivileged user repeatedly call the submit ioctl with invalid
> handles to trigger a done_fence leak?

> drivers/accel/ethosu/ethosu_job.c:ethosu_job_run() {
>     ...
>         if (unlikely(job->base.s_fence->finished.error))
>                 return NULL;
>
>         dma_fence_init(fence, &ethosu_fence_ops, &dev->fence_lock,
>                        dev->fence_context, ++dev->emit_seqno);
>     ...
> }
>
> This is a pre-existing issue, but was not introduced by this patch.
>
> If job->base.s_fence->finished.error is true, the function returns early
> without calling dma_fence_init() on job->done_fence.
>
> When the job is later destroyed, ethosu_job_cleanup() unconditionally
> calls dma_fence_put() on the fence:
>
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
>     ...
>         dma_fence_put(job->done_fence);
>     ...
> }
>
> Since the fence is zero-initialized, will calling kref_put() on it
> violate the API and cause a refcount underflow?

 drivers/accel/ethosu/ethosu_job.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 5847433e87e7..b68a905d22f8 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -152,6 +152,13 @@ static void ethosu_job_err_cleanup(struct ethosu_job *job)
 
 	drm_gem_object_put(job->cmd_bo);
 
+	if (job->done_fence) {
+		if (dma_fence_was_initialized(job->done_fence))
+			dma_fence_put(job->done_fence);
+		else
+			dma_fence_free(job->done_fence);
+	}
+
 	kfree(job);
 }
 
@@ -162,7 +169,6 @@ static void ethosu_job_cleanup(struct kref *ref)
 
 	pm_runtime_put_autosuspend(job->dev->base.dev);
 
-	dma_fence_put(job->done_fence);
 	dma_fence_put(job->inference_done_fence);
 
 	ethosu_job_err_cleanup(job);
-- 
2.43.0
