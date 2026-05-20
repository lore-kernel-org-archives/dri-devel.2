Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A877CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699E210E43E;
	Wed, 20 May 2026 14:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2vaaCjk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aD1L5ten";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BCD10F0A8
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oMfp1177857
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KrGdZ6Bna8qkROGke7rL/1evORye3ZzPkLd+P26j6Fs=; b=P2vaaCjkU1BUJZWl
 XIZQhkEQSn5+slMBBq0wvj0JXwI5ALlArUA/q/Kvzk38Q7z0Fa8wsHaFrtMZJKVI
 nYWJf2PRBZZJ49SiTKXi+J1Rq6ohbWIWhEXDV70skg/xO1gv/Za8EORVhK/erNDd
 KykoCbbGwX2oYNJYNzFIsh9jrlTGug9BsTX4tYc+b17x7koLG1qf0+VVGZYmGaLN
 Ac3PW33z/S7J8pdTLAY1ni1l/GzU58/FsgTQnMPqJTPujxpOsN4COjZmUV2LvByF
 8NTI4GDbEes3D3kBvABVlwugiKgaQeaWlx1WgDIk9rawf3rdHUGIeKhVpTv4vKRr
 XKR80Q==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6s3j0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:35 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63271d633b5so3342697137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288694; x=1779893494;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KrGdZ6Bna8qkROGke7rL/1evORye3ZzPkLd+P26j6Fs=;
 b=aD1L5ten8m1d5zvAX1n3YIjCQCVDGt52GGciHp+qUeMD3dI6f78u6lPqoQtZ1lW9Dz
 JYw5TW5PDDpWq6ArM0qpH+L27o6GPvx1PKMYhTAx+85k65WSdnkrONgH37+4+TMoDTed
 +LLlUnx4DpC8aXuv1zXG1sBimXklw/usGRHGY82oMvYoqwrRBSd41RDOjF/x9QryLIjF
 hy23v6333XJl1DpEbQC9ctqE7515igsLjT9+A0hw5T/L1fZx5Zo0ujhRKHBOc3xfP/Mb
 ITBOGN+iY6yKdrAylqNTqnd+ZhH5i8WsCZuFKlIh2gQzDOj+xkUQKj+Dn70iN4uMYzSj
 IZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288694; x=1779893494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KrGdZ6Bna8qkROGke7rL/1evORye3ZzPkLd+P26j6Fs=;
 b=SzYpGfrNrLrgjllOseNR+1yipJ9zkqLtQWUbQp/FiJWDc/jYukcWI/QmjBr5r4j6uU
 qK6Db92rsC9dNyN0OH69wdv3kF0A4Rnl5C7xS0l+LkFs0uxbsbixlMi3lx6surVSEN9E
 1DiQ/nEfPelxbea/Yxao0vT0fLOTULsh3jphYQz7b0VQXlB6TwDw70Qp/Ex9+Ek3cDEX
 pKRprYYBkx0TLTkIP2RlUOFUFDn86VEBAvV2FLEsp2VksPMR79hsPj78ugR4gI+BKcTh
 xNPqOVF/y/trsedWWP2pHzS+TRRep3xhIOwfNePVZxzKm9dlWQ6PzHC7ZOTvS1SHjLBH
 bDDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BseJgNW/9LIwz9vVjBe31OOkkijyOI/pj8U55YXohfl1ihaExumRXy5PtYNawa2EbBy2SfQRroWI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0tM7WxVpSZoGuqbnwsc0J0+tJL8Fe4CPzpbideZYMJZThfbUx
 heuznjBvxqNOzDFgnkwDZzH84ExjYT7whULGbd00mGOYNFlr1YZd+rG56hf9SbwNw4b0hykcKJQ
 NgBByhw3/6OAKyNvUm5QTa8z/GOOCPvZ3IG1WaIWqj5+ST9WfnzxRMX6wX4i8QqLIlUEgydY=
X-Gm-Gg: Acq92OHiVOPUhuat87Fuzj8z1Kp5OidR9z6Ph0tL5u9mKaWeZ6/vdfyHFNrKH65uBUf
 /6GSEc2JHrjJgm1k0zGzqkh4QmdlQByLTi84NRuReFAki77RBC1Zum43RiIsZD7LO70H+YGzNS1
 HGpwovnAljGV4plCH58MAux7bua/ANzT0urXxD0pPvXi6IZaLZQkhBZSZ7t5SsW6g4dENPTPewB
 32BBNr71+QwAVGnZPwkJI3S28OFKppo69YJme2NifIH2Pk2B27enQkbhkpvjVj6/r57uUIiq4+Y
 kB28O6t0D5ZNR9Zc1hRtdHFUfuOpIm1A6aAzoWIyIaBZyV/eJC+zEA+XrHCFGEh1IfFlinfOYtq
 jnGbwV3szD7oTrAea1y1MHgKYXFsHDRxTIGBXrmlDKtX65vTlelWNMIxso5rNZsCgpYTndjIpNn
 IKo5O1FL+v92z1aJpxt8hLjM6Nv2M8oe3FlnY=
X-Received: by 2002:a05:6102:1492:b0:631:d3e4:efc4 with SMTP id
 ada2fe7eead31-63a3d951d5dmr11748433137.11.1779288694405; 
 Wed, 20 May 2026 07:51:34 -0700 (PDT)
X-Received: by 2002:a05:6102:1492:b0:631:d3e4:efc4 with SMTP id
 ada2fe7eead31-63a3d951d5dmr11748397137.11.1779288693853; 
 Wed, 20 May 2026 07:51:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:13 +0300
Subject: [PATCH v5 06/28] drm/msm/mdss: use qcom_ubwc_version_tag() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-6-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pQcZSLClq75f0H7mdOxTbEo5DpGKFB3n0GBshQz7Fb8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpmxwfkqlssMuazJ+ZnFSAY5SwQV8SGP2rxc
 OLxiVEELr+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZgAKCRCLPIo+Aiko
 1RtVB/9jLWGlQhSV8Z4vXHYlDNi3b4AohzUIwBfvDF2UuVqGjP4wAJvNTIxAO9+Xx7ShPDskRfP
 sGxAF9JqvTllksEWZJ3RL+Cs6pxtBLUcmcXxbXOtsms57sH+L3yvTc4oLpuwXXQ6yhlkxiAySPr
 mEHrqxmxcVVjYTBa5hScgIiCtucXxp+GDJb+H0TUb+dUESvyz+K3R+iuuZq3WzIntwSeOB1+7AH
 rXYQGPTt8RDQ7qcRcnbzoulM7w1u5olKt011cNdiRidfk2nHCQWfeYpI78zZAF0lsRBzzKguljz
 vgM1ZqhZXnlBoKr8g3a0u8NaxmvhQbeopvlPxFXJbGXA3eHU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 1wpP671pHsHe_qlhu-fTvGoMo2CQYMHF
X-Proofpoint-ORIG-GUID: 1wpP671pHsHe_qlhu-fTvGoMo2CQYMHF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NCBTYWx0ZWRfXwO1/VEGFeJd2
 Vo8GMcvotcyIJfrAc4lRz6kcwjTG65mkjbh9oiYA082oRlowK/XZmPWn1tzHuS4x728PNG/efS3
 KGrLTQAaj/mucVvz0Mu+xOsh//P1efboPIKESaCKur6xBYK4GKhWROOzf86aT7fJDYtGekWMzKo
 OEULYDDnJeBlijL6S3Wy7sxhG0kCz/f27uRXA40gTbn6hL6MKd9nb1hfNmo+O2YBxCpxPbjZVVx
 5wN2Q3K4LwYBlKARYOfE7YzdiaYNY6hqSpdD7K+JJ+xxicNVltzBJki1agwvU1ONkBgWt+pGfnd
 P7NPWEY2U8l+tXUIW+Jpl3oSUYS6ytK62thj3g1qN8l0gfOtBJrKsYYOMGUs6F5ne6FYQ1RM5zv
 34/jMoCKwh3Gnf381EkwR05ykDOLG4SAWWqfyTOCkQs171rN9iIyOv2SoqxA0aLc4My6kFzmOb0
 X11ywsBoacFZpSxw3jA==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dca77 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=qBJULKV797PGQuHHbA8A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200144
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

Use new helper defined to program UBWC version to the hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 4a6acd468bc8..229b47415f29 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -201,7 +201,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
-	u32 ver, prediction_mode;
+	u32 prediction_mode;
 
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
@@ -219,20 +219,8 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	else
 		prediction_mode = 1;
 
-	if (data->ubwc_enc_version >= UBWC_6_0)
-		ver = 5;
-	else if (data->ubwc_enc_version >= UBWC_5_0)
-		ver = 4;
-	else if (data->ubwc_enc_version >= UBWC_4_3)
-		ver = 3;
-	else if (data->ubwc_enc_version >= UBWC_4_0)
-		ver = 2;
-	else if (data->ubwc_enc_version >= UBWC_3_0)
-		ver = 1;
-	else /* UBWC 1.0 and 2.0 */
-		ver = 0;
-
-	writel_relaxed(ver, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
+	writel_relaxed(qcom_ubwc_version_tag(data),
+		       msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
 	writel_relaxed(prediction_mode, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
 }
 

-- 
2.47.3

