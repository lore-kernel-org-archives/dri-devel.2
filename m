Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MwMsvsOq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BF610E662;
	Thu, 19 Nov 2026 03:47:58 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54C310E662
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vw
 TZeo7iBYBs+QejrwiRws0+OdtO38BbVpGXCkhgvvE=; b=MwMsvsOqUuoy5QcTAd
 hL/GhAeJkifpYQORLcUmSxG7p0L5oTbDPuxoStAMxEp7Q+2cCRGgKcn+PxgfCOHP
 8UOT5d/yg6a29XsinV50psgNX7v7F/+g5lefja8gkj5KehBsSJxgmTEReHVBpu3Y
 tS9G3du98N2GduVAxLKt5sBBM=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgA3En9Icf5qbvhPGw--.13124S2;
 Thu, 19 Nov 2026 11:47:22 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: robin.clark@oss.qualcomm.com, sean@poorly.run, konradybcio@kernel.org,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] drm/msm/gpu: Unwind power and clocks on resume failure
Date: Thu, 19 Nov 2026 11:47:18 +0800
Message-Id: <20261119034718.2818183-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgA3En9Icf5qbvhPGw--.13124S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1kWw43XrWDAr4ktrykuFg_yoW8Xw1fpw
 srJasYkry8Z34Ig3y7AF4Du3W3Aw48AayxGwnF93yfAw1Yyrykt3W0yayFqFn5AFZ7Gw4a
 qFs7JF17uF1YvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QrIN2r+cUrK8QAA3M
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_gpu_pm_resume() returns without disabling the power rails when
enabling the GPU clocks fails. If enabling the AXI clock fails, both
the GPU clocks and power rails remain enabled. In addition,
enable_pwrrail() leaves gpu_reg enabled if enabling gpu_cx fails.

Disable gpu_reg when enabling gpu_cx fails, and unwind the completed
power and clock stages in reverse order when resume fails.

Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 8319119041eb..5480abe1aba2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -40,6 +40,8 @@ static int enable_pwrrail(struct msm_gpu *gpu)
 		ret = regulator_enable(gpu->gpu_cx);
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable 'gpu_cx': %d\n", ret);
+			if (gpu->gpu_reg)
+				regulator_disable(gpu->gpu_reg);
 			return ret;
 		}
 	}
@@ -110,17 +112,24 @@ int msm_gpu_pm_resume(struct msm_gpu *gpu)
 
 	ret = enable_clk(gpu);
 	if (ret)
-		return ret;
+		goto err_disable_pwrrail;
 
 	ret = enable_axi(gpu);
 	if (ret)
-		return ret;
+		goto err_disable_clk;
 
 	msm_devfreq_resume(gpu);
 
 	gpu->needs_hw_init = true;
 
 	return 0;
+
+err_disable_clk:
+	disable_clk(gpu);
+
+err_disable_pwrrail:
+	disable_pwrrail(gpu);
+	return ret;
 }
 
 int msm_gpu_pm_suspend(struct msm_gpu *gpu)
-- 
2.25.1

