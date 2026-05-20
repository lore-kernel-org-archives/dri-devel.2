Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B9ACD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A2110F0C1;
	Wed, 20 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJz1z26r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P//IIL4y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217E010F0BF
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDXcrL1798088
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K4BBNxAe0Vo4ZyzoRvicUmzhc+J3e3nthdb1jV77IEw=; b=HJz1z26r0pEKobRh
 N5ZVpUabHoZ48+25h6+5EMBOAaB9UVxgU7l6/gozTd8Hw65fn4iX21+tWIz22xsm
 i/tqZ4yoaVgRfVCPQLaLsjXxvc8D9VCsDMmM5Ngk85K8/NgGgox6jXB+7big1CRt
 TDo4cGOAMzsTc+RGQAVwPbaCO/sjHthh6Bj3sZB9Jl4rHjTuf20DkMoVpXiykRF1
 Ame4yb2et7bApPZVLQ/JIkxgl1T84QW4995QRgp1tEUNEa0aKU9OjoSpuBB/1CFL
 sDEr6dHQ9tml2LlzZGgKPfZ46rs6pnNJqdpH7C7qHFxdckRsrhbd+OEKClAeOmlD
 djriYA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu0a24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-63144b84f14so8020434137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288713; x=1779893513;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K4BBNxAe0Vo4ZyzoRvicUmzhc+J3e3nthdb1jV77IEw=;
 b=P//IIL4yKjtb+xDuFfT24IHSvXMG/bHkJtgR91KQE+B1PPy4NMlrJApBKibOUm95GH
 Sfni3cJABTO03p8SUO2Jjxqv74/KdbzVTrtRsWHEeF99atPEzPs9tbETAeQjut+HXieM
 WdGq94hcw+MdpeZoKUjI4qBb5u2VzT7Gj6pQwKiIZUA8s/qkMdLDQ3rYYoDwBcHqHP7o
 Xa54F7tEhX97HvEtQ8vLjey0Qg/lwFLALcGc57RSwSH4K35vJZpi8j5WE6tHJizZfeLq
 UyKq8fKyBF7QK5TEi8flpyJze4PGFYYgqVYEjXu8RA27dMBpSZrZN9AdNJmMpmF39dlG
 TbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288713; x=1779893513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K4BBNxAe0Vo4ZyzoRvicUmzhc+J3e3nthdb1jV77IEw=;
 b=VsqFXwOSP8yHFyVYrqVyFGsXhsssgUWs/lpfl0O0pXy5z1H7fhiNJnFwnmszsakMfv
 +UfvyptcBb2t3nvxwIwUJ/4qreThazuciMOczCzWMPG+T3muS5qgNQHTH9VOt+Otx6Po
 G6XN7k5RKiLgMvRSW9k0Is3ggu6UjjUrq4rkNZ/RPcEAbiGBBamuCA/j29OeBN5oYAYG
 rDgtungWqWBZJ3o+7QXEQLoOF1np+B6OG1HSx3UmsHAxgPRC5piz1Bq7p4SUFkT5ZLax
 VPBeHw25t1XC6hmTIOJ6DCEETGvoFO4Je94zR1KZ8pUEcJKkP7q8575FXFRLr5TkhC42
 8s7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4Bi27LLli/NVaj6AFHIAFUNksxATD8J6Zmu1GVl+9yKH6mffwIJFLG2GNY2Dz2YRNEBmRqVmG3qc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2PdQscBoKL4/mkHi0vNutI6fSN0evmQ+jBYWVd0N685IsBHpg
 d34GWET8fNVrQlHAObcoEpGtQvios6kBuaZy54puOdkLf1rNwwrHt5GwxooXHOZmYY1xKa9PqAu
 w+VH2YsiaBBsdWg6P0+M4JgSwxSAurRtft8gPY2/O32jvlUJMcw8hzR4rJ80Z8PwygoYHJqY=
X-Gm-Gg: Acq92OFvgduUB2L9YE+BAXqMxS/nFEVbcD2J3fdxAgk0V6p1ZssIIu3qVKFvj6gtP72
 hMs8PKAFItcDRZmbaFf59kFsMLUvNot37OOF0vi0ex4wboZe+q6FlF1m32t1Uhg2xRMe45YcSDZ
 pphFFa/mnqSs8hG3lLALv/UudFXl6c0z0H+kvKhlpTSR/+zje9wHdpZ1OM/wYE3vE1oOX9EpL9H
 +c91TZht/5uoXGtxxaQwB7axxTUsA0UOHTqAjI1xEEtpjokAcj4yTBWg33Z8k0lmrmB4gGofgxy
 c72/h2GNpn6BhonBA+N3D5WX3BMB+JMqUAjTjHVJRLIRXsZ3qYIw3OE217NnkCu5Kio6F7foUfc
 fvVi2wmwAXK7q2P12JTmW/tZN6qZjjLQVsQDDEOOXV2RMlib47Shqhmdubgs04x5lZrSCdZEocI
 d5E4QEK0KB2avME/lELK8gidadwOp/bfpUiR0=
X-Received: by 2002:a05:6102:4412:b0:634:eb91:695 with SMTP id
 ada2fe7eead31-63a3c801a1cmr14222505137.5.1779288712115; 
 Wed, 20 May 2026 07:51:52 -0700 (PDT)
X-Received: by 2002:a05:6102:4412:b0:634:eb91:695 with SMTP id
 ada2fe7eead31-63a3c801a1cmr14222459137.5.1779288710884; 
 Wed, 20 May 2026 07:51:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:24 +0300
Subject: [PATCH v5 17/28] drm/msm/adreno: use new helper to set amsbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-17-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BW3z4eXt9jEN8c9nQYgd/mUMJSPQ6cxnVEJl20A8eKk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpoKycU3HSHYK4pK2svQbS8VRsMJsLilPiVC
 l+gehuZI42JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaAAKCRCLPIo+Aiko
 1TPXB/4qS1tYjmNE0CLTAsPA24fES3n1dsid+JsBkf59+1D8nFIf+TrtzJP3DGCZKKTdHRlEMVH
 z6+AbIzKQ5cpst9ruJXHEw5yIPt5DYNdBVPJo8B3MYrc/IWjLLq+DQ9hU1HRrO5m55oh4PPLgJb
 gV9uvkLW/hqlVx6gVlriH1c8OV3XbbbBf9joz9+um+Lxk0LsB1I5aYEmjSft/bztemww/d98l0s
 rOETkwmvZqBa1ebqBovryUIMYYSGiJiEI7Uvmw9tUvs1tP1zT28sZJTuKgNfDzXqKSkbQoX3da4
 TvAMgb+eOChd6NpKJr+8rB3QzNquVVlKLN3icZGOKXathLxT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXzcplTEyC42ew
 vj5BEBc7e+GSORn5sqHQU0QE84rJ4MC87GXdfngpL/Y3XzY4FpaXIaRQHP+Exd8MqP8PEcFDynr
 0mcufKe3AU/HBr3EG1mPB0WktzRv6PpozEKUBPJymU5jpL8ProTBowtaeWoPijAiAl/Fd2ZCTsZ
 xl2aVD0p5bclqTO0S0J/E0Gr2dtdLcL1FL53T/ccpWaB9kd5e2C9Jkd6+vUOyL4X0OtDjqeVcpy
 agD7JEO+Bt7uEiJIz3kL7x05+5Fc+Gxmg4LL7dQ+ovrUpwWRUTN9xhHEa/dBzRLpfcbrzVeaZzF
 i2K/E01RAnCwkDaNH9cbp6gI0Y/9kLhD5Bv3ikUCMd1Whr0I1NhrK+gZEuCdigCm4mOyOAUQDaM
 2K13uNfFJUb7W+/pB1Q9aWsuVfkt4mcUDkcHoKEMEqprtMBFWj7HQvOc2eHhgG+HbpClPeNezjh
 NoNt4aR/dNVrLmEPp0g==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0dca89 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ZxXxw7YCAI2S9HbMwnMA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: RNqgDS6Jvm0gnrxq9YJczxBUfcOn79MO
X-Proofpoint-ORIG-GUID: RNqgDS6Jvm0gnrxq9YJczxBUfcOn79MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

Use freshly defined helper instead of checking the UBWC version
directly.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e7a0d315e022..1c5ad3e83cc2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -747,7 +747,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
 	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
-	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
+	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
 	bool min_acc_len_64b;
 	u8 uavflagprd_inv = 0;
 	u32 hbb_hi = hbb >> 2;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 867c7d05f670..5c73a9ebb22b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -279,7 +279,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 level3_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL3);
 	bool rgba8888_lossless = false, fp16compoptdis = false;
 	bool yuvnotcomptofc = false, min_acc_len_64b = false;
-	bool rgb565_predicator = false, amsbc = false;
+	bool rgb565_predicator = false;
+	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	u32 ubwc_version = cfg->ubwc_enc_version;
 	u32 hbb, hbb_hi, hbb_lo, mode;
@@ -288,21 +289,17 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	switch (ubwc_version) {
 	case UBWC_6_0:
 		yuvnotcomptofc = true;
-		amsbc = true;
 		rgb565_predicator = true;
 		break;
 	case UBWC_5_0:
-		amsbc = true;
 		rgb565_predicator = true;
 		break;
 	case UBWC_4_0:
-		amsbc = true;
 		rgb565_predicator = true;
 		fp16compoptdis = true;
 		rgba8888_lossless = true;
 		break;
 	case UBWC_3_0:
-		amsbc = true;
 		fp16compoptdis = true;
 		break;
 	default:

-- 
2.47.3

