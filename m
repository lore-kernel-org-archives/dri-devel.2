Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59366606A33B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eGCn0gj0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqmU8vsO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A8B10E348;
	Thu,  5 Nov 2026 16:42:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE5310E347
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQDp8494275
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3IaRlviCKeo
 uJQry4aQ15OvLZ+XYaStkOWv8RGarB34=; b=eGCn0gj0BT2sklDqP0AGICY6I9z
 E98tMO64fHO0iUXq5EcTmSXXnB9yguIQTta2aZJJ9P1/vLzMrOnzjCNB8yfH5klU
 DPnMAEPHt1M79vM6pil79d3e6TTJgjpcsHnCBMQTxxKS7VgVDY+LWYNUjtbzHz8f
 YVLWkRT4LzmiLHJy8vbI4WY2SjaSCpN9A/dYCMBoj9mPD95/TZ2Y7MjzgBi8Cn3Q
 xHq0YnnxVrzHxdCL4Q80j6+jqlA/3R8a6qV7yNteWbn+rp1MORo3a1q2SBmRM0t0
 6uwjND10CRBSyMdtHSDCcUidpiMQIQuDQ1uWMyaX7NzbMJBIvw67pct89VA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhksqvh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1252496a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896929; x=1794501729;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3IaRlviCKeouJQry4aQ15OvLZ+XYaStkOWv8RGarB34=;
 b=hqmU8vsO2vLwsi/2OrgX3xYRWM54RbqgarZYx/jfwSK+PuHhJ+pParFI1JG7jaPieL
 FMi9uR4ZDOpSRCKt/mlBSz2EZrBCjOXAD46bUOc0xgGX/81oGoUodK+owhGQv9dRDedw
 Rk5t3lO5sdQNd9oKie3HeOn6fPWP4IUooVTJhb3oZynfasqKO7kPladl75tHU1PtbE/r
 efMils1WVEaXV4F7OvCWxdbF9SwK3yxhi9vF7DGo0HxDuMPdbSSyccPrrSjtJkhwqFoD
 GY8PAvLP20sJFmWUIVqeHAPx6RtXAyNfL9AmOf68c5I7j7BogiO243w7/gLFux9xv7hp
 vbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896929; x=1794501729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3IaRlviCKeouJQry4aQ15OvLZ+XYaStkOWv8RGarB34=;
 b=X5lWNTugjo9Xu+S1wUtzKkmhCXRzgLx8A8HwB8aLqapNwsVzdNqueL7PvLOdr6ESrh
 Izyvg2b9nhRKTKTtijFS2Kaplff3RwAtgdia314MZz/AZDh9D76tXr58zSXEAq3ut5mo
 MNvyp49Hhf+YCfCC4jFlF7Wv8bI0VMLDlg7RzrtgP/+7MZHs2heu51m/glCab2H0faKD
 ECcvaaHgDJi7kPAugQbs5hstCTh14zSU7IICp4qX3cYiFHixiIUWjeI2v6ITfD8ZqJfq
 cyCiTIr+Gco595egXQBAUjbKBYHL9RZ1tHbmuT4VUyu0ersjJQ7V0R2SKvACN1sDfOlU
 LGKA==
X-Gm-Message-State: APuU4Z+ekJ3fiJe6rpLWZ8IALIMXTlwO8GXxdNpmUcMzYRCRFtGU3RVW
 IvCcTQmQAOTqwC40uuebgG+mBu6xYiwtY2JIbJrUh89b/l2UGxXkxRN+zcHR3EUbC13n66CWDCn
 17+6rSDv0EbDWlGf0GifnApe6O1KMm6Mo6ZdPJHIDXPr1Csy4aEDIwiJ7tv4ZtQs+u7wbsONqzw
 EdTym61Q==
X-Gm-Gg: AYBFou0plAU12tugZKcCp8IsKQQmD2uw5XFL+dql1RvF/5hawiexfQdDF4m0tLXr8Nx
 uKsaEcKvL5L5O/faGMXnL6pnIHkj22ga70gdSrQqKqVZhHrHnjB05L7xyhOjNyFYVHgNm7wNG82
 /oUJJwT4LwSF0T1+ydaOxYx2MXGNKfoP6dxr5vQKn+sqAnIAi28lY5GUNOGw7rEmyulFXRAmuRc
 4NiOOKgJf+QqoL/IIPqzw1a6qht0xVzvKuFkkUxF8aZWLbAnMGBgJBpXC7sE06ixmDCADo4AEdP
 3ZnaKNyS5ZrobN/q7R2Oy08RB5VBskPpL++8r36zVMRBpEgJvhY/yirmwwBLzwF6VIOobKczqzV
 w7jupV2vc+fe4mEaEcT6M/1/t9uj0wVmQKBDXSJ3WFZRW0qha8fVd/5ghdR4TOxJ0jMr3NJdbRJ
 mMg7ZcoBled/9k1FUlIDC/RF9eay9z38QPvgzHZkZgLcBlRh8byq1s0wVoSIZ9
X-Received: by 2002:a17:90b:1b03:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ae89287394mr15579500a91.0.1793896928442; 
 Thu, 05 Nov 2026 08:42:08 -0800 (PST)
X-Received: by 2002:a17:90b:1b03:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ae89287394mr15579465a91.0.1793896927892; 
 Thu, 05 Nov 2026 08:42:07 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0993fb8a8sm4659683a91.4.2026.11.05.08.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:07 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/6] drm/msm: Rework IFPC disable
Date: Thu,  5 Nov 2026 08:41:50 -0800
Message-ID: <20261105164158.23263-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX+qz0wuoOmT39
 00RCJso0Rb5qxCtWEVo33Q+DE2aUMTSqY3svsJc3GW4vmCxTC46IHbMuGsawxRM3uz70M074kSY
 1oJtToCps2GLaC5GiEIsmpY9VyfzgZigLnzA8HyxP4uYzezS/hBfrQcD/S0bqm3LfbIEJJlzoy+
 xEzXGcPxOiTT0Pe41MLG8aARB1dRaoZhEEdajhZFyONWkgXK9Pmjst/B5kkk3QhGt5IQsad/96c
 YSTNw7yPZ+j9fQmsLTjaqvhrsFFx+MQMOSr1mheG5OA5x8BNeon9iQmBX715n65z7QXn5CpNTg3
 5BxjSNm+v+PiXZER60/6zvXydOUBfeby2MAV3YCUo26Iy/BmesK3FDqH9GjWYODwGJzpvUqX1ye
 JZZTSzx50QOpvw9ZE62KCf8qrhuWtNgjEiOOTQ3FU9d3cQcWh+FqVjhehf5xW+tIOiIHOIahJ5j
 ZALVfxQF1xnA5KdpOag==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX98lUCIuzNZ+s
 BUpvqMRM/2BwZYNIuH0PTEneX9wtDmEUyHeyvr1Usk9VtojO2AwIGf05FO6D0QMDLuWQELpamo1
 8WWc6AysDH7RAOPQGNdu7soU8SgbFr0=
X-Proofpoint-ORIG-GUID: mK5sktic5mtAmqnDapzjizvwb7Upk9Id
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aecb1e1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=EfYLDePoL0mgIiDTUNgA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: mK5sktic5mtAmqnDapzjizvwb7Upk9Id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050066
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

Previously this was coupled to SYSPROF level, which made sense at the
time.  But there are other places that we need to inhibit IFPC.  So
decouple it from the sysprof refcount.

Now it has it's own refcount, so multiple threads can vote to inhibit
IFPC safely.  The renamed gpu->ifpc_update() simply applies the new
state by setting or clearing an OOB request.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 27 ++++++++++--------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  9 ++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  3 ++-
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 30 ++++++++++++++++++++++++---
 drivers/gpu/drm/msm/msm_perfcntr.c    |  6 ++----
 drivers/gpu/drm/msm/msm_submitqueue.c | 19 ++++++++++++-----
 8 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 7096d7e45906..9098cb0b884e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1506,6 +1506,7 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 	return;
 
 force_off:
+	clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
 	a6xx_gmu_force_off(gmu);
 }
 
@@ -2145,31 +2146,25 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 
-	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
-	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
-		return;
+	/* Caller must hold a runpm ref: */
+	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev));
+	drm_WARN_ON_ONCE(gpu->dev, READ_ONCE(gpu->needs_hw_init));
 
-	mutex_lock(&gmu->lock);
+	guard(mutex)(&gmu->lock);
 
-	/*
-	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
-	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
-	 */
-	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	bool ifpc_disable = msm_gpu_no_ifpc(gpu);
+
+	if (ifpc_disable && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
 		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	} else if (!ifpc_disable && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
 		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	mutex_unlock(&gmu->lock);
-
-	pm_runtime_put(&gpu->pdev->dev);
+	}
 }
 
 static void a6xx_gmu_destroy(struct a6xx_gpu *a6xx_gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index cddce9b5b28e..28cb0ea7f149 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1565,7 +1565,8 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
-	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
+	/* re-apply IFPC-disable OOB request, if needed: */
+	if (!ret && msm_gpu_no_ifpc(gpu)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 		if (!ret)
 			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
@@ -2840,7 +2841,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2911,7 +2912,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2942,7 +2943,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 5cd817a259f6..ab4cb43e4a54 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -295,7 +295,7 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu);
 int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index f892731cd3d3..25ee3ac16ed6 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -849,7 +849,8 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
+	/* re-apply IFPC-disable OOB request, if needed: */
+	if (!ret && msm_gpu_no_ifpc(gpu)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 		if (!ret)
 			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 44e5da9d6ab9..d1cf8d87952f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -1012,6 +1012,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->nr_rings = nr_rings;
 
 	refcount_set(&gpu->sysprof_active, 1);
+	refcount_set(&gpu->ifpc_disable, 1);
 
 	mutex_init(&gpu->perfcntr_lock);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 799545c69093..d1abe0ef3d1d 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -93,7 +93,7 @@ struct msm_gpu_funcs {
 	 * for cmdstream that is buffered in this FIFO upstream of the CP fw.
 	 */
 	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
-	void (*sysprof_setup)(struct msm_gpu *gpu, bool force_on);
+	void (*ifpc_update)(struct msm_gpu *gpu);
 
 	/* Configure perfcntr SELect regs: */
 	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
@@ -186,6 +186,14 @@ struct msm_gpu {
 	 */
 	refcount_t sysprof_active;
 
+	/**
+	 * ifpc_disable:
+	 *
+	 * Count of votes to disable IFPC (1-based, values above 1 mean IFPC
+	 * is disabled).
+	 */
+	refcount_t ifpc_disable;
+
 	/**
 	 * lock:
 	 *
@@ -376,9 +384,25 @@ msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
 }
 
 static inline bool
-msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
+msm_gpu_no_ifpc(struct msm_gpu *gpu)
+{
+	return refcount_read(&gpu->ifpc_disable) > 1;
+}
+
+static inline void
+msm_gpu_disable_ifpc_get(struct msm_gpu *gpu)
+{
+	refcount_inc(&gpu->ifpc_disable);
+	if (gpu->funcs->ifpc_update)
+		gpu->funcs->ifpc_update(gpu);
+}
+
+static inline void
+msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
 {
-	return refcount_read(&gpu->sysprof_active) > 1;
+	refcount_dec(&gpu->ifpc_disable);
+	if (gpu->funcs->ifpc_update)
+		gpu->funcs->ifpc_update(gpu);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index 189be6cc23f1..b1b07212252a 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -267,8 +267,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, true);
+	msm_gpu_disable_ifpc_get(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -305,8 +304,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Re-enable IFPC: */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, false);
+	msm_gpu_disable_ifpc_put(gpu);
 
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 4d744604f436..cdfc7a6c6848 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -9,7 +9,6 @@
 
 int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sysprof)
 {
-	guard(pm_runtime_active)(&gpu->pdev->dev);
 	guard(rwsem_write)(&ctx->ctxlock);
 
 	/*
@@ -25,7 +24,14 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_get(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Disable zapping perfcntrs on context switch: */
 		refcount_inc(&gpu->sysprof_active);
+		/* Disable IFPC: */
+		scoped_guard (mutex, &gpu->lock) {
+			guard(pm_runtime_active)(&gpu->pdev->dev);
+			msm_gpu_hw_init(gpu);
+			msm_gpu_disable_ifpc_get(gpu);
+		}
 		fallthrough;
 	case 0:
 		break;
@@ -37,16 +43,19 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_put_autosuspend(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Drop our vote for inhibiting IFPC: */
+		scoped_guard (mutex, &gpu->lock) {
+			guard(pm_runtime_active)(&gpu->pdev->dev);
+			msm_gpu_hw_init(gpu);
+			msm_gpu_disable_ifpc_put(gpu);
+		}
+		/* Drop our vote for disabling perfcntr zapping: */
 		refcount_dec(&gpu->sysprof_active);
 		fallthrough;
 	case 0:
 		break;
 	}
 
-	/* Some gpu families require additional setup for sysprof */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, false);
-
 	ctx->sysprof = sysprof;
 
 	return 0;
-- 
2.56.0

