Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800406070DB0
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZ/6DMHv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QwPwV8n6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38C310F063;
	Mon,  2 Nov 2026 16:10:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF3610E6BD
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:10:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpSs04070572
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=K1G25hLX5Ki
 186k1LXjEcMy3Ym6j6ix6RM1pmAIlnWU=; b=nZ/6DMHvFOP6HTIDfQjspkEVds1
 69STLXYocEUwu8Pn+QVDmBkvH8Z0bQJsV6nRgmmc0lYllnlyCR+4eQ5Uz9u6VHzC
 fSKOMvGiCXb/B0iyuxgnxWTbQASTuP4Gm2IiKGKqfW5/+CGYerefgsrsfs8HtBKZ
 oKqVg9si36x9J8TOSw64hyXhcEQSksWW+z0o41e7ds9zIsmNkPpD65Fo+NPinisV
 rDGLmHe1RSKmEkscUE+9xd76obBTe7vKYXktvOLh/chxncvmdwG1rxtF76sTvi7K
 FnKV3W4rRgG5WnHCmh0nHhxqnLKMiuc+647hv9V4zXvbCgGqpcWRmHwLE0Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5h7du-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 16:10:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a05b68f851so3819213b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793635811; x=1794240611;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K1G25hLX5Ki186k1LXjEcMy3Ym6j6ix6RM1pmAIlnWU=;
 b=QwPwV8n6Br3dkHBWoxEchafsC2t28Xh2DbySpsJhQbk964gzI2WEyBlBs137iY2IDv
 tkrpds5eCK2I2KNZwREkZhNdOsRSTc9ME0xYzVKBRugLb910dIJckqXgC8rb4aglABiP
 TpBcgV4afjToWDe7Qx5rcgjbP/s2/PYiuSiwUVSVKDfKDAcgUVxCOEIgWYPWVLzKhgah
 8vj7FaiOmejE55cQfk5z8e7LXgS6MJ+Q1KjIS/Zh05DTle8tWzfw9EBgBUFpGOBoKSWk
 sbEwi+TBOL30O86L65F1vg9dDrM5dY7QVF+0RAB4JBbJXXI7A3S0qjaYPo3pyH/EeHmm
 V2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635811; x=1794240611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K1G25hLX5Ki186k1LXjEcMy3Ym6j6ix6RM1pmAIlnWU=;
 b=xwSVhHqbe0dWNEtpS5uqZLCH2P8D5yBG6WOWmbK8U93pTc3LGKu/iPQfBPhCRXLbtP
 647Q7VLcFNRObQhvDIht45szZecZBJStmKQhlEgv2RrQrc1BdldsTj1sX8E9tTTQtbp5
 Nxdid462cv4o3Idc3j0vISG458IVfKKrBbyOqwV7NMRFjYmD7wZeSYOF2thPIiKMzSpA
 Q38uctXKvELyn8cyqInbyjzwozBpvYPueRGFyHXgpGjZ1yTAwuZDXSPXULXuzBjdJ6Lu
 SGFQ4zaarLvFJAyOXNbCcRihvUs2f8dRLy49O/2+YRR3+a6JDre1IHHWxIvqa+7c1t/J
 mRGA==
X-Gm-Message-State: AFq9FYK2viYig8x2fBfgefCg69lkKkBvDMkClK1L8bYzF2MNKYGfXqff
 jrGebnhQK+9VEPtJPeCmA9COaYlk13HvUDIJMWrnkjT9ulikPNRYQn7yOenEkT+2TRidSgeyqbW
 Q5ODihxbaBjL7bkpS07BbnNBRFM0x8fjkdtEo62ebtP+cp7jaaFmNOfEa7qlj1aeLqQJsjjpDjA
 CH+8xQng==
X-Gm-Gg: AYBFou2a3x04DSV5FNHPU602b/Jfyk7qgltSMx88IQprxwizfAD71z7H9X/WXP6OA1X
 EEWQ5mSO+nfb/IIKzNkfGHitV3wG02w+ztKBrQlkFLi4aEnZgY5P4HkCHy7mSkFdinGe4ZJriXK
 j7c3J1UlhUXQlDz8AcKhy7/vyprXXXunlsl0SfhdWyNWrXRuSUD8H3H7m7Op1b+ofX2Zs4c5Thx
 Sf6fSSzOz/9VR2pmypYHwf3c9mObMEjcBLBKx3bTOCS1/uH9r4iLWKDo9AjBLMrwK0nhleKrkBk
 R5IM3ivBKPAicg/0M4dBfdwLdNbOv7qT+GVI0shzcaF03/n7xRJnic8kIdfn3zZ/ZP4Y6MXjp6f
 82u640PygJ/NAR6LwEP4XlRS/CCelGFNX2M90T9HUh2JscjhsjOXdHopMdEJiEPGrCpO901BCnf
 HuHGok7bLIkQUk+jNw7NTpeKA=
X-Received: by 2002:a05:6a20:7351:b0:3e2:28f0:b360 with SMTP id
 adf61e73a8af0-3e913590580mr9379221637.0.1793635811258; 
 Mon, 02 Nov 2026 08:10:11 -0800 (PST)
X-Received: by 2002:a05:6a20:7351:b0:3e2:28f0:b360 with SMTP id
 adf61e73a8af0-3e913590580mr9379200637.0.1793635810795; 
 Mon, 02 Nov 2026 08:10:10 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364902dasm57218a12.20.2026.11.02.08.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:10:10 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm/gem: Decrement loop idx if handle lookup fails
Date: Mon,  2 Nov 2026 08:10:01 -0800
Message-ID: <20261102161002.497152-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
References: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae8b5e4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: e17GPCK4C8AUZAXhGwD593xR-wLBwClW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX3x0aLI2JWf77
 VcvORE56A/fu7r3a+SvBRfCL4NpK/2/7/0YUloiDuiEzR2vp/tcmal4alyecYGpANOsuSmJ/sby
 VD557NL/YMV5q+bQwLBf7UO2MgbC4z3/dDa0iEC7AgXPR40+N4hQtTzT4ylSzo2jmAvI2++vO6g
 A1qVNOdudReQj5OD9CiuQbQRGUqVz3si3cNBtPmaQzSugpDHCX8C1ZTShVfAeA3du5tRvPCYwRg
 KhbkKkeeyRKjKOyoWXWl2Mh1WWOVNZtPNv5bzpvqTA6rer7bi1YYjJJWK/BE1aP68jMbYre1l6l
 /HO3KGsFLk3+Bk/TOum/w3BTo6Zd1Oss5nLhNLLpz9cMi+TRVxUqZ5oYwbGcmck6GoqSyhwCSfb
 yjSQhdpBifSTeRL0b5VUB0f83lLezTBD1MUAyrJR85FkYvx8BwHoORSggZSwqxail/LYtHrhuGj
 juliEzCqM3AkEyebxPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX5BUWlyGx1iKG
 UcWoKjygs55COWrdjv7sq9kBdRW9jWE0oUbfILNVL/UlfRFWva1dpMSEOFFOJ/EspmbhZQB7Agx
 IWhnGwFJyY//JUNxhOmB8CiW1nUb9cQ=
X-Proofpoint-GUID: e17GPCK4C8AUZAXhGwD593xR-wLBwClW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020064
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

In the out_unlock unlock loop, we should skip the op which still has the
gem handle instead of gem obj ptr.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 922285537dee..4413db0644a2 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1110,6 +1110,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		obj = idr_find(&file->object_idr, op->handle);
 		if (!obj) {
 			ret = UERR(EINVAL, dev, "invalid handle %u at index %u\n", op->handle, i);
+			i--;
 			goto out_unlock;
 		}
 
-- 
2.56.0

