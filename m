Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC4606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ClBg9iNX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XJaMvSPB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17CB10F7CE;
	Tue, 20 Oct 2026 20:48:42 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CDB10F7E4
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:48:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KJI0pr1508696
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7RsaArbuiuP
 ytLoRLed3VREMvlql5azvY36KVQkP5yI=; b=ClBg9iNXohuNBvTBWh6DXxyhFNE
 3FMd5IKNsv9OansFpEQS6E6wdLejH3uJCIj3QZKMxWSd8GDldoewZ2NUuBV/1//K
 FUPVg7RBUWgbbolDHtvMybJFa1XICp8raoH5moTmnSI6OhanqYgpfQkoqXQjV6wb
 4m12lmkcMOswzsBEwk5emEp/mab5M5PUo4RJitY7rzWHMbCNrioXC7kZOwE6eKJa
 kMOJWnQUOndPMQB2+Xk0w+1NhNtgyuLWgWTUj5hA5/D8ExV4bTrPB0Q+mc3ArHHv
 dOBIYj9RrgAFTgsnqq5NvJG86fKjjMhyWzYB0mCDATz3IfgGbDoFa6pV7/Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb989hs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:48:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so35116085ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529304; x=1793134104;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7RsaArbuiuPytLoRLed3VREMvlql5azvY36KVQkP5yI=;
 b=XJaMvSPB/FjVml6D3CRMn3HeiM9hMfcUvpR5lZP/5Gz2ooGU22x7+cJJ+G+rmuhl87
 Qt84LOlPdF9TuYC4D6JFV/mgMb0bIqCWc/o2rBTFGcIK0l55X+yDSdSc8wpaI48d9jwt
 5TvFHrtk3cjVV0GAje+F42nmiepQmZeguRiDglmdB7gbY53Hds7XRL0RBUBbtU9gKXgv
 BIxFWYSKq+LT0a+wE/6BCfmyq/hTCIshiFe5ArwKuLuSf5TpFVhgzOQIcCZHZ08K3zdy
 AvLayAJa9k6xmbaRVr1/9pd1UFWeXEr4Pi6i1q7SMXjFs/40lKkJ19pzTK+pojpgGk7Y
 pRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529304; x=1793134104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7RsaArbuiuPytLoRLed3VREMvlql5azvY36KVQkP5yI=;
 b=c60Ov0X4i/l2xITn9OP5ggu2dgrSF1q6lFedljeIx6xHq57MI2475/Gzc72/4+rL+E
 VxSEV1TqMQwRskuo7BjyAm0He9oqLv97V59I8xRX+IVa9hAE1CVvquUSCVUhRqGom5+L
 iCE1IasdTwTFet64YBs7dBrx+s24hGJ6mMfnrMJ2az9SYI95MBeou0Z24rM5KVxR3ulg
 5GmT1evvmk5s2znYuI5Ni9pVRkMF8IF4sAME5eICaQTbQVAREph+2em3yWsY1zd8FcCE
 jzG5mmrslEfm3uHeUsUpuSyle1WDCYEkmbGef7TDUYMYJXNTSABb0HXaNnoVHlc0X8v+
 OzFg==
X-Gm-Message-State: AFq9FYI0pB2gUl10kO0KWqiJWApSLDgmZFLJam5pJQY1CmkjO80LqISq
 qylkzYUZ+Y526yKQX6FamVpP9fmLCUMudyLsIm3DIAwUf/unbLS7FwSW8xmKiOW6AmOUsEpOFN+
 1pMsCRFQJYxAgdHn+frChHE7WL+kWdqrRQjNz+CUmdkSadseKBDnjPenujvGj3wYPLEY8OKu1FO
 GlJXo=
X-Gm-Gg: AYBFou2vZ5iYNryjB4mYK1YY1vXpEoNahrxigF+ERWyfLRyVRab22zGuMDDabmsS+DU
 Rrxv/30JlA9jZXifak64hG5zvEtbEyIcEiYxfSsmHr1NF7IwqKN7P1ZI3XHh6l/BP1iGBUTknTQ
 knOTqTJF2Gf+M2OGr1udUyAjvhKVqgxA8nBSvBIEJYp9ZCSCmufInMKxCYmzStksET/NqLq1DQo
 prX9XJqfa1zJraRpPm9Mk8Af6VKPzn6hbRzEgP2g7jvM/smNjcMACxTfboZ8ZzCeXuItLZ4i0hy
 WKrfeYjwQ9Ztbh63zXt/CDUohJVPnbsEgPLsloj1G/vcUfpcP3oPNvVNu1eWO2DcZM51IMG9ZUN
 aLxSiu2A9+k1vePNPSe8KHpAip1ZTDTl0AdY7mIXnfIq3QHrqrQ==
X-Received: by 2002:a17:90b:37cf:b0:3ab:c674:d83c with SMTP id
 98e67ed59e1d1-3ad86ed34a8mr74472a91.27.1792529304085; 
 Tue, 20 Oct 2026 13:48:24 -0700 (PDT)
X-Received: by 2002:a17:90b:37cf:b0:3ab:c674:d83c with SMTP id
 98e67ed59e1d1-3ad86ed34a8mr74443a91.27.1792529303510; 
 Tue, 20 Oct 2026 13:48:23 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad85f38df2sm225228a91.2.2026.10.20.13.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:48:23 -0700 (PDT)
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
Subject: [PATCH 11/12] drm/msm/a8xx: Switch to generated protect regs
Date: Tue, 20 Oct 2026 13:46:25 -0700
Message-ID: <20261020204728.28844-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfXzGKmUbMEKZGI
 GKyzwL2ZcL4oMKanQT3PdMOOylhvRuyvtqkOisQS+1I8ePQBZRQ0/7hag9ii3b1GorN/1rfUMFq
 NA+esE+VorHJ0yYCYnrYMWBEJwlx2o4=
X-Proofpoint-GUID: 4ZbRJS3kT3VMXcj2IaBh7BNHdJKe868s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX2yaYYeh/m2qx
 dRWjhoByNeHgRwwL9acBFsD0ZwnpfomtdD2kQyJ6EcJprEvYp24GXUwWWjlMc9RDh4Ft2h2CCTX
 v+WjIKwIApkjJOGylMKoBdyLbJ5y2ZshYYtOGirCDvESO03iRmDzx8CswxgnsVlURzqGIF01gXg
 u0dEt6WU/tszZWAfAkAf+DOOXWF+/HOqzsHj7ZVsGOEbr9N1+qlPGwWfGMCNhHvrSDEjTeJXjk3
 IfFWYgPvoH7aCsjDI9M30yQcaAsp/Ov8WVYDLOalORxgBQ4ert2nZZ17eWzPsXvKPhVIy+s4duL
 sdA1Oq5Bw7Yph6t3AAf2EbTQTXKA0Aj/m2J7q92QEH+n8To223HUZiQMUUeaYvWpyjpQQhfTbYE
 tp5miJ9w4rYfsE6r5v4VjGvP5TZjxKbDnvWbpeRqAnCokorrShCWc22pgzyop6/Zlp8HyyM3hpv
 i5E0JAppfKTG8es2D4Q==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad7d399 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JcQOObtfp6PrThPhMQoA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 4ZbRJS3kT3VMXcj2IaBh7BNHdJKe868s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200082
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

These also fix some perfcntr SEL regs which were mistakenly blocked
since we previously just copied the protect tables from downstream kgsl
(and only sometimes remembered to fix these).

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 301 +---------------------
 1 file changed, 13 insertions(+), 288 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index bc79013165c1..5f5f71d86df9 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -18,58 +18,6 @@
 #include "catalog/adreno_milos.h"
 #include "catalog/adreno_pakala.h"
 
-static const u32 a830_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x036f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0787),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x20000, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0381),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0001),
-	A6XX_PROTECT_NORDWR(0x27c02, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a830_protect, 64);
-
 static const u32 a830_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_MODE_CNTL,
 	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
@@ -241,63 +189,6 @@ static const struct adreno_reglist_pipe a830_dyn_pwrup_reglist_regs[] = {
 };
 DECLARE_ADRENO_REGLIST_PIPE_LIST(a830_dyn_pwrup_reglist);
 
-static const u32 x285_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x0082c, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
-	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
-	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
-	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
-	A6XX_PROTECT_NORDWR(0x27882, 0x000a),
-	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
-};
-
-DECLARE_ADRENO_PROTECT(x285_protect, 15);
-
 static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -336,57 +227,6 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 };
 DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
 
-static const u32 a810_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x036f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0787),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x20000, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0381),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0001),
-	A6XX_PROTECT_NORDWR(0x27c02, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a810_protect, 64);
-
 static const uint32_t a810_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_MODE_CNTL,
 	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
@@ -626,64 +466,6 @@ struct a6xx_hfi_limits_tbl x285_limits_tbl[] = {
 };
 DECLARE_ADRENO_LIMITS_TABLE(x285_limits);
 
-static const u32 a840_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x001b),
-	A6XX_PROTECT_NORDWR(0x00775, 0x000a),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_NORDWR(0x00c07, 0x0008),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
-	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
-	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
-	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0009),
-	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a840_protect, 15);
-
 static const struct adreno_reglist a840_gbif[] = {
 	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071e20 },
 	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
@@ -956,67 +738,6 @@ struct a6xx_hfi_limits_tbl a840_limits_tbl[] = {
 };
 DECLARE_ADRENO_LIMITS_TABLE(a840_limits);
 
-static const u32 a850_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x001b),
-	A6XX_PROTECT_NORDWR(0x00775, 0x000a),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_NORDWR(0x00c07, 0x0008),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df5, 0x0003),
-	A6XX_PROTECT_RDONLY(0x00df9, 0x0007),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
-	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
-	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
-	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1ac00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1cc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0035),
-	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a850_protect, 15);
-
 static const u32 a850_pwrup_reglist_regs[] = {
 	REG_A8XX_RB_CMP_NC_MODE_CNTL,
 	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
@@ -1215,7 +936,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a830_protect,
+			.protect = &pakala_protect,
 			.nonctxt_reglist = pakala_nonctxt_regs,
 			.pwrup_reglist = &a830_pwrup_reglist,
 			.dyn_pwrup_reglist = &a830_dyn_pwrup_reglist,
@@ -1260,7 +981,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &x285_protect,
+			.protect = &glymur_protect,
 			.nonctxt_reglist = glymur_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
@@ -1305,7 +1026,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a840_protect,
+			.protect = &pakala_protect,
 			.nonctxt_reglist = kaanapali_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
@@ -1351,7 +1072,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.zapfw = "gen80300_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a810_protect,
+			.protect = &milos_protect,
 			.nonctxt_reglist = milos_nonctxt_regs,
 			.pwrup_reglist = &a810_pwrup_reglist,
 			.dyn_pwrup_reglist = &a810_dyn_pwrup_reglist,
@@ -1394,7 +1115,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &x285_protect,
+			.protect = &glymur_protect,
 			.nonctxt_reglist = glymur_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
@@ -1437,7 +1158,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a850_protect,
+			.protect = &maili_protect,
 			.nonctxt_reglist = maili_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
@@ -1481,7 +1202,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a850_protect,
+			.protect = &hawi_protect,
 			.nonctxt_reglist = hawi_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
@@ -1516,6 +1237,10 @@ DECLARE_ADRENO_GPULIST(a8xx);
 
 static inline __always_unused void __build_asserts(void)
 {
-	BUILD_BUG_ON(a810_protect.count > a810_protect.count_max);
-	BUILD_BUG_ON(a830_protect.count > a830_protect.count_max);
+	BUILD_BUG_ON(glymur_protect.count > glymur_protect.count_max);
+	BUILD_BUG_ON(hawi_protect.count > hawi_protect.count_max);
+	BUILD_BUG_ON(kaanapali_protect.count > kaanapali_protect.count_max);
+	BUILD_BUG_ON(maili_protect.count > maili_protect.count_max);
+	BUILD_BUG_ON(milos_protect.count > milos_protect.count_max);
+	BUILD_BUG_ON(pakala_protect.count > pakala_protect.count_max);
 }
-- 
2.56.0

