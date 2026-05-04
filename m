Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600F7FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA8610E83D;
	Mon,  4 May 2026 19:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaFmOxjs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSUA9gzj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0079010E831
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644I9l7m748927
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=k0Z25Ri0qsZ
 f4kdu4iu99TPanG49TW6penprmyqGHx0=; b=PaFmOxjsXBrkd/tQKSEVFdcgL1C
 yyaky2OyHEiB6aT8wjuO0n7hFAKM+MOmWiCuxMQwxiVJ+j12kKKf7amX+0aJQCCb
 UGcy91PzYaZyP7oeyFEIEsaWVwFUDtW8EK5uokOp0+KnHFdCVwGxu4V8zetA1tXt
 5ACrDsRZ6SaTg5C8ID5vZGu/ghIWmeGVOz6NqBC1oGpqu0JQlaPFkij8jQh1D4VD
 mqy0Oe1haBxSBJmxvADdDSIwNho5eZt26+548JeWKROPgui4AZ1mG44ef/VcoCyo
 RP2/GJbNt8c8mIErL4wwobLrJYY8mWNmmgRZSyvf/aE+GF/75y0qb44ZZhw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscf1xf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2ecc96a9aso44347975ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921731; x=1778526531;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0Z25Ri0qsZf4kdu4iu99TPanG49TW6penprmyqGHx0=;
 b=KSUA9gzjoRow6mlcOUREsdxvh4t4Qb8Y0tjEtvWJUF9HnUFG778Dw15oc67wpXARk3
 OKDUlmce2aQYlx79Zrqmswu6537UyvwA0F8oPvfheIW8VdmZtaLjfADs/DIaPB4AjTQN
 RS/borIlKX3gOx23hT03pfwjB7guBXTMuaJ0TsS5sKcpVT4abnTQKD8cUE5F1r7+KRmd
 Dp5jveUSyuAgsK+UfX4cBDRNMvrZ7BQlQZ2J76vn+D9CjyAiTjzbPkTYql/mJE04pzlD
 RhT2CgW2CWQbLQvW8OA/6evDw9Hlrcjy4hc0qyN2W68lHEMDBcUK59SRXXtzi07dM0zl
 G/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921731; x=1778526531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k0Z25Ri0qsZf4kdu4iu99TPanG49TW6penprmyqGHx0=;
 b=baiaDmQ353ih02n3qXmf6pvzdtt9sPj9CRSeGdi9asS13jV9ovSHnyYd9ziyw3hMWl
 pa5UYCpkBgYi0v6M0Unn1Cd9Szf+1DwCPIMoOWt3QgPYwR30PA/+XCq3X+hQLPC2ME8l
 nvnYZw1nwJvwkXpXwNZiDYO5YjxRAIwDhl3wrYJDZ0kWHkuABsujaqeONmdTgMJw1Ca7
 Uoacx/qziqqPx6xX8KxhWpEYCCckAH+Kft/P9hYwnGfYnhDu1+Ytl5xqtN+FBrWMM3TZ
 I2MSBdRF+X7BtVxDTAFUeNkfQ8A3qMcJLlPwdSznQ0hrsDbMjILnk+Wd9Bs1xlDmBXQF
 9jWw==
X-Gm-Message-State: AOJu0YwjRvkSmk03n5KM3EeNBFTHcTRkBCV2yfRjQ2i7Ugtkv1aq8kzA
 fkZI958UB0FMFpt1kM067QWiaJH0kCpYukNskw8lGa6COGaoWwwPis8ptuj42CVqS6vKO9uvIy3
 fBhLwfLAdlkstW+fcNT4G3699I6H2FJaoNMib2YdlVdY7KwbCOSFh9mdpDhKEJWf0HNiMHI1V37
 DlArI=
X-Gm-Gg: AeBDietJMEz+JZuXz5Jm+bh46UWoJ5nB80ILdPLtCVJbGAyoJHOI0EQuWBDBsuKJSj7
 VGBYtzEIyMTzilW9UjLj2eTK0RtMmLQ5l1+7Yo6JHBUUzvHjFpNdF7O9hgZ+FPqHUlFtHaBPis+
 /dtajSQy5YgUA3PmDdt4acNmX3dE2/HSBkHEhs3k/tqxayesej46XCUF8kCE4jTxfpP8vbb5/W1
 Xo4MUrBXLLyxCTWiZasWkTx5+8p/Q2FH8BzEjfPNZEh2HoZiNvO6vpiWOl99Gg5+w00onEigdEx
 rrP382t5xxarWjsyYwTwbuhE4h5qjESzuyho5Lxv8rMs+duZjjAtcUMHOs4Z5zF5xtmblcHucZU
 /mKs4WOHdNJfDUBS4vwN/xHgYbfWm+/Y9Nnvp++Y7CTM=
X-Received: by 2002:a05:6a20:4321:b0:39b:8b8b:39ce with SMTP id
 adf61e73a8af0-3aa3b75d1d7mr67077637.28.1777921730815; 
 Mon, 04 May 2026 12:08:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:4321:b0:39b:8b8b:39ce with SMTP id
 adf61e73a8af0-3aa3b75d1d7mr66994637.28.1777921729784; 
 Mon, 04 May 2026 12:08:49 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc8ee1csm10487520a12.25.2026.05.04.12.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:49 -0700 (PDT)
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
Subject: [PATCH v3 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Mon,  4 May 2026 12:06:59 -0700
Message-ID: <20260504190751.61052-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BcvoFLt2 c=1 sm=1 tr=0 ts=69f8eec4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=5obZvuzjGUYrwyXX1KsA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfXwTXP1DYafGa3
 eaesClYsD6F6q8MokyCRuHeQ5KXvMWAeL1oCocUKD/cvxlFV/3HHtEP2CQfVF1gZMf2C1hfX0hR
 1AyeaxdKOvvTEjChNKt/MBNyeD/mAzklK9fHCvpyQ8E3XtcLg5jmBLO/oovRlyqARIEwpgnBIJm
 plSHHjkF8DAzRWeZyye9ca/rqDHIgPyfSR4xokAB4JIumbkMy5/rlDSMCtQxCHHRlsViW6uh5ts
 g0kO1om0WOLnvtWKqxnOqly9x1TIb/9su6l4RT4HNilnbXCxjjduzwUzPeTGoTrtl5wjRkcM0le
 KS6XzYyUkiv038zQDV1iozT0DuxJdPYCXCVqAB+3Y3aiti+ATR7xwV3DEm30D6hD6Ufp9rW1Q/J
 uV3AmAwYg9+92LkDCozRWkY7U0ZWUlvw8trMZA5qRpROARn2/wLurYYz3LNgJplOiR2ewGfj95V
 K0xSgkSS+bTXcf6YPTQ==
X-Proofpoint-ORIG-GUID: 9fiBeNtJ6qvRsPyqaW7JfZykf6n7HHI6
X-Proofpoint-GUID: 9fiBeNtJ6qvRsPyqaW7JfZykf6n7HHI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040175
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
index 39bec201d5c9..d8ec65fa25f0 100644
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

