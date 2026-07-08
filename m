Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759ACC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E50110F1F9;
	Wed,  8 Jul 2026 17:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsFV1zUD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VagECq84";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990FC10F1DA
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GL9RB3125817
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=il8ffV2n6Of
 1AbVqvM2H1wzaQBsji1DJs+ts5z9fiOs=; b=GsFV1zUD8LoeoHXrsCAOY4Oh3LS
 nL0mOK9f5l3yyJiurMX9MTNThAT1BOTk6sHRzfRniUOiIGMoDjf3XlLoyoyWjMWp
 ziI8bF7rzk4PR6R1kWNHlG+RqIdulaybdD+vbGVUs948XOkpSSCmQgniaTSiMhye
 Xj9godHQfn0Ds5sqc4MzEkrnLneROoKP/PduTaoiIYfAlmkeUNrspWhuPCRkodDz
 8lw1GOqCf28yku/is8aYqwx/RXEQd/8WA/h0/UwQFuZl2CyBCAFqbol1O7nwtRx5
 t/KXSoStrF2lX8+SCoXITbgxk+lCPFupbPAIayyIwapj+D5WTuobRG+LS9Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s9a0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc8bde6318so503045ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532078; x=1784136878;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=il8ffV2n6Of1AbVqvM2H1wzaQBsji1DJs+ts5z9fiOs=;
 b=VagECq84i0VvcE+vzo3RnDiKTOA5z/hElTvW3Vx0DcYpydXuFjbJQLRLs9XsRX/Xwv
 Eq6S5dISsOX+7ptAoCPTMgZKjGc49lCxNYCqoxrWAzB7i1R7J7jf3mMB92I65BFITgdP
 A6YfJyffVY88IE9KUi/vz2f+HKannS9OF9Ns6v8F+AGk3LPocKKzlwV8mP2/cylz6ZYU
 ZjwJzmDCCMbSWroAn1WWnTtsRbxGMzxj6c9Hy2eMB4Da5KJIcDVyTLHrftDEKIiXyQYC
 VL/1nY+H+6BvbWnmuDYz80RWMK+mlbQ0Zv2es4I8UoDVq2A2piGKVp4D8EzhKdSOWral
 cXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532078; x=1784136878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=il8ffV2n6Of1AbVqvM2H1wzaQBsji1DJs+ts5z9fiOs=;
 b=eZ8Zr9XP47Ucy2uNHzsPaiFMWLNRWlgp5oUpgBwqflePSYTwheft+V3VuSjQj1Um5T
 b7I0Y825oH/VmK+SfltBEHTbdXqMFsenF5iu8cMKOKNVTpq66/24TmxRcVAVO1DqIESV
 epYowp4FG7Gs3mh6zZO5xr4DRCStzCWcL+5YhCfB2mvP5PrtMi7cGT04kVcBkQmcTzB+
 wKJHydPnpVIQqAkZN1dGoYKg6v+OcTeq6MRvpm09tSz55vJoXVbfmQ9mwhf4nETIIt0M
 JFKKUmUtn8WD3+8fgR/DeyLb5LmKOjeRhfPYiPc+MwHObeGNC81KMuBNVx4RLauKyID/
 Zpfg==
X-Gm-Message-State: AOJu0YypMoo5a18pvTd8VHpwOkgKlenevsdP4orda+TtCg7E9VDoUZhz
 ocHABucGBqdww0Guvwi1O5APMQzgmnXFeaU3oLkZalrR0YrvXI8RRDYtXHbkfY3hGk7nnWR/lgz
 ylbuMcf4CTNAPsCNWTQqZ+WngKw0kq0voix6QLNnVPnUn3fJhyr+oCarTYCzoylh5z5kjg5aqvH
 mlf5o=
X-Gm-Gg: AfdE7clIHXSoFMv8W+XAMTkWJq/4sAXdpkM7hwbrlyHWpSkZm22vxUnlPmEzyKzuXbR
 KtWNE36rTZsOgjW7fAIClVAl3jAaEPPABrKZg/2dgv5o0WT4uGwjXWxpghczxYHBdOOnhJtfj+N
 VpkBOpYjCGLWiPAECGoh4VmlxdMoKvKYMQirEjmREiQ921m+frbAgjGn6opu3J7GFONjwx1hoK4
 H6zUWkg/A+PKa4vkJi96yEzI4sn3PhKtfTHGCkwQJlyidmysL2jsSTb+LxiyQrYu5wH9LOurCkh
 zElgiWE9ZyryoxC1VaUZuykCwiqfv/U+XO9c2ocTapep+YsLJe65u9uy0ykODqCkhPkrLHCmYpg
 PSG8bhRGmDIG9kb5pIQnxF/pGEwdRIxyM1520twoy5vD1bbHbs4QjECVfQA==
X-Received: by 2002:a17:902:f691:b0:2c9:a247:171 with SMTP id
 d9443c01a7336-2ccea371dcfmr36609245ad.1.1783532078326; 
 Wed, 08 Jul 2026 10:34:38 -0700 (PDT)
X-Received: by 2002:a17:902:f691:b0:2c9:a247:171 with SMTP id
 d9443c01a7336-2ccea371dcfmr36608985ad.1.1783532077898; 
 Wed, 08 Jul 2026 10:34:37 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bcc0sm31168865ad.67.2026.07.08.10.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:37 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/6] drm/msm: Fix per-process-pgtables check
Date: Wed,  8 Jul 2026 10:33:53 -0700
Message-ID: <20260708173356.578713-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX9PrnBsZnq9gD
 yMn+uYJVhISxVsTqyBw4PO73cHIcgmzvrCrmcBn6hG5KNgbuURQARP9DAycDA1s0U/d6etrjGmK
 P9klQbzEtKFG3EHrMwJUqbisBG2BChcI5hmgQx+Xj43S8zQp6Lhl7M11HQQOkIdqi/Nc7ggUlyh
 Jd2gZFJy1Hom5o0GzngXkmEzDeiqx1uU2igj7Y1SwTc/Wt8MYZ0q+pZbaK4BaLvakpyt8+w+c+z
 pTxBRjG3tC/KWJBiBNIij7ZwvY4WcmclHq1OxSB4W9DE4yF52vXQWIyNiPHtTbQuJ5ze5nkBrdF
 ZOZAUWWJe/VbtLl0Lpf1e9Vjt8DYUfeK2o9SM2p1l9MpzsWDQKlo6+RAxUxQEeC80W1pDEUrnOH
 2a8qDh854EFMxIAabAbF6zZsYYkdU5+ZdiPvfs8z5xVH6G6qQlAmtlHCe+9to90qGxjCBsNkV58
 2vDeN39z5nXqz1QB8WA==
X-Proofpoint-ORIG-GUID: oZgxL_2f0QooGBKawe5lCVWnGkh3PJqu
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e8a2f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vtH2vi951kckHO5NeAIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX9iexSWJoe/fO
 yo600+Yz/SruB4kiRd6+UtN9/ju+hntBZTuy2IlVktTtvxMZuol57OP5GmA1wEq51W+Rha3mZGD
 E9pBbn949Un4YX3q+rfsgcZhyacC5i0=
X-Proofpoint-GUID: oZgxL_2f0QooGBKawe5lCVWnGkh3PJqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080172
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

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support.

Instead just check if create_private_vm() is supported.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..bff2a773c0d4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -505,7 +505,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
 		/* We can only support VM_BIND with per-process pgtables: */
-		if (ctx->vm == gpu->vm)
+		if (!gpu->funcs->create_private_vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 
 		/*
-- 
2.55.0

