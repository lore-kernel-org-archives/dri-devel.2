Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D2BCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E2010F10C;
	Thu,  7 May 2026 13:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGp8fkXr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kNJ0CxW3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5359410F10A
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:32 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647C5WXd1971630
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VjEGhwhCmeNmMAb5JNSZqAnfeaakx8wynUdLZKg6xFk=; b=DGp8fkXrCuYypnaj
 AcDMa+a/vTMndheBd9DPirsrEHiVjkgp0VWHUR1daixP5IEPAI1R3DXJGb6egjfT
 schPSuiOzOhUEU8wdd3dt10IEoyVwMGeuxAYt2mNlvcdkCQBs0qrlEt+N0/Q897E
 wZK+XNRb9yX8u129pekGE8Jq0oaVnsiz37OIfTWgihAhn2Pyfr0NiiEhyfbyN2v8
 eAEqfvfgZP2rMSkE/yKqZ/rRrC0yRFIL57snQJVtGb+FKbBShvS6pajn9LZsu7kG
 K//E4jhv0mqAwlgBBj4y5mLyNYUZBQJV3N/siDd7nDcKgSK1xdq5/HCT6r4oSZyO
 C5zm7Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej86bq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b79f4b35b7so8667035ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159011; x=1778763811;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VjEGhwhCmeNmMAb5JNSZqAnfeaakx8wynUdLZKg6xFk=;
 b=kNJ0CxW3ri9IcE+maWFC6wt3LMrSlS8AbJ7cXtvGinIdmYgQLaHoIvg1OYUu1435aI
 THRxcOF2HxDgqOmpdCwqgPSz8jE2ZjZ2bWLEOjG822txbUMAhfPvW6Egs1zGNSpxTqsf
 nI2w5VVl9gGoBUM9LQI9fwoXlg+JCfesjZbc1gbiTXiOQyV+YB32mLjKposHO3mO3mBr
 Wt9hBXEOnoF+8e4pW//QkUIiP7uKPpP2bW6dco8Cw1Kz70MV5pv5GPBgaHiu/6zb57h2
 zdoKMjaN1R6zoDT8eT+1Lg9KxEqLHyZ6m0i8TxTfybeO8ckGFP+5m+qFX2HP17pEvCoh
 CxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159011; x=1778763811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VjEGhwhCmeNmMAb5JNSZqAnfeaakx8wynUdLZKg6xFk=;
 b=C6LKVj+hhXG6W+WRfSKZ9eys+8IZkqA0iJKubA1LkkJBvAAgAPOgL9Gx0aj1vBV3Wi
 6AuGLDxh6OQA5BuOvj+0MmtLEw+lYoEdamSk8I6UgrnqmO089LLtU0i17Q2pyrGuxD+P
 qscT191xISg9xRhgAUUksgNriW+4/ogWqI03/57IQz/X7re+X5OtOZ9hOQuZZKE2TiFW
 H+pAfJNfBTKu1v9r53SDKmYEzY4VK8XU23WwipN0r8zT3dYXti0J+v4TgEC2E5KeWUmX
 8NjP2i1CYejMkZ9u8IT7N73AD5Km5wBmQg3SBOP/QMiomjDj9ZC3x/YPwDzCOQlEZLzG
 iIYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+f8yNqu6I/hkBhg+QmH/prC19hEWmxIkJtCzFg7rNjlRQgeyxj3i7ChWNqtEgfme2sDxySQHu0QXY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDzMEQc3aWv1NDgy3P6WJg+wnJxGSkV3tDUyzWB4HyAaFFLbmW
 VHBZhjIOdpwT3bUmjDP3AkJNkzgWU5CXi1O38D1roW540j3BVWj+d2Fa5/2fwgL9kEnZhkOAKhd
 bKrRoBEaEpjX2Tik4KdS06SS6IlnFYgnwmDEZcBx4Qnfj04lNIeqWcvV2XYFLujvxl1F0FVY=
X-Gm-Gg: AeBDiet0NObcJAQT99Qaz1pl20NkIfx69lIaMDcl92jYRPAjsP1uukwnjPP6c4QhtpW
 9e3mYnLH8zz40J4/P/BrzbhTXPCm0xiijc+2fuiv0UYznnDt7QInr9o3gdAWHnru6viGJVxMTth
 koKyUS4etbnPZre9DFqtSbLxGK7NPxqllIT6WuEtmfJi3cc2DcO4bdcn5uYC42Oo4k2kuPJIDCe
 B5luRy5bvShBfaiM0rHyz6eo/yO4r0xwLlJmppiFXEwh9cagwlrqgPNu4Zh7lp4+4pKxfF6eDZp
 ne/S2rEykVQtFllYcGY4ZSjbzLBR3mqo2W31BjIupQ90y6tD7gbjMJ/z8eDiKfyGUYRN4IvtHq/
 U2GXxa+hDbhwcbYZSTXLtAMLDiwkwN3tbQ/NdviGy4iFA5Iw/sGG2XWMI1LryjcOZEK+aNhNHc1
 1m+m8SNojC3vBM85oOhYPQDaX0bHq1DwKsb8krD20h7xW1rA==
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2ba79285966mr77063575ad.5.1778159011003; 
 Thu, 07 May 2026 06:03:31 -0700 (PDT)
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2ba79285966mr77062925ad.5.1778159010398; 
 Thu, 07 May 2026 06:03:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:04 +0300
Subject: [PATCH v4 08/29] drm/msm/adreno: use new helper to set min_acc length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-8-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=u8w5QRXYz08nzTFeeOvvUABZylvk58f+hXEv/T/Xk9c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2F0+NpfaspL8pZUBBp+X6pZBEUAoZt0Z8/F
 qWGy5aY9D+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhQAKCRCLPIo+Aiko
 1WBOB/0e0Rj4/4LpRbW1tMBmidfdTUOmpst7orERKAS5oMvMZ6Fzgf20IHn0/f2Ro47Kh54EGTC
 ToSD6h+9tJz1o8bbiAGX9uGhQs1d8IOpn+YYHKLVjHkmPVo5vuvV604vhULn6eNMhE8Bh7ITHda
 6CuRLQgPOQXqtzTPXenTT4KbEodTsnrugbZEIXWxkscSLB5uTrkMYZdnxvIU5HEHyVVEWenxAIc
 91qEZhqIWIOgFJxv9t/QT6fjG4xV3frBQV53+di8HYj2bYmypovZz+UZEKhtqH2kfrelFJc0HgH
 IjfpJvlsvdAXo8wOwXH5teP+yyn9U9wrtHk7yH836EBY2VES
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX0KEGrL4ZXJfd
 mBlweFJxg5QT6p2PPMcc5cPQG9ToDBlNAt2IotFEviGE6WeDzNPIMv3BAw9xlWiLy+nXEYRrj9d
 RD/1xH+IPDUnQ0xCpIP7YyzegGmU47LyHOceOTJk1rItMvSat1aJ3ClatlDbGfZV5IuhRu0QqiV
 r/lQO7bFmi2YYsJrH9hdfUmyKx/ah4pIYyNBCDaciw3sN8ky0lho3BsViVrjgDk0VqhidDFKD3v
 tj8N//24GXOPxem8kjMetGUaZco8XwQ1770ueoX0j5UnimNlBDzQQl1wGtVJTIgW2xJLGandpw6
 NqP9UvhTMnPbU24cvfvh/xLsVok1UeKtras3Krr4fj92dP0jCKSuyGcQJRFTVJY0GEFbANP1N05
 ZU35gjYACHADth3kIK2bkI6lxmeraC3zdP8QuVGapkDfkl6H1HfBt9sE4FBFPNieFwk8ay/L8TP
 I6W1KqlRjPNtioZaxzQ==
X-Proofpoint-GUID: Dj4FWNZr4TO6UsTXEeYms3qx3KPqkirr
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fc8da3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=X-e67srwgh_QgMMAbO4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Dj4FWNZr4TO6UsTXEeYms3qx3KPqkirr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Use freshly defined helper instead of hardcoding the checks in the
driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1d998636c5a3..812bb95e8011 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -748,7 +748,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
-	bool min_acc_len_64b = false;
+	bool min_acc_len_64b;
 	u8 uavflagprd_inv = 0;
 	u32 hbb_hi = hbb >> 2;
 	u32 hbb_lo = hbb & 3;
@@ -756,8 +756,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	if (adreno_is_a650_family(adreno_gpu) || adreno_is_a7xx(adreno_gpu))
 		uavflagprd_inv = 2;
 
-	if (adreno_is_a610(adreno_gpu) || adreno_is_a702(adreno_gpu))
-		min_acc_len_64b = true;
+	min_acc_len_64b = qcom_ubwc_min_acc_length_64b(cfg);
 
 	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
 		  level2_swizzling_dis << 12 |

-- 
2.47.3

