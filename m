Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D7CD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CDE10F705;
	Fri, 22 May 2026 17:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="emQzGiIa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WFU4abw9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FCB10F6F9
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:35:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MBwF2u1297937
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Deid5R3Lmtq
 Z0P+RFoa9IB3pG13iRkpjEqosdnVWrfw=; b=emQzGiIaIwUSh3vZFwhRt7U5tum
 NLbask7oToJUR7ULN4HKSoohBeBdHxzYkodxz4o9aF79zYzWU+bEwGR3Eho9YPyE
 L/adbM+XVf+Q1bR1k/DF5608W+0MGLl5rv/lv4HE4um/RAWoGlBjT5qWqZnUa+Y+
 aCCflJdFi10DxSWGRhoSFgUd3s0f6MEVkNsdDFKEq8NOeHv9bKWZuv4ht5YFNCcx
 5p7agD/a6KaOIp2g/om4a63GqLTlhPJ0EWkQvR00G2ac98SPk1jWgU3GdkgWBPM4
 2gi+9Rb5RXb8K7A7B6WlTCFWAz7o2XOiaU9UFFh8b3G/W+ohWf/5dclrcxw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0c7k7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:35:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd1dbcccf6so127151475ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471305; x=1780076105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Deid5R3LmtqZ0P+RFoa9IB3pG13iRkpjEqosdnVWrfw=;
 b=WFU4abw9dIoOTg6qtBNff9dUPEcXcejF4stBQBaJG9pp1K4/Ei5cLs+CZSwN/TAnk3
 3Mc8eGFI1mBpo5c2XrTbUR6rgVv4Yha8wipNcppXccFw3rKZVxS76h37hbDCcWP8OYCF
 TVhqxRKH7jihDehuypAozSgj4XCNTnUjW5tvFZj7JRyw0YlWUMqtygbY2pnRGiLotTGh
 H/jwywJL0B5wIOeqDh0rZgFiz8xnzmhVZjVcDQJJT/z72gt8tQmOSRhyzQbKp2iTVvCg
 98oQRLv7h9A/AgQ9hw2XL1jTckypMhvOn9W7vyiK122lnnRqurOU1qpD01wTCmUkHQv+
 K5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471305; x=1780076105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Deid5R3LmtqZ0P+RFoa9IB3pG13iRkpjEqosdnVWrfw=;
 b=cwrnxm8oT3MW9zk6JZIpi3gwzDHfUBC4R3akZ6SN41fLjb6Hs6sZqdSymKzvrSwhSf
 8z/zGsP0nT3eKsr7zeF4/27cC8P8RpsWVPLpqv9xUG2CezsSzWFK3RIDMHGfiqnyqHFf
 Fc8l4VQOW0yInwRmxNHJH4tkrXqbdnwKqOaX89aWUyJjzzd46NBhwwhPq65LR95X+Uwy
 9+WfSJ7AQIg8Dzc2I4sOpFiqo9hU/8d6YsR0Mi2XQ+xn3I8aEhUfaAOwI+hbdnLa4hMI
 otdo0u/Zi7h9Upzp4tKC2UJo80OnN+ZJ4H+vD8AjgvgZ/pyin7A5lN3eBD9Hx4Z6P4GE
 Qrjg==
X-Gm-Message-State: AOJu0YyOoDcEyM5s4rJXoHeHqs3bkqnvJSzN5bQfkT8hTIsSnF81w+iv
 tSszRMv70RcdqDsWGNRLOqM0X/h1/fedr+Rm0kj507mTLz3M6hKcsIcNJSzrXXSQuoYrniuHpyC
 ovdNfEQDsav8QsVBVrqg8vX5XTfUBmzf63vHi7WFxaMFPHaeX2izwQokCvux5bUp1/txLOs8URa
 Tfhg8=
X-Gm-Gg: Acq92OGLCaMztseiBh9i+8mivLrNwTN3oQTWN2OxoNytIC93U0/y3ndx6EdF6Libsmj
 psiztcBulHGfJQeTfM27HZTRuaa9Wrp518M4T/qyLXHCtlK4tTxVtMJ9chP2YK+gdSW4CbToY0s
 kZOfg7CzFdLokPe+ccJg2tlLLOoxH62oVHSY2Y+kIHBZZB5wVFJf46NfIII2LfacW2V/upQ8eP8
 FwpIv7oysnHitlUW0TRJSogVhn+/gn/2k9zNuunsG10DvtPdWLKcQ5mJeEih8dnhOXkBwqPKPwD
 KyGgaovZzvHIEc2Q9wDxA38+P/jk5AA4XPoHdcSVz5ERwm+JuYHPJXNvc1K+MuCQPLsswwQDghm
 KUvyLNgqqHvPOQG2wezA3BVP6cUDelIG7
X-Received: by 2002:a17:902:f650:b0:2ae:55eb:f82d with SMTP id
 d9443c01a7336-2beb038f177mr55487115ad.1.1779471305474; 
 Fri, 22 May 2026 10:35:05 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2ae:55eb:f82d with SMTP id
 d9443c01a7336-2beb038f177mr55486635ad.1.1779471304953; 
 Fri, 22 May 2026 10:35:04 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2e8csm20708725ad.41.2026.05.22.10.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:35:04 -0700 (PDT)
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
Subject: [PATCH v9 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Fri, 22 May 2026 10:33:02 -0700
Message-ID: <20260522173349.55491-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfX6FnyZ71DdwWR
 BpgL53ehV201DrfFBpmB3AXU/OMHeXrVHbIjkU+5A6EQbLVNIZoL0dXC5UklLfXQmK+PFJYgMz7
 +D/nmSH3AX+pPsOdywybGWJSj3JmjDevUQIpfBQmpF5oBYiRs6TXmGpdgy5hrWfMrizw5/F8BMk
 rHmFL8mWuqBJdoC0Hh9lp/8hEebgVTWiPOkrHMFg3rGjqry8FjnaroDQUGN/5fs4adfOf+YTao/
 6QEkvLHfkqeoc0nEwfbQKdRd8EJVKtRUJoNtWJlSyIqRWGREbmcnng77EhhwRQ0aZr7XkQh74LU
 Sk1j2J0VF6bRQIaDDbzi6+8f+pD7t1WLqHi7ekn1dkcMRe5J+2URLNLAkuAmmCEN7he+IawTgzq
 uyhqMzUzpVfV7Zj8uvW6F+V7J0FQUBRnNtbltM91W+kURQ9qED4C0qcm+zsQl61ziD1XYiRRPob
 ktNDr6XXbQQ5ZBiGGUA==
X-Proofpoint-GUID: r5BflTB8HFmesY5LFoytGiRvMwo8aqpO
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a1093ca cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=5obZvuzjGUYrwyXX1KsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: r5BflTB8HFmesY5LFoytGiRvMwo8aqpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220175
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
index b72fb58bf223..f60a0801a62d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -281,7 +281,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu);
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 22cbafe75a07..3d8f1ea5335b 100644
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
index 419e797478e8..fbcf8822ce61 100644
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

