Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DB9F5A8C8
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088D710E1EB;
	Mon, 20 Apr 2026 22:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NaYBOG6x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CKJg4s4y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F248D10E1CC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJNwdF1011934
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lcPhu9r6gLN
 Un/M0FOO+8vu6c2tQ6RhDeBZbp1avftg=; b=NaYBOG6x6AMpRPPDWHtjCDW2/tb
 FqjGDEoXIPDXVsMj567NoofMztEBDvEd5dOfSqloXCutNXitCXJRNIvOX0MpgiwZ
 EcegMPFubCK+K7zSy6HbeAGt37HgrjTtEEpBMPQDoEkk9uGSevtKArheHEIvL/g4
 dMQVQxH3DSN6bChx51TJ16eICLNQR02KY2FLcxppfDjNijaxT+jXCbKW54Gxm/vn
 WivY4FCwyxcBOtBdUKqyzUgyke82Xw/1UrB0DMYAU4CndtJ09X1J592gg5zTUacK
 lqHn11tY3ULIB+WIjhdjw1quY3s7TbN8+BsvMJNnok1ng1daWcnyS7Or/pA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt900fuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2497cc190so26961315ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724035; x=1777328835;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcPhu9r6gLNUn/M0FOO+8vu6c2tQ6RhDeBZbp1avftg=;
 b=CKJg4s4y4rsNFoXKsjuZ56+SBvxqURBmubiAPvvHZDQeq4oW22SvUYkMfnkwZwbRbl
 AFu6bKqt0LOnQT16ZLcHxpryMzEer/a6Z+RzMYwRIZ7t2aWg7Jidj8cdOYA6p5U/Hmgj
 qlLE1Ikqu1CDetKDKC49Yy3TecfG4aswI6dSUX4/U7Z8jjDuuY8EwrlGwWKAzQb5RxS2
 dxaxK0vKRSnZGA46FU+96uxp+APbvn+7iS6cuqj+RNeoh9NA8c+kNSIE4oxZlZAFZ/bi
 sqAd2vjipTEIsKFfNFqETAk78KA41GyNoMTsL13fiHAmw8akPdn5Vx6b82FmZ4HKzaNu
 20kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724035; x=1777328835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcPhu9r6gLNUn/M0FOO+8vu6c2tQ6RhDeBZbp1avftg=;
 b=DgtHGJmk+fDalw1wAIc/NpUKC3m9y0hyJTnOFjmBeycB7hmsde7yXE/f7iMpaWt16/
 uhcnIMMzDcVoBN+AgTuWtVHlLbwiTX+QKvtqhTADx6p2BYQFqhQPVFZHm1K1ZHWOjxy8
 hZwBFV5yGBcsWb5HxlvLD8SFcXRJae4Ku6FpeCrUsYqDu5cf/h10q6Djg3YqE7LM/+5B
 Zn8FY1iIW5fACYxcwL5geCPP1yFvTKPbtti/eHDmFTfe6Xly+bgIVnijbur5vocqIOMx
 LeWsTB7Hk3EOMOjLybV+pIH4X/av4FbPXynWI5/f8NvakUP2HYIYKGO8vXxdSHlqBL2M
 q5ZQ==
X-Gm-Message-State: AOJu0YzzsmCZkJMr7tuw76KN0gtNNKLGRV+54FbPoBmAJsGse9jeA4no
 NYKyVKswqN8GPlwQrD0wie3MWp278AZHfBMo5wNW736/VhMdsIlyn1oIyyTlcgGLqJOvzJW97uX
 mSvVg3ngOpZS0iNEfIPy6QX7YPf+FC2hb4d8MaJ5o4qJOANqdKatAXpvT8/de2rhWroRYI74JNa
 WBMLQ=
X-Gm-Gg: AeBDievPWL8OyZwFyOfouw08KL4PqTPUAAkkDctH5Tu8r9+H1Fe+15cW479UW3aU0UY
 nKOofHWnqfBLD+UH8bQUxUxO/WyjbUi5BsUnN7MinQSPq5Hm4O25bkgWGYpTAS9jSzrjRL+J/cY
 a/4l3OQfrTMBhmfvR3z3FVKoWwD1mjOVsHpUy2sEr8tFaflP+s97FgTPlWHxUeVVi8++DO49ULv
 utdHyMtT93HIXswfsVGaez1yEoAg5ETedfn0J9Q0xiKEfJV6UZE26rUHFTGi4JkDTgeuZkW8THJ
 rJCosv6Yrk6H21RV3bVCZkgv16yYCY2fUynlwVeNidcSrYPNHnCXz/Hd293OU1MhRd1DGVvmv/x
 UglGWIM2dDDvLdg6tFx7d+NllSqHXc7YEOlGl/69r29E=
X-Received: by 2002:a17:902:7612:b0:2b0:5450:a910 with SMTP id
 d9443c01a7336-2b5f9e95060mr93671855ad.17.1776724034663; 
 Mon, 20 Apr 2026 15:27:14 -0700 (PDT)
X-Received: by 2002:a17:902:7612:b0:2b0:5450:a910 with SMTP id
 d9443c01a7336-2b5f9e95060mr93671745ad.17.1776724034184; 
 Mon, 20 Apr 2026 15:27:14 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab4cc47sm116051155ad.82.2026.04.20.15.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:27:13 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/13] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Mon, 20 Apr 2026 15:25:27 -0700
Message-ID: <20260420222621.417276-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e6a843 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=ZRXlmS4ShPoOlOK7p90A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: eR5XrSbcz6ygsYFgYwXkzVzRUS3j9qqS
X-Proofpoint-GUID: eR5XrSbcz6ygsYFgYwXkzVzRUS3j9qqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfX89MuLrXGQoAB
 W3xtPzY03gShQ5Yjb5cb0pu58zZmvx0eNMPYzg3Sp3M+gpwsdwyq5QQefEcm3hQBGgzvF8d9c0K
 S0CJMBtkA89wJFM4ZU+5ZMS1TWAJ8llyLkcqEGEgt+ROHJxGgFNYGoAwgarItb3TqW8oon3LTm5
 +7Hu5ttmV3sS4tSo9+JcZPuMq4AY1sDz/IUMLwjXmyQ+CWwU3PS0r/stXFj9J7XFvCkAhU2CaDy
 ofooYqrKW8K72xCXY9gHFPtHw0btVZYJox3itEhcoK9Y8+NP4ktDbB+IcFvJMcIdVyKLvAIK13p
 fgipCyNVcJO8QGvkKL5HlAPsnwtcxEpiqvPThjiCHekQorEDTkn0Os6l12CjFcmWApscZ9UxOBo
 YyuHbAlFpTLFZ3xD72rolPixAil8SGUlzvIIAlv6CIqtrKp1G6/mHhng6eGZJDFRo+TzyTLEsee
 wgykqiG4RtOtDkng6nA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.53.0

