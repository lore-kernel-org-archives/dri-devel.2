Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0ECCA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568BF10EB08;
	Sun,  4 Oct 2026 17:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="e3zwIBPd";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607EB10E765
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fz
 qlwKVaG5F2Cl/Blfh3aivHLdgARdebIfadlDcrE98=; b=e3zwIBPd9Z/fHXL28y
 RQCsxrifvMrkOOeSKsZ52Okx7FIKv6yzDUlQ48I6OHD83emduTJG6O+fbJDRt7Cx
 CnZ0wiOMhn/5KZM0ralQnMawbWNDsiqlaU+FT+lNN4opT6FZV68QdFiv1WM5AiHn
 uxVOw4rWFBYnx3NBfxJSi6800=
Received: from pc.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgD3qHRLuMBqTxqBCg--.60808S2;
 Sat, 03 Oct 2026 16:09:48 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] drm/msm/a6xx: handle runtime resume failures
Date: Sat,  3 Oct 2026 16:09:45 +0800
Message-Id: <20261003080945.431091-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgD3qHRLuMBqTxqBCg--.60808S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF15KFW3Ww43Gw4DGw45ZFb_yoW8ZF1Upr
 Z5Xa1ftr48Cw1agws5AF48ZFy3C3yrWay7Z3sFg3s5ZF15AF1UtF1FyryaqF95ZFZ7AF13
 tF4UJ3y7Cr1Ykw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi3fQiUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wwMRmrAuExQFAAA3z
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:20:52 +0000
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

a6xx_pm_resume() ignores failures while resuming the GMU device and GX
power domain, then continues enabling clocks and initializing hardware.
The common error path also drops both runtime PM references even when
either acquisition failed.

Check each resume operation and unwind only the references acquired
before the failure.

Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 081e79ea4652..aa785f197aa0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2188,8 +2188,13 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	/* Set the core clock and bus bw, having VDD scaling in mind */
 	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
 
-	pm_runtime_resume_and_get(gmu->dev);
-	pm_runtime_resume_and_get(gmu->gxpd);
+	ret = pm_runtime_resume_and_get(gmu->dev);
+	if (ret < 0)
+		goto err_clear_opp;
+
+	ret = pm_runtime_resume_and_get(gmu->gxpd);
+	if (ret < 0)
+		goto err_put_gmu;
 
 	ret = clk_bulk_prepare_enable(gpu->nr_clocks, gpu->grp_clks);
 	if (ret)
@@ -2204,14 +2209,16 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	if (adreno_is_a619_holi(adreno_gpu))
 		a6xx_sptprac_enable(gmu);
 
-	/* If anything goes south, tear the GPU down piece by piece.. */
-	if (ret) {
+	goto out_unlock;
+
 err_bulk_clk:
-		pm_runtime_put(gmu->gxpd);
-		pm_runtime_put(gmu->dev);
-		dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
-	}
+	pm_runtime_put(gmu->gxpd);
+err_put_gmu:
+	pm_runtime_put(gmu->dev);
+err_clear_opp:
+	dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
 err_set_opp:
+out_unlock:
 	mutex_unlock(&a6xx_gpu->gmu.lock);
 
 	if (!ret) {
-- 
2.34.1

