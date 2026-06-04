Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061E2CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626A610E15D;
	Thu,  4 Jun 2026 20:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAcVTu/Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXD3lHAU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588FF10E15D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:28 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654JnsXO3111478
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d1LOKmeWCklvB1wmRVCwZ81uqYX7Kq6ssXn3ZHjkSh0=; b=DAcVTu/Z9OlhPpun
 94V4DwJbaIGHP/fLh1hipVBMmcLRLxBXvfdQt3hnj+jvjwIkApN+yOxICE3ISDtv
 djyL12gvDf5Na7wT6SQFbX7IawSsJEwfVKt8DzdoNLRIAFrapqweMH6r2Jl2Fo+N
 P5TERCMynl0eC+T5X4CCYArbosk+4nr7S/2+Z5mUmW7ysF9qfAezur27SKnwLbwb
 PwE7cr7PVkqTDhHzWEpVavYxDDiTcYqw8huIkDW2J29dC3DP5cn3h+Dnsg+KPKQu
 tKsSKvqF6/zz4C3VK9CJLGLNsRQOpjGsEBY+2Tgr5f/yDHWuYReFexiPFLiL6Dlx
 XOu6Ow==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv702q0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8514f8ed5dso792429a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603827; x=1781208627;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d1LOKmeWCklvB1wmRVCwZ81uqYX7Kq6ssXn3ZHjkSh0=;
 b=MXD3lHAU9cw3jBk4xXj41TSRTntLBQyS8vXdvQS6y4dVeldALZOACQlEPnKG4PgCq3
 VPX8w7gi7Mz83igoccALLLkdftmGkNYQSgwIhWgWoNr58e+OiC3rqV4Jrtj9K8t0+7Wn
 h3YjeYTrcE7fgXtK85oCmaRxL/aj0Z36+LeLrNhx1L81jwxqJsvynqc+7Gws4Z4nvpuF
 H3EQnAQGC+Px40jxHJ/Mt15N6vP7V8q5RS8xeGKcgJoxQI2BX6lBMWLfwHAr0S+/mTyU
 K+yuDLHlys0+j/SJXJyZmreTT071hR7N532NS3bimf3wc4PW4OQDsR+fjCx0Q2Uykn1v
 YosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603827; x=1781208627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d1LOKmeWCklvB1wmRVCwZ81uqYX7Kq6ssXn3ZHjkSh0=;
 b=sQaULaYs2ZxYoyZgl1NWEeBaiUcZbFXu7B5CDGQPpnPy6lFKuCjNyZgHhR80NKLPRh
 i6T3f9/h0uCq7pInaJX1j4Lq00KAbkFyFUEJZXTM6EBJ36OA0rJ+Sf5mcrkD8fA4DPmu
 Dxq84HQOZe0++Uf5jwMwL3TbdiAG1pf+oxR/qOcDlNcRqJf83YJNS6RuuH3VeM8A2VfA
 oAy1MeLFU5OLlbAWBzmKC/YeRfwwJLwHyb1bSB5CA7YX/o4I9VzR9uMV+k9LEzkGCAnp
 +LX91X9z//TuTs70RZllBw4y5s4VDQ9dOcwh/QkRZNRGYOQImEXbRSz5IUth8ecHjvzU
 eR9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ97v5F56U9QD9kAl1H9y6G63M7IaXM3kBU25ftN5gzCAVPDT1ZWpgSJtvxbCwPyAzaLztpPimhZCiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywm4FAKT4kXmELpAUFRvh4eAIB2lTvyQ9us/whf2VWBI+Kmy1OU
 m/p++xX1hNWDffkgxmwRmumAD94fRy2fXVq3dkSiW7f35UGMhOIRq35Auu6U9bSU5wXN0UMWISI
 0KwGUt1IaCmbc4hUslHzwiHILNw3iLlz4huKOzfVEQqmNqvS8ejSXqfWTz3E0aE0w3sz7CBY=
X-Gm-Gg: Acq92OGziDdRfVXNK/XWX1BOktf7edQoEsIMcW5bKsLNJy9HOH370Ir9S3v8RzKf+Rf
 fB8hArDvr8JQHoQFgh/ux9tTHL2J0O+l52qL1e0xXpGCm/Mb+5KoujmoinXoQ2c2+sLK+God2y4
 xmvgb94mkFHYd1QhIGu5TnzoBiv7+FwuDzyMOrrXafX1oqUjTnVMlHPxuWH1kPstAMqMPljIRbK
 tEHSOYu3ySVaC9B+fYW+f3hh6XjdWCwva2WJ3Qzw17tlCzdJ+xUaW5U19PeaLweC/QKTeHzdd7J
 Eqy63tl1myeW/Trbc6LvgjZtkAjfbjonEKfTCG1B2Ss1iX/0WdwFd05lqbcdlvr+gdXObQ4Bsq1
 0/CcfjtLrzzEo5eOuNEN212X9r2g5kpmJ8lCsfTVe1f24GQOSvCv5nE5f
X-Received: by 2002:a05:6a00:4390:b0:842:6a3b:60ea with SMTP id
 d2e1a72fcca58-842b0fbbb03mr218437b3a.40.1780603827131; 
 Thu, 04 Jun 2026 13:10:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:4390:b0:842:6a3b:60ea with SMTP id
 d2e1a72fcca58-842b0fbbb03mr218394b3a.40.1780603826637; 
 Thu, 04 Jun 2026 13:10:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:26 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 01:38:20 +0530
Subject: [PATCH 4/6] drm/msm/a6xx: Fix A621 GPUCC register list for state
 capture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-assorted-fixes-june-v1-4-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=3134;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=tSqg6MXJBXS7dUIh0h2uqjrVYJ/YB9NP37NGGPXAuYY=;
 b=6PwCHeX/RE9aoAgTAtoWXZ2Zk7LDsArqadG9cXOU0KlksNYRsDwRIrOwz4MDZ0LQcHMOqdGqP
 M6QWCLhg6pTDw6BSMoNDfyadY/C5BK4iuY0lk9A+DSeJb8FqRyJSamN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 6SpNvivYElQCakPHsAFgYwqiDkBpwuBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfXwGj1Or/lJjpu
 LD4vpPGrlieddTSstEIephF+9ZH73jfunJ3Cg2/TwUA7bmYi56DR54UUw2l+rd3R4JsRLZdzgOm
 Z2zwi5shclvpsIgBbgktueCnDsxQvibzLtWP7HemKFLlhdjBk0/BSzQdKbjESuR5SJEPndO0/oV
 d6a4HWnwKLvqercB0ieh7oxFGuMFJJq0EAwwR+jwPBQK5ZvCOPJp3dl5N/A0LP2KYdt7OaE0l6i
 nOMsj0KpZS0CLqxYDZwsUPkOKTQ6Pj31ZF+fotakESP5xGyK+/n1k9+8kZk0riVc4Maz3x6/aRv
 ZR5kJArtMuITfL7gsOh1XS5U2OPKO3Mme2515C09K0b6cg9HSrSk0Lub+qx9JXo82cVeeuNIzT9
 IydATzFvH6B7rFANKiFpzO9Q5GSs1Owjeszl6z1KT1qKYa9esVL33Vubn3w43xZgKOQfE/jS78x
 DvQwfS/kt4Km3YCVLng==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a21dbb3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PA11-Dht09vKeR9g0aoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 6SpNvivYElQCakPHsAFgYwqiDkBpwuBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040197
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

A621 uses an incorrect GPUCC register list during state capture.

The existing list matches A623/A663. Rename it accordingly and add a
dedicated A621 GPUCC register list.

Fixes: 11cdb81b3c1b ("drm/msm/a6xx: Fix gpucc register block for A621")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  7 ++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 2a62a22077f9..3ea8ff8c7404 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1244,11 +1244,12 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
 	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[1],
 		&a6xx_state->gmu_registers[1], true);
 
-	if (adreno_is_a621(adreno_gpu) ||
-	    adreno_is_a623(adreno_gpu) ||
-	    adreno_is_a663(adreno_gpu))
+	if (adreno_is_a621(adreno_gpu))
 		_a6xx_get_gmu_registers(gpu, a6xx_state, &a621_gpucc_reg,
 			&a6xx_state->gmu_registers[2], false);
+	else if (adreno_is_a623(adreno_gpu) || adreno_is_a663(adreno_gpu))
+		_a6xx_get_gmu_registers(gpu, a6xx_state, &a623_gpucc_reg,
+			&a6xx_state->gmu_registers[2], false);
 	else
 		_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gpucc_reg,
 			&a6xx_state->gmu_registers[2], false);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index b49d8427b59e..0a13a65f89ac 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -377,6 +377,17 @@ static const u32 a6xx_gmu_gpucc_registers[] = {
 };
 
 static const u32 a621_gmu_gpucc_registers[] = {
+	/* GPU CC */
+	0x24000, 0x2400e, 0x24400, 0x2440e, 0x24800, 0x24805, 0x24c00, 0x24cff,
+	0x25800, 0x25804, 0x25c00, 0x25c04, 0x26000, 0x26004, 0x26400, 0x26405,
+	0x26414, 0x2641d, 0x2642a, 0x26430, 0x26432, 0x26432, 0x26441, 0x26455,
+	0x26466, 0x26468, 0x26478, 0x2647a, 0x26489, 0x2648a, 0x2649c, 0x2649e,
+	0x264a0, 0x264a3, 0x264b3, 0x264b5, 0x264c5, 0x264c7, 0x264d6, 0x264d8,
+	0x264e8, 0x264e9, 0x264f9, 0x264fc, 0x2650b, 0x2650c, 0x2651c, 0x2651e,
+	0x26540, 0x26570, 0x26600, 0x26616, 0x26620, 0x2662d,
+};
+
+static const u32 a623_gmu_gpucc_registers[] = {
 	/* GPU CC */
 	0x24000, 0x2400e, 0x24400, 0x2440e, 0x25800, 0x25804, 0x25c00, 0x25c04,
 	0x26000, 0x26004, 0x26400, 0x26405, 0x26414, 0x2641d, 0x2642a, 0x26430,
@@ -402,6 +413,7 @@ static const struct a6xx_registers a6xx_gmu_reglist[] = {
 
 static const struct a6xx_registers a6xx_gpucc_reg = REGS(a6xx_gmu_gpucc_registers, 0, 0);
 static const struct a6xx_registers a621_gpucc_reg = REGS(a621_gmu_gpucc_registers, 0, 0);
+static const struct a6xx_registers a623_gpucc_reg = REGS(a623_gmu_gpucc_registers, 0, 0);
 
 static u32 a6xx_get_cp_roq_size(struct msm_gpu *gpu);
 static u32 a7xx_get_cp_roq_size(struct msm_gpu *gpu);

-- 
2.51.0

