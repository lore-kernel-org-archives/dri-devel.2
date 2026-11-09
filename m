Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED14606D836
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fgtp3d9l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuJho641
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AD610F372;
	Mon,  9 Nov 2026 14:21:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12F510F370
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFSiU311058
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mInqVCgb/Jp
 cHAFW5diV2Bd7SIXa0C+12G8PqaKwBHE=; b=fgtp3d9lwCGuLASp5DoT/o+Kcu1
 7KYMVdswK/M0LVXz8gW5lY9VoWVHxZziIAAM5EKHOjaephhahcL7mNyRS8NbGnf3
 hDsngt/6ABEmpp+9W5B0xvYagwA9wEJLvzfCNFin3YNpkMKvD/HJA8pjjnZyNF/7
 15yJxhbSv0H0jEdIWB0gCmGjny9OmSzE9dm1udddVo5Y7YUhC0yinIPCX1H3UhC7
 +v7ViUuPI8L4oolR/HIUoJP09/6lJkyso+mCJRsEmbcKuSzwcUOwfRYHVSzfhvqD
 Au41fBplpTZdjmwmlu0LKTmzBTwn/rYimT7/o+jOkxQ13pV2G/AnF5DJfjQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucap8s5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b08aee6b3eso802911a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234083; x=1794838883;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mInqVCgb/JpcHAFW5diV2Bd7SIXa0C+12G8PqaKwBHE=;
 b=IuJho6413kPYnLneUMsbcvo5X8Okj7DZyziZOqi/IR6VKlyO2P1XB30rS5/hp6tl5V
 HuTs0amfzppLJo2xulJTUnVmgbNEXP8WExuC5ywenHgy9pO990Xwfsz7p4OoPEtiPeJR
 11A5ztHGju+HuIRu1vr5VkK5LAd+moU5AxLjtcvmRdikucbDUgYTT7OHHh+MzDLBvbfJ
 tlHY566tvxeoS1F3BJgb1AHuwCYn2usSiEjvnIBS6xQrb/fUy4MGSRGl8Ts13nCL5zTl
 z8RgmRhMMM6f1G/nviraNW1A9B4UaLxKyejhxBDo73DWzNiJeSkNqdnhT216kLkawyDK
 EHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234083; x=1794838883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mInqVCgb/JpcHAFW5diV2Bd7SIXa0C+12G8PqaKwBHE=;
 b=ifIjwVVuidVuDVs/fPvIUxKJqbtIM+QAfAldtECQcd4LN+8UfYTfms0LzHOE9q+K3f
 K56YNzLRD+MqNwohJUudBuCPsN6h5XRvGkMQj9YAy+/9vmldx7TX11ynjGLpsAiW0Gj7
 OFNi7O7/VuCBggAlEiQkLOUG+h2cz9w5DIXRryl9W9cOfI8CqTaFcxBdBYvQoSWv8xvi
 X0+e7yVuV+xmnIOyfdvn3Kur9K03rX65hjXK55oO4CdMC0+yhNgTljHd7KLtM9vW/410
 c3WK6/ShSI83ldwUgKibbod874PxBLqkfaIN/fPWgY2W8EkNulhp0RoINH+IjEJviIIs
 t3CQ==
X-Gm-Message-State: APuU4Z+DlA+4kbRXa1l3FSKo0qEE/V1TkkE1adCPqWNyhfvF8SR4R8EA
 SYUxokpRhz/NDnbIQFXQ82uAUivkx3nSIJZ3mvvxj1nZZ+DBfJJHdJorhUExV53gvYyyws8T8/o
 wAtdAhTMbv9JDCULMR6INPypdEFEYj7HAlx65oukh6F7aDJm7a2wLhsigFPAf3rRkOoO8QBdp46
 /5rKJggA==
X-Gm-Gg: AYBFou1c9lfkAS8gDNlkzMU3wz/yHOH+xqLYLKq5S961RWHEom410BwkLkJwHKrmL1E
 ruNVEeFMmpuOqkMjrSukXURm5YQAzNYbjt5PH2tFH4tOxwjtYjhMdktQgOr1CKmS4uPf8nDmLai
 HTcwUFhEaKvH29jo9n9xdR5fC4V+8jcSSwOIf4QFoKIpH0JQB+qePUJbIso6T4WwzlBkRhWhGDm
 SW+7LTs/coGvhTZsroZrACze3bUVS8RWUr0ZkoWbN4geBWWytyiWvn2Rlbo8uimO12NOiWum6/H
 n2e1w6c1Fr6795w/CYoOW+4d0JGfuudIQ6OXTZjZuPi+9WAW8FsTeWNZIHELNhtlPiiTWLScGy1
 O4davkhHEwxjDISzJ49d0ZQwfKEfYzpRAecGMAl6zlEdFZLd9PoKcS2XMyU4ti1gmbY2v96TXWV
 VKkVVB05vAEMADEs9p4ORA3Ax5cY2AiMoPXkFNPxHj3eq8ouL13VDP5jl5HS6Y
X-Received: by 2002:a17:90b:53cf:b0:3b0:a9de:9880 with SMTP id
 98e67ed59e1d1-3b12d4fbc05mr3538012a91.33.1794234083414; 
 Mon, 09 Nov 2026 06:21:23 -0800 (PST)
X-Received: by 2002:a17:90b:53cf:b0:3b0:a9de:9880 with SMTP id
 98e67ed59e1d1-3b12d4fbc05mr3537978a91.33.1794234082926; 
 Mon, 09 Nov 2026 06:21:22 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b127712abcsm7260861a91.1.2026.11.09.06.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:22 -0800 (PST)
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
Subject: [PATCH v8 03/15] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Mon,  9 Nov 2026 06:19:49 -0800
Message-ID: <20261109142111.256630-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX0dTc71uZW+pf
 pwzZcD4c5aMgM0JV75scpqwu4CUQbOW/OiNZVPTdngG8FWKdmLJUXSoIP8szhI1OJQ84kWTMviv
 fZ4nIq6f0KvYv6T755YEQCBLFccscApcyLpbTduB3dwNtrS/B5+bxKrfB/NAySRiD4xK/eaSqgs
 TSraNQSNEt3DJkwtjpkzph1S6l+zXJL+s1CTTCL9QQBP/ambZPTUqh2YE9BPgVl5DZPBc2YrW/c
 Dvh5ul/7xPnZ9whkGraesDTiZgbxk6+HAgy3PMlFbU1Rldn+vpODHvtPlFJJsXXLhXo1+UipMPq
 lOaWVYdQoMAXM60pPaduVFgglhWYKVKrMibbEpLcaCDSpvBR3lgmzsSViuBQSICNqbq6sKhhRfh
 Qkoa32HsDKUwF8Uikqzf5gmsjo4QTw3xZ+OWqIdt3ILWvG9EfWzxRfJ3BsLXo0sXcqcYKzYyUbq
 SD4RKZNfZ4s9k/ltYaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfXwtyGWLrZtLzZ
 /a4Agf3CwbDAhzpbqFdsu9goIsZ1Q3SvM8PvF9KanA1cRZmJrqUto88qmBeoC++lfPozz7rw4BU
 Bcv+eFdYSxTAR0OwKpTTV7uUYOIedtA=
X-Proofpoint-ORIG-GUID: g3yf2wnwrZnPtp07xfqYr5i-wgv_HoxB
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af1d6e4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: g3yf2wnwrZnPtp07xfqYr5i-wgv_HoxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

