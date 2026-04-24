Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F992FED3DF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5CA10F5F8;
	Fri, 24 Apr 2026 15:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Idw+3XcZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IUIdBETS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CF110F609
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9W2xP756614
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HLnAwFPOk/J
 Qm30uB0uKT2zj47gE1NdrqCSNluQVCr4=; b=Idw+3XcZ9HglK+Fam3941GQrCWS
 RuPu/UMx3L0XxJT8R+rWo3GQWcVa8gehHnZaFvaJhledjNRYHjwmuaLxNf7PG/As
 hRDSfBGSZqvbOW6BGb216aLfPO0bIsUY0UI7OoFaVuBoRq98O4TQKyj4sZ6ujpm7
 Cl1tAMHLGlxtN7KS3kEduj0aWkhPkJczqFxP0JsEp7YFPnitCmtEb5hE3Grj7Z1h
 t+cbb4yn+9TSKvEgFPHNtZQukl+nJdkLkie0TZHhcKgM5zK6YxSvPClLVk2Su2sF
 dyGYijVwav1R0gpH3hBCv4VuPAwjZoWg+EVnV38rOoqLYFNb91SOjLXye/Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr4bmn5e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f896eb6faso8406569b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043547; x=1777648347;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLnAwFPOk/JQm30uB0uKT2zj47gE1NdrqCSNluQVCr4=;
 b=IUIdBETSaVOXCNAtlI9TUqljVmjJf/JhZ4o7YtpEt6sKEvQmHOjP1BoJzgPwfEzMPV
 nl+16PysRPDvMsdiV0EQT8HhCqA++4HUl6aSxgNB2XO7N5FT8BmAwPKUb1x7NSpCkgLt
 aj2OtAv+Tp9BO81OsApUqtjiCwys1JL/jI+SRDtB4MUvkWQVHCHZuDZ9D9hDIUEKpaf2
 LTMqJd1evpVXFC/ZFA+gUSE+OCz6ldbwaT6cbl7KKALVA2qlTVuLt1QT45jeXoULEt6z
 FrOeB6PPHkGnsGN7TLmcGv1cBcroWvK6JkI3AmQR066uiLL8hEB967ZfjuDnI4FAt0Vp
 pwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043547; x=1777648347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLnAwFPOk/JQm30uB0uKT2zj47gE1NdrqCSNluQVCr4=;
 b=Vgzy3he2s/uHnoScWCE0sTd3H0TgV1ps4/ZUT5F/YxV7i7ySEAgAQDY5cvnxa/Y+ah
 rdw6TqYb2kyOPd1LDJc05B0T9mBJ1gNJg4+vzfT7JDXoegxW1n1tK7D8pEgMKeWo1WOW
 yeM1LNQvXAcavD8A2vDiUZ324qjCYMZnOLl6P/mVC/rl3g2oq3/3fxVJFegEJxASo3ta
 B8RQUGQBx/sQvXwji+nmrqURzBbpUAVGziZ0FgnYBX7ldqZfvGs5y8VZcef2c6dRbAD7
 9MCauCjAfb9v5S/TCZLaGYhy5HLdodWdjscbjX/TLGr8hmxG81j1E7+S1BbmeOQDxThB
 Q1zA==
X-Gm-Message-State: AOJu0YzdPtP60teBVGjkKYjcBCbEJI/wHpPmtHsu+IndN8a8kS0ajdP3
 xUeZgxfQmkFFav5I0bZYvuo5/Mm147Z7FKlRa0VV8xJhX5k5R/Lqhc3Xy4YEljHEWvZEWny8UE6
 nrBRM2O7SY7nruCyRMyIWeWBFY0YaSUdF4HYPqI+kAm1gOC5khvUxGPmGl3ib2yosvREU+zkkCD
 j0i6g=
X-Gm-Gg: AeBDiet+Zaa7y7AVdPlOx7hIBPpiybV9rrYxU1bh5N8y0XAAjg3OjWrYssUsyGB0Qpe
 vMqE/1KHX/Vhf+Tt1xQDjMiDgrrz5spd4ykdWJapCiYoIl3ZjMGEGMszw5vqUpZtdd1cM/tO8c5
 DMV9DYyZdtU+VrvW0qpV7TW5kRoL23MLALPA4XYolxtN/GEjkoYk1gRg2bxy39UbzunH3VzyZPL
 fEJz2l3T6TLMo73qOV6aZ910WgIhjQ07MHaEVVP0U1cWaUflRMdhf4X3B7yr/yWYyaKcxNN3UVi
 srr0SYSsgzAX5xyvj+4/Oho+ADQ+/bSmBz62kO8mSjFzem1meQ2pDo6tmCztKpTkxHtOVtOCGe7
 TjZQDvRH3BRuPj8f8a5rMxHlB7Sb6oScM96PY+5NnFmw=
X-Received: by 2002:a05:6a00:8011:b0:81e:12f1:d8a with SMTP id
 d2e1a72fcca58-82f8c90497bmr34751504b3a.34.1777043546762; 
 Fri, 24 Apr 2026 08:12:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:8011:b0:81e:12f1:d8a with SMTP id
 d2e1a72fcca58-82f8c90497bmr34751449b3a.34.1777043546148; 
 Fri, 24 Apr 2026 08:12:26 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe40e5sm22200402b3a.42.2026.04.24.08.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Fri, 24 Apr 2026 08:10:51 -0700
Message-ID: <20260424151140.104093-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfX2sdT3M2YgwAk
 ZShg0mFRY3QA6uH0D7x4UdGgCAwUrIF93Mz3wHZElmDzzOXny5fQVhZLW0ljlqhB5a1oSFGKZep
 bQeVtaR/NQreSM42HTPYRrdpd3xgLoBYgOvzvNTJ9ocItKMAOTeW5Duw27Cl1yT42ERQWSQmjnG
 43D04mXvS5VLWToxs3i/cIsg2CYh+6NhUZXxa2u04r6LsnPtU27pZvsUrya37SkQOfYp6P5ard/
 Xu0W/vVqibyBOvvhN4Pkt8Ifeq/MdmtUHY+MZTkMSqWRefLEmrdH40jjF90qSf+g24jYzEa36rn
 mzdYjOc+q/xg4WR+Eb1gzuJH+XoO2rJcxdI1yLP1s313hodGc1cYEPVoC3uk21wx89mY5b5N0+x
 0Z7t5ImwSCdqF2JnzSTVWJB5rhwvHJLwK/MLd4zV36YtUYI3siOib94YL+IMpNuU7vMcyzWCuuM
 Fy6+UW8iNMhDY0TxqBA==
X-Authority-Analysis: v=2.4 cv=TtnWQjXh c=1 sm=1 tr=0 ts=69eb885c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=5obZvuzjGUYrwyXX1KsA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: PWa_F2P_a1waTg9fIrWR0q3QiLAEqR7L
X-Proofpoint-GUID: PWa_F2P_a1waTg9fIrWR0q3QiLAEqR7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240147
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
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h         | 10 ++--------
 drivers/gpu/drm/msm/msm_perfcntr.c    |  8 ++++++++
 drivers/gpu/drm/msm/msm_submitqueue.c |  2 +-
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index aba08fb76249..3fe0f1cda46a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2034,9 +2034,9 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu);
+	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) | force_on;
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
index 67f1e84eb631..93124c032dd4 100644
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
index 8dd919c004a2..891c21be6158 100644
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
2.53.0

