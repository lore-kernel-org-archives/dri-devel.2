Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FE606A330
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QkmAvFQB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hm2C46Qw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943A310F24D;
	Mon,  2 Nov 2026 22:04:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E1F10F24D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K69RL3292637
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UVX7b6ntdrV
 +6wjxMqUvH3ly/pZHpls0n+hd4y9AHHY=; b=QkmAvFQBgUfjfXijqq/A5REgF6Y
 jC9bbnv1NTlDXxqSq2C0Wq15r6gzGRQStGF0ZWFegV08bMzKigcGapXV9BUrGr9I
 2DMkVScXZ8XWFYCOqlcpHCn+WLj4OWjxGkiVTHfBN+jidTDf16MuvgU1uXVWP4bT
 0w5Jk4wp/ruk8vCeOa6gtl0mgnt9P6Qvktxy+BgUh187OIRZCdMktGTsV090pKdu
 EyRdet7RYIFIyZKZP9vLg54fyBhX9M1uoQOsTbvagQ4eXr18zSiodfALG8XiCTCL
 fao6uLW9+vk3vg48FMLrIZlkZ70p0ZQrNN+JsBR/HGOyM2I1E1Lajt3D0Iw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07egp5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so57577a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657066; x=1794261866;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UVX7b6ntdrV+6wjxMqUvH3ly/pZHpls0n+hd4y9AHHY=;
 b=Hm2C46Qw9XRPQt/0vhJ2/d/eOc/F8b0oNWVczP2HEp6lZ1GeSyrwUFuA5CRjqdQZnX
 PWLyhjJkhenplbxd6hcFeaHonh+cjsbLgi9a8mHh23SUCXOsetSxul5hgAfdC2G41xEG
 Yed0/boDnmQSTpzCJI1OYObZx4xMWUjhoB0Tn7Rzrh2936tS5JQm3reu2YJEHEWUZA0D
 J2BNwiYPyXyhBwkddK4k3YunKK1/lAjfOhhf2vss7LYQNY9u5g+/JVbI4Tsv51wXYbi0
 ByLBXHrwIql7aj7+in3c96abQTLRkzOPo5QvIwY8pNYQYEs0CcYr6cFJOvN9DG3FxVks
 a/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657066; x=1794261866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UVX7b6ntdrV+6wjxMqUvH3ly/pZHpls0n+hd4y9AHHY=;
 b=Z0H5UsWeHwbHr92k/07OAhcj7cH5Vv3UaSBdfhlvp5bv6/Je7kFv7tnCbnAk8Hs+vG
 P4jBbipGNrUsHWZfGQomT3gfGQJE9gr04im2hIVtrESlAagaE2onDQmYbOXR153jtiq8
 XN6FRUN6SBQ1yevt6QFy6feRDuAC04kUYG/+TsdsK/TX2V5NA76IIWAxq3FfQR7LCMa/
 X642gFNpYHddN7ymVPnl7GKkMedlYSbvSCvCAUmJpCcMNy5dvfpkVF54ZOp9qwMzZIVI
 elVZwyLUBfJR/PrVoNC97ORHwRLIVZmP9rUdkFNck6qVBGPLGoUgm4UHEWPTpQWXzSX3
 1kKg==
X-Gm-Message-State: APuU4Z/PHGlhciwfzctXg9NmX+/Vuly1ux0qV3HvZMmYgMASdhqk4dLQ
 hEoH9C0RuxkpQDYNoX5f38CHflJlHlRbfNULWrCPyA+bCgTqqaGVaBTtciRYxt+HLonKdm6lgP5
 b/mqMeJBkd0pr6eqmmuYJ1wOqPFxRhxdF2olI9EPQ7JkXa2h/MMlG6zgMgOEz5QDieePfXyuG61
 f1HSCfHg==
X-Gm-Gg: AYBFou0/yHfOmbgztMJgrwOCSTCv69znZFIc8LwzBVdnIeY5tqSsHWsihkGEJobrd1C
 ZajiM6V9jsMebiiJ/IxMhDHySRZToIRlVYdc0TBtoTPt9ztsgdVQ0wEjR3VZcQqGu//rEGX3ShP
 spWRPsfKNei+U6iz2MHydASZbF54Ns8MMy/8gK/Spt9v8H3QurA58avRb92BdZqUpRKpc+neP5P
 Ly2h3fsgrn94cbNqtM0PSJ41CsCDCtDwrvC8BkDJOKfV4d6iHBB/v4bd51Wb5qLR4GoUqbGSQ5x
 lbRTYEML8NPQePbVQqIEF7dcxdekNTLLF28aB7xlDDGwSEwTgcTcED4nkatc3jix6Tc8lR4nvFt
 vkS4ET1unmfzcik7d65JXFaoNTb5/EZl9j7vm6GbXmjDEbyooVstm7GYycSs37wmhA4GP5HdgSF
 kQ1NX0Vxkz7sd7hw1+afe23Q==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae897585bamr6338396a91.26.1793657066419; 
 Mon, 02 Nov 2026 14:04:26 -0800 (PST)
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae897585bamr6338379a91.26.1793657065968; 
 Mon, 02 Nov 2026 14:04:25 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c8329afsm953756a91.8.2026.11.02.14.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:25 -0800 (PST)
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
Subject: [PATCH v5 03/15] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Mon,  2 Nov 2026 14:02:47 -0800
Message-ID: <20261102220405.30730-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX9qUAUcl83b87
 +Ly2hvrktGKPcCCzfib4iSPFrLVEhePVTHgJ0Vv5175H3eni4GwoOVxqHev0pSG7KWaXUhRPBSw
 8mD4JWyNlwUogwIS3NyoLrpg6uwsNsfwl0jII7b4cJnSBVdzh9cGQjMSIB71G32TTmgUFqbb3T5
 whsnqauRJzQCn9E8VHFshuTP1kv+7EaPBSsKfb3WBDo4Sns9mzWDpfVrY7yItistkFbG22XT/v4
 Ctr6gef3ho2ky3y0zhWc+ACYseCBtZT0zLywH/bqxApSVtILhSd7PvZnD7BW3hhaMK7XNGwYDra
 M16Jfn6ZPZNJ0hXGcvbH9TBHBSXhV5KIcpyiKyPcCxcjHZPMaWhyJBkU1W/6/Iyoi1G4+RREZeC
 rvkYi1Ma3hbSKMH74zF3sE+YwSBe9SYwDd0f17o9ShjaVDGQ6KdYwGelsMzg0EztRoOPdc7Lq4q
 0auX16L0Jhbd/FDKiTA==
X-Proofpoint-ORIG-GUID: s8CFi3FibGRww-PNE8s4wcZVcUrnW_Yr
X-Proofpoint-GUID: s8CFi3FibGRww-PNE8s4wcZVcUrnW_Yr
X-Authority-Analysis: v=2.4 cv=B/wsQ+tM c=1 sm=1 tr=0 ts=6ae908eb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX04lSyGXIIyYO
 RpJuIRmil7K+H17qQuXNiPg+lK+/pIpqvHWkAQpsqISwMmZO9FolRn37+QGQpehnnb5tqsurg1l
 m/2Lir5ZdUBPWCi0OM2CFHQampNVauM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
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
index 46e2b921f4ff..83c0fe39a44e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -349,6 +349,7 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags);
 void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
 void a8xx_aperture_clear(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index afb115c3d7eb..f2b635497811 100644
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

