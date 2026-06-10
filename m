Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EACCD98CB
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAE110E7BC;
	Wed, 10 Jun 2026 07:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="NqULZSBC";
	dkim-atps=neutral
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5244E10E707
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1781071325;
 bh=FjDzXjUTCA7PwSwSBXMojIa1RoXXpb1tpWd5EIt2Ab4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=NqULZSBCZen31aNEFQyql5UpEYhb2NYiS3SkqfOXh0VEWAj2asgUbVaL5XuiTQPu8
 TO3nc7VHsFkTGwVHhbYoPlaVD/YGmEMG/wCmmU++bqrc62jCybhKkO1zNSnvogOMsc
 jciznXlq03FdsUI5x5VvQggKpan2eHS8oCLKgvq0=
X-QQ-mid: esmtpsz18t1781071305t3236f62b
X-QQ-Originating-IP: iePxYMPyCq/TYnXweTLz+Oc+mDGPzOvpeL8ckYEnAJM=
Received: from localhost.localdomain ( [124.126.19.250])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 10 Jun 2026 14:01:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12200062237353553403
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, ZhaoJinming <zhaojinming@uniontech.com>,
 stable@vger.kernel.org
Subject: [PATCH v5 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
Date: Wed, 10 Jun 2026 14:01:31 +0800
Message-Id: <20260610060132.3239648-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260610031431.E8EA71F00893@smtp.kernel.org>
References: <20260610031431.E8EA71F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MOdUEiNUAftlWk9vIicVUgL6IwBpYf6MWLHZLxKPsMPW/oc3I2yonn8F
 9TFnDQXHMz7sj8m1AexAh6z3XlVdrLRH0AfXqNeOUZX1NQBmcbucA/guNic9YYVL3uk2vV5
 NJ7bpwqWp2CMBx9o2BPAa0PDeCPIkIFZx+WffGyGCzM+x+GF75HRz8TFdArXXDa1aZ7YtNi
 2nvKTf/6pDlddQuz4QZz9hKXVe2Uid/BEqQnKUS1tEGnN+ylXbK4EFVjXoujSuJvcNyNOmL
 8AnY4BYPJKRtXNvf5F+O1LzZ1KefTxNWz9AHAQZUhVaysMB2DOJRzB4/Pw8+bIUSh+PousB
 8Wxq3HeI8AtAfkHt6ml9BMafsV/T3SWhodTWvNSTyi0+m4obOeLGm26lym8Q0g8ORMN6fGz
 ogWGuGtwKBwIP/GyZyvJRxat2c0A5j85nedVbAmqIWhNlDpkIDZTgdn5lbxbaya+7AEZCY0
 0EVax6ZLLAtPufxRh1Ka0uYzZ/KFakfZy1uSoaOuVE4WrFVfCoLVqy+1GsErfyIqJRUyziv
 TYgutLWQbCREt6z3kzPvlSWs9i2EYlJveqXe0JTW1oXq5qEMMbJrWB9d9AjoQYafDZMvntS
 CJzvkxKhd9456MnWvD/s00+VkQ5D3P1yMrpGCSaQF4hKNK6LnODPEDbrtQ4J07FboX+bBB/
 yo1xADn1xXXW4M3fqEHZX4OGuia+D3ISlA5LTrFJ72VkUy8oMGgVv6xzFWQ/88WIoe3XFPc
 T5isbpxsjGUmW5bOkvKbHMqYrywZe/57+OEHfhGzEHCjmLHfXb00/8bgA980yv1zFrnwOHT
 cbC9hF9Y+yZv1YbWck1cGItB+1ZHSeL9EvEiCeX4kNEyPCay4JrCwmZQSPmFbdnEpsNhCO6
 jJSc3px7qbW/ZmY/qXP60CBvY5mjGXZ7wRd9PJNlJyrFhHKc4jT7omkuFSYaS+xDSYQmmPw
 gy8/OVkrVFoM2dU+ibN3mXHW5lRe+/5rxTxpkOu1lT6YOzHL5LW08yBrXxdkdM17WYHKnhc
 MHC7I/7YVNfrRuRnub4/t9lwplgxbCqMHfJG/tuQotrUVw/M6+KYYyFeWPH5MsTNvNEzLG3
 A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:35 +0000
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

In rocket_job_run(), after taking an extra fence reference for
job->done_fence via dma_fence_get(), the error paths have three bugs:

- The dma_fence reference held by job->done_fence is never released,
  causing a reference leak.
- pm_runtime_get_sync() increments the usage counter even on failure,
  but the error path does not decrement it, leaking the runtime PM
  reference and preventing the NPU from suspending.
- A valid but unsignaled fence is returned to the DRM scheduler,
  which triggers WARN("Fence ... released with pending signals!")
  when the scheduler drops its reference.

Fix by replacing pm_runtime_get_sync() with pm_runtime_resume_and_get()
which auto-balances the usage counter on failure, releasing both fence
references on error, and returning ERR_PTR(ret) instead of the
unsignaled fence.

Cc: stable@vger.kernel.org
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/accel/rocket/rocket_job.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..e8a073e22ac2 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -310,13 +310,22 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	ret = pm_runtime_get_sync(core->dev);
-	if (ret < 0)
-		return fence;
+	ret = pm_runtime_resume_and_get(core->dev);
+	if (ret < 0) {
+		dma_fence_put(job->done_fence);
+		job->done_fence = NULL;
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
-	if (ret < 0)
-		return fence;
+	if (ret < 0) {
+		pm_runtime_put(core->dev);
+		dma_fence_put(job->done_fence);
+		job->done_fence = NULL;
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	scoped_guard(mutex, &core->job_lock) {
 		core->in_flight_job = job;
-- 
2.20.1

