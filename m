Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAF606B784
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XtP2/e36;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EV08Tmyh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAC710E412;
	Fri, 30 Oct 2026 21:19:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC341129EF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:43 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAVKx3367757
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OuQj5LyMq+h
 aJbOeBteBY2/+x1n4Q2GfvkKjP9s1CHM=; b=XtP2/e36zDkpHSCmxSv9Y6XXd5t
 ajarRKs2oQS/OOKfJ9a+JYfnh6ver5NQBNqyCkAH68ZQ/82Je5bGYN5H62CShupV
 Z3R63SzNyD5n7w58gO2k8DVcBAqbaFRW6H8skf5tGJu1GmnS5rdIUGRdXVbdhrVZ
 RokiqNQ0FB2HE5TC/uGdGHku5+e6j57nrGxjFvtb4Djgf/GQgwahG3FTbuT0/tf4
 6YGwdM+qgEEjywplrhAx0D9HaTXVSXM1Uw3//9tQFY+09Ciz1rQCQhIut4SEjgn6
 2iPGuiCPFgTi/u5VMdF2YXGFSbUnC1cuz9GLX7MOZPyMmhZIjtqVBjXC3zw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x080r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ada8bc8575so2548867a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395182; x=1793999982;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OuQj5LyMq+haJbOeBteBY2/+x1n4Q2GfvkKjP9s1CHM=;
 b=EV08TmyhJsteZlujD+N3nJ3bp/YCipGZK9lx6KktbeJ2d/jf2HHVXpgkCaYXHq137l
 XR44YVJc7cli4sFGPRziL66kKJ3f2npD857gmfVulyl707kKMjEiYyGQNrL/eS83gGxC
 hwVt9T9Cmf3nPU6nncFUWIEPos1T5fFdeMcKLE/Kkv6TjaPgaHxm592OwEW5BL8knjAo
 4FXs8887/5P/vtPCMjYziLwVSN3qh5wBXI69JesRO8RR1kEmM4tEOnla9tZ2s8Y2xR35
 +aje/xwqmLqM9yzmGjePRzENMAThUQTHDeFbwbjMTWzy/i7SN90HeRj4b875+Hx21czz
 GakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395182; x=1793999982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OuQj5LyMq+haJbOeBteBY2/+x1n4Q2GfvkKjP9s1CHM=;
 b=X2hEuzyoNEiyBPVbx4X0p76f0mXPFzWXVBVHZf0m6/kYS/fUc2vgx/8W14tpDf1YIo
 +BxBIkd12xdSdV9L7tMCWH+e67X6gtRJGL568XTytfF6GWhQumXgAmOrbvrpPzusnSlH
 Us0bA/zr4NGzIcMPGaPXYK28nIXDmvtxk2bbT/JLyNfxuP5Cw7xrvgUAObyU39n7bU9e
 16dGo19RtyEThC5XzMhNNdNHKb4dgd2vL7T4JCLGPVW0s9Y5sHokoILbeodVkdWNv7Fv
 2ra53QNIBBXYN+IiBQ0ZivhJgBPDjrBXUGz5E16RYxYdF/BmqFKJVC+tcyKi81kf414x
 Dh1w==
X-Gm-Message-State: AFq9FYIdKriBombPX+TsrXxwllIdKcTNbXbAc1JtlxFvpZe4D51Ff+5E
 IC0rOpz5mYm67RW7mpB4PdxoHh7TT7Aj/2Zg8aSOG+AJ6whMGeFzOK4QpCuBkTIv6i4TpTjYvlG
 /oe+Amzk1GKRXUSiwIzFJlHqofHJ417bDZc0SY+Ovvuzdf7oOVDg5DZgBvzmTPTVOicb/s0ZEYQ
 9XdmA=
X-Gm-Gg: AYBFou37QbcPc6Py+VMi3lUjrNL64BXh9sS2a5/sZ4ghU7cSK2SXf9/JyQEbFMoIvVH
 JK3gqZ40IWId05i3l4lw563TDHURYBpX5kj6eR0ZPVRS9zmKB6bZeB2XRmy0NgXeXqEZ3lIFc2Z
 QiOvv3+DvpN3y/QitPYWkPa0b12kRjLKfEd/LeDVTFjULvr/M/lOd8kf1WkhnDORY4EJXeK0N/t
 nWGgmSj3YjJWzxdH0jsRkPywn0+nISJoZMjbRciPoLRQn0y9aSQFIsmSh0hg+tjYiShOOYPQB5q
 JOckmmdsI+ruzRt/xj6Ri/CgzS866DA8Fjs2WUu4pBPZCHWZ0g93ctH0OIt4L9m2/JFhGjS7RD2
 PHUXVqtKysZ5MYF4F+HrjaTNtmNap3M2Bx/5jgyQ/fQhOP7uJXx25RZTsiKk/QEm4CRCcs5oCk1
 SHwKEyF7Bj/uoGMmMCOBtdPg==
X-Received: by 2002:a17:902:f70c:b0:2eb:a1b:e9fd with SMTP id
 d9443c01a7336-2eb364de4efmr34482185ad.41.1793395182098; 
 Fri, 30 Oct 2026 14:19:42 -0700 (PDT)
X-Received: by 2002:a17:902:f70c:b0:2eb:a1b:e9fd with SMTP id
 d9443c01a7336-2eb364de4efmr34481965ad.41.1793395181706; 
 Fri, 30 Oct 2026 14:19:41 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392aa7absm11605155ad.65.2026.10.30.14.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:40 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 03/19] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Fri, 30 Oct 2026 14:18:05 -0700
Message-ID: <20261030211928.45761-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UGhtsaK48Pe2PA5G6lA7Fy64pvU3yr0C
X-Proofpoint-GUID: UGhtsaK48Pe2PA5G6lA7Fy64pvU3yr0C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX68frkMmOtEGA
 YyYpbb7AX6IrHaEOMXLKbWoQlXsxnj/UXyjIkEoNH8VVjP9ofDA0mHebDHh24PWnalUIXo2rSgV
 s7ba7JiPtFsddFwbgAhFVS7oW96mWFI=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae509ee cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfXySS9uruny2QR
 jF+G59II37ci1pjt5H2oC+gRZtCg/8QZhLDTjfRBMi7eqfpDGx4RwL8oOJ/DoBfDlWMXNyk4ULI
 qa90EJYsfMx/2rhl89Eh3fbFJa1g1/jtntCNN9RSoRsOOra1bBbHUcnyWrAIfn1aGxRdx/l6SVW
 7AjQqsbey8NvbCNO5O0Euqwi2TxD8vAEhcoccz5aN+RZRzXADCjFoHD7eoEY0++eapyxUxAykTD
 p+uwLOB+E1ZY0Ez8yD4aWbXezjBZSoXRVO3/Dw7JnUyyVR4i4f0xdo2S+jHhj5NOhve04n8khhh
 D4jW+H9pxkrdc6Ezj4DfRrLc4hLS6chwUNOsDXbe8f49WCwWpWCGzvVhOy4sGNlROAByuC+R2LL
 OPicPpClgFk7KQTwvJape9DDwKp2OttoTdWp6lYF10qFLldRy8o6twbgevU+mYT8PdRGiOVn6S3
 +uHtso40Jf2pvLGZTtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300084
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

The snapshot code will need more control, setting additional bitfields.
Rather than add a list of additional args, add a helper to acquire the
aperture which directly takes a reg value.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index fb000b79fe2f..2a2ddba6761f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -348,6 +348,7 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags);
 void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
 void a8xx_aperture_clear(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a14379e26fbe..a0983e2ee641 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -16,13 +16,10 @@
 
 #define GPU_PAS_ID 13
 
-static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
+static void a8xx_aperture_slice_set(struct msm_gpu *gpu, u32 val)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	u32 val;
-
-	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
 
 	if (a6xx_gpu->cached_aperture == val)
 		return;
@@ -32,14 +29,20 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
 	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
 
-	a8xx_aperture_slice_set(gpu, pipe, 0);
+	a8xx_aperture_slice_set(gpu, val);
+
+}
+
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+{
+	a8xx_aperture_acquire_raw(gpu, A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe), flags);
 }
 
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
@@ -74,8 +77,10 @@ static u32 a8xx_read_pipe_slice(struct msm_gpu *gpu, enum adreno_pipe pipe, u32
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&a6xx_gpu->aperture_lock, flags);
-	a8xx_aperture_slice_set(gpu, pipe, slice);
+	a8xx_aperture_acquire_raw(gpu,
+		A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) |
+		A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice),
+		&flags);
 	val = gpu_read(gpu, offset);
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 
-- 
2.56.0

