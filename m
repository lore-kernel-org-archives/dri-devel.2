Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C407510AB82D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35ADF10E180;
	Fri, 27 Mar 2026 00:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aO1xPDNk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QKP6bnwH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8F110EBAB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9pSW3898437
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lWzxoxI1BoNjbMnzfK+mLddqJ9V6D8F7yAlBnaGh3Lc=; b=aO1xPDNkqEbv4+vM
 02h63L2kgS3h1tjvBSVRbtD7qn3OdH2WjwSEEEBJ608Pgo9/XRcS8pdPmXL43jvm
 8thtjL/aTl2hdQuLc4RKsNM94mI/n2RJArTm1YCMVWHoaDJ8oF5dl/i2GkOwx03A
 lfzLr3dobEN1vstiE90Uhjz2rHCpeAGLcuNc9IZ0vZvvapYH9ONl/43gAxvQZZih
 Pm9srRRANWg1AKbIabkImDwqtKnpvtlz0HTVs5bSrmf0l0sIZzsahweE6kP142m2
 IcQ0ro17lOaz1L1rqUSxpVxFA8i/LcRcwGec7HNdEWCdM4YTPFwyVz9YZybuRhk4
 9qCalw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kgb885-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso4838898a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570490; x=1775175290;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lWzxoxI1BoNjbMnzfK+mLddqJ9V6D8F7yAlBnaGh3Lc=;
 b=QKP6bnwHcrTl5mVDRk8+jDphbufoxqssufc9UFQtXty1+wxT2RbCDWQOnykV5zUa/j
 3aUUbznWM7MzsYSWJ2RgNkPxpRtwKXlcMDl8oz/GsFthWm0Gwaqf1EkQHlfsfmDZbHk3
 OhGLokDddhute6Sbt9bzCDjnkr9nFO0vxRy7qdPRo4VdqfnlzNhNTCxCyIbhFYK6JfUN
 eMVixbDnkEdb2nI2KAZ4d4rrMzt4pVHik9/V+efANQOKH0lb4KUUuOWEQa/wSq/TPqA8
 hGgzH1TNqAjJEWp3ogevT5g1aXbCz9plM3Ho0HofndeQ8FK2PmCwhfjnbsROAxEGNQuf
 pQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570490; x=1775175290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lWzxoxI1BoNjbMnzfK+mLddqJ9V6D8F7yAlBnaGh3Lc=;
 b=f38/V7PzS9fTZbzBzN5Z/mvAy9vsq0motTvGhwrcqjCQprRUIuIXvCGt6JpIDQGUuY
 E+Qt5XVF78r2DzfACT6hyiP7CuflYNPAak7hnIndzYfNNeNd+e9tyaZfeKSov4i4827Y
 K2nltGUX+Iu9nLBE/d6wBYeN9k94cBzT9aNFHMkOfEgYg07oHT47fYQE7P9BVqitHHn+
 Opg2DtOK2+xAXRpcqmipwAtUKFLACdXV3czpxSbJyFe7Dp8oytAI6nK0jGdAouMc0x5o
 SomZ5pcjI1ZhlD3Iam4VSACZ7SdqEzPihMKsQ84KVlFSzJdt6SFHx4fNWoMQOrSU5iyY
 mnTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnioH73GbMLsVttKvpSc5LS6g08TPDlTXoboYOjXn6FAcb1+NWzkU3Lw8uD+DuuZB2Ho89YDDoC04=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2wA+pWUp2LH28g9E5+yoZTE/Y/lBRDUZFpnNtlFYlmh27R8Ta
 YFmmaFCOObobMnvFY6BZZHRLf1GFXnPpLfA+/F/p2BQ2b/8Ob6ThqqbciYnJHcWn8bXRyR0FJdG
 PPcJaTJ0tzqVrg7Q9YOYnQflPxIitRC0p0hU67EMQ8FwPdOflhiSaiNG4MICkyvJKCxUmn5U=
X-Gm-Gg: ATEYQzxnMVJ8lo7d7+h74/zAJH2xkddY1V2QDi/kx9ptS7sNGKq4gU3GQwkKIubrZrV
 GN79UsSZVsS7zZIw1VjbGrg2QNBrlrzDRZnjuNetxHWvBoGO2QIEtY4ByFDLQhiCNqs1FJ3J1n6
 qXurDu7rzPjXSwji2S7iH5EiPsCyMlZsq1IMtLaWAmi3XSj6zKIu1Xp6uJ4XfhISko9ANOlkeHA
 LNz59xvkgjyDHxQaEC+sUNufRb/EvfZl2s71/t0mMf+n0SUVumJ7VlNWPxIv0dbwi38MkNZ3pw1
 XDyeNVD5C1AOxWZj+kmCc+smoCoW7u3+Y7r3aGSaJrmiuVAhYLeLJi11o+90eF9MmlKBkUnUMc6
 HSuXNWoyy0V77QZYHEQM/QIRJpQ313Hz2XtAXnOI6cLPz+w==
X-Received: by 2002:a17:90a:e7ca:b0:35c:f82:fef2 with SMTP id
 98e67ed59e1d1-35c3002fc51mr480854a91.14.1774570490293; 
 Thu, 26 Mar 2026 17:14:50 -0700 (PDT)
X-Received: by 2002:a17:90a:e7ca:b0:35c:f82:fef2 with SMTP id
 98e67ed59e1d1-35c3002fc51mr480825a91.14.1774570489808; 
 Thu, 26 Mar 2026 17:14:49 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:14:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:52 +0530
Subject: [PATCH v2 03/17] drm/msm/a6xx: Switch to preemption safe AO
 counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-3-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=3298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=U5fwvqTvmhxC9U5Bv8tyvwyqOYj/HJbmdaC+3G7oXm0=;
 b=Sidpep9VrsVhXmKIRsMrCsxM9lVnQeKh3M83V7ET7hyl3L6Q2czyJWoCujkX06x2zL3k4BeNV
 QV7C9ktpR7RDSzKmRcOThPkVNP7ivyR0mV4Yr6WSswrTkEwVdgqFi3C
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c5cbfb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IjstctezsF06UAORExcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX78W9ozCg/ixB
 hnkcWii8gr1oIZeM30KUAwnqWfQFlWBjPG1WYIT/mRmqrn3nIyTCDskueMFi4Z7uvkkxQVicWXf
 7+OVe90Hd1J16hsctbSgW0zDMtLp5Er9Hz0QzqXc0NtnjEDWO/EsYpTI7zwHnlkSmCAAy/6iI6T
 jjePiPtdCCiW2Akax4EM9emb5PhmgkJgrmkg01Qq5sTMeRUNDNj8J8lHAa39mg26xkEHx2eBeCI
 qBaLeGOgk13+pe1cAqI8E+ro5tB7nSN8BLlB5hcd65IlpDT4lnpQ7Hpg+GXc1mszuAH5NeACIUH
 WPJ+0KOfSl/dg8GwebF5gYStSe6343ucN1F7CC4CrVJ8j9Bnbl1E+82qRcVFVCuXOqY5uOu9ULk
 V53KV+e6N3/C8TNwjP+dOw/uVXyUZp9ASw9P7N3Z/NMgn+SGwPONPzi+cj8Aw+g8yRTcrOLwtEb
 2Z+VFF3wRNmJvXfMEmw==
X-Proofpoint-GUID: 5mwm5WiXoTA52ldss_o_89WvTv-y9_O8
X-Proofpoint-ORIG-GUID: 5mwm5WiXoTA52ldss_o_89WvTv-y9_O8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
provide accurate data about the 'submit' when preemption is enabled.
Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.

Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 50bd7aa4e792..f8cb8b578661 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -347,7 +347,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	 * GPU registers so we need to add 0x1a800 to the register value on A630
 	 * to get the right value from PM4.
 	 */
-	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
+	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
 		rbmemptr_stats(ring, index, alwayson_start));
 
 	/* Invalidate CCU depth and color */
@@ -388,7 +388,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
 		rbmemptr_stats(ring, index, cpcycles_end));
-	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
+	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
 		rbmemptr_stats(ring, index, alwayson_end));
 
 	/* Write the fence to the scratch register */
@@ -457,7 +457,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = submit->ring;
-	u32 rbbm_perfctr_cp0, cp_always_on_counter;
+	u32 rbbm_perfctr_cp0, cp_always_on_context;
 	unsigned int i, ibs = 0;
 
 	adreno_check_and_reenable_stall(adreno_gpu);
@@ -480,14 +480,14 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	if (adreno_is_a8xx(adreno_gpu)) {
 		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
-		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
+		cp_always_on_context = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
 	} else {
 		rbbm_perfctr_cp0 = REG_A7XX_RBBM_PERFCTR_CP(0);
-		cp_always_on_counter = REG_A6XX_CP_ALWAYS_ON_COUNTER;
+		cp_always_on_context = REG_A6XX_CP_ALWAYS_ON_CONTEXT;
 	}
 
 	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_start));
-	get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, index, alwayson_start));
+	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
 
 	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
 	OUT_RING(ring, CP_SET_THREAD_BOTH);
@@ -535,7 +535,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	}
 
 	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_end));
-	get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, index, alwayson_end));
+	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_end));
 
 	/* Write the fence to the scratch register */
 	if (adreno_is_a8xx(adreno_gpu)) {

-- 
2.51.0

