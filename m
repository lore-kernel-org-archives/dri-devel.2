Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B3606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ly0FNyEx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OcGR8TBr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FB11121FC;
	Wed, 21 Oct 2026 20:53:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FCFA112227
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeI6s2237353
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4iyKi3o3dnw
 WyP2nsGvDx0M5Mc69Qkq1oajv+rbaqtQ=; b=ly0FNyExJuhZdTIu082wFsqv+n+
 WqfHM31IhO5V97IzDMFzKjGtNnV3vrRKAVnx1n7inyfSynwK7uNqrSNdo/TpFzha
 A+3jB0IEFtID5ISzIwB7G0LGoiUMTByyJ0Y9nZUm/T+KpP0ijh2L0yVBgTIOCzS/
 jJHB1XhwMgHP9uXuVaSXBrPJstNOL+MtCVDW4ar2+nV+x6In+5iFwskdKT+Y15Q0
 9tqy1BaseywKJbUZDuqRbhKdBasC/OZ52OMCpShWSLXq1XEei0GN+xVirjqAl4QK
 tNabLC9Sbg0peBuC49BygLf8rmQ9sT0SJ/j3XWKj8sV1hMCFkDpCmrIbNNg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v89070-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so138971a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615961; x=1793220761;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4iyKi3o3dnwWyP2nsGvDx0M5Mc69Qkq1oajv+rbaqtQ=;
 b=OcGR8TBrinsEwu5CaQ+Zofh1BJdpJ9sBu60ExtfSsmguHwZhtjW1cB5wfZI/GW5eDI
 fEycqzuX/dmzn9NuRcNJmdPCiOxEZtRr71PuhlhD4wSIA9cGMRK13B+g6bP4YsAV2qqw
 Qp3jaXFTaR91VJAL9rskI7VXMLhj+yGHb0VbHstKXQ8Jo3AoA9Xtx4CNS8zbLElfam20
 pr4gYl0Zgq+YsVpbf8sQpvGM6KVygDu+VsIRJGfziukUG6kel4GAPdrWRuxhheC8EZ6F
 FrmOQMWhERN9YmV+P3J+HTUlZl3/icNDbl4I/0woV+otpIpdX7IYVGEq2EAtmV4ehSoK
 FRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615961; x=1793220761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4iyKi3o3dnwWyP2nsGvDx0M5Mc69Qkq1oajv+rbaqtQ=;
 b=rUBweZadLuxdIDAsLsZrGiRC0MsGC8yi22AbEVE5+2PyAL0efOY2FaqgKs+VThJRaw
 Lq4FSxM1tljWbNvyIfyI7PMcT1lLaNyeee5i5Bbl7s57zSjipK+kR3bn2skKDAvnODk8
 xwNtrb2c2Twzbg7554wMslLU8BeV9pA4Q8ytd0n8Rb65uazZ2gEFSFlkefbzBK1M5ZCv
 sMKzX/ghzP8IOeYsdsnkUkchOAvpjcVe95mvW1FTpxKphKsA45JoJk2N9dJb9sJMwtBq
 XRCGu+P+HrVXPftbFnJDCFbE2QJ/VnPWtwd587h2fpBkm+arUicMbTT5Rcx5+H15YpyP
 XayQ==
X-Gm-Message-State: AFq9FYIYzLKjdNmrNMWQjBT4okM/poQp+qK9oybNEhyQj6v1ZP0Cb0Md
 uiUVID6zrWlopWUg0qstiPZOt41W8B8tAnDSQAqqb7PB6M/nRu/JUbz6+fmX936YllJdz+8fNCo
 e4yiwCrP81A7BD9Cf9mYnCqQV9loxvbIaErc6o5O14G1MV8trwqaS690kEe+QjekvDM6se08qUL
 P2TmE=
X-Gm-Gg: AYBFou3aP6wdDFLQwBgXCB0Dq+/JjKoaPMeOYAN/mmcnSAag39eKP/gH9ynpETFD/+n
 lmc8tC/OJ/6HZRsly8owH+fPbIR0gklaVthzH5VZuvQn+IvW+Q0bcjv/e7WsDYHMaLowB2kVjqP
 dxptUp/MSGtAmuEHBtFQEGpwxjUxtLovqEBUH9te5zBYexKWGd5zkQfJcqjh4V3IjlF3NvkdwT/
 K1tOclpbvphe8uOQnocQ6nAU33yl4bp8RSwRQwHmzMejIlTlHMVELHzwSJhvE9mYc0VdlDEGb1u
 lvFRvTTEpxQ7G37WTCG6gPKaKD8VXd1svFW97J5vOqF3szB0cEwsQKckaZRumlr5T0x0TpIs1yH
 zbBw9PY8P48M789I+CCdg0gLSxPVwycT9ejeWw+86ZxhIcAmUhg==
X-Received: by 2002:a17:90b:4ecd:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3ad86cd5f8bmr2490095a91.14.1792615960847; 
 Wed, 21 Oct 2026 13:52:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4ecd:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3ad86cd5f8bmr2490063a91.14.1792615960340; 
 Wed, 21 Oct 2026 13:52:40 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm1025666a91.6.2026.10.21.13.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:39 -0700 (PDT)
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
Subject: [PATCH v2 03/14] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Wed, 21 Oct 2026 13:41:28 -0700
Message-ID: <20261021204244.67160-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad92619 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfXyS4edoBtRLaA
 IouSK9SkKmsgtOa6B8qOYeFDc/LoRHVz5up0c4TH1rIk29tFDiBd6ygzyQ41+Qdvfa2hjUA6WEM
 /3cB2fuM43EnXMgcPljWVJmznJhXAhI=
X-Proofpoint-GUID: 8bzA2mue9BD5Rp_VSyKtf3QrNReJVnHP
X-Proofpoint-ORIG-GUID: 8bzA2mue9BD5Rp_VSyKtf3QrNReJVnHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX+IKXxRZOIlp0
 U58+oXTMjLmB2cJLsAp9k2Xfdg4Q3KCaworFCkTgUNrUTn8uJqbzcfQF0/AXaUksBnJ1qHO3mP7
 ku1ARI7YwbWi+rOz7BUgtI2g6ehPKFbhiiwWQznCPmZFPD6DEQ5Ejt5O5synOQvLEG2ukmizyly
 unxWVnnorVIajD8Es267DkLlcutNK7vtl5CZ8V3wTmG5ZqzfA+fUOgOluVkGC/rHpBYHOV5//jr
 c6E6xTVfClG12v0qX1eDG6e74njHVfXXNKpVlslrxNnrNDGzFbGh22bAGWAg520YZjjmvwpVe7Q
 mNLVer1kyXdcz5D8MsSti5N4m22fYoE/PpGXnMiyR427tWDJbiWfJCwQGIkJCo0ue3salbwY2Wt
 Abl6+Ei2pFaDTSlJe7LIeiLf6xQXSa42Ybt1L00g00b9TGoy/p6QgSmZQj9ZBNDxC1nqIWdrROE
 b+ugflOKwm7QJ8I/m6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210083
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

