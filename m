Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2ACC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F23F10F3BB;
	Thu, 16 Jul 2026 20:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hF2Za22D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JwuNNlV1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA2410F3CF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJqLsO3853418
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mmTWztalT6h
 ryopRPQtckYmk1TcKP24H1NmDD4Vro7c=; b=hF2Za22DHpjLJxSlXR3pOV+0nlJ
 CTYSTNk4kovuw+27nQ7r7V+SMur652gblaBaxhNdMdnJNmGmySLgDR/4LrfwlLbQ
 eqKEXKKwOWBYZoO1E49pk0R/bzGXleN/gX2SMOdh1yzJb/sFV37Hqzw2b7y7+ztT
 xL6rYCJac+ap7zfxxG77/NNxrDMg03I3asPx3cBMN+OKH6DHt45fRVdOpNlwSd35
 wuWcOd70vqxZFT18AcCjsbrCN3jHRxkP7SfSNJoNLBTz6MNnZW55XDvHFgQMsnzH
 MR9p1u3AfCU3IGBTrw5QmWowBFRIrG6kIy79EXAYaHUAv8v5LvhS2EgvB2A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19y09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso8720660a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232953; x=1784837753;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmTWztalT6hryopRPQtckYmk1TcKP24H1NmDD4Vro7c=;
 b=JwuNNlV1fLvjgHoijlrEE3OcuSldQjUZEQ/XieFFd7ydSDXy3ITwsswAZWzcgeHZI2
 Ljh86PTiNdU5Y1IjunfecMrwURWyV3hzg/J6gR0XRW5Dxw9dg+u7krPAx3y8Xmzoqxjz
 Xo1PnBw7XB7oEGUeF4VPzihRmCeVlMqcELEn5Ej/2BHgo/pYBIOzj8+t5JWoY6M1MIB1
 af+DhoAQUQoRZc1uU68wJsUaNEY5+U4W6mNfkSSEsVcPlKrYbwUBeamfCQc6ngCujtmj
 gAuV/E7WWyDL6nfyZCsgrtkQZaqN4bIleATrMSmiW42eM/FBSmDEh8f9CBl2+3xhTYK8
 m7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232953; x=1784837753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmTWztalT6hryopRPQtckYmk1TcKP24H1NmDD4Vro7c=;
 b=Xgfyr8Tu367JXAOxPwKtj1uMQZfOQy61LZuVOYyGoddD8U10GiRHNk/SwmnA92ntG0
 UE6ZvqxB5zNSH2WkOA53BYOnc5ArRKo8jT1+8bQAjYmxHT4Z8Pd7qFfJOfTUCr9b7hUf
 ni+st1QrfH7dhI5M9c2aS1Stz+w9UzDwud9IHZLsMpzZ75cNqeVMuSX7UwjbwKoKzjfw
 eDw9EB+8Xkjqz3QhVcl9mwgQYsQ1iSPumQXaLkulI40JKPViyCX9Qh0zVtvjUc4QhwEi
 DSQZn8j8+GPGhPrDYAa8WGlOJ/8MLk6qW2wutxF3tKpeEOcHYfmTPJurxSxUohIn9tAg
 0CNQ==
X-Gm-Message-State: AOJu0Yx2Hxg+zJWEzWUa8I4dAYePp0h53nnB2FlVhp8ZPaF8gBTPu4KI
 7RGMEw/I5A3frCmJsom1BEDE70s4fLI3O+P6s1puIBH/kcOZSJTbKfMLlXalKkGxgxY5SRqYcAE
 abbTukILr13rB3glSLTGnRk5BwTHVUgUwPAZ//K0XhTrPDGnlVgohsZAVmiQvQzCO9Dgihw6ztW
 i/5Ng=
X-Gm-Gg: AfdE7cnaSvy/i5oPPNUQRSz59XHI/R123jLzRqp2kiyLNDLPnxs/EPPzmwKru9Vps6n
 PDXTtPTrBK8poxNwqM75qsaa5V85btamZXpzN8R90hCaKuXwtQLNd3+PDb6qMQPIBxHPIgeDxKw
 7/wIP27XJEltEDZ2Jvw1iJX/PuG2umwe5NoFuRc0CD5qqOkeXy/XhJTnBpnr+bKOn0empVJ5tKA
 y5m0AYYwQ+4/DladqjHRkBQvG5aanX5aFqK7t4xKQEdUDHX3HnJUU+9aX3Uw8/MTFIX758xkR6H
 bUD/3Uj/MPN/gJxMOYD4iAan17Vq0u+6GFnnhTxFSjdhAtEbVMBzsyVwOxqeInWkqFCwYGKRmON
 VSNhxn4CaAklvaWRmCfgqwEx2h3965oX5+SE10CF1LlCRkxo=
X-Received: by 2002:a17:90b:3a4b:b0:387:e0cb:7f5 with SMTP id
 98e67ed59e1d1-38e17fab248mr14071719a91.41.1784232953039; 
 Thu, 16 Jul 2026 13:15:53 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4b:b0:387:e0cb:7f5 with SMTP id
 98e67ed59e1d1-38e17fab248mr14071670a91.41.1784232952484; 
 Thu, 16 Jul 2026 13:15:52 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e3a0d7a5bsm1826785a91.9.2026.07.16.13.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:52 -0700 (PDT)
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
Subject: [PATCH v5 03/10] drm/msm: Synchronize VM creation on ctxlock
Date: Thu, 16 Jul 2026 13:15:26 -0700
Message-ID: <20260716201538.365824-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a593bf9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Hu6Oc1eQfK70imYNBQsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX68iVQY6mKUo2
 paU3HBdw1KLTDsgGPxV/qRRAL8IOALSp8XPm9Gn0r3+bR11hL/bjuDGw4/aj4yHidacRqr6JxOu
 5Kl6d3CJH6PzzztCj/xhe0tSd3wzs8G3ReLZ1nx2xPFs6GJBqOkDd0JTj6L5yNGpGv2hz+Rh5p5
 /kdV+8mfry0YV+UQFwf0zVhmmzd4OtK5Ny/JAcnKsIlEcadCFSOml54grjznt6OZAzUY3sDN78O
 qVLy4HcOaWo3G2UVNL/YuBJMBLVjq91UL3JFi3qN2um/wsDAspBZ1mtD8r6ifOsEEWDHabdb4b6
 cO3iIFRqqkEffIUyp6Zgd5NWdW54FlbyvEVaeqi/QSkNtnudG1jDnmOjC62Ov8nEe/6CwpbThcX
 6INQasadvj4LvKbfw0m+p5gpCWfApmAN6URH4zbtpCgkWlcd7DyNjsZP+Kw9lm8Rkyt91X4wt5t
 r0poGxpi0HaDbsDLD3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX/b0zIkLJ2UeL
 WfPozRXDGR/wdfhJa48smxJ54SI82NDFF7s6JMLwGtvHq0HQma6/62HV8y+b9QtmbL7KVOu7kzI
 izv0RWn+mhkQnyLNWgVzNxrxOaZAh+U=
X-Proofpoint-GUID: Wfdtzz8LuK_qDw1pAu1Hjui04uDUdhXP
X-Proofpoint-ORIG-GUID: Wfdtzz8LuK_qDw1pAu1Hjui04uDUdhXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160206
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

