Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B841CC79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD90710E2CB;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqlEsnSC";
	dkim-atps=neutral
Received: from mail-lr2-f9.google.com (mail-lr2-f9.google.com [74.125.230.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6173310F924
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:55:54 +0000 (UTC)
Received: by mail-lr2-f9.google.com with SMTP id
 38308e7fff4ca-3a2ebc73ee1so6199201fa.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788526552; x=1789131352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B8bbaT/K4F9QIRkgiCQIzbuZJYSHMTac2dqp5kAWa+s=;
 b=NqlEsnSCNMNHGMze5KZpq/pMCjeJ3wyLvF62zByg3fI/x14KMBtYsftZg51YobqvRb
 eLVUREPALHNWRZLvT2rKDL+hHjojfoUV4Sy2DRdfcbqw87JtZ4qJxtpaYZdxp7SY9P0n
 +LHEyz3cQPCor07Umswktcejvtv1v9WCqQL17AvZp/0K9E7QdRu7oG4MOfjDsQsBy+XZ
 YZz/aZU370A0lE01C6VeCtPMK2fPwIz+hkd4+mPVeBpkBB+XKBREJ4g6Zflj/mpeO14d
 6x0O6Ju/soAdaMUj0xflHNHf+I6mje6v2VbZLW5mgAbjZQJO+v9MYLtIHFByyYzoNELf
 tKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526552; x=1789131352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B8bbaT/K4F9QIRkgiCQIzbuZJYSHMTac2dqp5kAWa+s=;
 b=aIoUndodjc2BugZSF7C1rE3uHRT6aWsfgaWOWvDs4BFr6WmgwJzwr2xcdOgKb29xDT
 J+Bfe2E70/LvWqd2D1FrTjW2o2hEtAHZV+xMN20KhdJoapTWYQx6WdRO/qfRIVS7QIJo
 1TsUioP2IwrtW7TVeb3znDZcdgHKy9oB5+h1eIogdiHXE3zYXdUua0gcgcDEByce8Wuh
 NK2r7v2HNTcNi4aBfVGPZqlekRGjAOYrWXiGDlXNDZIPWD0iGUkGG67ImaRzCXkw8l7K
 emh2VdSqcSyFmxWATxPdwKQ9EsdCg0xnoOvmhqqnFfvVNJzX3g8rXrSx7IP3OFurGW2R
 myjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL8V2/KhvLtSUJuMn4Ws3QZpXWfPVvSVY7U2BrzBE/XAEACatU64CdZbZRU46xxnM0IPHZ3/o3rSY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgMWC2/VhPBduEtepjrer1ppFVUJ2fuF3H6bIuYblSn2PmsMHB
 CgmOp8x1SwnLVcZUxcS2rMx/F0NWxjGeXArUapwcb34NpbIvDOx7KNKb
X-Gm-Gg: AYBFou1KrJ+yU7hcFo5TxDeX3zqEEgSswOq9vB1vq6F9OuNIeocRQ0FWsT1kSg8ODtx
 nz5G0XQKAQHAu8RGUNNHjeU9haklolna/ZATbN9qvOhwMEOuznzd7/so0UD97eTea4ZZVTeC+Si
 7ICSQpbZ3e4gVV0AUN0+2mGF/lX9q/XFiNE8795pJiggyxJbfwo5BncmZn+hUusPh6wEQAW7XEZ
 OdvsOuuzx1l6XdPFiD4G28MRJ5TDhPZ3PbKqxklxhaHDRRISBPsGCHn6Za+4T5uVEjRyv2OL7Sm
 /pZuv9ZrMSgBbBDaDTemoqwGCDk7vYDfqXCm8AmKdWrc5ntZbI1einlQrleaGNdRnWwpSflxxHj
 cC7mUzO/oUW8IeUgJIkbL52cZkqBdwAbmXa8yWPjAersG2ko80pvKpExw0JESGghDUp1rtu/bjn
 e6ihKNSXL/xnxed93Amrzx3W+O0CSMulZjw7LNnanBHfd1k2WI6JILKe617aWMECuzEMiqtqYJF
 8WIoQ==
X-Received: by 2002:a05:6512:3502:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b616ed4b1dmr1822141e87.6.1788526552231; 
 Fri, 04 Sep 2026 05:55:52 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b61669aedesm524025e87.10.2026.09.04.05.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:55:51 -0700 (PDT)
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
Subject: [PATCH] drm/msm/a6xx: check pm_runtime_resume_and_get() during resume
Date: Fri,  4 Sep 2026 15:55:21 +0300
Message-ID: <20260904125523.43813-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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
index f9de9329dee3..0cf205ea744b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2175,44 +2175,48 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	opp = dev_pm_opp_find_freq_ceil(&gpu->pdev->dev, &freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
-		goto err_set_opp;
+		goto err_unlock;
 	}
 	dev_pm_opp_put(opp);
 
 	/* Set the core clock and bus bw, having VDD scaling in mind */
 	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
 
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

