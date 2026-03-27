Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0715410AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E4910EC44;
	Fri, 27 Mar 2026 00:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCd9dkAp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMbE1ZeY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3945410EC2A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QIenTq3341871
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xXqAWNz0JnVqrMWKQ5HyyfU+1Bz5ahMZW6TXdTM85Uc=; b=YCd9dkApvJLtvNnP
 e35VRUe12AqIjkWdybT71XzaTa4iV5WbDm47ihqQocIWoMVg6HEO7WGDXqv6BEPw
 6qlg+6tMZbtBrrGugopvE2e6UWXMQ24/Qlfx6flrnbnwypcrqLdoddrQR/CbMxi+
 1NzU+EtbxRi9HgqUncrxPAJ8GkTEL7a7t8YZIZr93j791i514cMlQYVMFF63rODO
 aZygboPYGYOzIqJSSKUCpbcf8N10oE8mVcugsHKaxzFM2DBIbRbbfSvg6LQEflOp
 /RSaLJzLSUrGl8wGLgHgrlrnVRs8WL5/biwOYCV+F2nLsMFs8eE+sjJZI97NFDmK
 5uRA4Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5a9q0vwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35c1874336aso4819405a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570508; x=1775175308;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xXqAWNz0JnVqrMWKQ5HyyfU+1Bz5ahMZW6TXdTM85Uc=;
 b=DMbE1ZeYI87+d6Dqn2gCeJje2hDcPsWG0KflGU5CrIA6pjy2xZ+A6zSBss5koHbso0
 N3d+Our4VJ9mIle++Xe/nW+mZiv/oSoMyIwnkZAKREi4UsXsCmjVdyMY2zIXukMTL1Mk
 JiQFIa7EeRBDoBMf70nbpAcOfMiOb43Wgvzw+D+hy+ng5J+mjmrUh+c+hH3o3VQr42Ec
 oBr06hP9j4UW5IxmO+72JncoxbtzW3TckfZshVk7EENEj79or6NO7z95cjw2nI5ReP7R
 qQPL4Vcjppb/kgZnjh2Narx/kcUcUQmuG5my1lP8xgwf+Vi5iMs/fNmYDI4wZifc//hh
 Ch5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570508; x=1775175308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xXqAWNz0JnVqrMWKQ5HyyfU+1Bz5ahMZW6TXdTM85Uc=;
 b=il7+x1mAQl0mim8eiOhkaFxYuuNBUxM4byacTdT1HNzC3qOdfceSKZV5OISsy4x/mj
 2lI2DFQ5QKdxn3y3L2m1dKzgDqER9ywExpPZJEOgj6vADVc8xLAE8ry7+lFFuOatwP1u
 9qp3PWV+SRElNPxQ6Op5sttCy5fPHJHcoqY8F6auTnM3DGUpD4IZZDB5/CYqJlNXk+bV
 1BZTKLfwfXXCrD5+v9wKNkkf7QkpCe9VCXs26x8+YgVeFfPTB/BN3LYyIRi6/A98iLTT
 ndQzFfszetVl7X25mTtR5b1hW1O3wG+vtxcIBcsQK1n+EuDxSA/6dnenmVL+YLDKMUWS
 r8dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn1WVEAFHmdQaWKK0lDl0Gt8fkyDoWC2NsEgY5VEYq2u4RsywJuY1NNxP8raKcqFHlKGhe/oW6/Ws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7JTGyhp9kcdiV4wcDF6jnKdNbBFAb4jZ1dzQCMbN1LqqLI0JS
 1KezA20KsnxVXIee5woD+WUYKbcI65fPCIChX3VFQAAYvfGlESi43sJ2EXIULUMrL6JyRxUXOX9
 GMbchpPg04UM0pYfi7PDKqlUU8XGzEXNd/YSnFU1pfgXb1OCCeRUJJV3L7sE7RG9/we8kS9w=
X-Gm-Gg: ATEYQzyF9919l9rHB3EiPfA3uG6doxwgMrpfdUNQfUe1g0zK4wIxc2wY8kN/kvUaCBe
 oRt6RhtE7zz7tlL1whcLHtiYKFgTiCBYPMi6rEbfG5wJN44vKT7+LPccjEIdFL64h20J+1RKcSX
 OrZXzmmffFFxYhaNhhbFHUk/ciQ25eNNOV9zEl7b5NiXQblwVUH3oaIPIbQZ+6y4jF8G5iAN3KC
 Np60c1szAmnq3DwjRNXFtguo303FXiGl41U8GA1xpmpsh1KHh1A51opT4RqE7H6qRQAYrjQQadx
 I/3LHyF5STBQdtCImmul8qq34fol9833KXQ8kcxFdshbkrbIR9zkyBGbHP4RL6mvWJ3pwD6ftay
 krIpchGzOaXbq7ivcnloDr08HgggPbMRWRPnFkpjcyA3kIA==
X-Received: by 2002:a17:90b:380d:b0:35c:d98:d684 with SMTP id
 98e67ed59e1d1-35c2ff07d39mr491423a91.6.1774570507894; 
 Thu, 26 Mar 2026 17:15:07 -0700 (PDT)
X-Received: by 2002:a17:90b:380d:b0:35c:d98:d684 with SMTP id
 98e67ed59e1d1-35c2ff07d39mr491362a91.6.1774570507239; 
 Thu, 26 Mar 2026 17:15:07 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:06 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:55 +0530
Subject: [PATCH v2 06/17] drm/msm/a6xx: Fix gpu init from secure world
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-6-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=8051;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=M9qFPBPHvOVkzFgb15PLQYpEYj0jbBPh3xPS4yjPqmw=;
 b=QpWl3tj4DUArud0yv+weIy4uWXcGZXZ1GwP1HTdHRcJEBFK548SJIEqz2Cx/OfHB8A4aAYN5+
 H7DD88YxRzJCRpERzZXYJBtL9XIpJ+IQuBSCRXMHiMAZVkmzHaJh6do
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: q3YFRTWrN1Todz4KbzPqYT68M66-vIo_
X-Proofpoint-ORIG-GUID: q3YFRTWrN1Todz4KbzPqYT68M66-vIo_
X-Authority-Analysis: v=2.4 cv=J4GnLQnS c=1 sm=1 tr=0 ts=69c5cc0c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_DJ2r0yCx7h-TLoshVgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX0PyDy+Std7rq
 cIiJoGRhw6kfCx5pl1UmJwgXk+i4rZnvYbK6P6+YGaVg7gKvllww6JLRHQpPKfqgjKtK9aAU5uH
 lqgafLbvzib3aUg1ConRvHCLuHq3vi3MbAcOHqkgJFjBoLkNRgCdGgWcbYKdgroww5IHiJ3WLz6
 hp6k0X51/b0ATqgRU5NwdlLTtHGAecoiKvqdBp8esUr+xQttDb9lJU7y8n+RjbmgFHExq8dOaSV
 HxmSicCMKkJs5r5e7WkiGTLhaZpDXdlrFnnYtn3PesRpzHMiSBarxuTxxDbtae3Up0zfEYYCeOF
 jswWivRq2T+GIjwt/hKkB2Q7YLwaxMBlA9OIEQV1tQmMmAqgYSHtGyG+iPJ1mD6sNaqgnvrn6XB
 KxTMJmD03XjYna5Pp64MP7ZNefDN9rmjBsKU4qjFv658wChBwp5u0cdf9Pfk2Gd9HThxGtyKGGG
 PnW2JuXVAyO3JgAODbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270000
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

A7XX_GEN2 and newer GPUs requires initialization of few configurations
related to features/power from secure world. The SCM call to do this
should be triggered after GDSC and clocks are enabled. So, keep this
sequence to a6xx_gmu_resume instead of the probe.

Also, simplify the error handling in a6xx_gmu_resume() using 'goto'
labels.

Fixes: 14b27d5df3ea ("drm/msm/a7xx: Initialize a750 "software fuse"")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 93 +++++++++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 59 ----------------------
 3 files changed, 80 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index b41dbca1ebc6..1b44b9e21ad8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -3,6 +3,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/interconnect.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -1191,6 +1192,65 @@ static void a6xx_gmu_set_initial_bw(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 	dev_pm_opp_put(gpu_opp);
 }
 
+static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
+{
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 fuse_val;
+	int ret;
+
+	if (test_bit(GMU_STATUS_SECURE_INIT, &gmu->status))
+		return 0;
+
+	if (adreno_is_a750(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
+		/*
+		 * Assume that if qcom scm isn't available, that whatever
+		 * replacement allows writing the fuse register ourselves.
+		 * Users of alternative firmware need to make sure this
+		 * register is writeable or indicate that it's not somehow.
+		 * Print a warning because if you mess this up you're about to
+		 * crash horribly.
+		 */
+		if (!qcom_scm_is_available()) {
+			dev_warn_once(gpu->dev->dev,
+				"SCM is not available, poking fuse register\n");
+			a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE,
+				A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
+				A7XX_CX_MISC_SW_FUSE_VALUE_FASTBLEND |
+				A7XX_CX_MISC_SW_FUSE_VALUE_LPAC);
+			adreno_gpu->has_ray_tracing = true;
+			goto done;
+		}
+
+		ret = qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
+					     QCOM_SCM_GPU_TSENSE_EN_REQ);
+		if (ret) {
+			dev_warn_once(gpu->dev->dev,
+				"SCM call failed\n");
+			return ret;
+		}
+
+		/*
+		 * On A7XX_GEN3 and newer, raytracing may be disabled by the
+		 * firmware, find out whether that's the case. The scm call
+		 * above sets the fuse register.
+		 */
+		fuse_val = a6xx_llc_read(a6xx_gpu,
+					 REG_A7XX_CX_MISC_SW_FUSE_VALUE);
+		adreno_gpu->has_ray_tracing =
+			!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
+	} else if (adreno_is_a740(adreno_gpu)) {
+		/* Raytracing is always enabled on a740 */
+		adreno_gpu->has_ray_tracing = true;
+	}
+
+done:
+	set_bit(GMU_STATUS_SECURE_INIT, &gmu->status);
+	return 0;
+}
+
+
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -1219,11 +1279,12 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	clk_set_rate(gmu->hub_clk, adreno_is_a740_family(adreno_gpu) ?
 		     200000000 : 150000000);
 	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
-	if (ret) {
-		pm_runtime_put(gmu->gxpd);
-		pm_runtime_put(gmu->dev);
-		return ret;
-	}
+	if (ret)
+		goto rpm_put;
+
+	ret = a6xx_gmu_secure_init(a6xx_gpu);
+	if (ret)
+		goto disable_clk;
 
 	/* Read the slice info on A8x GPUs */
 	a8xx_gpu_get_slice_info(gpu);
@@ -1253,11 +1314,11 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 
 	ret = a6xx_gmu_fw_start(gmu, status);
 	if (ret)
-		goto out;
+		goto disable_irq;
 
 	ret = a6xx_hfi_start(gmu, status);
 	if (ret)
-		goto out;
+		goto disable_irq;
 
 	/*
 	 * Turn on the GMU firmware fault interrupt after we know the boot
@@ -1270,14 +1331,16 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Set the GPU to the current freq */
 	a6xx_gmu_set_initial_freq(gpu, gmu);
 
-out:
-	/* On failure, shut down the GMU to leave it in a good state */
-	if (ret) {
-		disable_irq(gmu->gmu_irq);
-		a6xx_rpmh_stop(gmu);
-		pm_runtime_put(gmu->gxpd);
-		pm_runtime_put(gmu->dev);
-	}
+	return 0;
+
+disable_irq:
+	disable_irq(gmu->gmu_irq);
+	a6xx_rpmh_stop(gmu);
+disable_clk:
+	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
+rpm_put:
+	pm_runtime_put(gmu->gxpd);
+	pm_runtime_put(gmu->dev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 9f09daf45ab2..0cd8ae1b4f5c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -130,6 +130,8 @@ struct a6xx_gmu {
 #define GMU_STATUS_PDC_SLEEP	1
 /* To track Perfcounter OOB set status */
 #define GMU_STATUS_OOB_PERF_SET 2
+/* To track whether secure world init was done */
+#define GMU_STATUS_SECURE_INIT	3
 	unsigned long status;
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8718919c7e19..5cddfc03828f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -10,7 +10,6 @@
 
 #include <linux/bitfield.h>
 #include <linux/devfreq.h>
-#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/pm_domain.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
@@ -2160,56 +2159,6 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 		a6xx_gpu->llc_mmio = ERR_PTR(-EINVAL);
 }
 
-static int a7xx_cx_mem_init(struct a6xx_gpu *a6xx_gpu)
-{
-	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
-	struct msm_gpu *gpu = &adreno_gpu->base;
-	u32 fuse_val;
-	int ret;
-
-	if (adreno_is_a750(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
-		/*
-		 * Assume that if qcom scm isn't available, that whatever
-		 * replacement allows writing the fuse register ourselves.
-		 * Users of alternative firmware need to make sure this
-		 * register is writeable or indicate that it's not somehow.
-		 * Print a warning because if you mess this up you're about to
-		 * crash horribly.
-		 */
-		if (!qcom_scm_is_available()) {
-			dev_warn_once(gpu->dev->dev,
-				"SCM is not available, poking fuse register\n");
-			a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE,
-				A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
-				A7XX_CX_MISC_SW_FUSE_VALUE_FASTBLEND |
-				A7XX_CX_MISC_SW_FUSE_VALUE_LPAC);
-			adreno_gpu->has_ray_tracing = true;
-			return 0;
-		}
-
-		ret = qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
-					     QCOM_SCM_GPU_TSENSE_EN_REQ);
-		if (ret)
-			return ret;
-
-		/*
-		 * On A7XX_GEN3 and newer, raytracing may be disabled by the
-		 * firmware, find out whether that's the case. The scm call
-		 * above sets the fuse register.
-		 */
-		fuse_val = a6xx_llc_read(a6xx_gpu,
-					 REG_A7XX_CX_MISC_SW_FUSE_VALUE);
-		adreno_gpu->has_ray_tracing =
-			!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
-	} else if (adreno_is_a740(adreno_gpu)) {
-		/* Raytracing is always enabled on a740 */
-		adreno_gpu->has_ray_tracing = true;
-	}
-
-	return 0;
-}
-
-
 #define GBIF_CLIENT_HALT_MASK		BIT(0)
 #define GBIF_ARB_HALT_MASK		BIT(1)
 #define VBIF_XIN_HALT_CTRL0_MASK	GENMASK(3, 0)
@@ -2705,14 +2654,6 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
-	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
-		ret = a7xx_cx_mem_init(a6xx_gpu);
-		if (ret) {
-			a6xx_destroy(&(a6xx_gpu->base.base));
-			return ERR_PTR(ret);
-		}
-	}
-
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,

-- 
2.51.0

