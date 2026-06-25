Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11102CDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6477110F3B3;
	Thu, 25 Jun 2026 22:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GIQNh9vj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IYtv0SQp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A29610F3A9
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PIQRIQ1196392
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CrqeyYgLg0O
 yN3yne80Nf16IikyqcRRNAcpAakZrOf8=; b=GIQNh9vj7976s1PV4uK6sNl1Ymh
 Irj/v3lo1FXnt0baIlR0HGIalpQURhWwD7ZF10IZfG4jm+Q2kmjUzcwmmbV682j9
 wJ8V5S2skww2vmG4xrbktPSs7vhsAIQY8/+GliP5WAxKn5P/TRGbc803FgRjrsEu
 mOWUrbBUymUL5pG99Ef6PNWv6cyJcmLrmBikJRkW8brsLO1u9W3j48iJAhe/9AeO
 ngQwZ81/zcVbxPmMtYDjrVitEc4McFZ6Hu3NBJe/eQPQXwFqL+FlUi//jqNDckkj
 bfrtXSlTC4vwTfXhZR2C5aIYElL7raKT2CBAmz2QnPRVtsauJi9aQsxMsww==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f19m3rr8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c804e38c65so4121975ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426477; x=1783031277;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrqeyYgLg0OyN3yne80Nf16IikyqcRRNAcpAakZrOf8=;
 b=IYtv0SQpNlJOeeOXWFAi9CQnMyU8imR1sZEV2AF4XiGJJJRljeYEFkd+xju4HhfvoT
 /nWLxNRxy6dR26F7G2WmjqTN4q35HfbAw9NRNTV2Y/VlbohH3Guw1MBOh2Htmc194Tu4
 DEmwUNacnqUd9G16zDBL5ThYWEX80L/ooSpfjl6q/+scM7ZZJ5bRgKSYOCOj33t/vclm
 GYAUusICrCaSH9dRMX7ellK2qjJhU2Gc12LTiT2cDDC+NNoLvBSfrX0C1rmV4M62wJyR
 VFDwsCyjPwcRGrCrCGqJ2uDR53usyfKSo8sweQLpAn6OWC9ggzACSoXDseaCg+uryIcm
 dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426477; x=1783031277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CrqeyYgLg0OyN3yne80Nf16IikyqcRRNAcpAakZrOf8=;
 b=QUZBgXVz0HXNm9H11/U6zigBDPdsohTv510Wc6CIYneZUaQiFFq/eI5CfBD4NknILJ
 ASF0V2TN4sjVjcFIfotTVwE6fI/kMj0TPGgh1R9Z6NMWmDcNAYe9rmaBVqmmdr6NE85h
 5f5BH7KahsgY+tUyiKFMLbdt1JZ9AV5ExVb5VkKfQN3R4exneorPxCQ4TipsCDJIYjs0
 I2sGxUqiytOqHsGGHnnPxoVHjJavqu3AC14TsVBNt26KcS8HnmQ8otlZR7FoZB2wXP/h
 z8+aCz4Yf/vJrwVCshHMr+TCQVdeuq3GnsclDfXwRJ0e6BwGUi1CzaG0SPO+NqjBOHhI
 zk5w==
X-Gm-Message-State: AOJu0YyfkG0+CFJAXpDXBpfcXWrRjQ5P2tjDyiAegW9mgvs0mCJ55b5M
 Jbm6kbkEF/Dc5WB+4KmbFlLs+RR9DkgcoUSVsC1bz+1lv+YgDhXacmqdDAOgBXomIxQeih5wz0G
 8nki5/pcmGnuEaMCdLlDUXi5QuQo3Na9+rP3L3Gkibjeo7PFR5iWEMIrZ3HoW1WgabOfPngXILo
 fOEzo=
X-Gm-Gg: AfdE7clT2j7H05VSN6KHc0uWm/QR6ihQv6CCYF6ugFdKQ0KOsbCz+LQl3zy4Axc0p7g
 FZ9GCLVb9MZMts2N2oi0Z6xTR7p+ZJ+aMttKqCAEMmbTMEPuth4kNLYqYmhfVXC1y/atbm1Vi5U
 WIuutRn0OQVm546p4LYVUjqIaCtVswG7Pq6CcRCaC/ylQBzWXR6MkJ1nb3a8qM7uen2s6mB7fk2
 LSaycPpASWz/e4EiSoiElvBOi6Wqn1BXYXKSJOoRyLmCN5lvXp4QRsd881ILpieW/EY9KJS37lv
 xGltOIbaf4OLLW6hZGJBNRVY6BLH21BXcs2d4aRmao0TyiRitNqf3dLkCuKNpzY1lTwZkyJybH1
 j9HSp45Iug9cSnYFdIcL1BT2+cd+1WV8lkbuL4YHmkjIBY4zK0w4F4d86KQ==
X-Received: by 2002:a17:902:e78d:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2c7fc632a17mr47006395ad.8.1782426477253; 
 Thu, 25 Jun 2026 15:27:57 -0700 (PDT)
X-Received: by 2002:a17:902:e78d:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2c7fc632a17mr47006145ad.8.1782426476790; 
 Thu, 25 Jun 2026 15:27:56 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f63b24a2sm28025595ad.50.2026.06.25.15.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:27:56 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] drm/msm: Fix per-process-pgtables check
Date: Thu, 25 Jun 2026 15:27:43 -0700
Message-ID: <20260625222744.22254-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX7BVEorNH8u6I
 M2JXIHtsud+W1ug6RcNszzBw65HbeqdeztK6Y+F/wfLPcwxUkyRH+Jbd8Y+Q1LmMKMSO+jEYvYn
 UERR0N2b5JUhp/5XgOyao2KqRzNp644=
X-Proofpoint-GUID: BIXTL3BzH5srZZgetlNz5MLzdnVOtAOL
X-Proofpoint-ORIG-GUID: BIXTL3BzH5srZZgetlNz5MLzdnVOtAOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX4yVTp66sbK7X
 P0e4KsSGtfj+2mghqUTvi+B3cKFwoJQ4IQEzhfkrRP0Km9d9QCiXzWYs0XjTWsJdl4iEGyfAoWf
 6WnX81oyBoUEmhIPiJzTVIk5ixoAbbCD7L1/ART39iPTyaqfiDjdMYJ2ViHS0RKdwCcg8U4HnFf
 +5vlX0pTNzkSPJpdjUC4hVwL1Wj0QljFpu0sd8uoLkiGXrV2X7E4BSz0Hu5g/sK6b+piIHNgFmJ
 3WKMYZAig2YE+GE27lZZu5oLaY0savU0nENc1ofhclrzUhdsIvvOyf6ynm1Z9cB+Jl9axLYGQH8
 HNTjXImwGr02AemZwqHCojrwwDEUcNUNAQlmUXmTTEzsK3+X8H1MqA8t+XJcT5wVZtVyoBZS4hs
 D5Dlkjw6sczR/r17GDducZU7/2X4TGZJCfwJ3VIi1xn9vMYBg/aavWsIawKbc9CR6Cx+guX06ul
 TQ1RyHFU6N3/FxVH9Ww==
X-Authority-Analysis: v=2.4 cv=Vv0Txe2n c=1 sm=1 tr=0 ts=6a3dab6d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vtH2vi951kckHO5NeAIA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support.

Instead just check if create_private_vm() is supported.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..bff2a773c0d4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -505,7 +505,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
 		/* We can only support VM_BIND with per-process pgtables: */
-		if (ctx->vm == gpu->vm)
+		if (!gpu->funcs->create_private_vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 
 		/*
-- 
2.54.0

