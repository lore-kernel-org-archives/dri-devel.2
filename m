Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0540606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ALRfDkGX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AY8qm+1f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158E6113042;
	Fri,  6 Nov 2026 23:23:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67F5113039
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:23:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoRJ61105104
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mVy1ahp/P6z
 Kdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=; b=ALRfDkGXfTnQsj/c7be9hGwskhm
 VAJZntA9czuWMltnPizvzIy1oP5/nrIb7fj4lgH2lVQWU0aGxEp4S3bZ26278wQM
 HEjuwR9xFYXE4SRDpRCqwcHeJoqxC2i3qJBkps8npmugHvQGSQEnpTZf1aYXlbOu
 07QP80QnNxVFUH3jURPftHu959u5Fk78TAf7F5dChAR3ZlsynHvyudAYTqQuMSOu
 5fGnQjr6LSo5erNOIWCsFXlCJ3MKzexG/ZLsI+1BP+Y4oEUQi7OvPfTsqeLig9wg
 ZGxYTlCDwmvfRQkgD8If+cGKZdrwgprs3GQCHgfdvaGXkFIBjGs/PRUKd6Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk3wh7jd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:23:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so1821217a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007403; x=1794612203;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVy1ahp/P6zKdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=;
 b=AY8qm+1fp11qrPPrKQsOJSay4lkx+Lu0zolVepmUqNCfMsBqOdqKaU56nQBRpDmIwi
 DOwjdfUcek+OfP9y0bsg179waeNpAHVCCDHMZrG2H9YGuRyG5PDZbA/7LjORqnfBW2hY
 E7+6OAewhUNKDHD2DRPI5G454GXG9ellCl8srNxnpFrM6fsgpm/ETw4YBZkOpBUXYl5N
 XndX7cK2zfRpOAFHThI8uL0yQXZwocaREK4sbTzFGcv1LLAEqOqkxIY5J1CEE6cmVx1k
 wIeIfYKh00lH92gIVIIOjeYPRU9ES4LhWaAR/rw/8CSOR7JXkp/UwFQlA+6e/u0nxwEH
 7oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007403; x=1794612203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVy1ahp/P6zKdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=;
 b=pkpsi2Xe7mFoqvRNQCHRFN8QPBdRHzK9rtFbeyashFpPDF34Rv/LPOF/bSW1zr7+zp
 UC+mkpeeszquyVso/q0YSKlgPtjnnhosfJ1E9BuCgcg0RhfcDtOChUJGh2uyyfQZ9qrJ
 1H+wvJu7HhaHjTg4vMRQ6BgweOhAyBkJJ5TrRYxPhm6p0sYHuxGcCkXBt/rNN02zy3wr
 uUu2uvCIs3LnyyAobf68q1R62XOIJBfqtoPaHP116a6Irf6yfJJCVH0bvMF+XQXV1mkR
 HjOJvJc+yVXcAVM9pCue8algBcnm8wL6fOtGcs0NeQEOYWQj12YyYgua/6iaCVWMYaou
 lw5A==
X-Gm-Message-State: APuU4Z+c/mlt6+5sSXFdfxUqbZIufQAVZV85p+Q8hKm+OgEdPq7A9lMg
 Qkw4GP06AyuJfFmquwadMgjGoS6XavWy7kiB2FSaMJajQ7UK0nSeFT0tv2JxcY2Syf3spQh/Sw9
 Cu4EifADyOaTgmtQNhCj2hzD8y6I4eJo1Sz6FlNyrP5ecEuG0oTlNf9EjlkCY61xPhvEuwGZ3MT
 ANDCEQug==
X-Gm-Gg: AYBFou3Oq33MiubJ4mt1afosxGR/hKVjOFj2StpSqecgNt9d1AfSHZXE83sxt7B8+Tr
 3R5dKtuZ2wOAk7zPyBqcwrWAk8eZwLF2iVvrBDF4KYggYCgt7Y6tTZFKwhK3M9WIHrKiGUbXBrb
 1OAdDFuNX8xYNtCx17bUl9hTPQ4cEbqVLW917x+ulSVNkzEZ8vewe1NnEQeE02q0ZS0oJq8nVYO
 AJyKpLADXhDMwnBOqHF5BoKC2s7TEowEbkMNbCTCGPCH5HqGHepgfeTa9XW1XizRLbHO49QAfHY
 gGQrbj9QtcfOKqOxb31mIF9flC28Q323T2J80smz0bihnxBUAFdDcquXS+nWepjuC4lqHWwuIa3
 6V64TADiaFa5t5D2ihSv5vH2uq7g0zSxBBfShZ7Pj3fy5jikB38dnlUUPLJBjWc/8ZHxZmu6s8a
 i2yThA30TF2L1ku+/fYvCDRpvadr4S3K2IYgrE2HMec2M7b7UMp8gx3ccOo7Kojg==
X-Received: by 2002:a17:90b:3e8b:b0:3ac:7556:8ee0 with SMTP id
 98e67ed59e1d1-3b0db6bc565mr3864392a91.19.1794007403433; 
 Fri, 06 Nov 2026 15:23:23 -0800 (PST)
X-Received: by 2002:a17:90b:3e8b:b0:3ac:7556:8ee0 with SMTP id
 98e67ed59e1d1-3b0db6bc565mr3864373a91.19.1794007402976; 
 Fri, 06 Nov 2026 15:23:22 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b105864390sm655031a91.6.2026.11.06.15.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:23:21 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 13/15] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
Date: Fri,  6 Nov 2026 15:21:05 -0800
Message-ID: <20261106232220.47602-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rcgo8zO9_VQ1UYHxkZ3B1ui4FijyTnNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX7GwN7bp+Fc2B
 za1RLxFgqecNEJhjkNHR0TasX3G7Wb5fTbZ81pvEVYBJ7+TW9c2QN9fEEJ+bdqXFcADccApv+gA
 F1Sr7vXsE44qkYkKYzOcAgotMmQFBDaEX0JyZywxNS+UeyH00NZUg0nLrffLiGzUSvZt+xUfPsi
 9T993Psj4LpTzBZh87JnK7sjsBEb9M/zxHNm/a4vvbjofvXGsyxgzOap0KgG5W+tVt9kUGK3WWZ
 A4jvUr5aQtv3thAKhD3hVSpzUhqnGfkDDxbpzM+mhFYGfvDj8yHvtIi6oz1f+hC81l6smuC7iJO
 szXOO9m9lQMcLV3JL3a9L4xxKA249c6Q9fYLNKEEiXh/VmplkLk1AYKZo9KBGYkDZR4IdT9kLV6
 AvlHg0Wq4EuGJzOYSxiGhXcgXIhv/xMQ8kYVcB82Cprf2EJtrqDGk+WCMhZzGjrCVbX+WJqgDBT
 EmliN947spa4romXgGQ==
X-Authority-Analysis: v=2.4 cv=a6OlZkSF c=1 sm=1 tr=0 ts=6aee616c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UnxhJFuZtzOLgjs1IeAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX0J4JUwxYoxqH
 F8RadTfS6WyVa2Kazusxsla2sUIVaU5lbDdVXgomJ9032yN0AKAUeAuayuIfcTY6Td6CuZEcn2S
 9fnLG1o1W19gZm1gkwFJWIJryXCKVZY=
X-Proofpoint-GUID: Rcgo8zO9_VQ1UYHxkZ3B1ui4FijyTnNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060093
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

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index f65bf82e5c21..f6afa5b3b0bb 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -261,12 +261,21 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
 
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

