Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC6606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GDd7Wezt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OVVeAiHL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738A910E27D;
	Tue, 20 Oct 2026 20:48:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFACE10E94C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtl012278771
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Q5GkNVNRfPw
 2zEKJCJZ4tInEwatTood77UzHJkknqQ0=; b=GDd7WeztKU3UZnBIFRu1ZuACveS
 4ewjnJv4KN+MFiQZysoLK/tX+PmITOMIx12VKCVPliRitgjuBjvViqGXkhXOOFgx
 Kx937NgaOYnMNf33EYVoceR0CvipZ6xXdQJ+u7wbok937Aq7VzCpIxsZ7wpF6ytI
 +zTGbVX/WtEOqWoHjCGIFtYRYE1nxNMNCJebfVxRw9dl/VBENlcUgmm+kczqsEnK
 V7RvZ8YR+dcNxLcUT7fR2WK9DXdX7IxuTTuaXp+dgRwOWIYUmN88mb1al9LxVCCS
 Dm36ze9r9PyFUb5G9Gx6uH9e9QoOYguzjL63WaKlNB+yQ9HX1jfA2MaHXbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2a3tf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e818ca61bfso114885ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529274; x=1793134074;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q5GkNVNRfPw2zEKJCJZ4tInEwatTood77UzHJkknqQ0=;
 b=OVVeAiHLxTrSpe8wdE3wF7SBKTwsSGSgtNrXRL0Yq97YZxmCKpxrs2Dt2PtBhlaDSc
 Ll94lDB2gozhGEQaXZyNTrG5bjYvt0nOGeAtoFoYaZWHEGsx6vLvl6eJVJAYJ52si9Lh
 DiwluyixsrsOb984EPRghtk50n02rHelR133Gp/dyhM70wr1OSJpQeupLJqm7NbahcHv
 F/89D/Q0vw7zZFeFTg79f4t3OpZ3ziOuFFLttn642aezYchKVhnNA2X492+rdhtiZrrl
 mqXQfz8cWGobbCuA5f/T57bLdGe0jw3V8TDtchWFeh8knB4aKrWZi/HVHm+h9rKCONEy
 vIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529274; x=1793134074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q5GkNVNRfPw2zEKJCJZ4tInEwatTood77UzHJkknqQ0=;
 b=jVmnVN2cFVBE+dCho8GMCk2TEIoShVwRGYV1MOljpA3kplHovVUJi0DHQPQ+cKwAHY
 3VK+W4eiz37LdtoTa5Ouat5YWauV1zm8suQLRJ/bWpGZ3tWiBK7CDfjpr2b72/VSca3J
 ZgFjcHkSp1a/g22Lq0hfcHxihlKXZL1CQsGuI3ER3jdgUYynxc0cZXSWo42+3pgs05lw
 dgJflRyI5AevL5jiC1ZcvZX0CxDoJ8xyUx72S2rnWoCl8HUS2DpqFUx0ONzHH7IybeW1
 hYeto3EO+tBxdKkcNXbvNipmACCEgT3a9RmbDP5mYlhivrBm8q9YmZZ14c8sfBOoUxo6
 emKw==
X-Gm-Message-State: AFq9FYKbeasNHCOo0jlKmL7vgM4chm8DjlqcfgppBiqtd681VDu6leJ0
 iT92hB+aEhLajoAd5hdj2TBQ+Zmx+i2/jhtvP106ffLctvnTWynrsaOePvMociK0JAAy71df8o2
 t0/buMUMgiZ2Be3YAg+zc65Sh/hqxLCnLO+aUNjEO8pSQEDTsOxFcJ7D0ZgCSCvoOpM+J3Is5dv
 RRe7s=
X-Gm-Gg: AYBFou2ZboWqm7fUuilTE4VlGLVhprRH/UmO2QCyo2LiaswQraGh39KOXLzWQYsU9ra
 9ACH5kp62U4KVGcE6d7WbHG/nJVPTUPjedrRadg6RMNA3LVZkq/e3/vFFuf9/o4wRbuvJ6bxt2f
 qGEUzB15YhjIXO3+WKnq4+uawXx0th3WPnByPKsqmK+D/LfAjnbJOBMIy23cGx5KclCufjLKoyP
 UgsY2GKnCnRcszVmsY0uiuaq1h0Y+RTel82ioG26b3l2O5/ugWZUQNdRFN0woz6BYhnx+HvflB2
 Yts14r78SRHPKG+dMr7smvoJSTqzNlRb4DQIpIhINBlfLJ6V9kW7C7oEn/2SjID8ANFTOZAaHXB
 66N35qUAZYrWCGZY9eeU66Rs3M/4W7JF8+7HJfBG6shJqqJn6Ow==
X-Received: by 2002:a17:90b:2683:b0:3aa:ff61:9504 with SMTP id
 98e67ed59e1d1-3ad86d1d122mr98470a91.20.1792529273659; 
 Tue, 20 Oct 2026 13:47:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2683:b0:3aa:ff61:9504 with SMTP id
 98e67ed59e1d1-3ad86d1d122mr98424a91.20.1792529272304; 
 Tue, 20 Oct 2026 13:47:52 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8035c42fsm1003438a91.17.2026.10.20.13.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:51 -0700 (PDT)
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
Subject: [PATCH 04/12] drm/msm/a8xx: Allow nonctx reglist to include GMU regs
Date: Tue, 20 Oct 2026 13:46:18 -0700
Message-ID: <20261020204728.28844-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YZJMY2nHEqyo6j1gGTA3-c7FhxTWq93r
X-Proofpoint-ORIG-GUID: YZJMY2nHEqyo6j1gGTA3-c7FhxTWq93r
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7d37a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX2wdqo2e7YLTq
 djP0ZDuwe4KlkVaX0BGD+8Ikka5OMqRw6kq4CuJTh8gPKLr+D9uqZcMO9ScrJ1yf/8JXBV/BiSq
 VuRyaNdlKATj4jRB5WEFqmEiT3w/hGM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX38kgQiNL38ZP
 1o1b9l/ZCFJZJ5ObFVL4SmTWDkH0mvPoNu7ItmSiL7zVAONYFrflUhGse9mHwWPIS/FM50pVUjD
 4u3dlo8FHVsMbBfC3ke9UHb8ECRyD1/ChVeSUC0mM2C726S+Q9uzmzj/X5By2j+59atZUYs2Q9K
 bNInH1idMu5u1b3llO8Jo0E5DUlOOjDS/ryuZ6EJF2s+xEhuWPYsX+Y439SSGtBmLzFZGOkeUKg
 OL4TF0x5PVA/nhQfXlJpysu3xQ/R/b5A8Jyt3V82bMNg7S2B6G3P2PHq58QTZ8ji85InlAGbdLh
 5Uga/6XfFWYewJ33Lo8spLqnxVUCj6CmtHDv6dTQqCCOy/paZ1Z9/AeFl8cbGcVNVScTVrqvTRc
 0zm8qu4E+gi8g/U7MTDm3426JUA2zFiqom0e0kkAANAbM/EWoaxPFRtY1Ek2MHLHrUcfeNSyjlP
 d8D4nx48GapcluQeNOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
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

From hw PoV, it's all part of the GPU.  But from dt perspective it is
it's own device with a separate io space.  So we need to detect this and
direct writes to the correct place.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 72c84f73157a..3e22ef788f2d 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -376,6 +376,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
 	unsigned int pipe_id, i;
@@ -395,7 +396,11 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
 				*gmem_protect = regs[i].value;
 
-			gpu_write(gpu, regs[i].offset, regs[i].value);
+			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
+				gmu_write(gmu, regs[i].offset, regs[i].value);
+			} else {
+				gpu_write(gpu, regs[i].offset, regs[i].value);
+			}
 		}
 
 		a8xx_aperture_release(gpu, flags);
-- 
2.56.0

