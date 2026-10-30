Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D660A2611
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bWMqRK0j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qiw8ttGu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D781129FF;
	Fri, 30 Oct 2026 21:20:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A71112A00
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAfrO799602
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Mvo7MCBtKan
 n098aYa75VWbgfs1Qzr3HITJBdPK6Xtc=; b=bWMqRK0jAzC9hiMUeHLN5I/G2dL
 ETokMUQEMbNyy4pm5qWIW0DXrp+h0Rn/15zedKBdZraRuGnoNerikPotR6bQj/TM
 /2pEw/JjbX9kHH9IE1+Hs347ilBd4C4tpy6Fb++k7ge2uYW8zZrvHh/yPVoZWhpt
 03BcXhVE/n/uHWtBpNoQDk+ymrfNgojH/ei1GAEugiqytV1CkalgBkItk90WM4t/
 /X89VpKRa2gWDD/FFozk5X18fE18HRTE2YwSZVwzw3hzbt9G+m5YsTR62nm7t7OA
 AFNNU+RJW7KYSyoumNaI+FewHinBaJJDMgBsJQY9geHxP5cfJPZQNCQbtPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x1019j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so795941a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395197; x=1793999997;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mvo7MCBtKann098aYa75VWbgfs1Qzr3HITJBdPK6Xtc=;
 b=Qiw8ttGu6Ule8L5eS0mPijHshlj4Axp/32oUfiOhLJZV1lLFiJBoLdUTh6xyZVF1NL
 OMhLGTMhHg7BfC0tssyp+pGPmjeW1gg9fmgk0u8dCHOiZwY/7my1amSFSHV7b3ON7gJY
 StLb2EwexPe4b7sxEvvzeFSg86fUOb7MXcZCbTjYAq2/VzCfLJkLgC/RN5zFVFvFWTqp
 f8WhT0FEOM9HpqyRLCWmCvr9SoSNPk1G+EkO3i5ap+tn+wVzGHXGzAwqlLYJe8LMviUV
 ceMekcUvoDUbfWRYF+qxXiv7tY3p3EeoOR472Swm7y09f3cNLCNaTdAftnDjUlFAIQMj
 APAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395197; x=1793999997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mvo7MCBtKann098aYa75VWbgfs1Qzr3HITJBdPK6Xtc=;
 b=LRz8d2EcWGuRKO2jJmo+U7xesFhifFmivfDSObIGJLFqZcb3VGV9UOVxFXjUlVBXK7
 lzSAZPNY32lQ2gpuWb2/rXXhyKiDlcoqJBVSWCAEhEg/RT7c//n57I0ZZu451fZZRq/3
 YW4UJ4q7Ksa2arG2ODVU5d8W2+7zA/0rNb4ISGH6cm2D+80CNUXnqYqezhKcktw3Q1rS
 uQdirxNNNpZ9ORPCx5BQMHdHmMCqyBsHLD5i2Ws+sehLmYqznCFdtNhL9JyaPfJ9vBnA
 r0gC30HwWVskAt0r/sdRfPbJeQC6YS/5m0sPEL6qVqPRKBwunDXR5O9u2aj/UnoQjej2
 twaQ==
X-Gm-Message-State: AFq9FYJranR1YpbD1PKzjp6enG9GKAxrDCpsuoKfw25hueN/YAp2h+Da
 qpj8PHMsHSNtQE5ES/E+3gFc/yC3zA/6gSmnHMx7UOkuKT2YBp4mI7LhYi43os8ncbDqZDteZlo
 zSkq7/uNPQqFCEs4ePYCg+yjPCaSR4yUXFHFCOEdDXCbejyPOxillx7PgeOltTYtLXFRNRlugTq
 fWtYA=
X-Gm-Gg: AYBFou36sgTlkb0V6fgk/K0wxSQjiBl2nUxaCPoFU3JeaOlvfaw4tawuwLGm9xfq/Ua
 ySFL+7aJwwRtbRY0Fz88UKYdw0sM9AlFSWQn7OBp4IcWg66D8za22oQfuaS6xq/izE8l/pHCDOn
 VZ+BHAOPhP9jQwo7fBPWtH0m67pLRelHye85wTM+WveZ+LeXFG6bfFRcE5qqZD3tS09llhVFWQQ
 2v4esiJTzydFvwmYdmyjK2wpO+qNoNcRSWJounKTWI/WLj7hrPcpgnuusY0o60InKUwRQWO/Pp0
 V8t8PV54fSILKcloCHNBg82SWX1btlFjIhl1KVKnfzqW1SiXxlrhAOtkHpguBEhU40KmKP7ArM5
 J9NWYBKzw5/DERuffujqXh8uUTnnKD8UXlq7919NYJsgI3kQy/lrnAlIPFcOU7SL2xMdOHSV+Oc
 OknZpjnM0ae/590o3j5fAyqnY=
X-Received: by 2002:a17:90b:2247:b0:3ac:7c4d:8be6 with SMTP id
 98e67ed59e1d1-3ae89836523mr2799611a91.40.1793395196888; 
 Fri, 30 Oct 2026 14:19:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2247:b0:3ac:7c4d:8be6 with SMTP id
 98e67ed59e1d1-3ae89836523mr2799590a91.40.1793395196372; 
 Fri, 30 Oct 2026 14:19:56 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845ecaf5sm5291613a91.16.2026.10.30.14.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:55 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 12/19] drm/msm: Inhibit IFPC for state snapshot
Date: Fri, 30 Oct 2026 14:18:14 -0700
Message-ID: <20261030211928.45761-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX+Q57ELAMuyWU
 GlZy0vIxdwEnUyNCG/4aN139/zTP6T0Zygpq3ESOZrcxtmF0Z3hXqDCiQ/MAFgOOhJCCM4HZtwt
 sF7bijDBkX7p/GtvYfncWaEHTxtTlYcLMu012yXbHlxdWA1Ex9WI5u4jixgW49fORWvGasdpQ+f
 0Zw1/iXaJfUMtAPjGNdcvkfA2eELjcnMuXJEJb5CkkN1EAe8H9Gos22p5N/2hE81OtETLaLNLSY
 qqYUhUiHBNurUkZ5S+IqMowSo4AGUmtCWpyj0KLiOMLPz44VDeW4UmvBfQAwUHVo97K7hHpk4pz
 AGWyp9ClWVQqVsX4kDhFs0A6gqdzm/DOm0XGjy+VvWlA2rOr+5jYfRVi1H5EO0bIciYNWZzK1Hv
 Gn+UfqYXXyfjyYPzhI7XQSNGcadZUw==
X-Authority-Analysis: v=2.4 cv=CLG/zhrD c=1 sm=1 tr=0 ts=6ae509fd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jgQnFmZX3A3noQDnNKkA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX7MNsmXcYTsdW
 JmiJsTYRH1nPMlJB64oom6o8/Pa4gtbRM7D4qgd/4BNH4OlYsxLqy2Y4/jd2d+gg80kwVqq4UhQ
 5RWlG2BuXX6wx+UE3pr/qUNZMzu9+MI=
X-Proofpoint-GUID: Z7as4TsDG1Mi9LmMgyghUz6xjvZmPiTh
X-Proofpoint-ORIG-GUID: Z7as4TsDG1Mi9LmMgyghUz6xjvZmPiTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300085
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

We need the GPU to stay awake for this.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index b0ddc02f67b5..224401b4ab12 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
+		guard(ifpc_disable)(gpu);
+
 		scoped_cond_guard (mutex_intr, return PTR_ERR(scope.lock), &gpu->lock) {
 			msm_gpu_hw_init(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
-- 
2.56.0

