Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C6606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jIkFXWlR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GnRo1cGo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C176112BC7;
	Fri, 23 Oct 2026 15:32:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FF010E692
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:07 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6BS02974561
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J4lgPqXZovRq5NOnbz19RGauzLDixNMu9fw1Cvv0pkM=; b=jIkFXWlRZHuM9Koy
 qXdUn9o7+FERV1TG/ppXQBtdAi43WTmZRXbUalInNbfjCcbOxNJxDtXhuATcjLTn
 QPOA+KLKNnrplIOkrdto4xBPE2rZnbPnioa1bMv/9V5MdcwrbRXmtYJ4U/msGzzM
 0DyUfI+4hGMz4EUEx5dV/MX/b25OpHexTQ8OPltsJIsfxyU0eiaFgLcY7gz99r56
 mZlhIfqusEPgPcKPLLqK5OCsVGZvCM+ofWMmB0WlEQ8D+uMbirsP2PhWAehOfIG0
 J7GJ13TFB3DBg0SN3dNJbso4DR8M7sjr8TSmpsmISrNlmas+XUs34NZX22ssbcp0
 RAy//w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4tav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:06 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-990634bef80so246468241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769526; x=1793374326;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J4lgPqXZovRq5NOnbz19RGauzLDixNMu9fw1Cvv0pkM=;
 b=GnRo1cGohXkbqc7ztP1CmnjcWj5tU4yuCR/1rc9PmS99D0/qbqRRolnWZh3iIACncL
 iNjhHZjNhbCf2E1kQblPQ769FACUs433qEY1+DGOGbhs6wIE0UTryewbv7PHMj938/57
 PuubCsamoQqs/+cn+7A9c3GluG/ca5KolF9HoPz5Dg53wSp6xCjrXNv3VaCdWo3OF4MC
 StUbZWiDoSRQk6Bh8YP26Ir8P+IXF4YKugSmZxUAnP+SImoOLeajWJiRD5EPeI7tKceO
 M9JzvwDrlH8nqhJgUf9EYxlGWefZCzstXr9FvY1BeSXAJYqhZ2nGFBbNcF7NT6mOLrs+
 loSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769526; x=1793374326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4lgPqXZovRq5NOnbz19RGauzLDixNMu9fw1Cvv0pkM=;
 b=CE7ZHKnkZ5VJBt5a63YOzotYmGFDDkUeiBEv1BFxbF0/a003R1rKHqfkI4aCVa741M
 JH3FeQACvIn3e0jas9+oWjl4vzeU12HEZQ0JcNNe6VdMSc+MbQChE5+/nyJGAxvOuwsv
 q2ktgy972Npvr+ojW6KMBOevKN027i63i7+14F8wW98ub1KRBOs7ozB7BGe8kjfVdHYz
 S9mGArsRh+0P4na+90T8WLdvnsv5VZPFEReXBv/Hk1z8GOfZcTDhE1Nc3dGIui4+bqcp
 Wy6PPqcQct+wWzF2UBzwNI+Cnx2mLgMReYuYRr601nrPgTmj3Y5Di8Cz+Wfy9FCwWSKE
 KOKw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAyBe4VRycX/6Z1swktr4Vynm1ZY4tI5VHiwz2mEG/Ieg/XUsAov6/iVZODodwOJ2OoJEpRpzY7LM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiOeRM2NzXVlZ53/SinMmalIQ8DKtOq7N2/wcywKjlQENV5ORj
 sSKQQdDtBS+ZtgDHTZ6KwkD0/U4DLvyHqYKHRcNmRcXf+f+MGyAZVWF3qn6EijBvSU9cWyJRLmD
 yKjXFZOv0uBD7SOdxJ62WEPO4pSD2kI20RSQ7c4i3uyL0Ub1McsMUY2Q91PG6f8epyLvr4jk=
X-Gm-Gg: AYBFou3T7QkRk98uzTFhGGfpuwHKlqLh3FCOHsUUdzsMmADAkylxBvSruKpq51ghOL4
 KoqWJNR79VxYL5oRMtMgvqU8HHqc7Qhv3luquXZdb0o2V/cCAFITHcrVE2a4cdO53ZxDucxOKHv
 C28PsHe1ThIJaymPMxkjJ4sKBrYwFvy39CGeOnpfVHeikxVsVg1WcWyYz7+fk1PVCuhP4bKBRzm
 WYf9qO4CraIWV5juiUA67ZaO2Sv8epGF4FyLZDcHULozDVeX8nRHlEuWzK9kbx4PB1g2qei5C+j
 xy/Jv+yaqkaEoeN9v3AwLjBK7Egzy704A6A8LainjeHTXSCW/nAfQR7OavH5pGq7xJtOLmpio5c
 bgKn6hov+EUD0iyfQkyNp85QvSMNafZxnmeONsiNGmyF4ZqJKyzz/kMLumQvMbjsMaNwQtBT9Pl
 HiTsPEkpw63KRk
X-Received: by 2002:a05:6102:548a:b0:7ba:d953:edd8 with SMTP id
 ada2fe7eead31-7ccc32dfa8fmr954662137.27.1792769525856; 
 Fri, 23 Oct 2026 08:32:05 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:7ba:d953:edd8 with SMTP id
 ada2fe7eead31-7ccc32dfa8fmr954638137.27.1792769525376; 
 Fri, 23 Oct 2026 08:32:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:32:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:27 +0300
Subject: [PATCH v2 12/14] drm/msm/dpu: unwind a failed dpu_kms_hw_init()
 step by step
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-12-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3855;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CqSiLL5IBlX4YCUe6BZMO8fXF9pjuxvbGKp7tY7bOYI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233aal7O3xWU0ZXZMrkVM2UbGMd8hAN4MojRK
 6+OVOvqFsiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt92gAKCRCLPIo+Aiko
 1ckpB/4oMAikM1pxonhjPzMPtryQIf0cZjPxj25DxTmoM6dyM5A/o3e90RY1mT1vajlnoM+yDO6
 /mB6dStivvJCE9pY1KM5zY/SlgMEIFuy8+Xq/NLfAReiIutBY8d6xzn4ekaEO7XqF9545KRWOM9
 L6HbS0OxIkS4CsayF3tdoL2UVAh/iwc9TkpbOTh+sJdHFvEU8+IF1fxMe8Rg8a26afRolt3nJjA
 IoTETtrmSFFhSWxyfXvy5o1aYZwEP/0oXADJhjEo1/aodQ07Q4amZhhAZCLQN1paZMDCjmcQNez
 T/8uqTNwELo+YCAkcI6EwQXvupwRmTq4TozmgQww86UxaYJt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: AtorBM-urDJrobRSoltKY_KWkhz0RQte
X-Proofpoint-ORIG-GUID: AtorBM-urDJrobRSoltKY_KWkhz0RQte
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb7df6 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mqmjYGUTO374PHIbFJAA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXxc0pDM3Yccas
 PhMeHaxyllEySY1SZmuRlPG7//74iteUEuaBuS88xL2znm+QNCmEJTySsqrdXf9fISsAbqdpcL9
 j9QukpWBODJjlfE6ESpicIyIqxfpsqA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX5iVujs/NxnKr
 1pscO1Tq77AsHlEIizixFMRVj5HZEmKjOnPoyd0R6D8miGu7t2YKUSirnGSeMiJZKqclDCLtObB
 p9Ijltp81K05gVMyRvh7FgK/BziGoomDZ0iZqZZKSU2M8VyO/22c2W9F9MYFfNlnf/4nAe5LEb1
 0A1ZVUoBaaqqCf+CbnmQogMaWNzXOGCYlozOUnKHDoGOZqFlglznYc6olXtuPFicasPi/X9kyO8
 DtreVlc4VjPRgfTQtx4G45dncLSWx19ToCCTlFIs/2Bj63iTYPvmD3KraS1ezrv0pHKLuVK/D4U
 R3xqleCS0EStmJG5ZKpti7vJiMyjBQpz0Pw0bJhnSo3WKRfZS5fsEOuOQBNLRP52PfFOKGIiNAG
 9q4Leqf6VhjrcF6VhCiuCCEUJOLD89MmalJQahQY29IxVhn9Qx4Sy0wuHyrIzEcQsrbXx5eEzzq
 mrjHwN6cZT1jewXAtdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy(), the teardown
of a fully initialised KMS, whatever step it failed at.

Undo only the steps which have completed, in the reverse order, as the
kernel convention wants.

The hw_mdp, hw_vbif and hw_intr blocks are allocated with drmm and go
away with the DRM device, while dpu_kms stays around for the next bind
attempt, so clear the pointers to them as _dpu_kms_hw_destroy() did.
Otherwise dpu_runtime_resume() of the next bind attempt passes the stale
hw_vbif to dpu_vbif_init_memtypes() before dpu_kms_hw_init() sets it.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 934ba47b2dae..3546efacba3c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1161,7 +1161,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 
 	rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
 	if (rc < 0)
-		goto error;
+		goto err_global_obj_fini;
 
 	core_rev = readl_relaxed(dpu_kms->mmio + 0x0);
 
@@ -1188,19 +1188,19 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
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
@@ -1210,8 +1210,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(dpu_kms->hw_mdp)) {
 		rc = PTR_ERR(dpu_kms->hw_mdp);
 		DPU_ERROR("failed to get hw_mdp: %d\n", rc);
-		dpu_kms->hw_mdp = NULL;
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	struct dpu_hw_vbif *hw;
@@ -1221,7 +1220,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(hw)) {
 		rc = PTR_ERR(hw);
 		DPU_ERROR("failed to init vbif: %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dpu_kms->hw_vbif = hw;
@@ -1236,7 +1235,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	rc = dpu_core_perf_init(&dpu_kms->perf, dpu_kms->catalog->perf, max_core_clk_rate);
 	if (rc) {
 		DPU_ERROR("failed to init perf %d\n", rc);
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	/*
@@ -1253,8 +1252,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	if (IS_ERR(dpu_kms->hw_intr)) {
 		rc = PTR_ERR(dpu_kms->hw_intr);
 		DPU_ERROR("hw_intr init failed: %d\n", rc);
-		dpu_kms->hw_intr = NULL;
-		goto err_pm_put;
+		goto err_mmu_destroy;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -1274,7 +1272,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 	rc = _dpu_kms_drm_obj_init(dpu_kms);
 	if (rc) {
 		DPU_ERROR("modeset init failed: %d\n", rc);
-		goto err_pm_put;
+		goto err_self_refresh_cleanup;
 	}
 
 	dpu_vbif_init_memtypes(dpu_kms);
@@ -1283,10 +1281,17 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
 
 	return 0;
 
+err_self_refresh_cleanup:
+	dpu_kms_self_refresh_cleanup(dpu_kms);
+err_mmu_destroy:
+	dpu_kms->hw_intr = NULL;
+	dpu_kms->hw_vbif = NULL;
+	dpu_kms->hw_mdp = NULL;
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

