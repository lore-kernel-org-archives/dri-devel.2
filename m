Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E0606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UCPspQq9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTzMbLwY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DDC10F180;
	Mon,  2 Nov 2026 19:05:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37BD10F1A2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:05:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HP0ct1382329
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 19:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=M0wsEcVQYSm
 G7vhv4bdYrWC/tv1Ytps5T8yIjzxkQEE=; b=UCPspQq9WRGf+6LSuAw2WP7GfYf
 CQy1YdX+2lSlPmHrsI1KeqfbInirubaJch5PH7IF4KCHhCC777rC8wyN9w/ABtK1
 UWDmej5qB/flXb8GyI61F85H6wKx3lQWI5j/kVqWkvc2Ca93kYSp0m4iEsSQIO0i
 EgI8J3yWHHnQPDWH3ybbNqFIHE3N6yJA2L4rigU2EHRk2hk6CL6ZAyMN2IGeIZ9w
 xqWGv6qDEtqNb+HX4whp/JQC+1yKNr9J+lv7T6sjDVfcXSdQAhL+xGqDQAEN3we6
 RigvNMKBIEM98ASaojojGaeyEZ7jj7j1TaxvdWYZKWGONLq8lBPA/qOsh3w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvtf7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 19:05:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso2631608a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793646017; x=1794250817;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M0wsEcVQYSmG7vhv4bdYrWC/tv1Ytps5T8yIjzxkQEE=;
 b=ZTzMbLwY2PoWs0v0yR964dx+qX3mjV9VpjyosXsakpTm6oIXzBsqyEuVlorRG1rdNt
 e02d5qUx5CsWRgfLyqBHD1X/+bb2d1Py2hO+HPacls4u8UG0dZcgqCJARTFBlRhniYjO
 3mcrJvOaAa86HVzrROJemtcZJaWNzIVnWp0J+9SRzxRQT+V0FNnQimY33R+qn0CLyn8L
 jyhssX9sC9YNWFBgaO+1YzdzEwbE9nbZviDSNABo2tTBcKT7dsqPabb8nQrZyHKN1rfO
 7Yl2TTEv4wXOCc9Oij6ayOe/1jVhcByds1jWYAfEqN113spdlAPOSV7T9AeWVfh/OSw+
 h0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793646017; x=1794250817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M0wsEcVQYSmG7vhv4bdYrWC/tv1Ytps5T8yIjzxkQEE=;
 b=TNpD7CSLPXQZ/2OgnO08y4tTm+xoRXONkLw23gQBhR6ek/rCAfYKdc1JMmZJx+4yUZ
 escAdnCdxIRT1kZ89lLmKnyShh9fQhdcAuADsdy94af7xFqBJkJ6UHdQNtdyFDkD21Xc
 JOQfir0oZ1fGSMUQufAcwxs7l8zpUX1TPB0dn4CRR7was0Ebw2FdMd1kP+Bzj1vAptpp
 igV68nruUepM+gCU6Gumz2ZQjiGckjwFL2QwSaXwoZp3GmQNufYl344d+d0rX136Z9hb
 s6uPXOncLQWgeew7Y2BcYu8/9O/lygH2/34NJqh27yPMFTs4kuQZ12g40k6uE9fsHqEh
 NSlw==
X-Gm-Message-State: APuU4Z+84MdhXsSkJkFA+bNHWUSahFcwdDxspDaIW45QT+GjuweK1IPq
 QjiDMnodDXJguxLSv+ZXxyS/y1qb/rwKPuJbV2fjMiW4fH3Jgjjyxxcl/MQydtxbn6NEE4a3113
 1H8feURnR6QsILE2ynIpMYsbZKvg2gyIX/R+W2FTQRQOhvlLYdDPjtg2QmrTowoPQTSzrQJNh3Y
 lGZQksiw==
X-Gm-Gg: AYBFou33gYdP3AZ5x7EvmXEwbhSdvtzUi3IvZBVWedqb38CNt6vvOHWZ0flk8AZbSJL
 VS6un2vgtgKgQ4aNl6BjJJ59aXqEY0shF4o6IhSKuIXvZ57zxNeONE/s5BXhLj9KbenEUcQEAzp
 PBzwk622MX/tq6Dt6hjSX53+JmSsq+s+6hA/q1otYWt/sTZGZanZ1wqwcoDyA7Swf+MMqtwQRS2
 MpJyhWmgmXbkHkg2TmySEmcJPbdxbsAIOViTmvn8tCf6VsLmJunjSzEm6ZeEbps8NdaqkH8wVv/
 FR0c9i4o3Ay/Zz4z8l3j4xx5zpsm6OW1m/gzYJcBdY9/52ATqN9oxraDNCTjxD9yCelmAeQfDvg
 2fn22X7YqsgkGU2Y/eKdHY+DxvXMs2OkGckfdmFMMATLz1+iqS0UBJM2wa/s4C0XqrcrDuWe6LC
 FpZlCAZCwpVtOc7QNZjf9qtQ==
X-Received: by 2002:a17:90b:5686:b0:3a4:9a7a:360 with SMTP id
 98e67ed59e1d1-3ae897f6e7cmr9056101a91.29.1793646016027; 
 Mon, 02 Nov 2026 11:00:16 -0800 (PST)
X-Received: by 2002:a17:90b:5686:b0:3a4:9a7a:360 with SMTP id
 98e67ed59e1d1-3ae897f6e7cmr9056056a91.29.1793646015304; 
 Mon, 02 Nov 2026 11:00:15 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c6c4259sm446437a91.14.2026.11.02.11.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:00:14 -0800 (PST)
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
Subject: [PATCH v2 1/4] drm/msm: Rework IFPC disable
Date: Mon,  2 Nov 2026 11:00:04 -0800
Message-ID: <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae8defb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=kBZMXW1S6ahmPhhohEcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: VRU-ZWc43eRx38RPydE2omBImIf5adTz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3NiBTYWx0ZWRfXw0R07O3dJK5v
 1XKexpj9v2d+C3Kuc66KQBYZ4YaeU+RzNdWIF0YEwgustaEk7nMGbU6QeKi4sSO3F25zOnFTKI4
 FloeTRgckCxz5uBZlYfgpeRn7F8+8XE=
X-Proofpoint-ORIG-GUID: VRU-ZWc43eRx38RPydE2omBImIf5adTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3NiBTYWx0ZWRfXwU1Wy3cISM1b
 6gmvbHFVbL23edrn4RzKp6TLI+IHY6qnLYPLFOObj1v6J2ayetFksMQcAmutl6u5xg3NOHKQY0p
 H7KB6o1JbppD65y5DBfs/xTp3g8lFmJe/4HsyFD5ta3wEMJeeVNHG2m8+NF0/oCd9i3VklyzNrD
 GvgOUfUDLSsHcMF5XuI/5Ggrz0kXflUb1/L0nv+U++9OW8rj2z4Ym1dImlmXfaGqHdtfqUIAGAN
 VILUnlPw1hUMn/En/sOTqrMvOUoX2u5MSjDM3rpjton80vCn5nWtdAcYCKcpsxuhtZ5a9653HkE
 A2WSbanhLGG9Zc3aJ27041TNux8JiVOPX4uCD/iVPVolbjZzWzPFo5Bk4wcKNGnwepMR+i8MgEe
 sA1uE6r990FOUaBfNx8JtMMyaIS6NaSv1HJJHqBEStMgKXcDNY7Oh3thj1/eO2iXSWPzErrgb2N
 43CAQac541x5LxjvjsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020076
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 32 +++++++++++++++------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  3 ++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  6 +----
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 26 ++++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  6 ++---
 drivers/gpu/drm/msm/msm_submitqueue.c | 10 +++++----
 8 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..bba5468db42e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2128,29 +2128,33 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
+void a6xx_gmu_ifpc_update_locked(struct msm_gpu *gpu)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	bool force_on = refcount_read(&gpu->ifpc_disable) > 1;
 
-	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
-	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
-		return;
-
-	mutex_lock(&gmu->lock);
+	WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
 
-	/*
-	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
-	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
-	 */
-	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
+}
 
-	mutex_unlock(&gmu->lock);
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+
+	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
+	if (pm_runtime_get_if_active(&gpu->pdev->dev) <= 0)
+		return;
+
+	scoped_guard (mutex, &gmu->lock)
+		a6xx_gmu_ifpc_update_locked(gpu);
 
 	pm_runtime_put(&gpu->pdev->dev);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 09d76cdf059f..bf71129e33a9 100644
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
+	a6xx_gmu_ifpc_update_locked(gpu);
 
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
@@ -2953,7 +2949,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 81d21acccea1..cb0ac27dacba 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -298,7 +298,8 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
+void a6xx_gmu_ifpc_update_locked(struct msm_gpu *gpu);
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e7d04c865968..ecf15a8f68de 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -846,11 +846,7 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
-		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
-	}
+	a6xx_gmu_ifpc_update_locked(gpu);
 
 	return ret;
 }
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

