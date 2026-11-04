Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D2606AC13
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pZcViku7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZLYiswCE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AB310FF13;
	Wed,  4 Nov 2026 21:21:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D8610FF0E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 21:20:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4H3FOI3031773
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 21:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=rPngJgcBG6DrOJRfy/JZMVXSOtKUd2/SKd+
 TwwXTsBA=; b=pZcViku7H4Fjlh21+DQI8d+N0Hb31e4A+kmcH+KR/ajU+Kxr70y
 6ube28YhNeyGFQMQ+rJtJMPogBDoTl6Pkj+Q7oA0EzDDuO5/x6lfiwpG5cqMCKs8
 oXwyOHcmVhwQ+CBw41KaYLfek8u9OAeIa9elERR32E64KRRFAtELj9pekYfC7Ofg
 uXnwSwW41FxzWPIWY/jlmw4PegSwmUKWeQh9RDdXoX94ABLvieiA5XTEEbWkeeDB
 FV5Dm6BI+LtYf0F/NiIdTUQYpG8MctSsTjIas7wMPItBYzaAqrs1OQkSQwrJOqEt
 rYJCiMUoAAiOgk5Kn8XxFOPHacrCaTE15pw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr8rv14ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 21:20:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so2077965a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 13:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793827254; x=1794432054;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rPngJgcBG6DrOJRfy/JZMVXSOtKUd2/SKd+TwwXTsBA=;
 b=ZLYiswCEMmrS0kJOLwWgqMplZ3b3Rr2V9s7RkE5qZjXEWB2m89SLDy9DdYVRRvTPEn
 0XTKU64eLcshrh1+HhIqrdNep7k4t7oUiovFhL36bVhNSWJM4C/TFSACXqQ4cX+vTHt6
 TSPqIXT2zrdU7kZW2SnJ6zfnUZfhS5hFTMWHvA/zdvOD45psFgJr7ZSsnXrsepFMQ2RQ
 Zro3JKSBca+q+U8SZsrECDHkQuNHsUZVdyb330g3/kq6PmxVQTlbnBwPbvnKTOb++5hf
 LpJcBNA2CvGHJnotDA+zM6uDoSveOMI4dOP3voP7WhMOtJf2258JoI8AF40xAN+H4vlG
 bCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827254; x=1794432054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rPngJgcBG6DrOJRfy/JZMVXSOtKUd2/SKd+TwwXTsBA=;
 b=EpTepu8NmEwCGHgns0m1XnCWEBxVNcgwiMGI2RxmtVEGdG8p19gv+rZQNbPfQnRsdA
 f+aJsHdo07PYA4I5TYOkt2cpLc3IIzfT2VNd2lQuFA7KNhLhUC6slJsmKN1P40CpKzkr
 ZoQ3IjyP6koBUKuHhiczToG0YNwfAvgM9rXB2ddAklKTHulY2ns1RQJHNYHqavYuEJDQ
 wV9IVnDBS/W3It72sb7tAlIPOBXjLPxV/F1rwDOfenMB+9oR2jtrHEJK3RA0nOq8EEmC
 TF1WZUOGwQVc5ECuToZripmSr8lPd9e7OiHtjFiUkEvO/ljVY5gxFagF98a3iJu0PaD7
 EpgQ==
X-Gm-Message-State: APuU4Z/ZemM5mPcJ+2JCqarCuIMu+OJlr+qtUWMTa/4P4Vdm5zEYcFai
 Y7NQ9mpZVAO5SZiUZ3xSRYqOc+GmNgkRT1PbH8/2q4piQ3Kf2Oz08JEiC0LMhnxTC/rmgWSbicL
 qlbGEN0MQLD+iGZPkMGvkvR2dDcdrwk7EySTz6JNL8lItyootFUiqfqE1kE9mJjF3DwhSFaP5v/
 15ZVl4fA==
X-Gm-Gg: AYBFou3ExI/MJlXxxZgGve83fUAxtuagnRaKX3HoUh6E4TKUPI+baMXgCRQDllYklZ2
 sb3PsIIR1SE8SZBQAoShg5a7+b8HTJWaftjwGKJjfcymYG1MXjgSkWERDFvdY4jzxUQE91jjPRy
 8tKxAEUHgKIYuL83Sq+Y5tlqodCWDccza07H6EVlZJfi4OkbWkzaMNr8N7RBL7K49CzczBKexJu
 oUHuaJO8t3NpEpzV3Zhb5cJ4Qx9m5alf7TW2OrmfYoXg2cc2hMEC15HvLo/FdWnSOCRd+/HkZeg
 UH7McDqeZCjHXGe8GhZ+B2Hdv37ly7v1y0u9W4MlkqZEMthqGSi4mjHMFQaZBR5B9gt7fxsXYTt
 YEsMkuZdBP283V5l0brkoHlP17Yh0UxAY9e14oLMclI0sEFGc/030RJ48uXwLU+i6ktND9/fGgs
 W3juNA7KavuQJJe64NDf1kNOr8+iv/BbFXI2NcEyyFgmaD/mNWf/njzQvqYweR
X-Received: by 2002:a17:90b:268d:b0:3a5:147a:3b63 with SMTP id
 98e67ed59e1d1-3ae895a5bdemr13706665a91.8.1793827253840; 
 Wed, 04 Nov 2026 13:20:53 -0800 (PST)
X-Received: by 2002:a17:90b:268d:b0:3a5:147a:3b63 with SMTP id
 98e67ed59e1d1-3ae895a5bdemr13706633a91.8.1793827253328; 
 Wed, 04 Nov 2026 13:20:53 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31601b7sm554517a91.5.2026.11.04.13.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:20:52 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Danylo Piliaiev <dpiliaiev@igalia.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a8xx: Fix 1/2b alpha filtering precision
Date: Wed,  4 Nov 2026 13:20:47 -0800
Message-ID: <20261104212048.21010-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vtm2kO2n c=1 sm=1 tr=0 ts=6aeba1b8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=V2sgnzSHAAAA:8
 a=EUspDBNiAAAA:8 a=4RKTuTdSK_1GKjLeyWkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4NSBTYWx0ZWRfX1uR7axpG41yD
 JlgviGtlv01P7YvKY9UIfdaVqO50Bi5+6YjNWgqFSzoIZEVv/IUdoejHJ5QNrv462dr7ItDaBdD
 oEmAUOqt8SnicBR3Q5u5Tefuy8tA5MQ=
X-Proofpoint-ORIG-GUID: 5NVfMTr8xz7DaO21Rx_mN1kAQUtsSdBH
X-Proofpoint-GUID: 5NVfMTr8xz7DaO21Rx_mN1kAQUtsSdBH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4NSBTYWx0ZWRfXydBSTbu4uidR
 QTG1rAKPFGwq2NXzUK4cixPDm2/7Uu5HdwFTY5m/6DeizPfmA1WGFDXr7h404GFC+f/gkFWu9cS
 33OEb2NoCtYnkpaOEN81UkWVHO2dV7QKegaL9hb9Yclf6IraaY/fQMba9nuqZkEZEourmgq/xhy
 i29QFw3xdzoiM9qs6D/A3rGVMV5DW9PJx440ILMB6N0poBavJ+dpgfl3TUwVg0zqGCTQTP2WLGd
 v/XviLf/Crr5tTklTPh9H1kU8i84jvs21zYLOtProLcsNXCozx/ogTd4XMx1GO10CNjsKuQxDt1
 QS2nSqKQDDLtLbFJZYfeB2nMk8XL+qC249il7VAxy4f+njr7NhdS0Go+RKy3YGrVxzgA8Gow8Wu
 wfbW558tHRxek5zcVZ7ORkp8qiOjv8oV/PaoFKsjGhZHZnhWhtKX6u2kBflIz0oHBCaLOTt7iuB
 bXncnbScB5Mtks2wmeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040085
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

Need to set b25 in TPL1_DBG_ECO_CNTL1 on all gen8.

Reported-by: Danylo Piliaiev <dpiliaiev@igalia.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index a7d9ccf26493..510c2f6017db 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -61,7 +61,7 @@ static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
 	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
 	/* Enable cubemap small miplevel optimization settings */
 	/* BIT(26): Disable final clamp for bicubic filtering */
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000724, BIT(PIPE_NONE) },
 	/* Disable tag bank id hashing */
 	{ REG_A6XX_UCHE_MODE_CNTL, 0x00080000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
@@ -297,7 +297,7 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
 	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
 	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
 	/* BIT(26): Disable final clamp for bicubic filtering */
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000720, BIT(PIPE_NONE) },
 	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
@@ -397,7 +397,7 @@ static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
 	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
 	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
 	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000724, BIT(PIPE_NONE) },
 	{ REG_A6XX_UCHE_MODE_CNTL, 0x00020000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
@@ -630,7 +630,7 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
 	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
 	/* BIT(26): Disable final clamp for bicubic filtering */
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x06000720, BIT(PIPE_NONE) },
 	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
@@ -972,7 +972,7 @@ static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
 	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
 	{ REG_A8XX_SP_L0_PERF_TUNE, 0x00000024, BIT(PIPE_NONE) },
 	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x00000720, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x02000720, BIT(PIPE_NONE) },
 	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_DBG_ECO_CNTL_0, BIT(31), BIT(PIPE_NONE) },
@@ -1030,7 +1030,7 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
 	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
 	{ REG_A8XX_SP_L0_PERF_TUNE, 0x00000024, BIT(PIPE_NONE) },
 	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x00000720, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x02000720, BIT(PIPE_NONE) },
 	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
 	{ REG_A8XX_UCHE_DBG_ECO_CNTL_0, BIT(31), BIT(PIPE_NONE) },
-- 
2.56.0

