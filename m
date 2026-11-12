Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6399606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2F61124C5;
	Fri, 13 Nov 2026 13:43:29 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 15:58:12 UTC
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF1F1121CA
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:58:12 +0000 (UTC)
Received: from Mogu.localdomain (unknown [220.168.84.219])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5479c1088;
 Thu, 12 Nov 2026 23:53:04 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: tomeu@tomeuvizoso.net
Cc: heiko@sntech.de, ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Naixumogu@whut.edu.cn
Subject: [PATCH drm-misc-fixes] accel/rocket: publish read fences for input
 buffers
Date: Thu, 12 Nov 2026 23:53:00 +0800
Message-ID: <20261112155300.299899-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d0766ad503a1kunm90ffcb87766e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxoaVk0ZQ0NCH01LTUlDS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUtVSk1DVUNPVUlKQllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
 Y+
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the bug that a fence is not attached to a BO reservation when the BO is
read. An exported input buffer can appear writable while an accepted Rocket
job is still reading it, allowing a later writer to overwrite data in use.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Haoming Gao <Naixumogu@whut.edu.cn>
---

Notes (rocket-submit):
    Based on drm-misc-fixes at bafda823590ddf7031ecb765d673572fae7ab44a.
    

 drivers/accel/rocket/rocket_job.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index c3edb94355a3..7aa7bbfce036 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -201,12 +201,13 @@ static int rocket_acquire_object_fences(struct drm_gem_object **bos,
 
 static void rocket_attach_object_fences(struct drm_gem_object **bos,
 					int bo_count,
-					struct dma_fence *fence)
+					struct dma_fence *fence,
+					enum dma_resv_usage usage)
 {
 	int i;
 
 	for (i = 0; i < bo_count; i++)
-		dma_resv_add_fence(bos[i]->resv, fence, DMA_RESV_USAGE_WRITE);
+		dma_resv_add_fence(bos[i]->resv, fence, usage);
 }
 
 static int rocket_job_push(struct rocket_job *job)
@@ -248,7 +249,10 @@ static int rocket_job_push(struct rocket_job *job)
 		drm_sched_entity_push_job(&job->base);
 	}
 
-	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inference_done_fence);
+	rocket_attach_object_fences(job->in_bos, job->in_bo_count,
+				    job->inference_done_fence, DMA_RESV_USAGE_READ);
+	rocket_attach_object_fences(job->out_bos, job->out_bo_count,
+				    job->inference_done_fence, DMA_RESV_USAGE_WRITE);
 
 err_unlock:
 	drm_gem_unlock_reservations(bos, bo_count, &acquire_ctx);

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

