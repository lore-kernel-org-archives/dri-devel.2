Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E44AF483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D27010E49D;
	Mon, 23 Mar 2026 20:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8Cd9pY4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hRKLB+2L";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481DB10E440
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:37 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHr9572972957
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Nx0bvZeW+J5SMSuTF/HVH8X59gK1KW+/QrWtuB3c54=; b=V8Cd9pY4PTTKTHJh
 hyt4Nv7QJjCmTsvKmac/P8ceMJdRg07YbWBu2pSVgIyUB/b/njN9F8thAAPXSUY7
 sRUv9QM1PeRB242hDzKKwkb8r9jpf39j7NMkKlALVb7zpIpM9duB/HbHVXneWmJq
 /mvXWnpwowuRA97Wr9KTkUnYx/8tTR/J1UdWTAzp4sQZBNvv+O/yhH1h3VxhZFjD
 qyDf6J1pJREjZWqXjumv68FBpz9GrXPgHZVf2EtC4UUyurn7v0SZZRcShlGFo9Vr
 BV6TlWbR/aN2+I5262Kxpn/ttgageJW/3qd7GhSiWpfmm7JyEauMcMQnMN7fQAQk
 49/6/g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc2m0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82a1436347eso316306b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296816; x=1774901616;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Nx0bvZeW+J5SMSuTF/HVH8X59gK1KW+/QrWtuB3c54=;
 b=hRKLB+2LlT75Z69QxcntvLNhXp6zsnGP65HshLpZJCI3p2iVXqpMAoDsgBOkhwMGwG
 N2e8bZjT8Jg0LFillYDJhcr8ObvJ4sym7i56ZfP/3yIPOfMFiaVmPSH7wAieU3t6KC2w
 vBqGAQNkpAHf8VLUNynR4OgBswEp7WonOMFs8zOIcCQ30NK5WDiodO9RYl/iYOgywJHo
 PnUn2sO+WwpTE7Sw+ocMq5wFqhvbIgm64vUQleTGdtC9wS8puX6+vADqZAwid8uI6yaz
 nsJ/ZqLXmUaF4FM0bm9kUv0KJAnpRBc8z2EYCHoTyx0dxw5Rw15+vQQ/FzTQ6xU4vHoN
 n0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296816; x=1774901616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Nx0bvZeW+J5SMSuTF/HVH8X59gK1KW+/QrWtuB3c54=;
 b=ZMor3euQaw+d5gKRFTcg3lxPCin7kLozJUuOAK9+7tfkwJ67lBNZSNypihsfjFuzcL
 ChZjq/WSQBJKi311Gn9a2s5EY/Fodp8WthhJAz59QlN5CWQwh13eKcpEh9k4HJkfU1OB
 AsyyZ+N21QwtzG72VmIFJy/OflADBN6s7X3jYN/6Np63T/tJMaWErDHfkTYBehiy3uWx
 i7gftApbqm+se0Y4e1rPuJ9fZGJVs+Tt+MA42f2xzar/mOoGTzz89DcTUpXZDdzUPgMd
 3ADKLcbq74vBsvCCGCvGrXq2DsYNI+X1E00UUKL9vGDmljN2UgHDRE5NycvKe1tXJUDK
 OztA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxI5UBkiEZjMjH+hxu7AiFV4o3dBNwaOjJgISSNM0fFB7tkQp6UpzmIQSL5LM7FlHbUn6m/aXleqE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR79+kigp+BUqvE1oR2xaaXkzC1e5p5dnmjQat3J5msMTIeltk
 6cu1m8+PHqi7a5t3Ap3K4u44WYasI/SGKGHjfXWymOshOVIes98rLEgclGv5WBHvxbHeJLWO0na
 fdwy3BA9k1xG8RggXYzuk0X6NtaAZxLZur7nnG0zN0XWsbtYwEy9Ip/sMZf/rYDq0MjsQiu8=
X-Gm-Gg: ATEYQzynCt7ADhoOsYzLMdrn20E28ZMpnSLiRkDdsZMS41oM1BxRGag0R1IYwGyoo8z
 AqsQTzZGpEoXZVTwTUlmHvlIN+Mg1ucW1kJnkklQeztwnNQVsumnM/7jlPAg+SHDPu0i58MDbWZ
 qxzb41PERKP3KpqzNymVn6GpIu97sXFTFsmOHMgJ6LZ0l2bwiaYWWZEWAHLxRG/JrORXv5uarB8
 TpOfjP0vWLaNxX7PXy868v7pQEaRK83LrQPvyy/4UnhIFO6I31ZhaNXQ/5mYAKSjOJU2LhKcgx/
 WU8UlXq69lLW1ygPiaSBPDUm4zMFxPdSmgBZR7u0ZuxkhRnWr1wTks+Zl5/7tTkcEF4w38vGrRE
 EjZ773OgZDxIV4hGe45FxrdgsgFXpYniVT5bPIXlH6q7eaQ==
X-Received: by 2002:a05:6a00:3a20:b0:82a:75be:d371 with SMTP id
 d2e1a72fcca58-82a8c346991mr12354212b3a.29.1774296815940; 
 Mon, 23 Mar 2026 13:13:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a20:b0:82a:75be:d371 with SMTP id
 d2e1a72fcca58-82a8c346991mr12354184b3a.29.1774296815364; 
 Mon, 23 Mar 2026 13:13:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:35 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:22 +0530
Subject: [PATCH 10/16] drm/msm/a6xx: Fix gpu init from secure world
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-10-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=6048;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=LD258q8BiZPKjxboZZEHGa5/WJjqvZE6K1YLsrcGhkc=;
 b=6KkTxybuGhFG4MhRzfOXNucn9U+wGV8/nNzkWUSQhiMxHGniBVMxN4cnk3SHxU9/uhPL0PuvO
 A1QiAsvhfIWANIqqU1fgKZX/XHBSPPkejkcoW/V9X1MMP1LWR2YWQxD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c19ef0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BkmLZa_BGXOvOyRCPiUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 3hy5itQZaA6lR_mZRqTFdyQ_kL-yJlOw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX3jwYZmq+Zf+T
 HQy6nn+F/UlFXH6ca5z0YHX1c2J1uFE9yy0JULbqVVDqTbvQB11XNPWP4t7I+IZDFAa/7v6pm60
 bVOllBtSlrJ2qho9M0h/Q1TT5PLYY677vHj2+DEcGvtQ4J/5Hg8J2R28lq3PLKvWwbhp0gJEizK
 CRR0CfvBMiM6RpWA4S0cq0/Wg0Yprh2NdWg2gp7+69U4il3oiliMtfepUhv/NWpJLP+TBrmYaWm
 aRzp6xOBbjs9gouvrq4FhFPqgGyxv4bkCfGZLbRs2NGtkbBXiatyfX51POfkRoExBpu2PbIr4Yh
 Fb2XUHfgXSju+Aw8mzfLawJz+XWXXfGv4OI/d3MsLEgV9sxhie1dsKtyGcLtFyrqhOn0bOAOiS7
 +NeREp8M2rn0h2ZgkyyxG1PXnCXj2kvOnESqrP+7LccDmu4gKFOvGMq3ipfSzO71OPLBbGdlV1t
 BQauVcs4sXMDnd1dfDA==
X-Proofpoint-ORIG-GUID: 3hy5itQZaA6lR_mZRqTFdyQ_kL-yJlOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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

Fixes: 14b27d5df3ea ("drm/msm/a7xx: Initialize a750 "software fuse"")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 58 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 59 -----------------------------------
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index cd6609bb66fe..61af3b212ba4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -3,6 +3,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/interconnect.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -1174,6 +1175,59 @@ static void a6xx_gmu_set_initial_bw(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 	dev_pm_opp_put(gpu_opp);
 }
 
+static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
+{
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	u32 fuse_val;
+	int ret;
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
+			return 0;
+		}
+
+		ret = qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
+					     QCOM_SCM_GPU_TSENSE_EN_REQ);
+		if (ret) {
+			dev_warn_once(gpu->dev->dev,
+				"SCM  call failed\n");
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
+	return 0;
+}
+
+
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -1208,6 +1262,10 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 		return ret;
 	}
 
+	ret = a6xx_gmu_secure_init(a6xx_gpu);
+	if (ret)
+		return ret;
+
 	/* Read the slice info on A8x GPUs */
 	a8xx_gpu_get_slice_info(gpu);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index cdecd91094c6..cbc803d90673 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -10,7 +10,6 @@
 
 #include <linux/bitfield.h>
 #include <linux/devfreq.h>
-#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/pm_domain.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
@@ -2158,56 +2157,6 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
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
@@ -2711,14 +2660,6 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
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

