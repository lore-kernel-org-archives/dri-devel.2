Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A1BC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B950E10E710;
	Sat, 12 Sep 2026 12:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HF3eXwSL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UOdW7k+x";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE0E10E70B
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:36 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBe3fc3459276
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C08XeX2FFrQaQVRDvYflEJeFTvMG8k68onVOApp7D60=; b=HF3eXwSLNRwlfJAz
 fbY4/3ikrLE6/gmkZMGtiLcv46H9XsvE8/slsLAlFqw/nQvBPCp1ztBsg7gsSXRs
 Z1I93rQ+qQo+RfO3K2dqPeGnDOlzQXLBcbZVGeKz6Fg9aH2fK1qtEzh19AmurmKL
 COy8XceitD1QmLQLa47eKm1V+LvHZbyiuN+lzIWwEEsfEqPdMIlUFptu/m2QVwXS
 wz0o7xh2gAuJN/WYebtY/5ptoq6mxJXe2Qn9IbYQ7kLbZJcSD0V1fr0gVmjbPMFE
 7nioCxlYzxfSKanz+aI8AutktBqvo6BQy/VPJ9cSvENQyyOgyjYrQR3t3DgSdGgI
 jipN6w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgxv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78fb9f59781so1445587137.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217315; x=1789822115;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C08XeX2FFrQaQVRDvYflEJeFTvMG8k68onVOApp7D60=;
 b=UOdW7k+xxDj+rTOWojdwqqME+8NHKZaaPhEcoqVhRS2vH1scE/g3iXTz8GEfUAR1nm
 +SBT4hFCcuYdv52y1guug4VUWd2WJ/AYsRjfTAr25WmIPwuqRX6xdCbH0AcNOhL/9VDb
 PujQ8OhLmZn2p2MzYXsdlJAf9akiMQzauA71AF4RSdrYM3+YAJyMLlpocCXE3C/q+Dvp
 2AY1wdfrHhBGoOVkA0VODs1PmQ8wcbczaMkTCC4Qt7cdUh4D2mgmD9b4t5+yOfEnl+yt
 sYpRBq4OcsjwXn2mKqKFrbVy4CWOYdg52J+AFBLcF8c8ffzHLEZOJuaL+Kqhs65CgrhR
 mfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217315; x=1789822115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C08XeX2FFrQaQVRDvYflEJeFTvMG8k68onVOApp7D60=;
 b=AJjMyKJ6/QzGliDm/ol6OzElFkF3ffJvmWCSXuePN3pu8ohoszqTXYkfuhwx25ZNmY
 /7EqSrnGJYtIYXaN6xQJTdJtUCGng+tCSunog5D70HjQRrDymN/F/JOM/3Bo+Z7q6ZWo
 H/+zPndZchfUqb4IogMXyH0T3s0eESeWTJ+NavQALFcJgEJb2yf9JQmyUqM0sanQlfq+
 e6xYxbNqpcY1VaO8VbZNbLd8j9Rhdumt2efdXvRdtbEPDumsXrbIZvsX/RcwKyPzBekW
 D7BUwyXXobBsz6kbobSXOXrnnLuFXECEZZSLGe7k9x8o3t+UFgD8L87SkXXKgNiYmdfZ
 eMxA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrRuEPzqa+yl2hsZLYg7amiFeSu/9pkv2ul0ju0ezoVdkpm7chK/Rtrt+YJrYlAGWLLYNJuKbViII=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nnpDQrPNhpk2qIB7o3mWcb/0huHU8C0I6KmciaxApJ8NEtNq+d
 ZnWirthJcdy5Dlb3IhsTU5Sb++8cbTmSxddbZ4u7mLUUWkh/LWsStJy9DH/18Klwi6pDB0tWRgS
 iE7N8EridY1u+J2mL3wI2TFfNmAfU88uHLu3VybOjp3N7oTPfcRhNBSei583q4dqy5cy2qkA=
X-Gm-Gg: AYBFou0UACPR/6j29JBKG8XSj/yQQ2CJi9xG6O5ov7WryAFUjLlOzftlTMXYk/sBx1x
 5WaSJpjNkC7HCNTzPicUEDefi1ZV9gDb1Ir4Fg3+60WKlmDxh1eZCMJxk3r6HkBcB3hmmr4pKXk
 yeZ/t/d2llNI3DhV99hRmE2NLRbFK9Zkk/9QL370e/8FSR9x/BlNRZiYr1qyxAg2bK5mSb/jTvN
 SBMjV2jgd1bTiIr3fEGcvWDJbuDTrS40bn1a0A8OdsKKk6l996/2ryICtbtxIyWvRjn2ooFBezv
 j/+G4EvhGYsv7zyF6SzjvMsvobFRuEM1SvrNetWIV5EVs/dme1pa9x0zEiT9ybEIxQKzIgH6HVc
 kuv4r4AdqLCe348pggDIxVX9B51LeORpthdiHqYMqnnDM5C+8TmqzhqAEtiJTHAyLMT2yF6M2mR
 gRaJyk8NeqbbKj
X-Received: by 2002:a05:6102:2592:20b0:786:dfa:c5ea with SMTP id
 ada2fe7eead31-792a5b8ec7fmr4320401137.5.1789217314812; 
 Sat, 12 Sep 2026 05:48:34 -0700 (PDT)
X-Received: by 2002:a05:6102:2592:20b0:786:dfa:c5ea with SMTP id
 ada2fe7eead31-792a5b8ec7fmr4320392137.5.1789217314461; 
 Sat, 12 Sep 2026 05:48:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:25 +0300
Subject: [PATCH v3 5/8] drm/msm/dpu: clear the DSPP pointer when no DSPP is
 assigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-5-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=42MaHuKsi9wtmIKNRqT8ly0SxW0ZKEjpv2W8+Aag/4g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoXJtkp6xzhmqkONLh41KlY4RqHvvU3nyLSz
 yg6Ldhr4ICJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFwAKCRCLPIo+Aiko
 1Vw9CACWmy7M/jD5kaRVjaa/LjM93maKtO6/NwlYADO+O4on8dxA8tmlBt9L6s6LHatDjap7D/1
 spoGOXEdS7eZIbybnBNuJEz/INBcSm7hUAz4DWNiLe4rwrCZo7bWdUcawl9cV0UmyTK34k8uBnd
 5qT0uxHad1kYx/vRmw2SIyRZpb0JRiFfgLaEoo535kxuoFrYSHi9eG/fMiKN9VxO0yl1xpnu9ov
 FtLLPcoXAgsmM/aPs0F7AcElqrJ75rFL7qnA0Acq9OHl3g0wDJjNU4dXotQhGlMg7gTnR9sPuzP
 96PVsx/yodrA6p88BXpK93mtklYxAzhJDg+UeL3aO4o8JlFn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: tVYtb-ORFKXskgb69Dj_6_4sBUQDyrTg
X-Proofpoint-ORIG-GUID: tVYtb-ORFKXskgb69Dj_6_4sBUQDyrTg
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa54a23 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=jpbDcG_WXHA3xrgMYRUA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX8QFI7uy9O0bx
 DeKqq+TuZ57Qcql+/Bx5NI7R3eXQFm/FJhRp3JNSK3w+eFr3uVpLFKdsKsjPVeE/2GjHV/49Wpi
 Ux5GL1GAk5PCizEERdDqxWEA49pCiBg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX3M4rhNITB+Ec
 WaBGROVkQxsJOWF7e5avqYKV5RvN6K+zYyfNfPJQuY0pLIW8kAH0nGybEKcZ7UgWowWQDcKmV7B
 yhSTcTGPt8kdvrRmtW3oSHp6gm7KWH/SjXgF5rUt2GeqkMO0vdsCPjaFK0FfE3G0EPWyHe7DtMN
 fTDUkDuIbomOiCZkJ7Oax2ucrPnHJJU73s2GwZUxRyGfQhbdLUISDLDbWqrDxAwoG8NUls6gxEW
 NkSXCH+hQyznjqEgDi1XwnjQd9mzO9W8FyslIyAyjqwXkX30N/eobw2kV7s4it6VvRS+bQIA5DB
 XbnaPkFwIz4fTbo0r+mU7NC+0a6TKHRa6W0ITOcbhjvuuxutKMuE+6nItbiZ/RhG+387PKYass6
 tA6N0oYd84XNUjDpoBqDpHXtMjXaf4q8Q2sVFAnih31QeFL2GVyizJ6dFQPyoe9CW2A677m5DUI
 6EO8olP3AN8fYiIHvLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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

dpu_crtc_assign_resources() only stores mixers[i].hw_dspp when the new
topology has a DSPP for that mixer, and dpu_crtc_duplicate_state() copies
the state with kmemdup(), so a crtc which once used a DSPP keeps a pointer
to it for the rest of its life -- across reservations which no longer own
that block.

Assign NULL when there is no DSPP for the mixer.

Fixes: 4259ff7ae509 ("drm/msm/dpu: add support for pcc color block in dpu driver")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index bf593020e8e4..5dc0c9aeaa5d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1480,8 +1480,8 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
 
 		cstate->mixers[i].hw_lm = to_dpu_hw_mixer(hw_lm[i]);
 		cstate->mixers[i].lm_ctl = to_dpu_hw_ctl(hw_ctl[ctl_idx]);
-		if (i < num_dspp)
-			cstate->mixers[i].hw_dspp = to_dpu_hw_dspp(hw_dspp[i]);
+		cstate->mixers[i].hw_dspp = i < num_dspp ?
+			to_dpu_hw_dspp(hw_dspp[i]) : NULL;
 	}
 
 	cstate->num_mixers = num_lm;

-- 
2.47.3

