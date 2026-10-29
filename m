Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85982606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cyIkzQ3y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QXtXbI0Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC510112531;
	Thu, 29 Oct 2026 20:18:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C0B11252C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjhPo2104704
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+oVnjuYPbq3
 UHfk2AZIHMfqxpfWs5ivQGbBLfCTwFxQ=; b=cyIkzQ3yCSbYHnDpcmxjazIyPdB
 mcPma2N5phCwcezKRESZjY02YApPc7vnJQf4/SBEdB7SMAucaKciuW/JLZMuvQ6t
 HlfrB9/+WUbIJWrYs81v03jZMoFpqqYBni0GymzGdG7lROR6qgHtIF8KpXRSumUc
 Vip/gszIFo4hY4xhIMEdsBIyGnwh2ghbGbBMeKVrtf5WP12kbrYAPjulfvLcgJhP
 2xetnQ0C+ghTCJKp54uQSldFLbQp8Qh47TRaTIyt8HBCSwKLjxozbqcMhDOiDSFF
 czB7zLdM/otkeXZuA+w4JIvCOLu5ZFBv3FOs/GLGAz+0Qp/b9HpHSwHlgVw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44qamuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a06750c74fso1805253b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305078; x=1793909878;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+oVnjuYPbq3UHfk2AZIHMfqxpfWs5ivQGbBLfCTwFxQ=;
 b=QXtXbI0YzOsdKsK9/weD3CxJk47SuW7vkuzWpOsZ/wQWRpn/c5k/q9SRGL+N2bdJV+
 izHFmaZjUyxV3yol73XLOfsHhm2EC7dTuD6hh3SG6M+O7zsvlm4jG6XrQzqgk9X60meG
 DUnpkrqbycqgpJrm+lmj7jsjR8FTwOkVzrjOGvjoSwVw+mdXqLFLHcs2HQNe+eAl3O9X
 pSX9L0AKN0r3k78PopIvKCoEhB3CDTbBw3qAd2Gc/PizGeRjTh/vgyPaLCgx4GgrpaPV
 B5NL04ULbHEjyO70K3IU0aeTPIWv9PmVRgrMhvqXCibt5Z3186T/pSk2I+kN8bRt445v
 NzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305078; x=1793909878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+oVnjuYPbq3UHfk2AZIHMfqxpfWs5ivQGbBLfCTwFxQ=;
 b=pi7W3ygyIEMeXgEC0eggqxK2CUJ2VOJ6fGr7e1aTJR4ipVdv+wrrEfqXMiEk6ZHcAY
 vauCsr2FRuYAzG9a0lk+kcPem6FhmgCIn5KtQDJPSwE6dYO8zk7SZHl+V+SFWoA7Au+W
 1tZPJ3ZUi9YyEocWLiKU/kUjPD9r4Nswlq35760hEqqqUU4pknOXKbaymeRf7L1gUWxV
 QI0sDeZnaBBuMj8OctYcfpuATBKtuFcv5XfzHGW3l/zKUqkNTsdEWsYyEGcZkyCC20IY
 7/rVU61oiKWMVOiBVh1ZGR4qE4YJU6ed+kSFxouf1g+CZIKf5jztLEg0sfNfvC5cGjly
 SNow==
X-Gm-Message-State: AFq9FYIIQN9A5KdXoRS0ZEr08jRzQHht7cCnM0/NlKq53gtKSihEVaYM
 3tY3XpfkXCPDa/dy3uMmP7gIme/Jq3XEnU8AzhrdUkRNLGbOfKS4F7sH+kytLpVHZShcCz7QPZO
 meVp/9FARAusOc0n9ncIp96UgAppX6hRbBPKxW/dILxQxAKJfjMYsGvY+7gGohbvyje0GpIK8I5
 4xG58=
X-Gm-Gg: AYBFou1ETD8F2WH0jYBaDSTV87aHDAek4FT0Wi1ZZewjnhp8a07Fp4QVFjBjL21agIG
 +wDHUAiM6vIFW+8sv/aZQkUszfjOa+Fu8GVf8QUXEsUIVelmkPk29brI/FL2BYv2LfcHDgO9kgi
 FbX+n2QIxAcsuckdaVsmYcpxnLkQahqqbbVMDdAiYSDqQ8lkCcmY0m4i1Vp6y877sz3ZfLSCSTx
 /WouJ5Y2tBeelpmn98bi5mNiVy5uNy5vMcIvN7HIlENNUgyBjh1IhQPMgzxQncCKGQfEosPQ+Je
 ZfKT52gpSj3O6fxRgPDPTX6WnUjuTngKxR1f6YvdJ7I9AgNIUTjwuHgVlj/8hT4bjo0W0WlvdcF
 zme38JoFWYNmDzRhnG7CYyySnsO+qBhiOugZdo1n1wjOMvNbek40af3pZLclOJECNh+mOyYr5gg
 58QWa7BF0TzKnOrw3Gj/apL6U=
X-Received: by 2002:a05:6a21:7e8e:b0:3e9:f2f:a6fd with SMTP id
 adf61e73a8af0-3e9287523f6mr297169637.5.1793305078506; 
 Thu, 29 Oct 2026 13:17:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:7e8e:b0:3e9:f2f:a6fd with SMTP id
 adf61e73a8af0-3e9287523f6mr297150637.5.1793305078023; 
 Thu, 29 Oct 2026 13:17:58 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb05474fdfsm197528a12.11.2026.10.29.13.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:57 -0700 (PDT)
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
Subject: [PATCH v3 07/16] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx
 list
Date: Thu, 29 Oct 2026 13:16:17 -0700
Message-ID: <20261029201730.151754-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX+v1sgCgUNEDg
 TkwUc9IANTYh2OZ74ZSnKgByNZlzww0RzPvM9L8aSSD9d9lPB+FEaVQPixf3dXVqaovlBio4rGe
 878aAoUXXLXs8TpSSQzGH9S5T979/zU=
X-Proofpoint-ORIG-GUID: nKLczB7gu9smPhPy6fxZxSw-CTi5AnyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX4RBI4RSowqPk
 gELBs2EjM8vm2kNi+uLj3akOzvroeCoZ3dduhHeBbh82AAZIumjfPMF1u60vivUsnvQ/OX2mOht
 uFd629jh8OIHWZxYvHYiFhmNQ4vlSEyrCD+K19bZRDVEBuNl3AAFWQDSjQQgpsCjkXGS+xNN3gb
 3FUfoFo4M8XUCkLeUgPyzVgayY4jCtAea8inT4bWWPOyiK+zh+IhxIhVzZwvMQsAsm7jqfJhdU3
 Fr3Wy4S7UP2+wrGjg+w0HUhtPHkB3o6r+gK8RviiXz6XlLK9QiEnLfN04tE04z32/SODAazhFEw
 b0scfFF4wp+8e4NoDYHjH4HBCmVrsPld2e5AtFPF8rQ7aGnzXNhXXxFILi3iAno0vgAcPFTQVz2
 +s4bdM9scDJQlianvQKBVGFUhhNe01g/enJJwMvYn0l5zZiTx+tqDFUrvpTfib+mfHRxu/qT0op
 sYx5wMl2vyGM5wgJ2Kw==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae3a9f7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=b4MSL0WmfgirtTH71F4A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: nKLczB7gu9smPhPy6fxZxSw-CTi5AnyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290079
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

We can just simplify things and calculate the value, instead of manually
adding it to the nonctx list.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 795c16d88f45..a6146372cf7e 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -367,7 +367,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		  hbb_lo << 1 | ubwc_mode);
 }
 
-static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
+static void a8xx_nonctxt_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
@@ -387,9 +387,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (!(BIT(pipe_id) & regs[i].pipe))
 				continue;
 
-			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
-				*gmem_protect = regs[i].value;
-
 			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
 				gmu_write(gmu, regs[i].offset, regs[i].value);
 			} else {
@@ -635,7 +632,6 @@ static int hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	unsigned int pipe_id, i;
-	u32 gmem_protect = 0;
 	u64 gmem_range_min;
 	int ret;
 
@@ -716,7 +712,7 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
-	a8xx_nonctxt_config(gpu, &gmem_protect);
+	a8xx_nonctxt_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
@@ -835,8 +831,8 @@ static int hw_init(struct msm_gpu *gpu)
 	 * GMEM_PROTECT register should be programmed after GPU is transitioned to
 	 * non-secure mode
 	 */
-	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT, gmem_protect);
-	WARN_ON(!gmem_protect);
+	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT,
+		        (adreno_gpu->info->gmem / SZ_4K) << 16);
 	a8xx_aperture_clear(gpu);
 
 	if (!a6xx_gpu->pwrup_reglist_emitted) {
-- 
2.56.0

