Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF3DCD5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F3610E6DC;
	Tue, 26 May 2026 14:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lR2QBVFT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R+67oO97";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C146A10E6D7
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsX8v1430475
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4tfvGKSXQFo
 neM9FUCAjiWpETYTjQZebXY53uh3TIBc=; b=lR2QBVFTuJDcg1Gk5hK/KIVB2Lv
 MlXfE60ZwTWK35agwGn1WlXjOryvE93L+Elp73s1hK1aXwpO5cR7r7q1js4T+PKY
 ApA0iVH57KTFbtPCG6BBMOEG0oCZbXRC+/frjIGmWzuYahgdfQqM9GSAoFhkzLdU
 4jqUXmg65ChwxRFZiMD3rWFk1xByJ48pzzxJoAp+CQXPZH4gcxkTqYDMjFRuhzOL
 DtblkCkCWsfx2dpSMqn7VDB6B+fg/FBtiFui1idB8rCEIB8c87ycGXtGMDezBQ/9
 TG4rvNjd0nza+RfqWdzE62VpRqS1KpBiuln5UfkjtrcD+82BTTeoH+G6onw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv5m3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba224c3ffdso3364615ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807251; x=1780412051;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tfvGKSXQFoneM9FUCAjiWpETYTjQZebXY53uh3TIBc=;
 b=R+67oO97Aci4G9UiltX7Nu0iOoNnPCjV57Tv7veVfrLYdRooUdCbeavm4LETuK7+3f
 1LxuByQrggNZCMx+l3SwEkWqfjFL1vjLqTgmXcHaptmodYLom0oxgwNVfmmGAGLhAYNp
 BbkDoXjmY5XMR3UnheQ0+xvri5IoFHUevEof+IqmYcZl1uOLDxSWwKdJIsnsoNGshrR/
 7JagEPxpHEg2MRkIeDXQzcsj7wEWm5STP/KE6eoX24gUwGZANLOK1eEc7irSibMwPz/M
 iHXtzpdYU9Sz0l6vqjWEebKK1NMjsOfdkO3XRbJNqdV5UZJNBfyZKkGGaE7txyVfbQ1h
 jO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807251; x=1780412051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4tfvGKSXQFoneM9FUCAjiWpETYTjQZebXY53uh3TIBc=;
 b=WyLc+B78HdHDOmKxZR3TGKj5p5G+ZJ5NoM8xJk05UWzwUbvPgTYqnc5nr+i1UVGTYm
 WHfm1C+buQq3/+9J2aT6SJRW8ddO9dtLyXap3K1+M3iZdIIAQMigcFzvbXO4Zo9Fkobo
 OXOqMmoGsb+5mMLv766RGsDDZut+vRiGPvKzapIVvISJTsoOkVNZVNQyj2aCj9zAJguP
 ioxt9pq4LRlIRfHVNKuAEfyfc3Q/4D3piC286G7J1XlydQlGiSlBU/+b+7+DeOCduAps
 EN2o8uhEha9eqMyDsKDKgkBvQZWdC68fvrM//k0cRXOQf4LZ2UWKysS8RBv9zDPX5GRj
 sVHQ==
X-Gm-Message-State: AOJu0YxZPOa2G2uiwxLnwNssgWHQOtD3P8xUut1bIvCFtEvrWr65dIR0
 Jlgia+TTlg8qjuB+pcXSnk02bTci3UYcTuk6gyPMCSyjgBrqFpsHBfU/4DaX4/STL3AWqK9x5eW
 ZE+GrB/Xw7so2sVyCq55D4xRyljmTLE20CxE5x6RzbjEqKRzwxobxO06I5g2HTNhFxB0YB2BDl3
 z1aLc=
X-Gm-Gg: Acq92OEGwxvlyVl4qFasBlF+mGe5FA6HaSc5Fj7IR4ZkOJxd5PzWkxTOXDPJfQw2g4q
 xruEtnxQ7rAaJYPcTlyTYKGc3RnIM54p0WVEyw2mkSo6ANEre3aciKpEBvgunf6BYSznUBATpkf
 uHN4M/dpHdFZSGsu4/qISqi4fqd+AU519e4wxq2AE+J7H6pJcQrgevEBW+DTgwZHmcFLJmZt6c3
 FPWUpvs7w+W/yP0Md8YIC4oJQ6mZU0QZA16i90lc0awnutKiBo2UesOA7uapscElF3+9Ik5/w7c
 C5JtHCFrvyl0wdccu+/yn+jyCbjqJOuv+6WiFR2PYCIrunmzNoZOc3lq5rDI5SfwEgSH3XkzVMX
 fTL1gk4+lJuzIUWgOcfBLTKl+0fBAfrNS
X-Received: by 2002:a05:6a20:ae24:b0:3a2:f05a:793f with SMTP id
 adf61e73a8af0-3b328fdf6e3mr20955839637.51.1779807251437; 
 Tue, 26 May 2026 07:54:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:ae24:b0:3a2:f05a:793f with SMTP id
 adf61e73a8af0-3b328fdf6e3mr20955796637.51.1779807250963; 
 Tue, 26 May 2026 07:54:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202b91c6sm10470880a12.14.2026.05.26.07.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:10 -0700 (PDT)
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
Subject: [PATCH v10 07/16] drm/msm: Add sysprof accessors
Date: Tue, 26 May 2026 07:50:41 -0700
Message-ID: <20260526145137.160554-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX5wQh66iKXCSc
 /zph7AgtHw8lfKaiuvYWOwmhbIGzzBeiaLV63d4nSiVcXME4fNM+k06Y6ZYyyE0A96mxEtejUB2
 Ss9S6YiJ60tNwRiOxMM2TmlnJNJ0pFIoF015rDCWnBtDCPJQhJd4wl16p0NZctLmsKeapPA2EWj
 BKx93U1duMfwdGhnCmi1RMwgsTsW6uuEEvuiXgsGyV1XKh5aaoOq21uUw37JjjfNDkVFxVr8tv7
 lBNUkObmValVmgG4Up+AbvlYNPRymlIW2iYF6OGPKL/QlDZ4OtC/3GhNe9wMJNJ7T0XP0hDXEmu
 i4BrSaxPixPsB9pQSzDCMl3b/tVGvGLTWkYq2lFRLXZmvTh7j1DdGV8GD7YBWkuJZ3ROV8s3Wl9
 nJ3wxY/uUkBrM6JOjPaJSVS8ZkKWNLx5y3D2zmyOyrusMWjak+ZlJ4lxItVv8oizlC1fuECh99f
 LMPpTTORDuA1JFcD7ZA==
X-Proofpoint-GUID: h6XoFEhlefkp_L1Q5eFhF3GEsvG1DcRU
X-Proofpoint-ORIG-GUID: h6XoFEhlefkp_L1Q5eFhF3GEsvG1DcRU
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a15b414 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=v4b4B-quZFKF0PxyZCUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260127
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

Currently the sysprof param serves two functions, (a) disabling perfcntr
clearing on context switch/preemption, and (b) disabling IFPC.  In the
future, with kernel side global perfcntr collection/stream, the decision
about disabling IFPC will change.

To prepare for this, split out two helpers/accessors for the two
different cases.  For now, they are the same thing, but this will
change.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |  8 +++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  5 +++--
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h             | 18 ++++++++++++++++++
 6 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..aba08fb76249 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2036,10 +2036,10 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 
 void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
 {
+	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu);
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
-	unsigned int sysprof_active;
 
 	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
 	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
@@ -2047,15 +2047,13 @@ void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
 
 	mutex_lock(&gmu->lock);
 
-	sysprof_active = refcount_read(&gpu->sysprof_active);
-
 	/*
 	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
 	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
 	 */
-	if ((sysprof_active > 1) && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-	else if ((sysprof_active == 1) && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 
 	mutex_unlock(&gmu->lock);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 727281fbef36..71f54ab5425d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -203,7 +203,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		struct msm_ringbuffer *ring, struct msm_gem_submit *submit)
 {
-	bool sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+	bool sysprof = msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
 	struct msm_context *ctx = submit->queue->ctx;
 	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -1608,7 +1608,7 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
-	if (!ret && (refcount_read(&gpu->sysprof_active) > 1)) {
+	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 		if (!ret)
 			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
@@ -2854,6 +2854,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
+		.sysprof_setup = a6xx_gmu_sysprof_setup,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index df4cbf42e9a4..1e599d4ddea1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -261,7 +261,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	mod_timer(&a6xx_gpu->preempt_timer, jiffies + msecs_to_jiffies(10000));
 
 	/* Enable or disable postamble as needed */
-	sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+	sysprof = msm_gpu_sysprof_no_perfcntr_zap(gpu);
 
 	if (!sysprof && !a6xx_gpu->postamble_enabled)
 		preempt_prepare_postamble(a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index ccfccc45133f..e022c9a162a4 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -849,7 +849,7 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-	if (!ret && (refcount_read(&gpu->sysprof_active) > 1)) {
+	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 		if (!ret)
 			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
index 3d8c33ba722e..6cb53a071801 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
@@ -242,7 +242,7 @@ void a8xx_preempt_trigger(struct msm_gpu *gpu)
 	mod_timer(&a6xx_gpu->preempt_timer, jiffies + msecs_to_jiffies(10000));
 
 	/* Enable or disable postamble as needed */
-	sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+	sysprof = msm_gpu_sysprof_no_perfcntr_zap(gpu);
 
 	if (!sysprof && !a6xx_gpu->postamble_enabled)
 		preempt_prepare_postamble(a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 8c08dc065372..9e5c753437c2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -311,6 +311,24 @@ static inline bool msm_gpu_active(struct msm_gpu *gpu)
 	return false;
 }
 
+static inline bool
+msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
+{
+	return refcount_read(&gpu->sysprof_active) > 1;
+}
+
+static inline bool
+msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
+{
+	/*
+	 * For now, this is the same condition as disabling perfcntr clears
+	 * on context switch.  But once kernel perfcntr IFPC support is in
+	 * place, we will only need to disable IFPC for legacy userspace
+	 * setting SYSPROF param.
+	 */
+	return msm_gpu_sysprof_no_perfcntr_zap(gpu);
+}
+
 /*
  * The number of priority levels provided by drm gpu scheduler.  The
  * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
-- 
2.54.0

