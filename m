Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE2CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F344510FA59;
	Sat,  3 Oct 2026 00:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tx7y3EAS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayPInbIV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CB610EC00
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:30 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeaW13884959
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PCKckv3D3qYeE7jBJ3PaA+r53Z6LWd0Zt+icCTw5pD8=; b=Tx7y3EASDrt3gPCc
 GHH9TuXktZyBjtPgE6mMKExFR+ZJRIlXuYwUe/3E5NbBZjV+eBJrfiLgkcLomloE
 JiN83vQkGuUXmqn1QaJSF2d29ilkZOzJfPIR+OTsMqVghmFaUfc6E7jPD8mBz/BU
 R/k4sW3vb0wCdpwWAWnNx66gYKAKPE98VDqUJBIzbtzT67kkR0CMMi7zIBtB5o9P
 ywaYekL4I32IEMFUI4KGOM8tyxFf+Ej9sdeuJVPxEgdQT8Vddk4nk1z7JL+X/VZC
 3pSdm4M12iCctvdq2mrWOwWA5S3WOKGoRKwMsdPY3E9zqUKtomMv43R4yLqm8naL
 apuYyQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso488736085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987249; x=1791592049;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCKckv3D3qYeE7jBJ3PaA+r53Z6LWd0Zt+icCTw5pD8=;
 b=ayPInbIVmhhxbggB+Pl7wqqC9G51SfymdAlWuaEKmSuXT62Q1+0hQAFOW7DlTQHrZX
 9F1KaZhLuqzGNBmxlIu/lvEfy6CmOJ5pYvYrNF44FEbm8UAfrYhciR/RBlqPAXnqIcsK
 weh99AgyPF+2tZRKgB7ED9Imz7ULlfk7CYuRCn+HWW4TdR3PgIpWR96dVQZKwcAHA3qh
 jUItvwJ6kubRiJzaf7PTv+Kq+RHmkTepcUHV+DdqaNLbjFipi2j68nEVhGG2TaT8YgQP
 HO8WOpiuf55DpDhT9oET/YgnZS2iNvgC2Y6LLOkinWRKwOEio7KR5s90agmAtkTMFxUh
 pI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987249; x=1791592049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PCKckv3D3qYeE7jBJ3PaA+r53Z6LWd0Zt+icCTw5pD8=;
 b=sHK7m4mAJsU+CdWTDGovrlZJz89hV7m+o466yWNjYlrHXUgLSLVkAkw+lMo1IWzCCY
 1tazb1hj96mwFrMZCztTpoaAEJz3kSwFA/3sg17KjuqlqUPtJ6EOUp9/jvEbdIWKXHoU
 KWpoeXmtLdxIvgCSpGwwgMWONgppMx6YHD9khbsPt37jFXp7zTbIwOBs49DNPxRQmdw7
 sZmnZ4poqygJj3nowcbKaUteV6vrxwdd0uA5B0IwelvCwmbumyMVLDzJaxxE/RCmMAq4
 c4VR9Vxh5cJCKEgB9iG057Yw3PzncYDNoDsvliJQbzqGdHHVcXrDyA/CXuaghzEi8gos
 J63Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhxOMrTUdLCwlrVyuMOLyujrPaLIOt7RDYar8ipCYQxMAkbYwOluAbM2TBFuyJ83mpeEGCP1MyBTo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljWKYdwFWVmkdVeQt0yxWPdVuEH4pVG6TCzBnxvgjDGD2QK0VW
 9Umust7bpn3sEU7daoGKLXWzchvt4JSrVHvBOaqaYIhIUf9vJxPZdCeG4I3e0F49FYlx4uKabvv
 YL92oKHNEhArLDXqEZif5wLyKpO9jOBe2VIokDjl6dYZYTG5yLuctccnIdQqPVAfee2aDpk1Fin
 aawKY=
X-Gm-Gg: AYBFou1H8FI1vyQ69xzq31+7cb/m830Q5kZmYYNFQUllW86Y0WiffWhlZ+bVv780oB/
 BSrFLlpqNEmMvN6hIUnFMiUVQcyb4RuAJsmP4oLpiwvXyWDmDhid8SVJZr5WKgajhEzPBTIqJWM
 pBMOFIfm7gYuJ98H6rPhVkTfYRGtH3AnZZb3MrXCTtlneet+EozG3/bKivNxqL4HsGf/18dwCEs
 Ay0HzVUK5J70ydJfhbi4myNKVsAtQT4uYYcXT8CRwppqFMReQmATNHPPSBguG+U74zCgjHqgb+d
 /Kljsm4rD3Br6d/ZdwmY6XhITPYVju2SRtsMP9XOEG9WQtiBAmAEFyB01e3GoUvHKMPpyYFUcKe
 zfeSJ0fzlt6E2PefUh+R6U0ityb0LcABNiPmEv4p+En9NauUFLWT3goBh55fnjP8sxkihyvuiH9
 UsXNBA3gjmU1qz
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93cb5abb8bemr1457657085a.17.1790987248905; 
 Fri, 02 Oct 2026 17:27:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93cb5abb8bemr1457654585a.17.1790987248462; 
 Fri, 02 Oct 2026 17:27:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:17 +0300
Subject: [PATCH 09/11] drm/msm/dpu: unwind a failed dpu_kms_hw_init() step
 by step
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-9-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3257;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bbO86FGXsDHqLs/ciqm/qxFg1OxXE+ZgD1o0bUcmsp4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvgKrR9+ITvbSenZojV9Y0W/JUgHEO8dm35v
 tsisGwUT2aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL4AAKCRCLPIo+Aiko
 1dYiCACQzypfKlxO7NdRdL0NU6LsQHTUPR6nVg8j1QYpG2UVdXxIxKS1flR7TbVBPzpwtCcVjGb
 hmdeTxNZm9vMWZLYwRTjxR8wjEl3Ugh4d73pT2tH2pfMOdW2rb4b5Lltvms1eEIO2kTY/MDymxW
 pMB86GNshS3qYTd9PSJaVPrODsx+OwVXomk6qjCKDFZGmhCrAMdu40qUefY5DGab36xPa7HAPuf
 QmH6xG+FzruAn0eNqPz02rRrxcRHuJuFqI6pXg0qE1lF8MB+lGQm8c1Cd/+vAo7lV1C3bVSSQ7f
 Q+NGZR4Wzz+Uq9CNJ1O4r3Ln879P0Qpm2BiP5YPo/eWbHSHy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04bf1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1OQLaJ8wmIwZLDPTffUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 73vwyTL-KQ98rRt8S1IfyDy6hTyLz5Mn
X-Proofpoint-ORIG-GUID: 73vwyTL-KQ98rRt8S1IfyDy6hTyLz5Mn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX3IKXg1WFNzOn
 QRSHRHrg8hHeIV8AJAlQ9PcddJZIhECARIfnX28E9jzg/p8+ioG4PcNd5heXVvJVdo+fLWMKjCW
 0jtcOCOW/kkN9MovQrdgptaWt0dtmiY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXzQnbxQG3NEPU
 nGyYEwoWVXIm/bkE8oMt26PMXNVplcmwikvFq13qdRlVSLjoRDlhw/5H3g3sgViPcghTtxBXabP
 jxW9GmHd+/X/OgqgZiMHGHf3xaMKdiVqYmuz4LoFeLw2Es4ux1WKdr/8ogKsBqg+KtAZnoscGp4
 3/GpRTprhKBczkQQ8Jhf/l4/C53y4Q/ngmA2j8eYpfBFTHvcHZ8+Yx32586tgdhnHm4ujlJtiFL
 gRbrHimxv9XdexkuMy4Iul1H6FLgIqlun5s4mcChqdPWDuZrq0h0nii3D+pDGtgG22P65KkkKep
 yt/UBHrENnoxOXeAwz1rHn60FiDej9bFs4eLtwPYCsxO/px8FJsqSU99s+ncWH9wuD14GpUlqQ1
 kN7OSo9wxbCQ/nH9WwgXTBYkzbYZsr17PD3NFy3xvl37oq2PemIJGrFn07XhJKuPoP2ujgpGMJx
 c3xkBd0vRdTBzKkhfXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy(), the teardown
of a fully initialised KMS, whatever step it failed at.

Undo only the steps which have completed, in the reverse order, as the
kernel convention wants.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 65ba8fa697e9..2de4d881d13d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1150,7 +1150,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 
 	rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
 	if (rc < 0)
-		goto error;
+		goto err_global_obj_fini;
 
 	core_rev = readl_relaxed(dpu_kms->mmio + 0x0);
 
@@ -1177,19 +1177,19 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(dpu_kms->mdss)) {
 		rc = PTR_ERR(dpu_kms->mdss);
 		DPU_ERROR("failed to get UBWC config data: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	if (!dpu_kms->mdss) {
 		rc = -EINVAL;
 		DPU_ERROR("NULL MDSS data\n");
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	rc = dpu_rm_init(dev, &dpu_kms->rm, dpu_kms->catalog, dpu_kms->mdss, dpu_kms->mmio);
 	if (rc) {
 		DPU_ERROR("rm init failed: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dpu_kms->hw_mdp = dpu_hw_mdptop_init(dev,
@@ -1200,7 +1200,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 		rc = PTR_ERR(dpu_kms->hw_mdp);
 		DPU_ERROR("failed to get hw_mdp: %d\n", rc);
 		dpu_kms->hw_mdp = NULL;
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	struct dpu_hw_vbif *hw;
@@ -1210,7 +1210,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(hw)) {
 		rc = PTR_ERR(hw);
 		DPU_ERROR("failed to init vbif: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dpu_kms->hw_vbif = hw;
@@ -1225,7 +1225,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	rc = dpu_core_perf_init(&dpu_kms->perf, dpu_kms->catalog->perf, max_core_clk_rate);
 	if (rc) {
 		DPU_ERROR("failed to init perf %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	/*
@@ -1243,7 +1243,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 		rc = PTR_ERR(dpu_kms->hw_intr);
 		DPU_ERROR("hw_intr init failed: %d\n", rc);
 		dpu_kms->hw_intr = NULL;
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -1263,7 +1263,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	rc = _dpu_kms_drm_obj_init(dpu_kms);
 	if (rc) {
 		DPU_ERROR("modeset init failed: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dpu_vbif_init_memtypes(dpu_kms);
@@ -1272,10 +1272,12 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 
 	return 0;
 
+err_mmu_destroy:
+	_dpu_kms_mmu_destroy(dpu_kms);
 err_pm_put:
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
-error:
-	_dpu_kms_hw_destroy(dpu_kms);
+err_global_obj_fini:
+	dpu_kms_global_obj_fini(dpu_kms);
 
 	return rc;
 }

-- 
2.47.3

