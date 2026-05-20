Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205FBCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE9610E429;
	Wed, 20 May 2026 16:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6fyIZQ5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U1Vdr5Kx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9552D10F0FC
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:49 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KEFZsR963711
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yZLNbGmv9aQ
 +0juIl0AWS3cctse1A5Ppe502SPgUtuc=; b=K6fyIZQ59J76PXtESrdfPWV3XF0
 biSDX3DuyH7qMW9fJDc2U9bWkvc9XIc5UgvPzd6L1ecNZyxf5W3AxjxuxxOT5+Lo
 5Dk9HSSDjm3HRcLjO9U2LMZHYTLayQMI0fKKyT0QGgvcGScupPO2UeCQeIQaPa3M
 SSVzq4VZBk5jyrgLrq1FXeHv3MsniO0uzQt/Cu//dhfAa5MUHIZJ4lVbKZwPH0Rg
 9aIv1tvTI5/q9QxqVWKSIRjZUvgB1LR2FmITvORZOoFY7jnzkevRAt6DZugUcuHR
 2UNTpjsEkfgj5c9iAl+rOF1YIORjEEbIc9nUGEiyteLpx+sq8c2uAo5DPwg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh0jsx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2be9e0905a9so92555ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294347; x=1779899147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZLNbGmv9aQ+0juIl0AWS3cctse1A5Ppe502SPgUtuc=;
 b=U1Vdr5KxAeJ3sf3+O9cSyLr1utU9n1l7sgxrzJ4oJJE3PQMA+fERiO/osyti6H/LBG
 XBfTzIOTguhBPaBghYECCfOD7UKyqHrUBRpbsPxAnpczLf4GgyydvmocNSap2eVvvb9S
 OPD5zr/EqhqTz9Lf8t3Fw5Nkp3Bmk4G89IvRVUw/9ubIhXQ+n0rYRHPk0qWgf3+zMn+x
 8GdTniNuSbhLdj7LkCZ9lYcer3nLwrMoPTSS9o/ZRHBijITLnMfBxRQiXauZAEHYUyPg
 f+eBtDA81njNltbyrRMLcYAk5q2RuLlQ8urPSiGcxmUHcjodOZcipPsxME8aGxgiR0YH
 1t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294347; x=1779899147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yZLNbGmv9aQ+0juIl0AWS3cctse1A5Ppe502SPgUtuc=;
 b=J/+9AvvcthePXIjKsK++Y8pLuF+8zw02m0Q200HflAiFCIVsgVMuAf6JAOAHx30vmH
 UcK6nHwqO9NyZoeMfE7bNLgdXHvWMR7QOaPQCalzmcLNMo2TSzVFHJeoZTeKUPfvvHBQ
 AmlP6klu8KHbwDswXN2BJ5Afk2ffXV2bDNWVW8YwzLyhtr9EQ/Q7pfZGVYODzuCIauBL
 bemHUBsUOVOlNNZ3AdTZM3ufXQgrcoHTBJtg6dNHmP6RYTub8kjxxQnK8wlOQavqqpWn
 8M97A0v5jQnoMJ2NpWh/EsEKQXx/fX5we5Ja7gCRyRMlIhKARHE4hBTx7odasr/mbxEz
 kxeA==
X-Gm-Message-State: AOJu0Ywd/DYoSiHkAzYd27wo0B47iyn+J01d7RQsMoWtIIJcPsXrzXKg
 akz/L0bz2nVRwxrrtg6K902hYBkSEG3nBLWl4i3jF0XuMpVuWzud2bSHBbDGJRoJcfbc/LSg1tV
 C5oSLfcrJJBoPlyr+C/g5nc80KwAhwoy6xWKxV5FB3trNLlrmSRmpb4O4rBAB/lPgTSi1sMZHpH
 CDrO8=
X-Gm-Gg: Acq92OFHnN2FFqAdCq8jijo2o1VoSnFSNdNS/a8d4A2D+dvnLWEWs6bOAGtM+VxJKPO
 rxOMt37mgiozDYVySzsVmxPJ0UOSSsLdA22L8hnuB238GepCjfgPjUwm9yd5uVGgxTQD9464Mn0
 TlsWgcjQq4xnGglbxx5+6LABTB1aeeehTFnV5UHqp80T5GIuaZjJGOajFRZ8Zyw7TWIimP7r6BD
 j3V9YduERnNh6Kp/LuPdkzgk4N9pHofHswHTQHRUmJD30Z4HlY18Pnm37ZJztCkHKk9s9wt9npJ
 K+THdR/H/5djIcZcPmeYdtzmy4hHPCHHjbaqK4GClyeWi+bm9uXbNclNXuZ7syYRozmYnzEN9fx
 k/M7pDMIbAQwamHadHkDqAcBeo1VmEXev
X-Received: by 2002:a17:903:2ec5:b0:2bd:9061:d544 with SMTP id
 d9443c01a7336-2bd9061d6bbmr254826095ad.34.1779294347173; 
 Wed, 20 May 2026 09:25:47 -0700 (PDT)
X-Received: by 2002:a17:903:2ec5:b0:2bd:9061:d544 with SMTP id
 d9443c01a7336-2bd9061d6bbmr254825715ad.34.1779294346670; 
 Wed, 20 May 2026 09:25:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c26355csm226190895ad.35.2026.05.20.09.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:46 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Wed, 20 May 2026 09:24:03 -0700
Message-ID: <20260520162454.18391-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0de08c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=5obZvuzjGUYrwyXX1KsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX0W3xlFRRAOwP
 Gg/6LKmbCRR2iBs7OR0/CkD79gMKEaswYF1T6D/LPTtvmI4FJtl9AtmhB+rR26sND9nBv6Mnl/t
 PZC57Z+qohqFYlKhRnl+OEvQy66WiczSE/5/b46e02+3PBSl8qCQm5SaWFuxoxANR69MSD8C0ty
 xF2Wymfy6GD70JAlsAL2jiB/4FEOv3mRORDG5LezHc9+DoPgh1dxgqekgxl1jKa6xtOVLi7loPc
 uwM6Mb8QJBkr4Cye6070NV/yyETX5TFulUw55NR4Jafard4DVe6IPn2M7AaHqNVkSXy6SNB7u5P
 NefYUrwvQ2OaNEwMr1cUlUYKg9VtUEGcb2iqRZjl5KtQs63nLUyrfdo6X/s3gWMmIbh9bVnvF9f
 PwPdF9+ixAupd/mCb8eS+cBodU8jh7Qj7UtIppGsYdLYdMwIx9pJ3L8S6uq7oC4qxLEeGrBJc9A
 3Udf54RdP4RcdCVBPFA==
X-Proofpoint-GUID: TVlUPKxwVcgEZ9lC2PKOB-xzXSgonw5Q
X-Proofpoint-ORIG-GUID: TVlUPKxwVcgEZ9lC2PKOB-xzXSgonw5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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

Now that the dynamic pwrup reglist has SEL reg values to restore
appended, so that SEL regs are restored on IFPC exit, we can stop
completely disabling IFPC while global counter sampling is active.

To accomplish this, we re-use sysprof_setup() with a force_on param
to inhibit IFPC specifically while the counter regs are being read,
while leaving IFPC enabled the rest of the time.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h         | 10 ++--------
 drivers/gpu/drm/msm/msm_perfcntr.c    |  8 ++++++++
 drivers/gpu/drm/msm/msm_submitqueue.c |  2 +-
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index aba08fb76249..0a7d49a2c877 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2034,9 +2034,9 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu);
+	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index f3cc9478b079..eecc71843bed 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -280,7 +280,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu);
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index cb74b7606987..e3b5fab6f68f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -93,7 +93,7 @@ struct msm_gpu_funcs {
 	 * for cmdstream that is buffered in this FIFO upstream of the CP fw.
 	 */
 	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
-	void (*sysprof_setup)(struct msm_gpu *gpu);
+	void (*sysprof_setup)(struct msm_gpu *gpu, bool force_on);
 
 	/* Configure perfcntr SELect regs: */
 	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
@@ -378,13 +378,7 @@ msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
 static inline bool
 msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
 {
-	/*
-	 * For now, this is the same condition as disabling perfcntr clears
-	 * on context switch.  But once kernel perfcntr IFPC support is in
-	 * place, we will only need to disable IFPC for legacy userspace
-	 * setting SYSPROF param.
-	 */
-	return msm_gpu_sysprof_no_perfcntr_zap(gpu);
+	return refcount_read(&gpu->sysprof_active) > 1;
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index 85ee784e3851..b29f4664db87 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -256,6 +256,10 @@ sample_worker(struct kthread_work *work)
 		return;
 	}
 
+	/* Inhibit IFPC while accessing registers: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, true);
+
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
 
@@ -290,6 +294,10 @@ sample_worker(struct kthread_work *work)
 		}
 	}
 
+	/* Re-enable IFPC: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, false);
+
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
 }
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index a58fe41602c6..1a5a77b28016 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -42,7 +42,7 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 
 	/* Some gpu families require additional setup for sysprof */
 	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu);
+		gpu->funcs->sysprof_setup(gpu, false);
 
 	ctx->sysprof = sysprof;
 
-- 
2.54.0

