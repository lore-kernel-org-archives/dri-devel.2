Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F8DF3ED4F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 14:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDAD10E9ED;
	Sat, 11 Apr 2026 14:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaD8qEr7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HHMtEpjU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D153210E9EB
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:59:18 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B46Sdn2624931
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7Nb/AjyriPfrtpiJurQyhh
 BOLNHKNPTN1zEcDyx9jfQ=; b=iaD8qEr7s6n89iZHreQI/MKz3+47pqtv9ssTIw
 ih29ff7tWOEMFhlQbFq8GsMg63sEdVLXhjq043gUtUlNkqqMGoIjtdH3vGV0bfO6
 rVjWepvu0WxH03GaRHmpkAvkQuG1cShkYV7BvqYlzEtkwchudP5LBbR7qXThAOsB
 jT03zTdW9coSidvaA3HQ8kVMCYP1/+eCKPtpNGGYkjFfPbAFjSO3Mvhwt1VWcuee
 q43JrL2PFuPiaUh6Aias7FJwq023uYMC1kxJYWpMmbyimQQbrIPW++I7E35t5KhX
 0UJPkcZ7lMKQwZmuIzL2dirwfHH/j4HCQi5L1AwYwzlzV7Ag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfeyyrw9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:59:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb706313beso418050085a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775919557; x=1776524357;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Nb/AjyriPfrtpiJurQyhhBOLNHKNPTN1zEcDyx9jfQ=;
 b=HHMtEpjUcvd7TmVSC6UnNdGqeu+Le14uqkWQp7gBI93RYfI+25JdkJK9rYtgHc9w+m
 pz/l2Y9YinZU8il1gRO00MzNUXv6DcI76wNT6VesU6gfXZuhIJas/hSsoEXDV1v23FQP
 9B/EraQKKh7eKv5LTLgx3RfSDW1j/+swnSmbAQq4zwozCZsaozt5cJyPuR+9Api2mn3C
 KZZ83DR+7DVO+ZZZrLDDCr+ayZ90pSnbsiP/jgQJQgfpjqufMGl6btfKXI+kezCc55P0
 6U21hSg49cEVoNzCZcLLbclHWlyHi+lyTqzUtkeoeNJYde3vkzpn7S3hXScA9xpW1LG2
 bR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919557; x=1776524357;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Nb/AjyriPfrtpiJurQyhhBOLNHKNPTN1zEcDyx9jfQ=;
 b=EXK0B6gid4UjPHYczR1VPpH0jidGUVSCaa5uglscnEKlOs012i7XwuKrugmLPHHHBF
 90PIEit35vKroymnMGduO5uHmGWfo+4M6ODEusdUYuiNA6b/72zoNTV1uALou1etYTaI
 WUmAQwrIPOqd0ovqp6G4chF80xrNa82FzVXTu8k+OaRof6qONi8VjWg3ApQR0Ssi1c9Y
 nWOTN0NbTNRVft+wROqfK2AEGp4A1alFPIsNkR18NF4M1/yXs74kFlPLmKuFKBIMfK2M
 bor9Idyzr8mmAZffmA3bTDyMGBQjJ1hzIZRW7oWdS2onl46db3Ewhs/4PbM/Oa73SBWy
 AI8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeETWpxNZc0e8DBOlwV8MXWis3ezivh2qGtFCC84R7A8SF9UQenb5/lQ7uwMPZ9dI4WhnrWpQdQd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKfxaEbKlkjmUmpFS0/U58k0gh5LvovinG2SWmPWJjA64kjJRR
 hUUsdCfCRzCj0dM1RyEHB8b2KlFf+o3JKWMNKDFXFn0J7HH0APWb43JXYpy4GcY0gkCtjqIwX1t
 fgcWVpqGwwCYbiiM1LhbKC3OZwbdbZiFb6UQa9VdFvjQI9F/zuCfN3FZ4STOt3NBDKUYBE+A=
X-Gm-Gg: AeBDiev9y9a+rQ7CF9XGCq/f2ruNWoEWAcGiDJO/FnSscX2rnPAF2VRD5tndJLRq0zO
 rjeKA93a5LB4k2HX8l7ovgW3iOs0ai42e7dllGgB8XPFtvQ3PBlB/yHlTrN3T5uwnPlzudRxnR6
 SH4rNtLhhTttuVZ5klk8Y5UxRyZv9F7SpYcQS4/LaboN5F0dB8Cifbag+a2c5YsJNGwo9XV401j
 oNDVtBst3WL2EsAUjm2oX/oA+evA9YRmrPRlywGJbyc9E4yaVXIDWwHPNdj+5w5p1Jvj6aRh1Cb
 sR3Ny8Bzc5nwmfHd1MlTbcozi0Ufm5CIdmZ0LztY0g390znaOwvxJ6x8iPQhv9QMskHto/5NKam
 OEYDRxX/9x/jSiRidrfEAd9qKdopWsdPNjKwLmBbyFnCsiVEOJbYmiPEO+mXTD+rxySXymCTS3W
 rCLJXXvX3TtIwro36lKgkcGeKKeiIx72w7rLA=
X-Received: by 2002:a05:622a:8a0b:b0:50d:8c22:47f2 with SMTP id
 d75a77b69052e-50dd5bdb454mr85336951cf.44.1775919557166; 
 Sat, 11 Apr 2026 07:59:17 -0700 (PDT)
X-Received: by 2002:a05:622a:8a0b:b0:50d:8c22:47f2 with SMTP id
 d75a77b69052e-50dd5bdb454mr85336631cf.44.1775919556623; 
 Sat, 11 Apr 2026 07:59:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee12fesm1448241e87.40.2026.04.11.07.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 07:59:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 17:59:15 +0300
Subject: [PATCH v3] drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-adreno-fix-ubwc-v3-1-4983156f3f80@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMJh2mkC/4WNQQ7CIBBFr9KwlgYoBXXlPYwLoFOLsUWhRU3Tu
 wt1q3Ezycv8//6MAngLAe2LGXmINlg3JKg2BTKdGs6AbZMYMcIE4URi1XgYHG7tE0/6YbBQrBZ
 cUgKMotS6eUi/1Xg8fThM+gJmzJqc6GwYnX+tk5Hm3G97pJhirZkmO14TvZUHF0J5n9TVuL4v0
 0F5JLI/GpY0sm1lJRgXVQ1fNMuyvAHmcLM7DgEAAA==
X-Change-ID: 20260407-adreno-fix-ubwc-6a2564710e21
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kys2+nhf6Ed5y0sTw19sLDV+jvztfPs0R/fXNp6raQM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2mHChdpc2ZTtjwLHakNI5nxuTlXVhd8s17y1Q
 iiisyu6/wGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadphwgAKCRCLPIo+Aiko
 1XxlB/9SbltxguzGNBXkgiFsdlDDC6QEegF2crxUCwPsq+z8hKBz8QsLVNoiLsfl+odFIc998fH
 KNqR9iHctqylW7Fvqu4K9+yoPegTZvOpdn4xMDJwCNhUvTS/Ye3TtNWMqtWAYZTU3YCykmdG3eW
 ZS0JXU0MApA5zVnZUewCGb0YWPOniQgP3FZdD12rf166eJWt9HY0uLH69zCgHVte9z/BPjsa3Hj
 0j9OZIWoPyITef1DnHVN83eJrp/ZSYj4UMqJismGlPXdNWfFpEwO3Bm0rPFcBSA5bUzB742t8/a
 zlM3aMhF/qQj6OtZ6UHRA6QokKIV8HmCsJg3CZ/pNam1tWZS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 8RUPnjkWwqcfdOiIOGkghxvGBQOLG_hF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEyOSBTYWx0ZWRfX0a7OcDV4nkpM
 Lyb4kIMfZhOPfWeMHf4E7o/jkZ7OxjG4iDfIyjiJtlnFCNj9p9W6J68jIMKp6PjGRWudi9Kq7Dt
 xGCe7359ne4L8ivCrotw8LSmx7tko3AH9ZHhRSV6zZ/xFoPHgwBms9dz+2Ud325U6dOxUoqawSJ
 JJohxMuBtl3G+NqX8JF5nS/4TNISVKLYWmmDW/sHuoYXUgOevoYVvk6gWyCr4eLlozo0Q8YjxKx
 lHp47bB2zuhNG85xtlQSomrg2Rt+WurPnxOLyuytshfWCS5HNqk10bwX0RS+SVcYFakCigTc3ed
 Wm9RRTb2l8tGRFj1GdRpF0PxMfeE0fqo6PwIPNOQJYab8Loue+VtzxZ9rhnZAtNm9CGyjuYBI7k
 3xZBMiCru6XEgTSdnZKLyhppIKCn8KT3Al5huGWkjQmmBgz+4Rgb6HWC+kSajj8NTS0oKJJnQdw
 lDVWu/wUsAzhAUM6aRw==
X-Authority-Analysis: v=2.4 cv=FPQrAeos c=1 sm=1 tr=0 ts=69da61c6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=uq7AuM9elF0DF7tEa_4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 8RUPnjkWwqcfdOiIOGkghxvGBQOLG_hF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110129
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

Before a5xx Adreno driver will not try fetching UBWC params (because
those generations didn't support UBWC anyway), however it's still
possible to query UBWC-related params from the userspace, triggering
possible NULL pointer dereference. Check for UBWC config in
adreno_get_param() and return sane defaults if there is none.

Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config struct")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Switched to UERR (Rob)
- Link to v2: https://patch.msgid.link/20260407-adreno-fix-ubwc-v2-1-7ff73624635e@oss.qualcomm.com

Changes in v2:
- Changed adreno_get_param() return -ENOENT for affected params (Rob)
- Link to v1: https://patch.msgid.link/20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..02f60b33ea1d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -424,15 +424,21 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = vm->mm_range;
 		return 0;
 	case MSM_PARAM_HIGHEST_BANK_BIT:
+		if (!adreno_gpu->ubwc_config)
+			return UERR(ENOENT, drm, "no UBWC on this platform");
 		*value = adreno_gpu->ubwc_config->highest_bank_bit;
 		return 0;
 	case MSM_PARAM_RAYTRACING:
 		*value = adreno_gpu->has_ray_tracing;
 		return 0;
 	case MSM_PARAM_UBWC_SWIZZLE:
+		if (!adreno_gpu->ubwc_config)
+			return UERR(ENOENT, drm, "no UBWC on this platform");
 		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
+		if (!adreno_gpu->ubwc_config)
+			return UERR(ENOENT, drm, "no UBWC on this platform");
 		*value = adreno_gpu->ubwc_config->macrotile_mode;
 		return 0;
 	case MSM_PARAM_UCHE_TRAP_BASE:

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260407-adreno-fix-ubwc-6a2564710e21

Best regards,
--  
With best wishes
Dmitry

