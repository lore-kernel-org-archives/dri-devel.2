Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F005CC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8E610F156;
	Thu, 27 Aug 2026 19:08:26 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7F489622
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:06:20 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dd0;
 Fri, 28 Aug 2026 01:06:17 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/3] accel/rocket: Collect job dependencies before arming
Date: Fri, 28 Aug 2026 01:06:07 +0800
Message-ID: <20260827170608.39511-3-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442fca0203a1kunmddadd30e6f5a8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0IaVh1KTRhDTkgfQhlIQ1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:08:24 +0000
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

rocket_job_push() arms the scheduler job before collecting its implicit
dependencies. Dependency collection can fail with -ENOMEM, but an armed
job must be pushed and must not be aborted with drm_sched_job_cleanup().

Collect dependencies before taking the scheduler lock and arming the job.
Only operations that cannot fail remain after drm_sched_job_arm().

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 7e3d123afc5ad..51e8b43c05131 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
 	if (ret)
 		goto err;
 
+	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
+					   &job->base, false);
+	if (ret)
+		goto err_unlock;
+
+	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
+					   &job->base, true);
+	if (ret)
+		goto err_unlock;
+
 	scoped_guard(mutex, &rdev->sched_lock) {
 		drm_sched_job_arm(&job->base);
 
 		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
 
-		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
-		if (ret)
-			goto err_unlock;
-
-		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
-		if (ret)
-			goto err_unlock;
-
 		kref_get(&job->refcount); /* put by scheduler job completion */
 
 		drm_sched_entity_push_job(&job->base);
-- 
2.43.0

