Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C979CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F57E10E7B6;
	Wed, 10 Jun 2026 07:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="cm+3lfIO";
	dkim-atps=neutral
X-Greylist: delayed 167549 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 07:11:58 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.79.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378A610E754
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1781075476;
 bh=FjDzXjUTCA7PwSwSBXMojIa1RoXXpb1tpWd5EIt2Ab4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=cm+3lfIOqU7zG8hTZLroEdDH/jU9TjGQJFfqssEBBqwKVliJvdKrBpj5QelQT8iun
 8opzyMZpnaDknmqucip2xriPMdp3gK5RcCJvNxH5PEkOfWrGTUfcqfVIQO9mJTrtfC
 J0VofpfJsbtxsar4yQVHBDmEFqU9WcdBYr6yB0Hk=
X-QQ-mid: esmtpsz20t1781075457tb0623c5e
X-QQ-Originating-IP: 9w9119h/pi2NtSaFq8NvVC5uvLHbf8Bnd7PYZkuQcAQ=
Received: from localhost.localdomain ( [1.202.39.170])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 10 Jun 2026 15:10:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16958495345642707546
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
Subject: [PATCH v6 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
Date: Wed, 10 Jun 2026 15:10:44 +0800
Message-Id: <20260610071045.3414828-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260610061915.1CA281F00893@smtp.kernel.org>
References: <20260610061915.1CA281F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MhWaMTxgikzcEseUwhScMwKj1uvHXyIQadEREZTD4v/yhebL0peP8Dlz
 vRQeEJdIATTrfX1CFaoq+tajdOMDoYC+kj+Xs3eghl7htp4cdQci4PwUtW1OjuWGLDDI245
 7tImIbYK/W5w70agxHYBVNTNxX4sdbskc/cEYY1ZOMgJripyNr9xhPCZ2kH8fVm/Qh2Mw5z
 7If1J0zSU2Iom+56uU+078RTvR22RUdeTQ0Lud1ILPon9QaijFOTw4d5dBTM6IdOmMrxFtK
 1M6krdfcXiKIPV8vdU2pNe0v/dSBLBJTqde/7kmcUvwxn52fADJL3DHQW+4FCTFntZfTa+f
 flD2Nc1jqpZlU8dJ2IT+fNsDGFXp34Ul37e0wHlqH/gv1qgS+xHYX79UWtxKVSqpAdBcOdG
 gvttsuaKltpieYYu03mr8eL3KR62j/R6gEu9whE4q/QClMwp40VTsuO/77gBuCVJ62FC4KO
 UhMYDoGB1+nFYdH5O/lf40GlFJrxb6SYHLiJNqWPhFgwqeVLptZc6UAKMu9OCJJpmphSxIy
 jXML3DWTfgvCmbzvRhed28ggUz5dAxflqE93aqm+3fFj36R3iyHwmZ2SSq8ejY8BNGTjtbL
 T9ALXe+QqgDS+dzHPwZvSzAdpR3BaoIaTeqIWv/3JeXFJklGFA5VO2pW4TTUu4SPgk+Sknp
 HGvTuXjyMdNfQ2qpV38/CCuFllSHBIdRjyHBRN+MYmzz+TTfkxxpJPTvVmMbMt5Iu7yp4p2
 aJ9eUhb0Pmr42jT3uiOLXLcR7fhgeGYzOpmf//rcgB1w81Q3Gozztpx6Yg0SpqTpI85YeW0
 k8QmolWUYxpczXBI24bpgtGCDjM3kjL+7HEarmGUFbTftRrEz3gSDC0Sf/YToPULLxEHwoJ
 f51vADU2u7xr/xyZAi318Sjt+HzTr9WGc0YZyV5HHR+ur7Ezl4K9sg95P0eAmkhTk1f3Yfi
 8+j6NqC1QBlQ1WWm8vrM4BsStTr/GpxKPSSN2MmBKFlZbB04iZ+S2dLwieDFD6vcOzljNiE
 0w/q/ugDMk3GoMaYXJ8Gw5Kgxu9TeLCUZre0Dli1pVIxjo0KAw9sTgAcxyppck0CoYTbmPM
 w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

