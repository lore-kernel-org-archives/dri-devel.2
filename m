Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hm+akrSk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i1wBL9Wc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4064C112518;
	Thu, 29 Oct 2026 20:19:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF9711252F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjQEj1131907
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YV5tZPo8PYY
 trQuP3aDlqbOD57AnAHDRODz3J3EV/AE=; b=Hm+akrSk7LESXvwd0GeKcZplXNt
 3TwcX4YoaTgbZZVFqGUQ6BVk1XStwGO61P4f09esk8FwLdFnBQHiyzy89hiAKgbc
 UNHvglbPzCvIw5ZL0zGa+898tDSLUHUKZJcA65O1getFjY0rHJNef0N3QEFudlUA
 MDnmH50BUsfUEJGv+v0WnJqNbK8WIzJO9njbB+JnL0KTsFARwkLXveWpOJ0yvxr5
 P1D2mqKIm7JMzrMj5L7+ofiS8ncdZR0z0Y17VD6Ne51DXk8NRGkh4iIUwmp2zDY6
 u+jrmzDqb1nC8JKmt3WH1Oktcw944Lpk/Kmu/9yX/QGJ8YXOiHLaTWGKtsA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmbeas23h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea381ce04fso335175ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305108; x=1793909908;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YV5tZPo8PYYtrQuP3aDlqbOD57AnAHDRODz3J3EV/AE=;
 b=i1wBL9WctRbhbPjIheG2tZVOJmuEhT7CrBv+6+QojtlnXXFCHRR9zhUYnHux65Ikdb
 m1mWPDYcKossZdXyWx+za92Tv1f7tATRfKKFEt7YvQhdhdIt+O50uYDFrYq7tEPOD88j
 ASMeXtDCztJjrIGfAhulPW75YosMbofeZ0sGwM0qvopbrvM3Rdfb/unAjvlZ8QiL1L/I
 ujHmgWoPupjboVbeGCyJ8eIvzvWIcwtgVUfzgRJEJE8RkJc3iyGg2ywdFMVtd8uUUpSI
 DT5YuZvUBOd4xSUgfEUA2V5Xac7m9rSwDGkwMDvAd4d3Qfp+GYtfODIxBW/mGnJfj3ws
 TjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305108; x=1793909908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YV5tZPo8PYYtrQuP3aDlqbOD57AnAHDRODz3J3EV/AE=;
 b=FfMK6UU9noz1ebBk3BvDopppgOtrxFLmK0A8KAcu24hxTzVym7/DN4EB6jlfoC6b4x
 dUy+I0kWszAInriY64UmCShmwTZo1AlrkWvRJLGoZnzZYMvCQfM/asTSSDHR2GIZgIBe
 WbcEYW+I4UlQfq5WWYYcvEJIqlBVvkvFOfYzg6iJcaM3TUzE8OtChjIbo1TAzXcjOYS8
 3V2nu31ICaacwrZkCf1jf3l7i0952DuGrgqbbdr3utULJPffZLxBv907KyKzE9H8Ym54
 4KN57cT0KO0ulO2uPLEdV7ayGhCKJtntt5c4dUxrv8vaVRsmiR1WZUBWMHk6FwYz7mjq
 XP2w==
X-Gm-Message-State: AFq9FYJC1Wfv28qvsfs+tYrhdCVCj/3cfU5hexn+PLOEudmzA06TvJSR
 C8oW+SWf6eWBmTBO1mlQkavhshAIlikQYk0TYE7yJYMs3KzuCAFI53OsfUtFsiXdH495bvWX2FN
 2SxDkY39dFCixtgbO7MkkDmx5MszN2oRmEh7SvQpqDPkcwz6eP7v+a+z9qA4cOfwgBBeO3ScBl2
 Ju5GM=
X-Gm-Gg: AYBFou2dKOTSdqDKAfp0dGZjeW5qinDdrgaVUdHB7bx9OtQwFgNeSPc9PPF3gR/OSqh
 oCOW5nO2o7LDqIvU4EECmtkjVGIF3gnDGm/qc5R+qplPX1VJcLhZoof0WbXLD43D1+2GgaFRodC
 EcC5ZMTOb88srrTcY7CFGbsfPIjNklEap7yEs+EWRszpRR5VZmzCcDB6iXRiwSkCF6hZ3QijUNP
 ZF3/Op9xleZ5uGHbF+iJwiC1++AHgsTBUoHt4emkDFVb6TP7v2oh7S2mlfj1o+WR24HQBZd7UvH
 vQV5EdzvQkYnfiUVNl/NHHwYLYuRUdnfFup1iePYNnQwkYcbX5JP6hSuxdAJKfVeYOlgEnfhLcP
 6et0h756T+e2c1THkT35zrz20eB5b9COgsmGlFl10RZi/WlQqJ9z+UjuYNWCZ6U0hTFefgk8TVw
 x91heQcD0vW2kvabjrfSSq2Q==
X-Received: by 2002:a17:902:fdaf:b0:2e8:3b2d:c0e1 with SMTP id
 d9443c01a7336-2eb1acd3a9amr24561575ad.41.1793305108026; 
 Thu, 29 Oct 2026 13:18:28 -0700 (PDT)
X-Received: by 2002:a17:902:fdaf:b0:2e8:3b2d:c0e1 with SMTP id
 d9443c01a7336-2eb1acd3a9amr24561415ad.41.1793305107526; 
 Thu, 29 Oct 2026 13:18:27 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3690a7f7sm588535ad.16.2026.10.29.13.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:18:27 -0700 (PDT)
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
Subject: [PATCH v3 13/16] drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup
 reglist
Date: Thu, 29 Oct 2026 13:16:23 -0700
Message-ID: <20261029201730.151754-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UejE26SN c=1 sm=1 tr=0 ts=6ae3aa15 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=GwKEIKth3DexCsueK50A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: DNXwe6q2-NdFdqsUSL12L2VgQ97dflR8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX9Tx7nlPm4VPy
 ZbGC0hjHHKPD3gxZVynpJgkR3WNpWrBoX4RnF5qkRt2D1Xl55Y/VoOXkY5u1KRUg5mQDh8V+ttb
 OhY2QzkxGo8LLBt1iRbPiHodSfNX3yrYDwd+SqCIni/sY75mm6Lq+M3+Bm8qIRrp84wKw4Ppx54
 8eUONb/g7jI0IYQAmzhf1lrlW4rbsXBOHwjv6WWn7V44UFeGAfOxcwcAqKIpgP+WlampqHDviLr
 ELquwiDIjYSz4NacwdzPhIHQjtM0Z2wh7MQrmZuUvPPvU1zUkCv+bl+TXWTTlONxsX1wVo6ih9h
 71toHBClgbFgnglO7Ko2qGGggqQHzXQy2kzhXVU8Pm5cTwgy/3dFEWkWm8393rdy890GIYB/yz3
 g6f8MYHxyQlbq3cXz1V6h7kVWRnZOIvw7Px5+uQxO9k/GTr7U9w33Ks+pIp5+GAQtksE4eRW22F
 CuCmd6Mp7g2XK1cKTzQ==
X-Proofpoint-ORIG-GUID: DNXwe6q2-NdFdqsUSL12L2VgQ97dflR8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX7Wd98sHODfRb
 jDu6QaRI+UNIN2vab1yEMz4ElEMb5b6jk3gc1qO7pgGuDFm3RXHUryxP0mVpBkEkOK9vbKcq/x5
 qK6FZgVETBL0uRbpaBZ5ZAh16S7O1y0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_75_100,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We're going to start using more of the CP_PROTECT_PIPE regs.  Rather
than missing to restore one somewhere, just add them all to the pwrup
reglist.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 4365328820a2..3c9025a93445 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -277,6 +277,21 @@ static const struct adreno_reglist_pipe a830_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -439,6 +454,21 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
@@ -673,6 +703,21 @@ DECLARE_ADRENO_REGLIST_LIST(a810_ifpc_reglist);
 
 static const struct adreno_reglist_pipe a810_dyn_pwrup_reglist_regs[] = {
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
 	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -1087,6 +1132,21 @@ static const struct adreno_reglist_pipe a840_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
@@ -1538,6 +1598,21 @@ static const struct adreno_reglist_pipe a850_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
-- 
2.56.0

