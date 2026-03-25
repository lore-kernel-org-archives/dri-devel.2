Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325BF109C059
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851B310E904;
	Wed, 25 Mar 2026 18:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dB9/AK3z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZhBIA9RL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6067B10E903
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:41:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFH2nI1257937
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=yD3+fkKUCogV0OXXreNqk477OXDaZsvVesq
 RPlP5eQQ=; b=dB9/AK3z2AH3NkWebPapWT4Cq+vJ0PH6KcnxSm1EbUm9uq5JSdm
 exUPYNX5BFEpXrY8zk7+FBpvJppxgwmCjAyf0snicsqXEe1h1a5RECi30jqIiTJe
 MlfjDDRnTAHEux7QTFtfSkytMK40W4prplfcs7WfN7ABLxLLRVjti9hQn4ctgDfh
 GUZ77HamZbK7bciZvEicfS5nKUZvpf+XIzi/U2NSm+jbBpyy1Z484iH5C6Xwip0m
 r7+nfmDQ4MAicc+cLJrMLW1wqig7YcIlOKZfl5SxbbGLZ+LdCOTE7/5Pql/Q9Nw2
 C9B7IxbEiCFX+67EUAPwkNHjo3Zth5DglDg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2swxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:41:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b0b0aae381so1437555ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774464071; x=1775068871;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yD3+fkKUCogV0OXXreNqk477OXDaZsvVesqRPlP5eQQ=;
 b=ZhBIA9RL7tfK9JzQFtC7S/0sXxcyJvE7Pb5WcDjQZeW5erPMAHm8HoJKVVtoQNmfOp
 Ygo38B9tyUw6CW3s8Rj+HHOCo8tgrfqRM1rCvIqHuUXKrH7XBGaGz/tvASlkDv/QLKBM
 Vzxh33OHJsSnKC4GVkV/uoso+inyPO2NOmpCU87iN+qJLzM+pTLqzba7Xy7G1WxU0XZR
 1t1CEMSNm0pJAm+s8PwuFZNGmeT3xYtkxDeFNf0yo81kI/lGjbDcdi6ECVyoHeWUgj0G
 Omne72kHxTSBEmVHnoNDi0jdlw3oJ457p75kZzmAr1uW0Elt7nWmPt4L/NfCi8iaLDJu
 Z/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464071; x=1775068871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yD3+fkKUCogV0OXXreNqk477OXDaZsvVesqRPlP5eQQ=;
 b=HN7J2kkfJPMSV+59TqXQc+WhJR4CyJVJvkI/UlOA832rP3vGigtE1dX8PMbg+uguqU
 Ltrk/i1ImuK1kQKyZLFrRo5LpvpQa39Do5ibsPGm0Qpv6z3zMd5bybo7XrvSErIFCpjo
 HED5hI0Qmv9N606yHqI3usOqmUKzsNE524tzrMF7SfqXq2lsTBG1uMNP9TPWew1kYmDY
 rY8ajr1SnATukmefV/yeLy6uP1j8oLm3QlR8/hKPKoKSqyHNjInsdCZOokMV3r1U96Fe
 5mp3vBiJHYIensMRbKkFZw4lJMOiCFKU1DHB81qevrL76F/NEJO2oNucBbMaSDU4imIU
 6Afg==
X-Gm-Message-State: AOJu0YwJ9ocyKRhDaPft+ic12OMR07SH9kiFCqTz1/+TJTtHXuiHJ7W6
 SD9JHZgAy+2OMEOjU219WUZdvoxpkSeZ4KGFc/uzuqkAGl2ewy+Wl/1JpbwAy6Y21IdVwZGLzWD
 oeWQQyU5Krh1iwU1dmoklsQOd2LTBD+pjUwFyYBsKtmzpSRdyGmTD/0lQp9nTk405Eal1hjkxR5
 4jQQ0=
X-Gm-Gg: ATEYQzyelZTt/MNqwa5PCbr7TLO+K3DeVcJz7rZ+XVAGyEG5U0+j4h9AjVKnI2+tFzL
 hNOa5f6XppqzpYckVXitnai1aBwy2f19KZBuQoIrAnFXzKp4EzOPNgx4LQVQQr9e8eEmanO0tOW
 McJwDgg1pc6xwpC0i5gehN2lMQAOwL0XGFvEFi6dW3gMEjnkb8EqWtxK1ujZaGvb9pBkBBzUqzD
 xZV2aQNfemKwcGdVlCpksGJKuxc0UzFliRIKjlNvIP1kxZ4pIAQbYD04UiVaite4u1D3pZg4zR5
 Bx3z4U3/A6rmDvM7u4n8LQiwt0XPohP978vva1mwrwTVdfx+s1zqGeC2iMFiEC/+50dPBQEvpuW
 9M1JNWLNUDynO0xqO7Krm7+j30OVAls23
X-Received: by 2002:a17:903:228c:b0:2b0:6e8f:8e79 with SMTP id
 d9443c01a7336-2b0b0adf54bmr50362045ad.42.1774464071016; 
 Wed, 25 Mar 2026 11:41:11 -0700 (PDT)
X-Received: by 2002:a17:903:228c:b0:2b0:6e8f:8e79 with SMTP id
 d9443c01a7336-2b0b0adf54bmr50361775ad.42.1774464070497; 
 Wed, 25 Mar 2026 11:41:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc79c471sm5980785ad.22.2026.03.25.11.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:41:10 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/shrinker: Fix can_block() logic
Date: Wed, 25 Mar 2026 11:41:05 -0700
Message-ID: <20260325184106.1259528-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzNiBTYWx0ZWRfX/CqTi1Up2Ayd
 qM+4QNpcpjNDyZGL50AFnM9V4RljUTFyW98GJtrRrmr2+JcVnL69GnkqIDUeZ2byjhe8AdxSQZT
 dWlYMn+WlcznvO/0dzEpxE/9FQd7rvC2FYrf+MS77cn5UnklrkJqsa/CZ4//nqVp/3vkNVciXwU
 jg8oLZVODtLZnsMi+uJYixhdR/8lksfw2aDel2zIZWbCdGZ1mOg65waliJ53RbP2A/j9FPanx6D
 4U0s/cfe6PyrwU3Iu2xUKtM5d8kFnul6jHGFNA6YNLF5uwi2qPuglh+r597uTUzeam8SqQSEZ0j
 00+iVOHAyIqPogmvBa/NkuY+JPQ2sH+uZ/tsntG0IBkbpH14Hrf3EdLY6HqTgBw+QO41DhD1JDb
 6XGhUNsvkWtcQyeoYT4K4uJb3Rz2zvyJPyruMMpeTJFAUX0x2I618p1JIazlJGGL0hjBpiRUMi4
 Jpiy7SIABnRCMoEiX3A==
X-Proofpoint-GUID: tAYKr8l9x0Og113R82GfJj4et5lamTew
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c42c47 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=3XT13xyzjVv8HZeWGjUA:9 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: tAYKr8l9x0Og113R82GfJj4et5lamTew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250136
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

The intention here was to allow blocking if DIRECT_RECLAIM or if called
from kswapd and KSWAPD_RECLAIM is set.

Reported by Claude code review: https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch9-20260309151119.290217-10-boris.brezillon@collabora.com/ on a panthor patch which had copied similar logic.

Reported-by: Boris Brezillon <boris.brezillon@collabora.com>
Fixes: 7860d720a84c ("drm/msm: Fix build break with recent mm tree")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 1039e3c0a47b..31fa51a44f86 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -26,9 +26,8 @@ static bool can_swap(void)
 
 static bool can_block(struct shrink_control *sc)
 {
-	if (!(sc->gfp_mask & __GFP_DIRECT_RECLAIM))
-		return false;
-	return current_is_kswapd() || (sc->gfp_mask & __GFP_RECLAIM);
+	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
+	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
 }
 
 static unsigned long
-- 
2.53.0

