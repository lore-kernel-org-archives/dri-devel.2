Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43259606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XGIUxLqe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OtJB7jCS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863D810F946;
	Tue,  3 Nov 2026 23:19:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2DC10F93B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:19:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKjIp2395429
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dll+M/H3iQD
 7KOEN8AqTqNktTQiz8H9I7kmdB5ZKl/4=; b=XGIUxLqe0IzNl53qsfxlRzyB1eS
 TnKCJanrJ2jE7BD+14T3y0J5reuEC/4M5H+EDvTRnmsQOs05iSYDU2Hr+8A8ZlwW
 z1uSBRVPf5OD7CaOi87Se1Uqdd1bZoJJ9jC04rCOiQWmeFi/OfdVPpGAFMlepe8c
 JpKkxWV720ezj2ke6btTnM4B9pfBQljSmqTKAHsB9QF6Mgw03uZp1R2AzYWfIVDh
 yTw01MgEmgJuQsUVaP03S7qXuaF+JIQmjoT+3Y4MyY2SRzb9/5u5IzlFKZMeFDRp
 XK9UvmLPBrb/7KZ54TBsmNK1vat1ncpZ2Z9wOf9Cg5zn98P6ii/A5+FK5Ew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhyd1vmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:19:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-89e96c03cd0so165516b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747941; x=1794352741;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dll+M/H3iQD7KOEN8AqTqNktTQiz8H9I7kmdB5ZKl/4=;
 b=OtJB7jCSL8DqodRiwT1MsyEyAnETS/5n623gMDtKmFfAL6T7iwnQPC1dyBGx13V98X
 bsaj8upr378SApxQdT0LKWkZPkyT5EQR6kmhHlhAK1ppG70nCwrBMqZr1LXrk6xBGA+P
 z75JlIRCOH5ASBr2AqIDawPmlO4gvc3CSO1V6TAT3xhM49ubXOuSvAaSi3zKmOb8p3fe
 DIzAm60uvIw14oyD5kWRERR6zYOuzlmTkqi9HkJPH5veAaUwXi7Yucb+zWrQF3o+f19R
 oRHJK/mT+ywKdu89yg6R/l4Zdr/zzX21Ry/GlQHzoW6a6A3VI3MgHtH1DsuRCUKDvzM4
 7ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747941; x=1794352741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dll+M/H3iQD7KOEN8AqTqNktTQiz8H9I7kmdB5ZKl/4=;
 b=yXP4BE+goj23fIOMaHVmPkjBpxl5NYqpK6F3qwEDVGTiIry/q6p38ovPrZbae9A3A9
 R18djuiJetM7Ipv2a8b01mnxHtoNAhh/tqF1xuk42Dxwuzn44KrvMroSLs/wvqvI1ICF
 oofDCZ2j6H8yp2wVguMxsARwQny8CxqbEgn+t5RvGocdYPaEq4PMulyPX0ZyTEGE0th1
 Liyy4ow43EdrjU5W5SxGmgerFE1a/XrN9Y5y/gvYJzrFZYdU/Ltxy7TysuwpoGzMUvEL
 K46XdvCD8r9m8dE7Iqj0vCsuJMHyHIhmalfeaIm9vLR/Y/etcDie2JdPR6q9I20Np9xB
 6c6g==
X-Gm-Message-State: APuU4Z+mDqzqq3wLsKyoWH0lEawR0Yk3xvvLITv9WR8KXPgeyP8irIYd
 QRURxhHk3SX6Lvnhqvu7grKV6fTLt0O55L+NvBR4+J7/cFapY2FN5srpV2ev+SAc2+/jnZFxhOn
 pgt+KD6W+0YAbI6wWe6tQ3LtnSATEd2iHvxJf0xVIlEDJDmi/HqH4tVMHEtzKSMnpTWQcrKibZU
 SARBpSZw==
X-Gm-Gg: AYBFou1lL6gRbDVwfEKuPfDCBFIr+TcV+tB/XBtfk/X4DrQLiN4rIF1+b/9i25dY/Zr
 Do7HGcV4rcw6XLALQbqsf7W5JjEH023Ikit8BkUjIfEOiLam9MDahY1LSj3jpn22CThX58WuGpe
 gb7JfIbYYoAMygR9FOMIOYFdMFXxqYD37/d3ME5HND6ZK2P9KgifIwjW2MUwNKllCX6eovgeop6
 qhQdLKx4kpw6STuRpQ/MtBLRlRj/JJUhRyNCcaktMnYOehjSAVgCnYpnhO5AFQvm+qyuRCArPbc
 gGdB+U9gMvx0UQLbzHBVqEQXEEjGlVjkT9j5xYd2ZAIwsm2NTftk5rqBXdg08I5ag9oW0U1OTTX
 yBAHAuuaErew1XB/Uy657Fd+hTBNzTENSHsqlPzK2zduKw7KA34yzwymVwockPpYYOQel/2y1PX
 wlhlHDKs+bjhtMc2p6zfk5sMwZMu41HNoc4tbkWF4d7+rh4UdXai9LNypz+A==
X-Received: by 2002:a05:6a00:9512:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-8a9ba902187mr11080466b3a.6.1793747941399; 
 Tue, 03 Nov 2026 15:19:01 -0800 (PST)
X-Received: by 2002:a05:6a00:9512:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-8a9ba902187mr11080451b3a.6.1793747940945; 
 Tue, 03 Nov 2026 15:19:00 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09b569444sm155154b3a.36.2026.11.03.15.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:19:00 -0800 (PST)
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
Subject: [PATCH v4 3/6] drm/msm: Rework IFPC disable
Date: Tue,  3 Nov 2026 15:18:42 -0800
Message-ID: <20261103231850.17493-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bp/Zl0ai c=1 sm=1 tr=0 ts=6aea6be6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=0FW7IQkLa0pm2cqxDqMA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ZIeN81RU9BIsMYT_NtAwnzGw49rQt0Wk
X-Proofpoint-ORIG-GUID: ZIeN81RU9BIsMYT_NtAwnzGw49rQt0Wk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX7QqBWuwZE+Bg
 hiyLpY4zwWm2fKoegcKcK6QhMsJiPLN8etHzrh+JTEORJLCi07MWS4HT0uiPRX8ZKI+BQBicXj0
 7BAhAl1gy9tIT3sFW3FFvCgXd2tY+pY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfXxIXEQqsBKvbX
 hno05EPYWNVPFwMvVZWaLDVxgwxtKDxzGHxAQpqfYXuRqpvqTuczgjl8PLhJDJ5agl6CXp0dl1S
 07msB7VRdPE/ETW67NB6bvk+9JL2/LLzSElBtDz37dnD/JL0XBDgTBb7a1NzqSrk94SmT0qJilz
 alD9+G59kYLFtxqeyYvUt06SjXlP5sKAWGlG9Y2GhGPF2z+4qhpe9GlXN80j4Lvu6xbjCxlPTpE
 CnuRc9JpWBhKPjSppcum8vRwLjJAaEtOxfvmdRqlmPkZNXrurfSu61GotFWJJpyvVD1q/+toiq3
 hmuNDjNfO9Svs5wXV96Wpq4guKSkQdRxHdQYszb4R7QW/r3YpQxDCUwA1KQNIrfIoMukOeWrAZc
 Z8+YN20xGEtXTHfPHYOjKKL1gLadajGlbDQTtu5eyrOplgRlUZ2zSto2mad1cns3LVJbAQx27yg
 SEUB3zsgmm7/hsN+HeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030092
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
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 28 +++++++++++----------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 11 +++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  5 ++---
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 26 +++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  6 ++----
 drivers/gpu/drm/msm/msm_submitqueue.c | 16 +++++++++++----
 8 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..b02bcaa4bd96 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1443,7 +1443,7 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 	}
 
-	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	if (test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 
 	ret = a6xx_gmu_wait_for_idle(gmu);
@@ -2128,31 +2128,25 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
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
+	bool ifpc_disable = refcount_read(&gpu->ifpc_disable) > 1;
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
 
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 09d76cdf059f..2a4f81d14400 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1565,10 +1565,9 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
-	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
+	/* re-apply IFPC-disable OOB request, if needed: */
+	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
 	}
 
 	return ret;
@@ -2851,7 +2850,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2922,7 +2921,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2953,7 +2952,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 81d21acccea1..cdb830b7b778 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -298,7 +298,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e7d04c865968..ba8306e9eb44 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -846,10 +846,9 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
+	/* re-apply IFPC-disable OOB request, if needed: */
+	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index ca21b3bf20df..07b7bd8d2329 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -1014,6 +1014,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->nr_rings = nr_rings;
 
 	refcount_set(&gpu->sysprof_active, 1);
+	refcount_set(&gpu->ifpc_disable, 1);
 
 	mutex_init(&gpu->perfcntr_lock);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..0334a0f604ac 100644
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
@@ -375,10 +383,20 @@ msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
 		(gpu->perfcntrs && READ_ONCE(gpu->perfcntrs->stream));
 }
 
-static inline bool
-msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
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
index ce65b1160955..867dd476ed88 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -259,8 +259,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, true);
+	msm_gpu_disable_ifpc_get(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -297,8 +296,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Re-enable IFPC: */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, false);
+	msm_gpu_disable_ifpc_put(gpu);
 
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index e3e7c401fa5c..d41756c0152b 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -25,7 +25,13 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_get(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Disable zapping perfcntrs on context switch: */
 		refcount_inc(&gpu->sysprof_active);
+		/* Disable IFPC: */
+		scoped_guard (mutex, &gpu->lock) {
+			msm_gpu_hw_init(gpu);
+			msm_gpu_disable_ifpc_get(gpu);
+		}
 		fallthrough;
 	case 0:
 		break;
@@ -37,16 +43,18 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_put_autosuspend(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Drop our vote for inhibiting IFPC: */
+		scoped_guard (mutex, &gpu->lock) {
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

