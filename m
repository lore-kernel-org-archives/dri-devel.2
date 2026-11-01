Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195E606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N0NH3RNu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ajGMhZAP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F89910E3E9;
	Sun,  1 Nov 2026 17:47:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5849710E1B1
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:46:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HRjHB381180
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ykBFnu34zbE
 fS7RDMlFrrKA/aG0eK8eZnKjyWXnokT0=; b=N0NH3RNul24a0gAhuaTrH4+V1QC
 SdhwZYDK+DEWjo8T71V9f4WXNRsAY+3GZk/OyuOwj2aBmaSU39Vdt615e7BhSwpU
 88HHJkcD7pmzUssSNYqN92yMII9xzfWj9M5BB5FqKskb6vPLcAK2b2878QObITQd
 PiSMO/fwA94KvQUsE1ahO4An+8f2K7Ep8Vdv0lEIprVezDzav6396/Q0zmEEehcc
 go0T+6IyUAMpJuvyeV83Whkm7qPsJ3xtU/evpEkbtT7Lw8CDS9V2CR2QGwqsZvb3
 jI/4sxMngEBhnF5l5i1+m70JYFtuBbLONUn1qMePU+WdGbRVpid8RCjJ+mw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7utwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:46:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso1376821a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555214; x=1794160014;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ykBFnu34zbEfS7RDMlFrrKA/aG0eK8eZnKjyWXnokT0=;
 b=ajGMhZAP2/2wIrJhqkbcHIZyUGuvRtXzxgUenfssilZRetoXu1W9uqRfVQbqyC7V67
 vlmh1Z31+zThq6oVkkZuNkXzt8NncQXfCtyS9azICyYTty6r2zoXwQdLfcj780/pAJrS
 qfqVkUiKLOw599vPFaICmLrLxDGvUHcOubPG/dxiUUh5x5Gkj1wpNaMUy/HZE08m+9x3
 m1+IR+NjDNxjv7WD2Po86OpVKb/LsdwMM2kBrgmN3WTJrW36jYafeZc941/3cko/Bkgv
 zFSOz7VKBLukx934VRTfHwTx7D2CmyZfMXPhLuh0+F6lnXOIRUCkZHgh6L+tgUo+N+b4
 o/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555214; x=1794160014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ykBFnu34zbEfS7RDMlFrrKA/aG0eK8eZnKjyWXnokT0=;
 b=T9IMdIYHtHQiXAHc3Ui5i0ZJkXphOWRRTzjTrhVmZHxqkoFtjCPLq7z+qO9/mGa8xA
 oaoxgrpkq0f5EMaxCFr3zujmP5rjdoKi37xgop4dV4W0rD5VBPFOGegudNO52UbHZUU9
 a87CcVdxg1N/AkDYfQO+FirGxjz9vuHPS8zDyqc1PgeoQLzhFAB+tMRJilQhXE3qGV93
 MP5rMt3MqwVGV1GyEFPUCz+WgjAXT/itA+jJSyBaP5qnwwYBCLLuW1omrN1n+JKKniK9
 LZ+u0wr8uN9cJV0iX9VpY+5q0c1p0ezyae9kWrona4qoNUzUUpz0dUPVMJ7XRW4rucVe
 +zwQ==
X-Gm-Message-State: APuU4Z8/rR1DDQOc1ihPaUXsrpWlFz6+8yomlbe/ozlQeA2W1l915A4B
 5z91oLGOUWFKHkw9CeCJQaYOFCcrL50RFy9b2A1dNcoXl7j0Ni1TnpQUv41eU7mQEZdyIvlUFiH
 pRJ8xuL4kfWMjWVlTykdKcDk6cCUTMJyFwfBRMSxoXEuzgwkm7i0epdoblcbuIETSiCkHG9FBLm
 5uquai5Q==
X-Gm-Gg: AYBFou0nBdUVzSBRYnvnKxcTDSOlkEVXbI0x1s7Inei3qnuT2QHk2C55Hyha2ENKABe
 evkpyRvAmZfia5+4JJPUBDfjU8by8QdQ592RwtIa/T9/GygS+ln83azUdlIF8uI0MDtGVA21oMw
 tczDc0Bwpu9wnWRwrF2j+AP6E/LykNG45qKIhpfkccg1L9TnXA31O1Aa+78FSzK+wI1FIdoPvTK
 P7rcwwGo9IwuNUZdjrXmabgw239u1uapNo9l9I+5hMtn+aephKDUGCH03AgvJMtGpI2R35B38ex
 WrnaHLZ9xU/CaQ607opjqTNC1aWJou/NnAmgEV1gPeqKVSecBAh3HJmij3aEronQhr/rnVHL01F
 xOROXCS4bOl0cM/Md3ThZAR6XpLyMU4d3/wx05jFoDVMyq2aHgbEh1mWGpUJed49lqTKlmtLR2k
 nd4kuaDYct+ZFEMgKqroxDDQ==
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id
 98e67ed59e1d1-3ae897c777fmr6103961a91.46.1793555213560; 
 Sun, 01 Nov 2026 09:46:53 -0800 (PST)
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id
 98e67ed59e1d1-3ae897c777fmr6103946a91.46.1793555213020; 
 Sun, 01 Nov 2026 09:46:53 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3aebaac28c9sm2045136a91.15.2026.11.01.09.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:46:52 -0800 (PST)
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
Subject: [PATCH 1/4] drm/msm: Rework IFPC disable
Date: Sun,  1 Nov 2026 09:46:25 -0800
Message-ID: <20261101174631.23637-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JHk_HoHSJ-fvrTYWX1c5ziw0ATU7n04i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX9BkheCf3Ri68
 yGW3f5pWBh9k4CslJNwKyhZru87KONEE1m0RAUPA29skNggRLwlnaiIdN8pLHUS9/ciylMTUcN/
 S8EGVm6D6rMLL+zfikK76ccTfO63mTw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX+o1hFIQ0KayD
 WcJo90IRvgNhkYDGefaq/Rrz7+PhX87YMOrzRhXMeYoIz85kvUyEQ/G3wXKnmuM21la+kjSIzHj
 wILHNOaW+m8pH0fWBdOBhPi/z6ftdsykBvDvTEPpHxYUv1PAwMvWX+FEubbz+3a1dpEl/uL8CPw
 7/KttTVKzzRpxSRCupYbpTUM/jdCPpPFDq8Q3lLKevDoDmHXlGUDj47LvmlGv8iGdo6DzmHuRQh
 ts/zDkyykrLYR3RIrlMKDpp/M8iDjnLU7lLvt4gxXBW3f1LE5M4r//WLDsavgtIJpdI4n9M8/ML
 lC/+VVux2T1bW9++MwftsHRYXL2CEKrwSLjBrYesh9UiEQK36kIRXZI1VxqpUFczCYauZrp2bvx
 LLbiQ8yhOyxZazGypZCIhf0InEnxrLqFlTRaOZwako5cRTPKPH9Kk1gSlr50+LbVTsvnGyatdDw
 tVIFBd9nJwOcazw25lQ==
X-Proofpoint-GUID: JHk_HoHSJ-fvrTYWX1c5ziw0ATU7n04i
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae77b0e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=sgg8FroAFpLa0IqUokEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010070
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
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  8 ++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 26 ++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  6 ++----
 drivers/gpu/drm/msm/msm_submitqueue.c | 10 ++++++----
 7 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..d1fe6c40da83 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2128,12 +2128,12 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	bool force_on = refcount_read(&gpu->ifpc_disable) > 1;
 
 	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
 	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
@@ -2145,9 +2145,9 @@ void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
 	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
 	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
 	 */
-	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 
 	mutex_unlock(&gmu->lock);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 74064eba98c7..3de6892d1b9c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1565,11 +1565,7 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
-	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
-		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
-	}
+	a6xx_gmu_ifpc_update(gpu);
 
 	return ret;
 }
@@ -2851,7 +2847,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2922,7 +2918,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2960,7 +2956,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 36717b511316..077b5cb60896 100644
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
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fb07803f5aba..37f9e93daa43 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -1012,6 +1012,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
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
index d307cdd17d90..8434a09319bc 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -24,7 +24,10 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_get_sync(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Disable zapping perfcntrs on context switch: */
 		refcount_inc(&gpu->sysprof_active);
+		/* Disable IFPC: */
+		msm_gpu_disable_ifpc_get(gpu);
 		fallthrough;
 	case 0:
 		break;
@@ -36,16 +39,15 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_put_autosuspend(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Drop our vote for inhibiting IFPC: */
+		msm_gpu_disable_ifpc_put(gpu);
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

