Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8C7CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42AF10F5CF;
	Mon,  8 Jun 2026 15:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="E3DXvVUc";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DC410F0AD
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1780913017;
 bh=xjnPQf7GAoyFUyGY5zxvgjv4eM33qSIDMbKW2dSfDqo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=E3DXvVUcT5fPBm0f4ZbkRRvwX6L3DVoWq5Mz1nD8bnGEI/L38Y1GmZydiVbnXPAHY
 GrFA2ke+0ZAYQOaZLcBNf/pfMslPqrd8jdN4/4mzN4tsPSumbB/zgcU+xL6paxMD9T
 i0RAygo78bh2zlsEa0+W3qW4YnZjL98QykOm81Ko=
X-QQ-mid: zesmtpgz3t1780912854tae9d0c57
X-QQ-Originating-IP: 4E4RYRX91c4laM26UrRIuLa53EZJzKOeKvUr8D6DNiU=
Received: from localhost.localdomain ( [1.202.39.170])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 08 Jun 2026 18:00:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 280074594800750850
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
Subject: [PATCH v2] accel/rocket: Fix fence leak,
 runtime PM leak and WARN in rocket_job_run() error paths
Date: Mon,  8 Jun 2026 18:00:40 +0800
Message-Id: <20260608100040.985526-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260608085043.688141F00893@smtp.kernel.org>
References: <20260608085043.688141F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MDeoJ9InxGeGBDpgEnCvayQAM3pvdCgTB+BqWevP9++8mnSH3Tl8YU/2
 VkQ6AvN84L4iRx/lRi0XxSKtebQffHtPLrfM5RjF7w8MwRRbmEhW7z00sMjbFfMldeo4Im8
 tR8LX+bFC8bU1K0w5Y3btSUeDQffn8v2I/sLEZyrrAHsMygsNzB6ymA5QrtCVEf8sn0WBp+
 rirrZ993TYV2UYMQPBGpErVZ53gi0BEYZ6AtBhdNJmvSdFZ0UYQkFIvTTNXa4R0lDYIz6Z6
 3Y/PRflryK38UCJ9IxRU75TW29kOh22Joiga/Y9daY0r/CXXmuBk0dNR+11HEWnCe/UCbm4
 Rhf6jvDOXoLUwfXxyGDLf/tZVj7l2KJKIWf/7yFWOrt5y/pPwxvuLOVswG9iZCYj+VIFU3/
 O749gQdCjsQjBdGvr9LYf+tvenbqsZdDcO8KqbzS/pSlA/vLCYP4uzB0ylcI1oqmF5HZ3rj
 uebQSX97VSW9kLOhGMopDqyYaVDXqR+lLqeVq5IVKgOBhBZH7P/QZZKKd33sFaYNYesRC54
 JdvRrvWFE2TGf2WMh5mOku04n08dm50BMzaFJzamFk09tOngSRG4fLe3wHbzV2XzA3P9E5/
 ytxsRucv6LzT4/cofEF0g4fibsCyffH3XJ7zM53qqOKV/l8qBzxfwGEl+y//Ue/WANPq1KH
 Y1b2cL8uPr2bJPM3OyHZW7LxdZwu2aD4ShdHp2mZgUHC9HTWtv5hDPsebje+zJ2qD4nqpYP
 I+eVYmjN9o8MdNLGyo/WrjQ/GNrm+CYtRkGpBEnqPxdPEjemYj1l10MoDPQVh16fE8LRKDj
 rXf9p1w2gKD+71v8TpyVMYhBGujB+ZR9GN8dh/NijZiNMKnHyVEVvYtEfstSRAae/isdFBI
 1Kohj/q7F7cyltNzROqOH/BGF3bjbu2IwyBR676012Gy3RfXWcY+6RxCWzhv3PAzPzFaBuB
 hk9DK2S//q8PASCgqHTSx5tip3Udaxo0thPfjVSinywyNvqWHJkn8EFUqNyXz9iMFKS31UE
 a8iQIo+S5xZCAGBu8pHV1wL+wkko1BoHNO+J8QQA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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

Three issues exist in the error paths of rocket_job_run():

1) dma_fence reference leak: After creating a fence and taking an extra
   reference for job->done_fence via dma_fence_get(), the error paths
   return without releasing the extra reference held by job->done_fence.
   The leaked reference prevents the fence from being freed, causing
   resource accumulation on repeated failures.

2) pm_runtime_get_sync() usage counter leak: pm_runtime_get_sync()
   increments the runtime PM usage counter before attempting to resume
   the device. If the resume fails and returns an error, the usage
   counter remains incremented. The original error path does not call
   pm_runtime_put_noidle() to balance it. Repeated failures will
   permanently prevent the NPU from entering suspend.

3) Unsignaled fence returned on failure: The error paths return a valid
   but unsignaled dma_fence to the DRM scheduler. Since the hardware
   was never submitted, the fence is never signaled. When the scheduler
   eventually drops its reference, dma_fence_release() detects the
   unsignaled fence and triggers:
     WARN(1, "Fence ... released with pending signals!")
   and forcibly signals it with -EDEADLK.

Fix all three issues by:

- Replace pm_runtime_get_sync() with pm_runtime_resume_and_get(), which
  automatically decrements the usage counter on failure, eliminating
  the need for a manual pm_runtime_put_noidle() call and avoiding the
  usage counter leak. The pm_runtime_get_sync() documentation itself
  recommends pm_runtime_resume_and_get() as the preferred alternative
  when the return value is checked by the caller.

- Release both fence references (job->done_fence and the local fence)
  before returning ERR_PTR(ret) so the DRM scheduler cleanly aborts
  the job without triggering the unsignaled fence WARN.

- Add pm_runtime_put() on the iommu_attach_group error path to release
  the runtime PM reference that was successfully acquired.

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

