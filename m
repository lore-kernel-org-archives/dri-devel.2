Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC8CD4F57
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC3810E9C9;
	Mon, 18 May 2026 19:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pvYv4GC7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VZM7NlNY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FF910E9B9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ICLC2w1890449
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=55Z0+HKKOjd
 4ey37cISeALnhSf6P7jsMdBMIO2WE5Vw=; b=pvYv4GC7HArbaVawg/BoTjQFhqQ
 xoVo5uLDbmtNJpTEdhPKvCPXb27uO5HVWiDUc7Scs+Y04mlMRiNWFcariT2FmEP+
 1lSWF3W5zYz9LzyRw7VWIEz/BBZLgF1v40DeEIGkHtBVfdf+F2xYje8oxQBEUte4
 Kkczdd+6B3vLNckjrpvM5y3ng741+ciZhRopRlhdN43bI5tLzFqZtK87mZw6I1Bq
 wIUjFYmwex+hu7TbL5R3eVbFJkYJbzC1lqVw+mIJOw+CPacItl6aEJUHoQM4h19P
 aVmI0YhRaW83HddRi05X2NwvB1mKMBcuaZyA5MhXSrLGxJ2gJkUv/9bJ40A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82pw1k4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bc860066a6so19839575ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131313; x=1779736113;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55Z0+HKKOjd4ey37cISeALnhSf6P7jsMdBMIO2WE5Vw=;
 b=VZM7NlNY0u2ye1aWnAbMWq/xerxyiNI8ereFk+Js8yfl74nH9P78mJTvFgoYHERhYx
 qq+qIsE/O5ppGPJ3yr2o8HX+4lhxUDAZG6HtM5TvXqAfOq+7kdvBYgakXw0XZqUO/DoS
 FqdJt9+6V0fYIJdKnW5UZaqYCDvSFOjVDVuFFMJd/cxyzh0HxUlAW5GPKz6JqnORTxjZ
 13GRMqEP6/uIdSmSIkPnrDG+OqH9UyW0GELUCV3ONpMMJ+72X+rWb/gNX6Qlp/RVqvL6
 SU0T25icpdE7LDu3y5/D7tB8A8ZpbgmzRHQ6n2Zj1bYb9nLA27EfoIs769JF8wzUdvt8
 8xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131313; x=1779736113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=55Z0+HKKOjd4ey37cISeALnhSf6P7jsMdBMIO2WE5Vw=;
 b=pqLfcmS5aHxECjMsoCxeRIvjDTr4E8IxfzNz049COXHi8yjcVz/LFSv+QQxhTNQhZu
 XZtBFrO032I2jg1aaVt8cDS2kzfULMTAph13OoLqyl1MGePBKHwjR90r6tus2EqZVeSF
 fvtp/KymuYjinB+uT/T/LT7XmocDGfm9nCXIES/5iYKaxa8cS+wEA4YeI4RpGlMDhIUo
 da6jqBZ7DcFn1gTvs+U5qLyRaZ+f+nYBC2cD3RGIQ7h2/z07as0VhijMWaMpBTxZA7hv
 Bw8DdKtspfvebTiWKszYn3/drGDOROv2ngrMouduP19QCA4CApoHEHTxiwHouKyTO4FN
 LDag==
X-Gm-Message-State: AOJu0YxBTQWUF5nqq82Km5HVTZwmB7LkVXh2kidUUEc9qRhO4auaoqc+
 M5xiK3ND677iiZq0X/zWKIdC3++Zud+4tdvFB8WRZZKoYVg25nxssbm2a53kp0usSipDm40ztDk
 SGOOp3gg0SwC41r0W4C3QTKHOeDkq7G5gpCF3l2V6nJKkKV9e8IMGDQIg00s8aSlcwp0CRCIRET
 Zb6VE=
X-Gm-Gg: Acq92OHRGe7BbTlJNQlKEDCMzwzis21pQVMg+hD1OWdygjsvMITEdkt1MxL7DlTMi61
 Vz6X2DOvu6gKqtIr3MOJ2L7I+TuE3xoj5EATUON3ul+VF152VybBQk286FzF+4L3/Z/gV1jCb/3
 zwvcRdrvoBz7lFV4hVFCJB7Y+UoM4obtl5oWu5ubu9NpWalpB5DByYSyQz0Wg8qmelBErWVZ35L
 A9A1TrFjtncEmmSezKeAJJDEYUtJc+PbtrNGQk9T97x7dJa35n82kC1sT+QfzchvhIyYH5udXoF
 sgnaxwjXj85kKgWsLPF3vKD1N/cBSdOUXIME9LpeL0s/aiEG5E36UHLYUcnupRTMSJIL6a/sr2b
 tuFfYHqEnM0/CUy9Lv5xy+qY0DPidE+b8
X-Received: by 2002:a17:902:7484:b0:2bc:ac76:c1d3 with SMTP id
 d9443c01a7336-2bd7e9af975mr125817175ad.29.1779131313168; 
 Mon, 18 May 2026 12:08:33 -0700 (PDT)
X-Received: by 2002:a17:902:7484:b0:2bc:ac76:c1d3 with SMTP id
 d9443c01a7336-2bd7e9af975mr125816965ad.29.1779131312681; 
 Mon, 18 May 2026 12:08:32 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0f94c6sm161995935ad.56.2026.05.18.12.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:32 -0700 (PDT)
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
Subject: [PATCH v7 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Mon, 18 May 2026 12:06:43 -0700
Message-ID: <20260518190735.16236-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a6AAM0SF c=1 sm=1 tr=0 ts=6a0b63b2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=5obZvuzjGUYrwyXX1KsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX/QGACnqrfZRf
 Me10++tuelsQnMtNOttm2lrx0LIaA2nQimdcac/BewNoxl1ZM4RO8X5QGr7hzuSfu7bsUyyCWgw
 febSszfJ4JcjuwFcmkrVFsofahHU0zUAsrdpM6KZODlZeUF7hrScAGjb9bgwr9UlxMq/YRiZxCk
 14sfEvPemJyYmbyciQt3jgRs9xGPKRDY53pD7n32DJphXhUbYpsk2asoz66ODm/ccKk2LjrUSQr
 eJLtFZMfXeRbjHdsnEsiK89JKEoTXWz97Ylld0RK8pUQw12kwcKVvKiFTyxCm6O37+MlhcmSmXW
 +rgE1iWAPWbuw37bxScOqewelfdWuwyi7GUVx70z4nJ1Kzkuu74cVVYgXdvkkb2FZVbZ0GNzMS5
 S0+b8evfSNWbboqjR1MPo8zPd1BvohJumPJKlMUj6B9L3KcEjPa2ppgdElsEeiMOODomdW+DfOd
 G2dWsyWk/CsrjOyTOBw==
X-Proofpoint-GUID: iEHK9SWF4By1YuSSyQhweWTghJ8Bq4tB
X-Proofpoint-ORIG-GUID: iEHK9SWF4By1YuSSyQhweWTghJ8Bq4tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180188
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
index 38f1130b99fb..6875c44222fe 100644
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

