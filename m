Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF7C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDE510F5FA;
	Fri, 17 Jul 2026 20:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8vPbl+3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRY7XKdr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DBE10F5F2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtTPu2449822
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mmTWztalT6h
 ryopRPQtckYmk1TcKP24H1NmDD4Vro7c=; b=k8vPbl+3ghmkQzJz6iXYBtAIFzB
 hTY5NspubI+xmijA/Xe3jfLpI881J1FrfyPE1wvkgdUxVK4EZ/JSnL8xV0vEfMV7
 VcQlbncZuSERz3uTa2Mn5CUUVnWv+t4wHX0wE7GVkGUSLFXPm2G29DD70yToP58R
 PkY8X36l1TTTRPwXisAPJod7bCu4zfISwMMm4+XnpOY8auUpDcaHRRBHY9rDPluG
 qQCb5C3sXvpRDrn/HIW1CPuQdb8nu8+LWK5WGQfMR5D7sEHTez9SQDTGPUHij8Mj
 xLvrT6Vco/GC3kbtQ6kkskRNWfri7JgIEy9a7ZJ6A2i8dRK3lBmKm5U4wzw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78tg6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84842381150so14407189b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321334; x=1784926134;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmTWztalT6hryopRPQtckYmk1TcKP24H1NmDD4Vro7c=;
 b=dRY7XKdrtAs1yYuYMiOQVsHPIcQsGh867AJM3SfHZznzlRBNOEZjyT7Zt4iggAuWRK
 LvpSUxy6PYcgFeT+lLvJl80OSIgB/eD/xZgvPA+ue1pwU48yEidckIzFDtJNC0pQHw2D
 O+32yW7+A2jCOnGQBt8vf8es/+tEU1DKB5XUhpSSKmX9p1gYUfKdyLzXaXlO7kpwJOl2
 hByYt9PTrS7L8IcHa64P/ZMdLSnkaXLROuSRPgpRyvLJbfTvI+4Qa0ZN9FL48gqKBkbO
 BHCj5qtdQVFZjx1CoI9wroJQhPmBht1I/jz/n3Z4liK3l1FiPmiOxXfFKSHC3unw2d3S
 sPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321334; x=1784926134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmTWztalT6hryopRPQtckYmk1TcKP24H1NmDD4Vro7c=;
 b=OrSVzFdTt3TSGQK4H4w+0ETPqjhnTRfClj8OfY+ctH+b9oArWq2ZZRw0Y1wx8iQ6Wx
 UZky+y0QYdoF/q1tZb3DF3qgBsNVh7d/LiPcqWT69y86oFJrgw4NbxXgD77S67G1/h3T
 VGkVE1uI0yLHKO6nXLbW9G8ix2d10gwpFuB6FxHddccXDqKyUgrypRBFKsjND+QRDOsq
 mm5gBDMPJPr7bCshLgNm3IqHU0gTzKALn2/jbooLtatZSrZ36uNd1dyJC0y9hpQD1ujD
 lHhwoDeR3xZ5IGHTTLm3jZM3R42AiSn1NcBrVLsGeuXzN3FRDA4kQY/iCzHsdIMVxxdg
 UjnA==
X-Gm-Message-State: AOJu0YyQ/gLpZdHqou66nE4n6sWy6t0pCgcoWA340e+gKIVEOmV+kVgw
 NeLP8yoaO/MzWB/OD1IacKXVpkfAk2WHWeh2uoeyJQ5sm5ulQ9eWWPdeuVAGD7rUo3H1XGifZYf
 IzRkncGNRXTGN28Be+D8MEXo5YyW/ir0yPGBqBj5D1QTDDX/mINyMR3+77UVkxKWdmIDceurATV
 Lrsks=
X-Gm-Gg: AfdE7cnU9xCMQa402qEr74U0zI7nxNAOEmUUmOqur46Mse9TQwjee1kYBJu/N/0kHrW
 13ZtslH5T4w1dghoxp21dt+1ldTT//NRN29zNP3tLqh26wrcs5NzXOS5i3to95SMUXGQXLsO9yJ
 1EjfRatGxS79zjGqTJigUmoheyY1Zz2gWBZgzqrthyKE+v15gOK9kO/AbRHMIjPVvNJ19DDhlAJ
 UAaU4GCqslzwo9mXjkjbwqLcohN6+gv1Tvt2vpvzEJfInyDpD3WFTz+Xigkgz63Y99mIXWLCZbL
 319hJ/lozlcWQHzeHMWI4TX6ZtxVdKZSPeNzgcjnk5RgJ+tczeA2hpbPj0+BraKSPFW0yQeBWXK
 u9PFe/mp49ZsjZk8OXvOFY7SmZ6RArjNy8sQNeDWHw22MDVQ=
X-Received: by 2002:a05:6a20:430f:b0:3c0:9c18:d5a4 with SMTP id
 adf61e73a8af0-3c3ad997edbmr4549945637.65.1784321334283; 
 Fri, 17 Jul 2026 13:48:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:430f:b0:3c0:9c18:d5a4 with SMTP id
 adf61e73a8af0-3c3ad997edbmr4549915637.65.1784321333859; 
 Fri, 17 Jul 2026 13:48:53 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb517f8f77dsm1397778a12.11.2026.07.17.13.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:52 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 03/16] drm/msm: Synchronize VM creation on ctxlock
Date: Fri, 17 Jul 2026 13:48:19 -0700
Message-ID: <20260717204841.26120-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX87Qf3BVk0cNC
 yaBmm1x/ZoR8W/8WRYuRrn3sMT72PFY83KdqHzpJXPEisDajotWfriZOSd254ILx/+25DwUnCP0
 SveeN5vFKRYjx+23WyUlXpT0G6mX/1yLLgz9vCqV+S0ahJuda/ZtindIcJLm+sOU6tojo2pJni6
 bQTZtuMRLp1QcsqUa7mtYbKQ5dWtHn54JxIh9XqmgDW6OZtYRmFR/Kd1cg3Way7vB8cnv5Ne6n5
 EIbZ2YcoKMJA1TCHMp2KqTDlVYz+mldEmLWpIKgnLwyAvz9IYr0REpGCD4RfptWPStmbgk/58nf
 8+RFttGSdKy4XkZ8ksRo4wdqXH+D3o/S2Mn/eoUCgwlw87Rl1wiyhEsY8t40x3bQSuR23rhHYFA
 9TrNIhxMjSHheT5Mod+BFsEYs0MykjullgwjYbMqOFe/DHMTMzdyjrxPemmsWDxdsxLuc8k3610
 q/QZdyFQ3ujXC7Wr7Ag==
X-Proofpoint-ORIG-GUID: K799a-zMghS18BdV89rO8ChxtYHFslKS
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5a9536 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Hu6Oc1eQfK70imYNBQsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: K799a-zMghS18BdV89rO8ChxtYHFslKS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXxFbsoyoSKMD8
 ZQtlzxnb29Rajv9EthA+Kerj1lORSpkq9lU+8Dm42M1JqsnfA5UvFtl/eul1jnCsmOAOc4TtUlS
 5r5LCnOB4iMlVOz5OiEi44QFcOkeCsE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

And serialize setting EN_VM_BIND against VM creation.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 ++++-
 drivers/gpu/drm/msm/msm_drv.c           | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..0d54141ff089 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -503,7 +503,9 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
-	case MSM_PARAM_EN_VM_BIND:
+	case MSM_PARAM_EN_VM_BIND: {
+		guard(rwsem_read)(&ctx->ctxlock);
+
 		/* We can only support VM_BIND with per-process pgtables: */
 		if (ctx->vm == gpu->vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
@@ -518,6 +520,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		ctx->userspace_managed_vm = value;
 
 		return 0;
+	}
 	default:
 		return UERR(EINVAL, drm, "%s: invalid param: %u", gpu->name, param);
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 384f32f4d0c2..2fd1b717d8e6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -222,7 +222,6 @@ static void load_gpu(struct drm_device *dev)
  */
 struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx)
 {
-	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_gpuvm *vm = smp_load_acquire(&ctx->vm);
 
@@ -230,7 +229,7 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 	if (vm)
 		return vm;
 
-	guard(mutex)(&init_lock);
+	guard(rwsem_write)(&ctx->ctxlock);
 
 	if (!ctx->vm) {
 		vm = msm_gpu_create_private_vm(
-- 
2.55.0

