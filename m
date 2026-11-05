Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E4606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cN0rNudS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f1Wuv3Lr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4134F10FEEF;
	Thu,  5 Nov 2026 20:40:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CC810FD72
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeB9n2433592
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=07HC8CYy/1w
 n7fl1/mdQptgxfFoHGUlLKkrop/ashJw=; b=cN0rNudS7g+BJjauacqKMkodGrH
 90KkFCJQG3wpydN93pRtOZrsNmPperoA0q6Md7smpIa5+EMqsWaKl30SOsof09RZ
 NrTaQkjDyj48ZdAwRc6epB5Y1KDqYlyqEGRG/65ccaX6E+6dFolWTq7qGOZLclYS
 JwbEC0CxdDY+I/eNtdeak7KKZFdsumOgj5wHnhOpPxEb1uKEUVR+VPyIo/F28L2L
 qrAUkWU9eNpLFNTFyGPzUc2HGo+tqGnFg28yBhFkrIHmOlwkE2sELUmezeD1dSlJ
 dex7DRZ80eTUaDgP2BSs/3WRlDkY2ghOn8wuPtu8fAvOuEl/UjzzaXkiChg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd2s6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdb4c49e4ffso1273416a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911226; x=1794516026;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07HC8CYy/1wn7fl1/mdQptgxfFoHGUlLKkrop/ashJw=;
 b=f1Wuv3LrcPOx7VRfa5bvOBfPoHLPR06igzDHLe0ybzAYR46eqJLDM7UJzTGuzDgzco
 OnMXx0GYvygaT8qctnC7hoOUu8BmDjKNpw0jUe0qtpRObTIc2lbQ+cjtPVCXoic0kcIQ
 Sl3tdi+27qt+ZIaSPW56z/VCJKVwBh/dQ1/OJi2p9NJ63vkYXjC+fHFakpchO+yd7NgY
 dxHy//QX3yOYxr9679Hs5i9y+VddOmckRKZ8UmL0HLW2DyhUJA60qkAskZLoK1HzkqrC
 U63+9mhWrqQALJYd7RuT6MEQ5XBJCM5ISAvD0bMfDTMK+38qLr3zM0cp3hRGmXbKzU7k
 EiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911226; x=1794516026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=07HC8CYy/1wn7fl1/mdQptgxfFoHGUlLKkrop/ashJw=;
 b=YviLIKHOqYuSm0jgIT38BUF/1FA7ZKNAqQlg4rjQFRhSZV/f4bHTFwtzucN+vrE7QC
 3/Lpt476/cxOu3qcxvCeV43kQzOgBmfMExJ4Zh8UjN/hG6UsnWBgj4ZKXjhRVPWd8U/p
 PHNzgRgRtAv2RfYKZqYl5aBx909F8Y7GOcNVHghoS0PDzGclaRBkeiq7rx4YJntL3mzC
 3W5+9Bhoe9QpgU0CFYTlfAYPRoRnr/oNHlkL5DkbouDPPlpjU/z57isCXOCkqwDUBTcD
 6Emq8V+aIr705hg4WdsFfSbL6/gBLn9SW1vs/VL1XGs2nf0AGXTS26GTYBLNZAvJdysq
 fH7A==
X-Gm-Message-State: APuU4Z81oM9i4Y/YmMXB0urQt/ejcDmuIHUtePCOvWYn6tVUR4Y/LFT0
 TRFSlNpyFrPRQcAi9x6KaEHCfDfzWgIUH/NzDFZ9o2l3YMOw2CdnyrMyioRun1ycqsaAPi3tvkt
 7y3wd2b88X0LaVVP5BJZYn9UBDr1kcXMJZusfu80YQmWVk6Qbeczbr4NtdFLaEQtAHodIQhn3B/
 ALu3g3hg==
X-Gm-Gg: AYBFou1zQFq2m5tVI/eHafsSZrpPgAOhAlbJos6YKsWOAhM/XupZctW0Sv9hLtpfGv1
 fD2MawJHqE3vIfiN7yTYwRsX+En8btglM1lO5Eo3GJJW6JzVHHRSpMFrlcCXQJlyCv1DtgseLcg
 LLpYWZUQv2+hmgTgk/jfeFSW1nSS3OQFJm7bhFlY55XcgQpMXaISZWQads7WRtpwBF2iRyBCrli
 FipIIHhZnwOoueTr2Th/CpPX7FnBE+hTVoq49iaceUxvFfU6bj1HAQA8Ie46k01B41vgkLDE1eo
 1MINqm/+b8el6EeZsdOFPWr1+1yJfmt/QstlJdfHx47FUlRpiGTnLI+DU0N0pc7w2gxMARBVSSQ
 rZsLSUkRAgepEwswSzzckpv8lIb9ZtkXQvhI8/fUTO4ztt+IFakka0N6pCQ5TUxROQr4aAKDfvO
 QBYVaAiD8q0H+hytOTNl4LXeEtcHgZS5EXB2zMkk4wRb7P9jUaofbXs6r+MSl33w==
X-Received: by 2002:a17:90b:3c8e:b0:3ab:de4:7fa5 with SMTP id
 98e67ed59e1d1-3b0db71d9f8mr154344a91.56.1793911226397; 
 Thu, 05 Nov 2026 12:40:26 -0800 (PST)
X-Received: by 2002:a17:90b:3c8e:b0:3ab:de4:7fa5 with SMTP id
 98e67ed59e1d1-3b0db71d9f8mr154312a91.56.1793911225918; 
 Thu, 05 Nov 2026 12:40:25 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d7c8f2f0sm646750a91.11.2026.11.05.12.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:24 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 03/15] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Thu,  5 Nov 2026 12:29:29 -0800
Message-ID: <20261105203057.66520-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX3MKx+AdKpvb3
 BVEtz/71r3lrPEJFwcvtyLN7wefI/+Aczt8nma35+fhhRAyWbW+dvdp8/xbImqRkH06ay4u/6E2
 y393rPbvByKg4c/DfPSWr3r3M2SHLbM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX9+GkGDZjkUEB
 OQhGQyx3MZ8VHdPQGDL+ZF1Q/CFJkNCFkOaZgxmQ47oFfo+vfxhscvyxI+6NaERIvAjqNHZ3siv
 vLfaeyzOzI8JNDqmmu02tpX1vkowBkqx+1Tca8u2lzvqhoMJQ2nR2KKPFtkngyG2UIssjwfHDko
 u9c5zTav9/nAXuojb8ae3LN9uEBrFtzD+280vXEVyKu29LiFdAi2qVvBoZsgRNRdRQxo/ut41io
 +pB3UCvm5zxcYnYRAt8CW4C+d7YbJJgfiub9ilKK63MJ+WCLE7EEgJvI2Oj9swjUXVv5I82mfzc
 AnQ/0w9cnLRC9xG38I1hLhk8i3RZVUfhNJwzQCePMQyMPF0bweI+ChsesVHTdp0BhfnMAie4Wru
 d4JLExEh3vewSh6EMWsd67LGwjDigfXQvf9Q+JqDsI6Zy6Cr9Zo0fcLX5cX0vQ7YjseH2HB+Wi9
 mrt4d2hUkhWG+vDkY2w==
X-Proofpoint-ORIG-GUID: zyJti73JlT23KVuquXDyut6XZ7n7_FoH
X-Proofpoint-GUID: zyJti73JlT23KVuquXDyut6XZ7n7_FoH
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aece9bb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082
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
index c58a2665e9ab..e6ec85b20fb7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -346,6 +346,7 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags);
 void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
 void a8xx_aperture_clear(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 82cddaa7278f..be81f141300f 100644
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

