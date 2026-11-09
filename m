Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B893606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VP3JndJq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OdWK0XRS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0E710F3B3;
	Mon,  9 Nov 2026 14:22:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E270B10F3B0
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:22:01 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFMUD3589048
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mVy1ahp/P6z
 Kdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=; b=VP3JndJqajd6DkZWuN71vb8csiA
 50Z/rE72BeJq721SdbBfWSAJfwadEbcyQm2eKZ4CM80wyJ1VoTrcgOC+GXgfnHqc
 uBJnZztTTTzsgxAB+YL+MlXWGUSAkO8jNvij4peWkpBbk6WpJeX9r2O5eYXDHvxE
 6DqetY5diSoiftEiyaocqI8+wqPrOBvAAc/W72I/yCDNTtqKwnC11y0dKtdM1SiF
 szI2klbpgkrspXGF3eG3WTl/cq0aTOp13jqNoyzF2QPt53uVx38M5c88TYyxGoBj
 arXqg87vfG1PMTo2+/nYlE8Zrmpvi/MmlfNm81O8Y9ua1KIgJH5u3+ZhvCQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcj8jdf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:22:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd61bdc8683so457513a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234121; x=1794838921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVy1ahp/P6zKdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=;
 b=OdWK0XRSZgEa80AJ42rCDJUsvGgWp9MzWaRfhoVsg8Kc2CamRpz6VzR4KOgx2eDnl3
 hvwHa0yzDlt8qhAh+3RCFCCmfn+gVxG5CeaKieSyQoYtdD3kiyCID56DxHS6lXo5GjBL
 UKKRQYPQBzufaN8yeOIrTRz6Q8GRfz3L2JKB90CdhOWnbMdIssWM5oYce4lZl3fHNxPo
 06M4uepls9xR/QrgvkmOj/pZ6nUOTIRSKvoU2ofoNH5tuJMK7vXCB2oI2WdlshsjqUYS
 +N+FWHgzxQeznGz7JgOKS96sLp5jaVv3vp59zQxMA+KjlBDVEZZWZrzBMMubyHLmPl4P
 jQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234121; x=1794838921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVy1ahp/P6zKdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=;
 b=st8EMqLjDDpSyLN31lDBG04lNGpSuf0R7SyHtMNHcrk96ItNkYCvtzHIhEtzMCMobx
 c1kmlAZGvz31O1JBYb7mz0d2/yijnpKIK0CNgg9mot1a4g4ACVbi0KpWfPM5CaTKVG3D
 ZCL38OP5BkP84RiBh02xB4zfp9xbupuosu9xvrhuCjgyUmUOYKgjGEiOmw9tr8upeAf3
 XMOi88PpaAfb21weuG7ZEHo1HDSYhLZy9ZPBlu1XgXbmDOp2W/SAQrK8a4ViWq0F6Sgv
 B3lbms+Mm2FEMFf9ASMbioh2/R87NFMI8AYpRu9sYXZO+vJ5+6aCwLoBhBqWzexPFcDn
 LFUw==
X-Gm-Message-State: APuU4Z+MFcNnYxmKX9FFwe+giRGWPeglTCKz2DyUvle2GRhOteC5YFJu
 nCEbbhdZB8gFYys4s9OXCpKqdnEzaljJdCTMLete+1eTJXU1l5tuzqbRR4Md76z/wWEIl/diBSs
 cldifWrxEQUmCeVwpvprg14ZkJ6AJqAWILW1tkOtvpBgcWyMQU2MQ4BNnH/JrNGt95d4oznyQHO
 l6ls5KFQ==
X-Gm-Gg: AYBFou0Yvn5tUdFJYU5eArnLTUC+Pf8wfK5GYOeHs/5V/uSfyTsdFRL08yFHBdaz9KI
 YREl2/lU0d1F/o1I3wdMAAc7r51iGpsECQZuDXCr4sjf3PSwcQrxiL2msYJI6uXVZCzxtRsgy68
 6MgbFIKuNLEBMfD0ob6if8P+rNGDJGAw2Zyw0j3Vd1Gai19ymqvDyfY+cPBI9SXOvDahihBAqAb
 KIKH09OSdPVXyej4W+A6ilCTG4vvZHaikCMmNZNNwaf50iRD7QQJCQ2NkbGbf80bB51wVWsMtq6
 s8LRCodXNlB88XPG8hDyq5YgmIeFp6daG1+RSOHFA4bz2rS3u0uegh998me419YD2q/mohXjOGQ
 Y6g8v80phKWToqCf8lpx59hblGbx/7AhSMTN3C368hWF1H/EfpZa+CIRiAWO+/KMxrd5GUobJc3
 ehgVPbVVWSujmpk00pUTUIdCsFisbkH+FwS8zMJbKqgyOS67tv87yEASL24RA9Zg==
X-Received: by 2002:a05:6a20:7f82:b0:3eb:a638:7c6e with SMTP id
 adf61e73a8af0-3eed4ac586amr4406582637.60.1794234120728; 
 Mon, 09 Nov 2026 06:22:00 -0800 (PST)
X-Received: by 2002:a05:6a20:7f82:b0:3eb:a638:7c6e with SMTP id
 adf61e73a8af0-3eed4ac586amr4406541637.60.1794234120184; 
 Mon, 09 Nov 2026 06:22:00 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b648e54747sm1400381b3a.11.2026.11.09.06.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:59 -0800 (PST)
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
Subject: [PATCH v8 13/15] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
Date: Mon,  9 Nov 2026 06:19:59 -0800
Message-ID: <20261109142111.256630-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -tQZ-OL0BICaCtnIaWDfQnUL9bU1DigQ
X-Proofpoint-ORIG-GUID: -tQZ-OL0BICaCtnIaWDfQnUL9bU1DigQ
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af1d709 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=UnxhJFuZtzOLgjs1IeAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfXz95xEBewYOy4
 Z6pX/s7OP9TXukEdCKRvXxhDqWZ5QZuc72EGF9r+rHJuQTdSSZJ0NUiMBbPhTrQuOkl16EJY7Pm
 X7QJFJ0Cp6RDcQp5dN4TovqAWp7O6yU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX42cK5qNtzwlT
 ucpkA10/YXmPYempb0PXPNrznBGBNbQlQpkHcjC7vafcF6Qr+x8Lqts+US9r8pv9ylZvJyO7WRD
 /F7W2KAjCyW62bSON3DiPbk8miGVrzPx+n3hxFQBee5VjJ4tLFQQTQ4ClYQF0+CP226xxY0QfDe
 7ee8b0um0vsafgofhX7NV+eMVsmomvwvcysIEaQN0VaTlCqtZebnOROp2jDjI2QvIaUobTykGvq
 HYb669E3ufnFi3nK1Pb1gsasL0oOa1qnuJsvua/hIOr21JZVwiLwBOWFkkrNNpoe0B0bEgUUkao
 mjcBCJ0A2Ug3G1T+U1I4UZDQ4sOdxhS/fKbz7af8+U3FT6ks1kNHUoGGvr1gB0f5X+EjcsnKY7g
 r9ekdyNFaIaGoq6dzQC6TANeu/+sPQpbdIffP8OazVHAbI6Z7mxo4t/E5l1pkBO97XAZldFggbl
 d+CJizgxBKcUelo1kQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090057
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

