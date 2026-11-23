Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C1606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JQyKKKnl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kf7GBLw4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E644C10EC7B;
	Mon, 23 Nov 2026 18:13:30 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B37E10E640
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGmco3025333
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Z1amoST655iGgyCxzXVgPyjK+ap9dKFBCk3
 BVwBzWnA=; b=JQyKKKnlGAUM4zzAwMuOoUQgg7/AT4+JYUKlz71miX6Q13GB/3t
 rS4oYltre0uYeIn18ocKhFVUzI9uirxwzHyIXjITAs1tXkoRODkessIIYxMDIdO2
 xSam1fhbvSk2iyJFna+3CEUCu7w1nICz4Q0o+5cIxz+2EuEFPNyFvdv1GKHR+Kib
 NAhpOIz1tUu/CYKBcP2taFwKVyCEvqPk3DyvW1MASBSaDAEHg47T4EAkgVdUVntq
 62vl3dfBkjevh6TG+YcDmLylUoqAziLw3tXsl8wSj7bW2SMosqncHgARkJZxmws1
 QLXc+JDk9gBrZT6v2/5SRCSjpK/QSd8/6iw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pash6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b45655b428so2499164a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795457593; x=1796062393;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z1amoST655iGgyCxzXVgPyjK+ap9dKFBCk3BVwBzWnA=;
 b=Kf7GBLw4Pr0Y9iZ0o/s2yLGWaHI89YYPSVNE6akz7BhQHR7I3k8v93runagSPwx2QP
 gdBLpTJlWY2GK9FeNAuNNAxr65sNnfbRqKkY16XCB5DWXi6+1cu8i+uCX+Jvie0QSN6/
 1vu877aQxToeHPZ+1HlMPtNCzGt4n2shcikWr0MlfGiL+KFM5n9n14H6Is6i5KfoD6pZ
 eHv/ck5oWLbwlAlIk8/LLnpOwjPk5gLUU8iGR9f80MFbX9z3YdmacOHowkn+rRe3xOgH
 wCnssEkon7/HvuXMlH/a7GxKeGTixtzF9e95hmlFmv303orzei0P03uADKh2nyqjk0/w
 hkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457593; x=1796062393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z1amoST655iGgyCxzXVgPyjK+ap9dKFBCk3BVwBzWnA=;
 b=pU7VFcz0+fOWhHSTf8srmjCYIE96HyKErwxquRM322gTqT+qlB7z96yG8Vzx1woX6w
 0Cy6LgU6OmbkI3+uJAbadk7Xsp7o+wlpqshtnhr92lfxbzHey13T9mu4N5Far0UxwuXo
 BSKI3KViLImQOrhybw0QhWwO1/WPS+ZVi9NsiColTIrOr/Y+aHBZyixqcM9znVbIE/FF
 K1HI6A7S3s2yCRTFyvlNVJ0UH5Jj1vW35QTXHdzZnpzqAsTCB6I8LNRdI7NsQ+T/rAYc
 lSLvZomDeAfrXcCG8pMDfRkyBNIPhJHTShiG9CjYvwk3yuWs02KmvFHfBQ+NN+UWFabr
 MN/w==
X-Gm-Message-State: APuU4Z/1QCCZSSSZ5Pi7VG0WIZFuUj9Uh5rOzocKYjZbPWsWeSJJhlyE
 1JeMT667IP6lCe6UyydPfYpb5p3LMMT0xP/xp0DAHNYui5ThLqszipD9jM7GqFNZxAC/luwV+lP
 nhCC6JgHNd2CKIQCLezUnjpvSMBRCL7vHVkA3u0OWgyQ4ScjlgUpFPvzfhV6H8Z5RBVfW0Tnpex
 Tdgd17FQ==
X-Gm-Gg: AZFdTZdjrwtn3SEuhab8paioq5eNCXTlftSHO5hnNb8CGUoJQgAuE1XemV/5Wr2xqn8
 6S6/yGJSNXTBB9tJhf47u+LL8Duru0xDsrjost05FI40Nd692fQFTq0Qe9lDkOBfbpIuitC0D85
 2dsDhpLjxAFmha9EmGRIw3OlGpeOacnhjvafXIO5hd/CipHF1+FWa8TV0yAhHQCl/mfggOHb8Oa
 PF78nmBG95ZpJUb4GVyMi7pC2sn5wFtglx0DuIsUHpxDdOtnUVwQdDNs4DscDdf3TSylwE0TMMC
 3309rms47iXUGVK1fEYHOyiguBrO4qugVsrywodTLAsSMGgsbyUMnOWEUlMgjLBZ1SGPYsWgveT
 o9IaVGMuEcG0qBjKBo2cxoJz0iW8dCtvSJaVX6gfHTYXCW/pfjcJkA76nPRAzjS/fsUv/uvENMn
 D+l8ts/l44e+UwpLsia1q5yaQRZJ+cLXegnOfr+Uykvi7Rl78R+YkdOUGVxmnCEw==
X-Received: by 2002:a17:90b:2e4b:b0:3b3:886d:621 with SMTP id
 98e67ed59e1d1-3b41c9e52bamr10846011a91.34.1795457593371; 
 Mon, 23 Nov 2026 10:13:13 -0800 (PST)
X-Received: by 2002:a17:90b:2e4b:b0:3b3:886d:621 with SMTP id
 98e67ed59e1d1-3b41c9e52bamr10845988a91.34.1795457592912; 
 Mon, 23 Nov 2026 10:13:12 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b7a8c64sm7779412a91.3.2026.11.23.10.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:13:12 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/a8xx: Add missing preempt_record_size
Date: Mon, 23 Nov 2026 10:13:05 -0800
Message-ID: <20261123181306.420017-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FcWy7VW6MZ2xcfphBPA9F0JBALGNWSP6
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b04823a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=2OSpH8Mq0sc3u4_c0_oA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfX1eyT4RYDtHX8
 5vGq/xZ4o+YG43/ZJyAuZlosjpa0q0SW64JQEA6MXLjiNPUxXsIXJfwwc3McyTqfQtqK8nIA2F4
 91IDV5Em1eQaSYpdiBgI4CQ87ZXeVwY=
X-Proofpoint-ORIG-GUID: FcWy7VW6MZ2xcfphBPA9F0JBALGNWSP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfXy0ntQsjxrwZt
 D/Qr75KLG0/j2zFyIKWAYZm8JEccLvotqHJRhQbuatHq50nWikzLd5FIiojn1HYhSom5aGFI9Bd
 U/9THtEWNmyFN9QTjVujPAcCBFlCWePPC1CHdtE/WzNzazUFhBy6t+0qPuCEo3OlWnqbR8l86im
 3uSLdkksJNhR6KHNyglChqBgzHYDalpYmCzLE7uBIF2DH4SEBk2PPfvbdgyJz2CQKYcXpcEtWVx
 jQvrLiuNaYuEpHR4QdaRWmQrYZ+Q4vjOdX+oDFHmVUzeLj+qHs6ZxlpNLoEucqtfpzYkYMJosLv
 GigFTATT6fxx32ldRteiMeEDbCeuVxCQyNSAHMj/YFfdrReMzRHxldXiFKo9L9UygbOR0GkPdSd
 oOVG4aaacQyZAPUPxeoM5vIlrgfUPMYc5DrCI7Ci5TVw/cIRNTbMpnE8zpi283ws36rnjrFsDNT
 WFcLKs8HXHKDLB9obCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230072
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

Somehow this got overlooked, and Glymur/Mahua were falling back to the
default 4MB.  Which is way too small for the amount of GMEM on these
devices, causing faults in cases where preemption needs to save GMEM
contents.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Fixes: 7fad33097e67 ("drm/msm/a6xx: Enable Preemption on X2-85")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
v2: Fix typo in commit msg

 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 0c6dde3cbea9..20fe93b83c0b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1337,6 +1337,7 @@ static const struct adreno_info a8xx_gpus[] = {
 				{ /* sentinel */ },
 			},
 		},
+		.preempt_record_size = 23088 * SZ_1K,
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 388, 1 },
@@ -1469,6 +1470,7 @@ static const struct adreno_info a8xx_gpus[] = {
 				{ /* sentinel */ },
 			},
 		},
+		.preempt_record_size = 17712 * SZ_1K,
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 388, 1 },
-- 
2.56.1

