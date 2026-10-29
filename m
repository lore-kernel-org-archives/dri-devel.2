Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AA606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NmmR/M/+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxJ5lfSD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53266112528;
	Thu, 29 Oct 2026 20:18:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961CB112523
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjOFK1077943
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Jo2sX9VXnBm
 xIbRFzoUIj/cFn9yYdevX1yQtu2aR0ms=; b=NmmR/M/+w3RD5xPAX4n3dVPA9gt
 Oc/tgfh0e3BypCgwElLAhl8KFKdpwbxnHCykv15KBSdrnY5lIbiaooNzPzs+IW/D
 +nlq1Ho9xyO9bfSm0xPkzckpNH7d3MIYeNsiMWbkFFESpWjm4IHTb1rSnigeBPPM
 da/LSwjIdjCIncJnaLf8LMcaWPjb+GZEfucv/l6oK3l9jNqxXL42e/zc3O4Bxp7q
 dUlpK0llhhoGzu4pp8E07YZj0tXr72vp9ARndn/2m/B1In+0WJwD52v3OGa0FI78
 oHBRysCaUecyZY+D0kIO5DkFl9R0L6SMwNE/TrfJaNKk7jAMzuu1sg866bg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmba4rhh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1369495a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305075; x=1793909875;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jo2sX9VXnBmxIbRFzoUIj/cFn9yYdevX1yQtu2aR0ms=;
 b=bxJ5lfSDjlOvvBFtp7steGby4o7ese8Vh2/B8Hl+eJcL+//qp2BqNQvrRwezLEpo5y
 lYeE9Gyy5bd4IpFDqO6OF4214uTV2d9I2Hfdkl9yUPee9PV5xYEjBzM8qC4/co2ScsvH
 qISBR2jMy1PH4HGX2OXSZudbzWvVXVAjhZQ0JfSOpIJGd/965GFxUG/g2PjjkxnpDjQC
 2g6gtrM78jok5DpGSAiwaqtHkP4wIt6yoeIJQn5dp1F/r57nJKZRPnzJbS6Mgr8AJqK0
 Q4t0XXX1aSMpVvSd8xnGyd8kELc19FTzo7qDC0mXfolDKRTfNaZpvli/aulPhiw2Sjyp
 m/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305075; x=1793909875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jo2sX9VXnBmxIbRFzoUIj/cFn9yYdevX1yQtu2aR0ms=;
 b=DUM3cMatfFhXtN3GyDfQsvpdUoL1PBUdN+3h4FKZR4P094rz5TVsw0dzTd++zdlwuh
 qCv4i2SBUd1hJ8bg/Cn67WX5ROpHV8YBZLQfFf7HyiAMdAZtV4Jp+uY47W+mej7y4Z5O
 RZkahTbK84208uCsLg+z/Vvj/FH11YEcSZ1/IMNNliV2vFyAHzo4MJ9xiMe2dyHQqjB7
 r3q05ogBldFO4hNISl1CWSzc6vN5rTyDCFY5nI6LfCn2D7PTnNzzpTfYlmeYWbFBsASv
 scy2/FwsFUt49KcB6lJj2l3L0tBntMhxa3wUP5mJkiZRy3NC/hqjGHuH1B45wmmHoIms
 AA5A==
X-Gm-Message-State: AFq9FYJxM4CWZa4NWVfne5dAaXSJroAyciuGf1itQMqF9CM2QuuDznOj
 bX6W6ecs/90iOzEtU49DapmdtXPCkCGboKf3/CQSFlY4sKKDMhLIYXjM/cY3fhFYtGxeFzU7Sqg
 1Uyg9lKxmhHiI6QS3lT4H71Rj1HuXl9CoXzdBeWIDPzbiVWBxK4pbpv73nnAKLsO49Ac6AU3wWV
 oFQek=
X-Gm-Gg: AYBFou1+ANHyNHPwmlizyYtsEG5DSZhKmU6HKFem0u4C7s8DqpYfWpkgiVw82oibFwz
 lMRJtAn2XbjLHfzT2HZkoi+zaIAiGvz579hSToJCNifUoUhbSucvsUgT4T34P2GK1S34XrAzQ4d
 FRHarEwIYbw8Y26Ks1INymFB5LhtHLAcMTzVPlHuvLWnJgY93H1ifx62JvCRUHu5UvEN22pkwyl
 C+/Z+t0ubptuiA1cv+/SRt/b7HDPW9Tp+3GwKDcO/xJuFyGjLgmZuzG9SXpem/g8C7S0Vd9Fpyv
 uECNt/f39AS/kJxVutVI9MMcTPXok4UnrtvsCo9zt4WeV0QmFOWyKYKfce/5qUKD8F1besd8Wr0
 /qkhyGRFGGDNGVy3QCWzY7UfGqAC1PcQFcjv+B4BGoJRA7fxQu/qxEmOmot3uh3+JEJSMSGFD3k
 dmrUbEW0sMtjVNoZYj7jbYew==
X-Received: by 2002:a17:90b:1e42:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3ae897ce417mr63816a91.32.1793305075434; 
 Thu, 29 Oct 2026 13:17:55 -0700 (PDT)
X-Received: by 2002:a17:90b:1e42:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3ae897ce417mr63800a91.32.1793305074970; 
 Thu, 29 Oct 2026 13:17:54 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85cb1bfdsm339928a91.0.2026.10.29.13.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:54 -0700 (PDT)
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
Subject: [PATCH v3 05/16] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Thu, 29 Oct 2026 13:16:15 -0700
Message-ID: <20261029201730.151754-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XOz8PfoImg3d3OTH25X4P4-Ww01QmjNb
X-Authority-Analysis: v=2.4 cv=X8PHu2Te c=1 sm=1 tr=0 ts=6ae3a9f4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=h-8skOKhzxl6Lr9m04UA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX8m5tMgngZDIO
 yR5JS5Uca1xEu/CyuK6Re6hoLWj0q60ZwRYc0hzqvIApK/gEy8q6xPadQSPNwHCJZsVowKysU7N
 Vkf26gQ8IKq3P7u+TnZ4NxkN25MF/OKCKx+hAWPAF7MbFEZMu9b74JBsosKjA5pn8OPZl+po3kh
 EckGJxkAcTfib+K1keBc/nBfCgRjToiutB8gbQd8wWKWXMTinNoh9FOIocYmXOZZNDlHFntf10D
 mZBPOyTW/AvSUCuT6cV1k5HVjBG99KPQ3nYnMbKj8oHa24CxC4nhCd3+lH7wcWSYqGO2BWWHyvd
 50DT5hU9csxoyZdBRo735LQNffyZmNYCL/k8XSFrraXwFxktleCo8HhQwPIJjSnp3/VtT1H07OC
 h5PgzssoMj6Dg//o8QVW8WHhdQv18Adfoe7ZUtcX5rDf4IOt1Dtenr/w5OBL/I8+2HXIKh9B/kQ
 N7lLlNywab1jLNqqMJQ==
X-Proofpoint-ORIG-GUID: XOz8PfoImg3d3OTH25X4P4-Ww01QmjNb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfXzJlqt8mb5b5U
 xVXpGUCFgnRlV8RYsSanOk4hQoL8/8aCiIYx6+ktTLDdmsNlVNIG0ogGQZdeRRO2Bx8D2rI+D3u
 SXHbtkRrUFLQkldY1T7j5EzN/PNCT+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
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

We want to save/restore all of the CP_PROTECT regs across IFPC.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 55a805ab438c..45cd986ad4b5 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1477,6 +1477,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
 	REG_A8XX_CP_PROTECT_GLOBAL(53),
 	REG_A8XX_CP_PROTECT_GLOBAL(54),
 	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
 	REG_A8XX_CP_PROTECT_GLOBAL(63),
 };
 DECLARE_ADRENO_REGLIST_LIST(a850_ifpc_reglist);
-- 
2.56.0

