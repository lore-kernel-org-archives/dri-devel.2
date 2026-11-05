Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954B606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IfUFlIF0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MECKHftO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0514310FEBB;
	Thu,  5 Nov 2026 20:40:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B981610FCA4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeBjw2513431
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QFNvTKwj8PV
 EttRnGaTT/zX367b+0e2GeEloYfiwPaE=; b=IfUFlIF05D2STh+UTqAZIsMpUGw
 SraiPofKJppu9dZLWFeb6KFG8wNBdLH/6PyfxQHCk9TYYQHRRBKz38Dx0S2VYzyC
 kNI5yFv+mNeBAq/j+t3/j536cqZ1dNVE6Y6N5FCKvDgHs9fpC52wdE/VMFSCWohj
 Q7UjsBLcky8fSm50XCbXVY+s/4yhiJEPV/RXUksFP9BZTqqpPQTPlnMOfubKSVAz
 Bw/wwrLGVYWD3+xQBJ8h1cRYuoZR9ENXyLJ+lTK1EzufY/X2Ds7skwNjGUF4Dp23
 Pmy3mk7AEdRbrZwOChvNYP+Z/b5/ZFg43u1s25POyyJ+3kcKMucCQgEynAA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraatkp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2eaae8d29e0so20474445ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911233; x=1794516033;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QFNvTKwj8PVEttRnGaTT/zX367b+0e2GeEloYfiwPaE=;
 b=MECKHftOfA2TUNovzYE0I0Ic2vMjhw5TSkqEUiyse7ERXDVGCkbgm1rVFSpL9yxgVW
 UMvJC0T7LszATyMvP/TNbuEZLmn3ZRtyOfPAFvfSTnnKoWnPFe0GicLPz1VT4TtWkZWK
 HuajoDmo9xKxdsJlNzIY9P/jDUAJ6THyOeS9tg361Qkhm2fobCwUnIDE4EoGpN2sc5W5
 pQbwLICFUueaXC8NlOnRCaDQ/nGu3F1mb4EpukKtZ3Uqb4nypaxaGnpYG6qnI/q+DBFL
 ziGCerGxtE9G+5aKcuzRTpvsTJizGEJGhQvv1nX+tk/GnrrKyEtrMqc99ZfrXi2I6xG/
 dytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911233; x=1794516033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QFNvTKwj8PVEttRnGaTT/zX367b+0e2GeEloYfiwPaE=;
 b=E2xajIDlkJkTSTqRI0HsBmLrIOxelHvBPrifdnkfrG4AqtNI8nDkvEFSjxh/Sb6SLv
 9/+ATLGr8miT0+DzDLTVgIksLdYR1wCNKF6mmXtneH6O1fNP8RVf77jNvYzFSdmDKvTm
 hUEGizKlYUtSdUCT3FvlcqMd60zs4kJw8a9/9t0OdWhq0bFNFSnCgKpnmTBcW6nfr40F
 oN75vyK5joznoRTfFqmrOE7lqc3A/v30FBCIwtLexjxztLhTTeXgQ+WqvbMHkXfpOzn9
 ElRx/jIstV3YFInNEVamX979kIRMUdH2hMUJ3FVZPhGTmUxA9NIRWYhEfJILqDSwUoVF
 Qzvg==
X-Gm-Message-State: APuU4Z//iIcoWd7kwmDLKSlJ/QJS1kP8Aob+Koy4cXCAbLzq1zfDG30N
 hBCbpJ7NHtfz2mRMj4HqlX52PsM5QlZz6lGgNxCDBAJ/WMrxpboRkzN7fzgODXALKAlm299S9Xx
 GwNPadTsTd/ajY+oaHQoG+pBgSnWBGnoqhXQ8grpUtmaeDstz9bmhmaBzll8WU5Gp2vfwyIHGb+
 9+Ppc=
X-Gm-Gg: AYBFou0QRz/XGk0DsTYn/y9c2MXkeS4PEmPuRFhnYfvLvUR5d5MXTLBCSQTiJ/66bcS
 q+C0AfGM+H4sAExWz0ybbjZLuBDH8utUoaVs5k2ZD2TUPKQ/te1MMznY62dSICyHblS/S9lTzAz
 OOvd4EZVu1K69+Vk9NRSm+da6elazLEa3NWf/5ry5blretOljYfjuid6fvRpW5lMCCo+oMH0Sxw
 FG9MQLMd+Oxd/r0gEIlcZljEnkopXkxavzI3KylJMt6YluTLFD+2HcrTAcb8czhSHSlzOHNSiQ+
 ARqHlL0F5ALkFEG97P9u5OjUbF4YrLK6SEZcLh+wOyh3tItK03v+fMLFcRi8MxwY1HOVBO8tUJ/
 NUNrCWxt/IKirl9YdxaQhwQyxhFeJ0D1O+OfIHxYlVqnj1TYpw4Y1x3WByybitDpg+HI3sbN/pV
 Jfv7fQKq+u1Wjk/Oy7GUQfzYRNsVL2QnXKV7YW/cMRMK9T6k6+fQ517pKZVe5oFA==
X-Received: by 2002:a17:90a:e703:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3b0db6dfb59mr146683a91.13.1793911233152; 
 Thu, 05 Nov 2026 12:40:33 -0800 (PST)
X-Received: by 2002:a17:90a:e703:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3b0db6dfb59mr146658a91.13.1793911232686; 
 Thu, 05 Nov 2026 12:40:32 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b326add7sm5033443a91.8.2026.11.05.12.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:31 -0800 (PST)
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
Subject: [PATCH v6 06/15] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Thu,  5 Nov 2026 12:29:32 -0800
Message-ID: <20261105203057.66520-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX6jOg8lE92wNA
 V0cP8ivuX8ub8IwSbt0skonfTvMY6qvvuaRRsGBkYFfRKin0sRrJRtTLhYrzu+PXr5mdLe2Z+0q
 x1QJlsaMiLQVyxi7olAt8xooeSOkOxo=
X-Proofpoint-ORIG-GUID: Rzyf900-0Td2QtEHCEpXgxR56q9nuyAG
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aece9c2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX7cd9bWXiVrIY
 IrKHSLeH4RYVNfByVMj9DbnwoZiAG6ifQJtJ0Tp9uwIGydHxJOBX5OUM08zJezei1rnXdq9qEbD
 XlJMpdUCil8b9BE51lcdFo0MGkebwg6xWhzR3P5/XcWbSqldnxugLQGd3x4dj73+iVM6WxHB6yD
 NuUHOOfzV+Ug2fzoqD6Ci994bwAxFK3LoSmaoE6Dnr4lAyyILyZF5iyuL4XE5Nab9XLY3rwko4l
 Tu+Cxt9g12roG5igfAidw7YWUfNx5z47k88WKL/68Ma+Ik8sNdB2X9G4ZtM9ub5ydp1sUss3WQe
 IxQGqYmLplUVn1y1sA1xsVH99JrQf37apGsWhh4UqHr5fz6OGIivGCI4WfEdV11SdgqJxA4ZEmD
 0vK8oG8KHRl7cfT6qZ1+3vZigVC93yaPWSziXsAh+0qWcmn4Vim2VyjoYGde5OvIAIuEJF80fPc
 3fAurocpztakYaoez5w==
X-Proofpoint-GUID: Rzyf900-0Td2QtEHCEpXgxR56q9nuyAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082
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

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a29f8149493c..59898b49a201 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -373,6 +373,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
 	unsigned int pipe_id, i;
@@ -392,7 +393,11 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
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

