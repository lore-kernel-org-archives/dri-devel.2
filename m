Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967D606A31B
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U9KKr84y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pj6KnM/R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF0110E7F3;
	Sat, 24 Oct 2026 10:31:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52ACB10E7F3
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8oEG8098942
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=; b=U9KKr84y5PWzaPth
 kjI0kfOxaZWo/SSWkkmSBif1j5+1AIoDV30Zu3OSVHHGoom0l7Fa6N0Y3lpnK5Ka
 XNwxQTS6O1mMACKgLVxisNCiusOGw5DOvygKF/X6W0/NUYfuXwoFlmF4uChhaQ4b
 +tzIo8foHWTVgmDgppZl9SBWywS63F/7EQUhOd4sR8d5RLdg7p2hST9LwE8+P6LI
 XZmpTTVYfRtcFS6TOKTureE8JjD9otAW8Pj5Q3sRoa8+ESVhaIvLj9FyueP4wZM3
 mw8sl0tLD/YI9HZcbJK7hz9R7bKKgAEJd871hcRG+WsGbgNeRW0Go/f4krIF2+3d
 9+pQYQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27rpwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-151ba226e1bso3388889c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837864; x=1793442664;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=;
 b=Pj6KnM/R2sRZAJjGU2ppML6dXI6homwxRXjcAsVO3TMpKFHbqU3VLGZ6kQYNkQEDEr
 qYIxdjiHOAeaUqYIy8E4byJPEeXGGTLFJdkpxkrg68geEQtInpKEc6h6lAMYaQ0IvEdj
 FexX4+FQMrs8dkiI5doLronugXL9TcSU4/mgFXePJL3sNm4rNR+WNe0+pcrZyeSQfFeR
 1YVCKiEKXH42XqeWG866yeT0HtLF/ZyRnUDqOeqoHIH7ngGZL1yMyATeHraHAS88Y8XA
 ZwuPE7TpN+QschYM/ugpnYN1M+wrWdd4pWa309DEwYge91afM5u9SOgyxt+ye4Vgqxqp
 rUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837864; x=1793442664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=;
 b=r1vVi5IhJVsSEgrDf7/dbcoSG28vS0Ut11xniPosqnMhFTOInzt6B/GeKUY29tSCH6
 zB9HvyYUCq2zHSmpEfx8Ld7yiHlNSldhzbrQIDfOt22XuczZC6zaroW6Up424tfFYoE+
 a3ABx6QUJ88f2TSy9uj48cMa349bScZYm9fTatk4mdeaQAI3Jpbck/86/fgMw88hD+5k
 cvFgIhwjhFRrc+YzVqDjj0ZtLd2N25phPNasDkuSsKYhWhERvXVRLxpZbLZ7c0Y0/duA
 KuHgFysul8CywL79h/G75wcHX1eeL/MpGI1/vC5zw/XDZBd5F0rrd45UjXWd2n7PXRNy
 gLxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiNhjRscMdaZy+KLAvrYUYFlPO139kzpVR8CnC0gCzuC4uF2hl5VpdUIs9L9La9l48Pa6b5pAuUe8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLT0uY3kvccePU42AJhvdoeIYXEho+N9c+PUi3yYz+wMxNexOnk
 zv8+TOJoNx782mEGqIjSi+3iAvQSTaL5Icn66m31KrULBm1gtZcXLALDQGKwwm3hmRdCMOwRNL4
 uQYrIFG5w/HmrFLFr1l2ZgAB5Y+ISSRukFowkDFh7FyVL5+sXXTcetgUdsP9y8PbKS7rLUL8=
X-Gm-Gg: AYBFou35PlRUBWbkzWOdxR1lebRJyxf87p4QHv7nCY7KsKUJqonWMMLMB+BGdBJ26nQ
 rL38tFSGPy4xW/paH++lYvBkM0/eqH+foEPDqoNyhg5mLl89vPMZxAilAT9GxhUoUizdduOHQos
 bkrHtoYtHJ8GDpLpO32rOwHFnSLJ7PJHAfyEXosWuq1LX+FgMLhVS8JJTmH8WnQGV0NslDa/DHJ
 hRQLZ55g0NG0XNZxkodRjqYIeui6Slsn82U5MeDZkpcPjddEswZaG5gHI41y09SxL/wq8XX49Ro
 KazkPKUpfHn162UvBCBtTYitvi5leED93YQepiLRdx/BmDYImw9n9L+WLzOeR/leYsQFaZF7EbW
 +DARQWD+oMRWZSnvFyoBw9Us=
X-Received: by 2002:a05:7022:7f15:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-19937022745mr2295234c88.28.1792837863894; 
 Sat, 24 Oct 2026 03:31:03 -0700 (PDT)
X-Received: by 2002:a05:7022:7f15:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-19937022745mr2295193c88.28.1792837863277; 
 Sat, 24 Oct 2026 03:31:03 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:31:02 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:12 +0530
Subject: [PATCH 6/8] drm/msm/a6xx: Reset preemption records across suspend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-6-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=5843;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=SthhH9Xamlk9NrsaGpi/oND+ZDdZF2KSfjmw/AAnxHA=;
 b=PSx6InzKK71G+dn1jQzEco3V0sgJ1aEwgIYvi4eoohcktnzB3AQ9dM4n7vIeDINeVguDYQlsd
 JafN2HN+tzfCP6Pw/CC2380vywRtaur2MBRVHYIrz2j4ElbjZ5MUchF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adc88e9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ALv2hRvo4tV7SHe0QXEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: Fz04HNTnJ10YkI8VApblE3JT2m5qJ2LR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfXzP5r6QSa+usc
 1E1rR7s/pcF/s5e3s7EjbtgzQlnjhAemvg/37ZhYwMhfHlI9qdlilRPipRufIsExtKRxuN1KH56
 lqfsxgK5wK25EHPFD4f/WmkNVy2xZEk=
X-Proofpoint-GUID: Fz04HNTnJ10YkI8VApblE3JT2m5qJ2LR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX56KmNVkd1bHS
 mx3t0k0UTGwlrYux6DrIierP8qvsgWz13+wlc9mAQuC1jg7LXVQaaoIqXNSnSQ2KRfl/ekSLny+
 0GzqDxaGZ2cYBrd/lnIu7HZxXocwBV9ginD+niP+0yhD6wldtCjO37po2e0AHwD8ZGBoew6HYfC
 qXQxo3OP/WgHXo9si5GFPLb9aN3DXNviuKzbJnDsP8npj6aO80OZ2jr3h15R5587Whsuw+9NR52
 dbNttbkGpJTtYkIjjqjcsWMs5EOHpbbJmAJfS4VoHkIITggiO2JdcX6U+0gEpLWqljaWhkvwKFk
 KdLvaF/dHgktLc8FiNWkfKkXWGd/ovQ0lwIc8+O+APK8cBinu29SyI8S5uzThtNepKwS1tguwIn
 XxysWpqSoNnJvjbwSVzyZbmD129LbCQYwK8DPC5vIazJxThhwZUOwCUVuOvheqf+IogQ+0jkdr+
 BrTEaaCFDbvc+baDm8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240041
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The preemption records are initialised only once at probe time. On every
resume, a6xx_preempt_hw_init() and a8xx_preempt_hw_init() refresh only a
subset of the fields (rptr, wptr, rptr_addr, info, data, rbase). Whatever
else the CP wrote into the record before the GPU was power-collapsed
is left in place and gets consumed again by the CP on the next preemption,
now carrying stale context state.

To fix this, zero the whole preemption record on suspend and fully
initialise every field in the hw_init path.

Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 37 ++++++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 11 ++++++---
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 92e8c8abb86d..3e4afaa5345f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2248,6 +2248,7 @@ static int a6xx_gmu_pm_suspend(struct msm_gpu *gpu)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a6xx_gpu->shadow[i] = 0;
 
+	a6xx_preempt_record_reset(gpu);
 	gpu->suspend_count++;
 
 	return 0;
@@ -2287,6 +2288,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a6xx_gpu->shadow[i] = 0;
 
+	a6xx_preempt_record_reset(gpu);
 	gpu->suspend_count++;
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 79912a33e17c..62a19e22e230 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -305,6 +305,7 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu);
 void a6xx_preempt_trigger(struct msm_gpu *gpu);
 void a6xx_preempt_irq(struct msm_gpu *gpu);
 void a6xx_preempt_fini(struct msm_gpu *gpu);
+void a6xx_preempt_record_reset(struct msm_gpu *gpu);
 void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
 		struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *queue);
 int a6xx_preempt_submitqueue_setup(struct msm_gpu *gpu,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 1e599d4ddea1..df8d4f3e8d4c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -140,12 +140,17 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[i];
 
-		record_ptr->wptr = 0;
-		record_ptr->rptr = 0;
-		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
+		record_ptr->magic = A6XX_PREEMPT_RECORD_MAGIC;
 		record_ptr->info = 0;
+		record_ptr->errno = 0;
 		record_ptr->data = 0;
+		record_ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
+		record_ptr->rptr = 0;
+		record_ptr->wptr = 0;
+		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
 		record_ptr->rbase = gpu->rb[i]->iova;
+		record_ptr->counter = 0;
+		record_ptr->bv_rptr_addr = rbmemptr(gpu->rb[i], bv_rptr);
 	}
 
 	/* Write a 0 to signal that we aren't switching pagetables */
@@ -163,6 +168,19 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
 	a6xx_gpu->cur_ring = gpu->rb[0];
 }
 
+void a6xx_preempt_record_reset(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	int i;
+
+	if (gpu->nr_rings == 1)
+		return;
+
+	for (i = 0; i < gpu->nr_rings; i++)
+		memset(a6xx_gpu->preempt[i], 0, a6xx_gpu->preempt_bo[i]->size);
+}
+
 void a6xx_preempt_trigger(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -302,8 +320,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
 	a6xx_gpu->preempt_iova[ring->id] = iova;
 	a6xx_gpu->preempt[ring->id] = ptr;
 
-	struct a6xx_preempt_record *record_ptr = ptr;
-
 	ptr = msm_gem_kernel_new(gpu->dev,
 		PREEMPT_SMMU_INFO_SIZE,
 		MSM_BO_WC | MSM_BO_MAP_PRIV | MSM_BO_GPU_READONLY,
@@ -329,17 +345,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
 	smmu_info_ptr->asid = 0xdecafbad;
 	smmu_info_ptr->context_idr = 0;
 
-	/* Set up the defaults on the preemption record */
-	record_ptr->magic = A6XX_PREEMPT_RECORD_MAGIC;
-	record_ptr->info = 0;
-	record_ptr->data = 0;
-	record_ptr->rptr = 0;
-	record_ptr->wptr = 0;
-	record_ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
-	record_ptr->rbase = ring->iova;
-	record_ptr->counter = 0;
-	record_ptr->bv_rptr_addr = rbmemptr(ring, bv_rptr);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
index 6cb53a071801..0e0503ed54a1 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
@@ -121,12 +121,17 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[i];
 
-		record_ptr->wptr = 0;
-		record_ptr->rptr = 0;
-		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
+		record_ptr->magic = A6XX_PREEMPT_RECORD_MAGIC;
 		record_ptr->info = 0;
+		record_ptr->errno = 0;
 		record_ptr->data = 0;
+		record_ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
+		record_ptr->rptr = 0;
+		record_ptr->wptr = 0;
+		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
 		record_ptr->rbase = gpu->rb[i]->iova;
+		record_ptr->counter = 0;
+		record_ptr->bv_rptr_addr = rbmemptr(gpu->rb[i], bv_rptr);
 	}
 
 	/* Write a 0 to signal that we aren't switching pagetables */

-- 
2.55.0

