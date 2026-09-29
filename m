Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8593DCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BD910EF16;
	Tue, 29 Sep 2026 14:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kwDqEAlZ";
	dkim-atps=neutral
Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com
 [74.125.230.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C1A10EF0B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:21:23 +0000 (UTC)
Received: by mail-lr2-f11.google.com with SMTP id
 38308e7fff4ca-3a5b0adf48fso21106551fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790691682; x=1791296482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lftI/6ehzwzDEr+70gWwS6iuo2yG+lmF8bwoB3kKEVc=;
 b=kwDqEAlZ7tulX/go8nhKjzHbEsXECcULW53TzlG9pxKeFWmGkGaR2B117Ve9dAjqDC
 i5y/r6fWNo9jfD+gQBGvK7PUPTEH57tLoil0EqOCAdGbGVZgmJMcfXQXBDndFQhC88M+
 bgymZOQfKWLoJEywVRf9ADzgTDMWJ6ONkdZxjvjYd9JfAdFu274C/sS4GTdYRSsL4C5x
 fUTnJSSiybGvha0QG1a0133CZ3+nC0sk9ZbCv4WyWZsOLfuWAfpVlN/7+VRWWzHfcMvl
 F3UNlXGWATx9BYCoAMDO7rD1gvPS7a8BFpkO2fbYvNzK4n7trDlhX/X5ivFZAyRdG0Xa
 PSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691682; x=1791296482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lftI/6ehzwzDEr+70gWwS6iuo2yG+lmF8bwoB3kKEVc=;
 b=ZhKje4+jAD2JpWcSfW8RZ9kVlEF+M9hFvaOekFiRMWeDf8lr7zQoc0Q0Zkp+4uBz+H
 xyhuqZKKKJOSr2Z/Fm6/Wv+57LhqQq0U2AQQCUot74nKL/1hRcW9KkKSbEnBIRubcwZn
 nYY1eUL0HNLzxPPyZXgYdbn6XnunP5V81MoXs19rRgfdC4Q7FqBTyJuhYk2kuVVFzua5
 qfsj9YAPJjDrfYNRhmMhK35zm0ZSXng6QBU9xSK66Xs3aPs+l0TSa2bCQwjLRY0NG4eT
 tQ43KCfgoVAFbLlW1TQj0FcNI8XuixTLeDDEVmiR2lM5sugMO3B3Vpv0U203g+08UJnM
 bogg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLeBbIPqQS35SOxpjgo8DkhwkQMjO2szRxUY/NygYgjc3xl49cp/TJZbz7S9/KUkPY/0dlS2QfC1E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJw6BLi/cmq03kv1B+HoZlrR5PYnOh3tyYFKTDSVGrPeM6fp5m
 nIoPwVhefJgK/VmK8BBUsSiAjRdVeonmrGedfoFhaO8Gzxu6Hz7ZkVBa
X-Gm-Gg: AYBFou3GiW+8PhnPGbhI0Pi9LJ17wFygkl8Tq/meN2/U115FWt97Yla6bhsU0eIJLHw
 vFBOIItB85RdaCMRwdLhK8b073zOt3XiTBiaXRChGaiz6F1Dmh4kjRh8OBW51qRcP+6cbLEsz5l
 poYsQCH9MyLnTHTORQWNMQ34dMXIFqcN+9yatHeFqJuwRsu2rWaxJrTB1t6Nqxbb79fp1b54Lg/
 ukEkG2QB2gepbiugEV4mDgV2r6oR1GXodK3oT76KypRWQfVc86t0HBbENhXNDHDMvvAWOA63tyx
 gBavEHDIgqaOwx8rCWjCJtPliXGSU1lnTtybN4++LQmb0KD9ym8GPmO+JBmDJjnvPmfntUoxo37
 AzT+qlJ1S0xFQc+SEnzroMmgwLxfKmd+WsGfDdoek7qY2dXCMZHutmTmy5Qv6KcF8uCilUtDz5Y
 J1N2cfW30yZU+yXE4FPJuRvLXPRl/qoXVM/65TnIi6pqB6c1u20RM3gQGHArkLhtmgvXln4VNGJ
 00kaGiYqI0Vs+Du
X-Received: by 2002:a05:651c:2212:b0:3a6:6282:563e with SMTP id
 38308e7fff4ca-3a662825decmr21779281fa.4.1790691681393; 
 Tue, 29 Sep 2026 07:21:21 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a76a503af4sm4538631fa.33.2026.09.29.07.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:21:21 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH v2 2/2] drm/msm/a6xx: check pm_runtime_resume_and_get during
 resume
Date: Tue, 29 Sep 2026 17:20:59 +0300
Message-ID: <20260929142103.81854-2-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
References: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
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

The return values of pm_runtime_resume_and_get() calls in a6xx_pm_resume()
are not checked, which can lead to hardware access on suspended devices
and PM reference underflows.

Fix this by checking the return value of each pm_runtime_resume_and_get()
call and properly unwinding the previously acquired resources on failure.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 +++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c827986951cc..a6da448ee6c2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2175,44 +2175,48 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	opp = dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
-		goto err_set_opp;
+		goto err_unlock;
 	}
 
 	/* Set the core clock and bus bw, having VDD scaling in mind */
 	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
 	dev_pm_opp_put(opp);
 
-	pm_runtime_resume_and_get(gmu->dev);
-	pm_runtime_resume_and_get(gmu->gxpd);
+	ret = pm_runtime_resume_and_get(gmu->dev);
+	if (ret < 0)
+		goto err_opp_clear;
+	ret = pm_runtime_resume_and_get(gmu->gxpd);
+	if (ret < 0)
+		goto err_put_dev;
 
 	ret = clk_bulk_prepare_enable(gpu->nr_clocks, gpu->grp_clks);
 	if (ret)
-		goto err_bulk_clk;
+		goto err_put_gxpd;
 
 	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
 	if (ret) {
 		clk_bulk_disable_unprepare(gpu->nr_clocks, gpu->grp_clks);
-		goto err_bulk_clk;
+		goto err_put_gxpd;
 	}
 
 	if (adreno_is_a619_holi(adreno_gpu))
 		a6xx_sptprac_enable(gmu);
 
-	/* If anything goes south, tear the GPU down piece by piece.. */
-	if (ret) {
-err_bulk_clk:
-		pm_runtime_put(gmu->gxpd);
-		pm_runtime_put(gmu->dev);
-		dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
-	}
-err_set_opp:
 	mutex_unlock(&a6xx_gpu->gmu.lock);
+	msm_devfreq_resume(gpu);
+	a6xx_llc_activate(a6xx_gpu);
 
-	if (!ret) {
-		msm_devfreq_resume(gpu);
-		a6xx_llc_activate(a6xx_gpu);
-	}
+	return 0;
 
+	/* If anything goes south, tear the GPU down piece by piece.. */
+err_put_gxpd:
+	pm_runtime_put(gmu->gxpd);
+err_put_dev:
+	pm_runtime_put(gmu->dev);
+err_opp_clear:
+	dev_pm_opp_set_opp(&gpu->pdev->dev, NULL);
+err_unlock:
+	mutex_unlock(&a6xx_gpu->gmu.lock);
 	return ret;
 }
 
-- 
2.53.0

