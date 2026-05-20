Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ED7CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C645B10F0BA;
	Wed, 20 May 2026 14:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kLrJKZoP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apwyo8XO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E7B10F0B9
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6UIF119026
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NK2U86iVUwe0wxQ0Q8Wy0PvlrVHdH7DQTfK16+7BeiA=; b=kLrJKZoPEpkYiTcx
 1+5v7y9f+Yf8W0fgkJU/hROnIS+LLs1nUbVRhZriEWc1jl337owfxxV1PgyCSi8v
 zNX+AU9/QZYhCY/NVrkYsIt1q6iNrthVku7IEMX4jGCF5kObcEFrCPvP2pZk7+gk
 j0fbIxxiqGI57QKhVYB0oQXEBqoWX5X0w00OkYVDpqTXML0+b34+R3F3qSIkC+W/
 kEeoH913ritLWWlmvJteRM1XxA4W9uXpeo2Tr6hqYv7Dr/cMEm5OKIbwD70W2hjo
 p3R6Y0yMwWemIvimoMK0n4QXxV093vPLnbOcetj6uxQ4+WRoZS0SHh6suDBhsPd0
 zL+6EA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-631455685c5so1472578137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288703; x=1779893503;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NK2U86iVUwe0wxQ0Q8Wy0PvlrVHdH7DQTfK16+7BeiA=;
 b=apwyo8XOcDNh5bIRkVVIgnHaDbtdjIaUTLZhiq0LEb3OKQ+Ae/0VBH2jcju+9g/aUi
 aN9HJRA442RqlZPSagohQhqT/5xcdKrIOPE75yHI8TSYWHwAlmi5fedUQKtU9Y5BahNK
 LZGmtfz7DNt3YgH8RyvwyietdripVWQ8CXB/s0a0e8xjXapKiwQPMjhKzEmraLRdzw4f
 q/VBHYYDr9tLzZyDm+Lakk8TKe7LlQsZOKpqZ11+HBSj/sd3aEcgNmVq207TsrHagCay
 53ReNrLOCQ8vpPphT310Z6IG9iVrOoPIwf8DPAcpaDzdKoxCh+e3L1U1jCJNlqke0LzX
 TBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288703; x=1779893503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NK2U86iVUwe0wxQ0Q8Wy0PvlrVHdH7DQTfK16+7BeiA=;
 b=hsuXNwO69wDKzxOfmJPGHFJDZGltp3SB27urNafJz5n25C4g6HVIwG97bRqdWjmp8l
 vbR3LCIB5lUMUALmAGRIdKUiVcGgCXoL0znYR4wzMlbGIBXOH1FMmVDd2wQo8X9gk80W
 j9L1gkV871lUnFH8/tAP3ynS0cJ/t5vqPtX3UhXebOVHjE5ZV5oVqgE0arR/3K132a6g
 koy2LskzAnFSilLQyR+2cyzPJVEFRbHUjTeW8FFYvXs/ia3e9CwJrHUehP+wGKqwd31h
 mjv7GLymM/Og+F7kNl0+md3pbelayU5iMpA6Qmn9eedzrjmB68dbzCrkPmVSnMs8aePK
 F5Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8B67sMURJ4JMCAyER4cFkMRznKxquhvgoMxiZ4FBQtrGAfd3BFww1A83bscWGz/Whdm9ScMuCpnRs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzna0CG5vDHmqVbcVtsS+Q3z7Q78HS/AJKyeuU9g+bGWOCc+Dfr
 qIUauVI7RmLHjfvBmSqv+/vHZ5a75drT2D6/FV1P7L6zfVxlyatzUTlPU9xoVzFeR4pfu+jih47
 vL8M4f/sVUYfsHGgNCOhFJ0OhTJrzzmxCmfjW14UhBWOsIFB5ziPlW/UEU1FXHOLgcNaPhaY=
X-Gm-Gg: Acq92OH8w2btamrdjcthbZiend8iKhF1wa6f2FjNZsPjVXAfJ68Vadkiw7FE5A6ql/R
 YxLcS835rPmjkm2omzYYLvka5U3gDbajCUy7f6S/DznQ1iTytshKAxFT2hYQCygdpimobgi12UE
 fNtxuyHO5JAMlzAQiuskMnE3lSOEgkGVrXiWutnCK8IVrMqdoauhcak/cT1iqBFvqUuuSOa3CBL
 qZbf4KwqrTk+Gsq91PLSZfmAh5JxBiI6Dauw1Avc8cq69hNK7swzVouSiCnmwnFmhvP8Bcq1pEF
 IiHCNNXN7zeL0dlojC1lJBJpfVHULK7B+bfkyuxpiWOE9Te9nGRljbEXFXm9MBZV0W2/jgXyG+a
 CjgxkHI+aHCh9gEfkXjEcJS/vraGVlpqcqbse87IPRm/6umemJDrKAx6MAjYYomRUvr1Yy3O9jX
 h6FUFJPQW5X8Xm4Bv9RNjvnegTwqWzD7seJMI=
X-Received: by 2002:a67:e70a:0:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-63a3ee862bemr12371180137.19.1779288703578; 
 Wed, 20 May 2026 07:51:43 -0700 (PDT)
X-Received: by 2002:a67:e70a:0:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-63a3ee862bemr12371144137.19.1779288703085; 
 Wed, 20 May 2026 07:51:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:19 +0300
Subject: [PATCH v5 12/28] drm/msm/adreno: use new helper to set
 ubwc_swizzle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-12-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2770;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Rq86OqLICFZTHwXLSbQJz1dBgV2pgL+p7E6Jilm9kng=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpnUEAvxY7G7aZM/d5Hma4ALMMOdIYBP2Rtt
 UZb8lqJ5vCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZwAKCRCLPIo+Aiko
 1c1ZB/9jYl+4DtBU2lqbMe4XPOpNhy4phU2TyumZVEgSRaYdONjSU2MIbn2lYPs+Czy7fPe/f3M
 9Bx5cCVxRLGNWHYMKjYFYiMHdSLXogh+ooVcRhZd+PPL3boBKTzOKEI5lYj7k/h7RTJD+TIf7kR
 x/0YPS2PZaL0w9omGNZjnXISUOAscZTb/6DRgkpob4au0PM0aqs3AGv8QwgJGqF2bVNMc/IT/kh
 0/b+6BUciHQY+DoXO3UjfLo4riTgFj72tDbXptsmuX4QKfMcnvk6bK+3XnvefsWCu0dj6AXgfXa
 H8Mq6WEFw6fZyZlp2OeJ75JjRRsYpEgL/rPlOLzz5qZK1n9m
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 4w4ZhGFA9zrUfYjP4ZQ8UrjbpZ7gdlTH
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca80 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cZwUhCRcRhp0DfqHmjgA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX53cBo1wDer6U
 MD2YMteHwqHm7y0VBax4eiQwPIPFjdoWpUIHw1RFPWODJzhkbnPknKpS+EMR8t8/v+F++GVXi66
 cXQ7/+MsFpuJLsL8XTAmt02huA7QuAlG0ndNJhvqEHWVotrbnQpIgjsvbcsUEapR1hg7MiAAZMG
 yXCccFjQlypQUy+RWaq8uPd349kpODw6TR3nk/iUxB+Izid1DFtE0zqTu0fVkn2+Hijrc443KwE
 bNn65RXbbEWL+32VnkD/3IMfZOWB9odFSq23ys20q5N8xvzGZ3rFdGUAEVII5+mEpeYcn4doGti
 EgsBIPyU3ulCre+DKt7/OD+ie7Ywbj0JyrsS8A5ONLSYrntWT7w5mpAAKvBJhHVJ3kXznbwcPfh
 2lmdY3uexrD/CVQDdew4xU4Tp/5IBUDXQB5VKQUsgenXlSHsXhNgZZObgtd31sw/irgTV+vwEiJ
 09qjLMVGdaxZb2yiFkg==
X-Proofpoint-GUID: 4w4ZhGFA9zrUfYjP4ZQ8UrjbpZ7gdlTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 4 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 43818d1907ab..e7a0d315e022 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -745,7 +745,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	BUG_ON(cfg->highest_bank_bit < 13);
 	u32 hbb = cfg->highest_bank_bit - 13;
 	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
-	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
+	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
 	bool min_acc_len_64b;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 1923f904d37d..53def136e0fc 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -275,8 +275,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	const struct qcom_ubwc_cfg_data *cfg = adreno_gpu->ubwc_config;
-	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
-	u32 level3_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL3);
+	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
+	u32 level3_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL3);
 	bool rgba8888_lossless = false, fp16compoptdis = false;
 	bool yuvnotcomptofc = false, min_acc_len_64b = false;
 	bool rgb565_predicator = false, amsbc = false;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 78d7ac3fd8c7..6a0877e5374c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -434,7 +434,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 	case MSM_PARAM_UBWC_SWIZZLE:
 		if (!adreno_gpu->ubwc_config)
 			return UERR(ENOENT, drm, "no UBWC on this platform");
-		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
+		*value = qcom_ubwc_swizzle(adreno_gpu->ubwc_config);
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
 		if (!adreno_gpu->ubwc_config)

-- 
2.47.3

