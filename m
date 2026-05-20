Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC439CD5BAE
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE44F10F0CC;
	Wed, 20 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fmEo6olU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rq9v4vp1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFB910F0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6Ses118975
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6pPTtabF6OA9v/5Dtpi3YOgqhDzAT72mJRYat9rS4JA=; b=fmEo6olUMDysvtwI
 cCrt8wUhd+GQgkDWk7f6yAUEhUNoESb/anppSzypW9MVC1Z2w6WC9YkTTrhQvUl2
 wrEWtBck0x6xOY+unNEl3NEbvzTJyljSNI/WM1DzaPk47a+mvYOzsWB3F6YE1hxc
 7/TTGeq71YgZwoiciIH0CCDB9h12wv15j//S6CSZdLcZtvlZ01tnDDZpHKcGGUzZ
 8Ns7Bs6vzpDV3qOzo+nhdFOgkZepuOuwTNnXyqDMAFmp1GWr0QrJ/+dkU6rfua/K
 0d0sjvkZe+rAVGpVqdVLbuP6IMNNL91rfuGBspnbdjrFBgfyvzQf8zuV7+yVlpgs
 XZJzzw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886h3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:03 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95fc346e02dso9226277241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288722; x=1779893522;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6pPTtabF6OA9v/5Dtpi3YOgqhDzAT72mJRYat9rS4JA=;
 b=Rq9v4vp1iC0xiWOmltr7s2Nxbttz2qoeCrWa3vvIsHFQ6mAVhBuPLr733UcsSWKsZM
 AF5buX2Sbb2XN7TB9uTq8gaGADm029IjsCB4vJZSx9/EKsIhWt9qkhhAYHYt/RBtIJFK
 oxo0qpZHWm3h01sAzjr4xzvPQtCpd1hkagI69jYZQQ5VozIcwg83H9+COlISgHDgXKBJ
 k0KIXuP+hRSXCoBg+C56eStQb362Qwj7jTZ4vIM2cw9lQVFoP8bRAOmnJJgkE9DxW/+E
 oSjmUNuIwvJzOoZKX/AdZZXJyswxr0A+Ocau2Io6eSa7mIG0EWbDob3OQCDoQJ7Sl4zH
 8TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288722; x=1779893522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6pPTtabF6OA9v/5Dtpi3YOgqhDzAT72mJRYat9rS4JA=;
 b=XSzBFT/KJ7rxyzf1sGQgtRX4jf7f9lScdsS5oEfs+lQJIUkmdGYxsLBPm7YjptDzeC
 tgdnlhUjJW4/RVNxGfiH2lYsDy1BOB8C8tP01mvh5ODw1Pptoa8q1ie8/oJE+kfNC7p8
 pixH/t8V72tt40U8VxpjRVw5s97YwydOHCOohXmcmUX7cpGKptx08wG35OrwdXf6B87l
 JT8cqiVsRpzaZzISu3cuIrcaDUL1zWbhBVnkM2ObKCbSjLLErip/jvrUp+qrrxjFCtXY
 NEoM4M3qNoDoaYKFi8/oHUJuIqYAKy2GamXHPVn9h72vEp0yaxZmw3tsgh1MqQV8CURK
 HFtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cwkdtHg4+N1xyt7C+NZ0ybTjGI1AjudTl9iiD60c9P0JipLqxznlXAwFBr1BTPmbeR0ELAr0hUhE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygkSriqF0GVuKR2ENr0O5p54qc4hk13hKHBsqU1q+LsbH5G8NG
 01H1sIiqjNGLcX8HcOpvB7BdZ/Zk+ZDDpC9swJAnC2/mehtvgMtsbZMyC1cW2xn1pcEEvfr1wuq
 XfbfvSxNa/FehaSMp8THrS5AaHWm/HwIkIq1Q22xQKPyXmPLTOUuWjYNb20j2qntyiv3qEIQ=
X-Gm-Gg: Acq92OG1+P4CZUC1Jurh6Quu/lBIR49BtnYoYj53J1GJ126t/Pn4sC7fbyzerQfgnf6
 o+ZyaM9AwtBMsIMuLQfiEl0ee+s8HexmKLovyf/bDavVhevR+SxN/nExjeZ63UZDn4S8TE0BcJl
 To6AXRc9KDyoDXtpffWLEoTfBZGsKn2EMkRlIrN3xKMAqN8jRk+JFFwRuRTAQC/RSTmCboFu954
 gfZxodYQksuHrUsGEaMAm7AgvcRjSWqOeFNQ0iyhgVVBNivVUbXtBvDH7Pns0hvTWYTG2nlON2y
 L6B1HL9ElKAKJ6bFSjdh5WNM7y6jDs6Kio1iHaEouMYMB9J66u4gofatjUL23JRdjjptGUdY7fZ
 CPHoFTvAT26c1D8jzXoO7az3ImBDemg+rYfLqxMxUYnYGM8tpPKfieiRmjtOPvHmbLxYH82QszJ
 LL17+cf9bvfvpXpEw1KBOdJ8YkEjAkAiRxs5U=
X-Received: by 2002:a05:6102:808e:b0:631:4e9a:ba3 with SMTP id
 ada2fe7eead31-63a3f28c288mr14430976137.21.1779288722340; 
 Wed, 20 May 2026 07:52:02 -0700 (PDT)
X-Received: by 2002:a05:6102:808e:b0:631:4e9a:ba3 with SMTP id
 ada2fe7eead31-63a3f28c288mr14430935137.21.1779288721797; 
 Wed, 20 May 2026 07:52:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:52:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:31 +0300
Subject: [PATCH v5 24/28] soc: qcom: ubwc: drop ubwc_bank_spread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-24-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5607;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ELfSfo30Xq2szDKMHs49lszh5EmDwoOzMcxayrSn7iI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpp4I7RvK2HILsybRcgfmEkL+/9WfJirTkYA
 jDZw6s3r+WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaQAKCRCLPIo+Aiko
 1ZJtB/4lsnTD7zdhZblkKl3eH/4SO3fLhhOuwa4VE2DtFikTLo1feLEogub0Xnbt7lFGtEF2rnU
 ykylJ7mH7bAfx+pxxBKKLKZNUUtlOcALJUQNoxjBl0vVv9eBn7z5opObMqTIxHwpV1o+7FS24+E
 FXiZJbcNJecaCNnQ0Gx0za3x4RqGSrJHHTkPCyJ4ScJdGthN+hU4nNiqZjuDF1NuIM8Ugyvlx4J
 UcCdw6sBFejsMj9X6fsPTrCfaBc4aXE7tgPEDngnGeTPX3AVuak3VcXQlro2twryZVLFxwPNXZY
 ed1JltJJfETWGoRF97wvd0bg15A0pKvuBdE/Y/BJNao25Mbo
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: g33wznWHsMyfkxFDL3BmmFkqupFHFxVD
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca93 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VGmcmSc_WkMUHOMtpCQA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX02wTO4EN2l62
 n6jqD1u8EM4LheFnGc7PjFqbhMH8RrOiATEKA47T3fcxoLnoDxAzn7bh9DoREb9bJVzCbDhpaQQ
 4kAVeUSRAHAuiKyks3qT19wM3FS6KouGSna/7YSGQLp0p0P3OLQ+WMrOLldoa/RPFL8JikEPXA6
 bQHq8Ehj0fJF1olJE2+9zf1/Q+YcX/hE7co3iWyEcmTsMLrE3dRlOOr9gdSD3M4v4Scf1pHFdGr
 GmFi+o9x1fHFVPrqMAaK8yC6C+uT7szailGiKGcPsP1K5aygn1jibu5aXItJlJOLppFw2iQVpZz
 Ay35xBel8kW1pyPOrhtVmp5pKHDJIVpTszsop3Uefb7zccxu4l0V8mat2LJnhM04HZMwAC57BS1
 MM1QzwLQNtnbGCLgR+Ds+Bo78Bn1ywzWZ5nB1f5yaPAo1EopoMhsnrQXf1edlDjHFPJPqUPn02j
 wJvCEIcCyuiobqWnkGw==
X-Proofpoint-GUID: g33wznWHsMyfkxFDL3BmmFkqupFHFxVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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

According to the documentation, UBWC bank spreading should be enabled
for all targets. It's just not all targets have separate bit to control
it. Drop the bit from the database and make the helper always return
true. If we need to change it later, the helper can be adjusted
according to the programming guides.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 14 --------------
 include/linux/soc/qcom/ubwc.h  |  3 +--
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1344cda0fb75..35cde4e9a238 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -20,7 +20,6 @@ static const struct qcom_ubwc_cfg_data eliza_data = {
 	.ubwc_enc_version = UBWC_5_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
 	.highest_bank_bit = 15,
 	.macrotile_mode = true,
@@ -30,7 +29,6 @@ static const struct qcom_ubwc_cfg_data kaanapali_data = {
 	.ubwc_enc_version = UBWC_6_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 };
@@ -59,7 +57,6 @@ static const struct qcom_ubwc_cfg_data qcm2290_data = {
 static const struct qcom_ubwc_cfg_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 13,
 	.macrotile_mode = true,
 };
@@ -68,7 +65,6 @@ static const struct qcom_ubwc_cfg_data sar2130p_data = {
 	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 13,
 	.macrotile_mode = true,
 };
@@ -77,7 +73,6 @@ static const struct qcom_ubwc_cfg_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 };
 
@@ -85,7 +80,6 @@ static const struct qcom_ubwc_cfg_data sc7280_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 	.macrotile_mode = true,
 };
@@ -102,7 +96,6 @@ static const struct qcom_ubwc_cfg_data sc8280xp_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 };
@@ -126,7 +119,6 @@ static const struct qcom_ubwc_cfg_data sm6115_data = {
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
 			UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 };
 
@@ -149,7 +141,6 @@ static const struct qcom_ubwc_cfg_data sm6350_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 };
 
@@ -171,7 +162,6 @@ static const struct qcom_ubwc_cfg_data sm8250_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
@@ -181,7 +171,6 @@ static const struct qcom_ubwc_cfg_data sm8350_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
@@ -191,7 +180,6 @@ static const struct qcom_ubwc_cfg_data sm8550_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
-	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
@@ -200,7 +188,6 @@ static const struct qcom_ubwc_cfg_data sm8550_data = {
 static const struct qcom_ubwc_cfg_data sm8750_data = {
 	.ubwc_enc_version = UBWC_5_0,
 	.ubwc_swizzle = 6,
-	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
@@ -209,7 +196,6 @@ static const struct qcom_ubwc_cfg_data sm8750_data = {
 static const struct qcom_ubwc_cfg_data glymur_data = {
 	.ubwc_enc_version = UBWC_5_0,
 	.ubwc_swizzle = 0,
-	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index c3f9efae5db8..254721f5ea3c 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -33,7 +33,6 @@ struct qcom_ubwc_cfg_data {
 	 * DDR bank.  This should ideally use DRAM type detection.
 	 */
 	int highest_bank_bit;
-	bool ubwc_bank_spread;
 
 	/**
 	 * @macrotile_mode: Macrotile Mode
@@ -85,7 +84,7 @@ static inline bool qcom_ubwc_macrotile_mode(const struct qcom_ubwc_cfg_data *cfg
 
 static inline bool qcom_ubwc_bank_spread(const struct qcom_ubwc_cfg_data *cfg)
 {
-	return cfg->ubwc_bank_spread;
+	return true;
 }
 
 static inline u32 qcom_ubwc_swizzle(const struct qcom_ubwc_cfg_data *cfg)

-- 
2.47.3

