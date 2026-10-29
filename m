Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012A606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EC7ofjzx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jUy4FNlq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE05112509;
	Thu, 29 Oct 2026 20:19:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6584112504
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjxvh1708213
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8ezEVu/wf9L
 Ig8Dnb2467LtGKEBxep11x0ghaaw5IxI=; b=EC7ofjzxolr8nIxz3oLc7q8L5Hu
 FeKJc01cKQpzdfxSgPkfzno5pNxha/enC7hkjkhVqOghsoYPINxQwF7EZ61tZcJJ
 grUlU1LqLAaRI3XtdvqXqrXEyot69XH0zsdhijexNbss0imw2yov60NbGXGZiTvq
 5IMKqVJdWIxckG+7+sQ6hk4AVHLAgT64L1LSYB1QJH30IXNnJuanpebQpokiHtz3
 AWUAiEnqgJNz23l8iC7eVLl/CmfpNt6L4HldY7RoURnvnqWQynHAvcu6zFtjYvt3
 qsbw5Zv5ngO81pVdwO3vLukuuzTV/YI+/P03WTfR4oo12rMtNu9Dc7A1QJw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76ck531-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8a0619b1fe5so2038562b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305110; x=1793909910;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ezEVu/wf9LIg8Dnb2467LtGKEBxep11x0ghaaw5IxI=;
 b=jUy4FNlqMvIutOGluiM+LCeuoGsbwrAq9DqbYh5aAbHHuaySx/5BKMTqvCbHSSzO3U
 RGIiT0Re9eIHM47Rj44RbV2WNZBcGHhqW2VGU2e/fiEpswc8ZDMaPzGE4ezbYRDWhWOJ
 yAlLk54cyDoMhPXFf6DPWxEFsFXpQv/cYLvan0RRdBwXRWp5tGBN9B+Q8uybn9pcQOy2
 QLmPtHFQlHbKa+JznAfEcva719PS/Iu3wgUag4hqfEvWJmU34G882RTJkRoNpI93/Bwz
 PDcEL7eUa16y3D+NsudmQhKY2rbG3GxJOdd1bd9N+DzKhrAnV/uN3hjtrY0bHBs9Hxvu
 ZADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305110; x=1793909910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ezEVu/wf9LIg8Dnb2467LtGKEBxep11x0ghaaw5IxI=;
 b=wNJRdIAumZn4lvYxSXowTYAkkEScZxpG2CpVjRA9HWukl7B87lZqB2nAglD13AmwzH
 IEcZ/YGFxDG5LPB2+gyUo3R2IvDjNW3rV/OMOPUQOsXHPDMA1c6/M4W+fbBYJKQftGrL
 or9DPf9N5qwnIqyHJXHa/GlMcu7Q6gWCYrkNT/ZluadlZbmA13hGwfclz1UhaA4GMh78
 2L8y05NeaziUrau2B4Evb1tftLW6nGML2hrfaIdLr6SPrBP/egMX7zU1bijTB73+Vord
 auMERfrqsHhJxNtHbIPgt8X04iKSJTkkm8I/nRIqIBWnbWnoahS/z/7IpO8ne2vrGX6Z
 dvYA==
X-Gm-Message-State: AFq9FYIKHMfpFEucuyTaLohWYrHv5UPN1ZOnT1TXwRHc9C8hC2YlvCdd
 DBaTpsfoT+uR7y28pX3sNSx19fv8YKSULnZXFzRuJjMpj8v/iQLbytJSTirjc1PTaw5UHc0ihtJ
 9SVfmfet/DFh/uKBKu3IXvwYygscQXBB3XNZhxPoYs3I9ixYKfBpjhXmx2pXbJWoD9/xwlpm4zB
 wQpHw=
X-Gm-Gg: AYBFou3STPwnYC/6qgmJtSIPDtHcKUJh3aKHLPgW7o5PHOsdTGFWLxjMxRrPxHECZti
 Qqu+KdNTGHqnnNPpnkSk/RXZ3qsYEC7Ds26sC1oVZWwquzLzmEBEkJMNjxI6NsVM9Q8uGb1xTcR
 /51c0t3EQTl18SKyDZTeuQzYkgWKU2gvG0VJ252JzVdk7QZ4zWQSxxmAI1PBL6tStM7gVuXhraC
 3jzbzZaXloKtIKyD4gYghYEVOjZj7pL6yfdt23kH24b7Uc0RK7ARE1k7D3LgTGPjrlcrpME6njg
 H6MmxJXqWFLyCvykUOF0UT6INcIb5ZXhWWD393MXD2VK4xZeu8BGUdUucf7pdR/KcZBjm7GrdNC
 PskF7wqnqadZEh0+Ri03R1aifmy30Oxlou8zlxs7S+QugkBIG3ZR32qLl6LuXUdz9JeC/Zm6m39
 28OEUsT+Z5UmbPBxoO+qJOLQ==
X-Received: by 2002:a05:6a00:1393:b0:899:27b5:214e with SMTP id
 d2e1a72fcca58-8a9bed5ba40mr156462b3a.30.1793305109764; 
 Thu, 29 Oct 2026 13:18:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:1393:b0:899:27b5:214e with SMTP id
 d2e1a72fcca58-8a9bed5ba40mr156437b3a.30.1793305109321; 
 Thu, 29 Oct 2026 13:18:29 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a98a2b049csm254918b3a.56.2026.10.29.13.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:18:28 -0700 (PDT)
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
Subject: [PATCH v3 14/16] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
Date: Thu, 29 Oct 2026 13:16:24 -0700
Message-ID: <20261029201730.151754-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7-wxaqTqwXnSA5XvHQPyFPzuCa_ygzfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfXwJWgOVYNRXop
 d+EZQNp8clyUiHfKbENn/AiYBYTPDW6tVTmrgTrLL3YpHj/4/Luh5IP4dN8A3tVciXPsj02vsx+
 E+qdluXB/QXN3UncPSYSmdHrok8rV0oIWQcmRRctgWN8jJMWn9TQk/xe8PRxwEPhkBG1ANUBP9F
 mJvLG5zqQOCQOoqZi++2GYdlTbA//Zkge2/guECG1ZZHwx64pkoZ5uZlbWVoX4LQl+idrOHlHuF
 xlYHsqF328ITT6D5eNRtY6nTeKo3bA0M7HVce9K+9nqzg3sgJGQKss+nf3b1IzFVJ2hFrTJS3DM
 9vt2Ksm2dmZvKED9KG5/zcXifQ9G9aQl/u6x3JpJn0BwJ/CAJXbZugIdomBJWgfeu62ddMu2ztu
 Bl6MFOKH9bAOcp/kA+W4RqzhS79Mc4ZKM/CcgK1J4WEB32bcuBJjjOpb0oQ9c+YU0G8XwsPurgI
 oXnQIOwLevZw54nGflg==
X-Proofpoint-GUID: 7-wxaqTqwXnSA5XvHQPyFPzuCa_ygzfB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX8n9597nxEEBU
 0VK5hD9es6kk58GrqnH6dY7n2KQvUujZg5iiSSlS9KLv1D48woIcn6MegmJmg+l8M3Xu1T3504y
 wnAHMW5V2+EhBbvxjQBXk4NtsVOVcCo=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3aa16 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Dhg23qV5XRRJQlZlKu4A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
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

If there are not enough global CP_PROTECT_GLOBAL regs, we can use
CP_PROTECT_PIPE regs for the extra spans.  We just need to configure
them the same on all pipes.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a6146372cf7e..1f8dd688b967 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -258,12 +258,21 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
 
 	a8xx_aperture_clear(gpu);
 
-	for (i = 0; i < protect->count; i++) {
+	for (i = 0; i < min(64, protect->count); i++) {
 		/* Intentionally skip writing to some registers */
-		if (protect->regs[i]) {
-			gpu_write(gpu, REG_A8XX_CP_PROTECT_GLOBAL(i), protect->regs[i]);
-			final_cfg = protect->regs[i];
-		}
+		if (!protect->regs[i])
+			continue;
+		gpu_write(gpu, REG_A8XX_CP_PROTECT_GLOBAL(i), protect->regs[i]);
+		final_cfg = protect->regs[i];
+	}
+
+	for (; i < protect->count; i++) {
+		/* Intentionally skip writing to some registers */
+		if (!protect->regs[i])
+			continue;
+		a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(i - 64), protect->regs[i]);
+		a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(i - 64), protect->regs[i]);
+		final_cfg = protect->regs[i];
 	}
 
 	/*
-- 
2.56.0

