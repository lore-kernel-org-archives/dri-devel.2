Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E8BCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48BE10F0D3;
	Wed, 20 May 2026 14:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeWI98GI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6rbG0kB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5D310F0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE2LFC826536
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VGf89U6GYhkUCRMDjtnMSMgOlYsB5OBRKvGiOBHGpas=; b=eeWI98GIgwnCxGvY
 I6JQkkEoPMLkCWm/7UShBuPtK36ii08I+qJl8UzNJGl96RW/R3usc4pZ88MMcSp3
 9j02mJKN6BhWU5ERZ3qGNSuM2vLW45TXZa/qm2FB9fDLGA8g0TFedb4tMDM+w8C2
 2DqWANcAVc7SOSty46Amuvr9r3no58Pugkvuwbg7cDmRL+7DApdGlfczjl/5N5DS
 MAsPczOw8Qu1kXDVF9Rj+NUOoWV7ZKj9HHTiIe4zUc+wQPRxLbllrj2rKzCTyHVi
 Pv71bRXHyCkpx0yUuCX9MSESFSaWniDz3Ze9fi5XJHOhKkEvt7M7IYG87XBCyYDg
 VswmYQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ecag6hc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:02 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-63136c0b6fbso8651918137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288721; x=1779893521;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGf89U6GYhkUCRMDjtnMSMgOlYsB5OBRKvGiOBHGpas=;
 b=N6rbG0kBzjyHITPyO6N+Q5gmF7BcZO5CX4oZxUXNr3N+U4aciNBf1lc64HduN2RGwv
 tGzB97DH5uFJbStYi2G6dZeHHnMAFny4hPD+W5oHUZG/CalEw8r1n2xvtxuWVT+fW1yE
 kI66Q2g4EOAICq6jKf5FgMv6bVMmSEjUvj7wpVl314Hnk2xudddZ1RKACbbU4SYeIp3g
 8zmQ0go4nYISaR2iqxg+tNfNcPSReq/iG6FGiAp/nyXYwSs7anaEBPjqf6JRHhPf9jo3
 xG+OdI8D1p2k7IXMlEEG50YdFJ+3K1U9pqgadzUOJYlWVVB+iZF8llKxgUHahrc+kBxW
 603Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288721; x=1779893521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VGf89U6GYhkUCRMDjtnMSMgOlYsB5OBRKvGiOBHGpas=;
 b=LKMT3g2lv8Hii0+iWEulabhFhhqfrqO9IWxb50IQsWPvtGlcGGQEqswBD/mO42wKeS
 ZB0P6Z1G/Gu7WknPzMszi35XVGKWJ0sY4sYGjPb5TSA9V5xWWJE/OEvxGObvWgWP3d3I
 DV4lbd5UgR18IbLN2sqOdkRDGnsnEm99eLAuo3AkuDKCIzjBk9paIKAbW5HDrUVHwFQr
 qSdFW0RrokoMf05qlQFHTgHlQZG0JPKoz32wSEyCHQeV7AERBc2IYiEyX3LYCgdAqT8V
 oRVredFtGp4HwWaFGaQrEdjkLXSKUfhnojB6kdhfHxgHrjY+CXJ4YPI0ONncWget7XPO
 8EPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+mVaakEfgjATUV/Z8mE4XjzxJoiZtuk8qk6tsXN6zdIGsvIfhqTM/CCHQRi9nO5dSnESgC7QJzN4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywn7Q5Jt6KCzNKRPobzLUU/I+NKWzpDdG+DLN9p4r/p3rU0Zwav
 nTiAhJNARbqbV2/70Xh9J0dX7i7UleIVFTbQLsR5/1ADAGJCruFwtEuMsw2rKzp4Zwx0TzBr1j3
 m6XLPxjnPZ7u4GETgWvp3hjBiF83H9zQ3/GXxzImMal3pJmfCj4A395JIzIeBq3omlOITtds=
X-Gm-Gg: Acq92OHQYOLVgv2Q024sZp9LPZRMkDe30seuJEBm7RNMK9WekDs70ENrxVNySUFqZS4
 HWPUo5/QU1Lm9pz3T9kYZ2XNOo0wrtWE+Yk458umAAZgnCprDV1qkHCPHKtbWTsANMAO7Xp75dn
 WgF4Nqr253Qx3MPcTujePIqED2cjXtmci7PQ2xEP/OQXfmLqsfAWTvUfOGXrM/PZUrXxr4z35aw
 pTNy0tfrXA0Pjmeg8GspASdxt/V6dp36qrYClXXH1zbe9ATeVcUayTylVTaPs6sHS60m6MLg5bH
 jt3k+9KJYzS6EZtv/vhW9YLNVResbUwijx04paEIDhwOytHIiGevvEY/r1sBeV9t+WLhAT20XyG
 NwMybPObKZPldxbiS8C6Gsb3Dh4QuohHBeFqtKj1yKEi9t5XW/VRISQzuZiDYvvCfWPk995Cjt7
 94Qsx2c68dP5kvCwSSYyO092lOhFSzK4BC2p8/zquLAJQCCg==
X-Received: by 2002:a05:6102:2ad5:b0:631:31cc:e3ef with SMTP id
 ada2fe7eead31-638b7bce28emr10836758137.17.1779288720931; 
 Wed, 20 May 2026 07:52:00 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad5:b0:631:31cc:e3ef with SMTP id
 ada2fe7eead31-638b7bce28emr10836726137.17.1779288720423; 
 Wed, 20 May 2026 07:52:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:30 +0300
Subject: [PATCH v5 23/28] soc: qcom: ubwc: drop ubwc_dec_version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-23-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8355;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GaD3OADWseoOG5QeHpQmN/nkA6MzTACq4ooKbr03Zf4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcppazzmFMZGx4Xv1t+eKUZjtt90xnyHtodIg
 DntymwMSQmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaQAKCRCLPIo+Aiko
 1YO3B/9PA2rwOTvV4BBcAi/pXbQ3DpD3NoXApZ+T0/yYtpyyujBJH+9/SDOjHhk8uHMXhb3C634
 S1MQHalBlNevPcSDjGMuBA4uvF7y8qUKhHvO+M5XACGHYdHHZPjZTxJhJb9I53UpUY3pzyek3GL
 /3awgs/l3FrX+nImCwBRK2Nh8ylaYMGLMNscHR3lDHa6IGrz9twNRR9XhiJlLazgosF7jf12zhI
 DYr+P4Fq34PPy8JOjDPon4+ZdKIeWYtt0S8LdKGDzbu8BJ7nfjnv4QYjz+mNM2Skdul41TtC7Jz
 fzj1vMSl44qb7txXgD9R6NKEwyZataIpM9ScFz43euQpWGKA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: TCSRIBZaStUqUCkS8Tg-_20zw5r881Oj
X-Authority-Analysis: v=2.4 cv=WqMb99fv c=1 sm=1 tr=0 ts=6a0dca92 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=BpkRCZfudPv80oEIFw4A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXyvPlSOdoHoVv
 KM8QMDiuCfg4hgi7VQAkSu3HwBkiRmdYkjX6ncq8rGnKNy05RmHAQ89XSKei3J0YI4q960q6dlD
 zKmxTJvyMt9s2wRFOrOdKHRMbn4ADgPjXPFr+dF0+AyKIJO/T5MIF2BqC0eyPmmrXNNqiOVQNFZ
 3awLfiWrf7aLSWwaQIdG3Y1xwpG9c++LF5zi2T438aUMRj7PpERxwOCYihK+c/068fJBuH3mAhk
 dyy6gIMjxcQJ3De2jv6mXWd2MpRwzhuwZAOQx1veCHb8ImEV0YclKaMySfg7dhOtCJ+64bXp3dy
 85CzEZfJ3mfnvP2sYnsj5FasOBwPm20LOucTq4PTUwmb17OsF7DbZhtgDfCsiSp3ymcJEzCWDd5
 Bi2hki6Qx89RW/mOMpv9K/msUAfMVBpx7BJEjMvLadQQOU2gSpO6lrIJ2eRlh7DLTPCevQvIXlf
 u4q9vRG5ZmuyHnCVWGw==
X-Proofpoint-ORIG-GUID: TCSRIBZaStUqUCkS8Tg-_20zw5r881Oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
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

The ubwc_dec_version field has been inherited from the MDSS driver and
it is equal to the version of the UBWC decoder in the display block
only. Other IP Cores can have different UBWC decoders and so the version
would vary between blocks.

As the value is no longer used as is not relevant to other UBWC database
consumers, drop it from the UBWC database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 23 -----------------------
 include/linux/soc/qcom/ubwc.h  |  2 --
 2 files changed, 25 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..1344cda0fb75 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -18,7 +18,6 @@ static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 
 static const struct qcom_ubwc_cfg_data eliza_data = {
 	.ubwc_enc_version = UBWC_5_0,
-	.ubwc_dec_version = UBWC_5_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -29,7 +28,6 @@ static const struct qcom_ubwc_cfg_data eliza_data = {
 
 static const struct qcom_ubwc_cfg_data kaanapali_data = {
 	.ubwc_enc_version = UBWC_6_0,
-	.ubwc_dec_version = UBWC_6_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -39,7 +37,6 @@ static const struct qcom_ubwc_cfg_data kaanapali_data = {
 
 static const struct qcom_ubwc_cfg_data msm8937_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_dec_version = UBWC_1_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
 			UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
@@ -48,7 +45,6 @@ static const struct qcom_ubwc_cfg_data msm8937_data = {
 
 static const struct qcom_ubwc_cfg_data msm8998_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_dec_version = UBWC_1_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
 			UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
@@ -62,7 +58,6 @@ static const struct qcom_ubwc_cfg_data qcm2290_data = {
 
 static const struct qcom_ubwc_cfg_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 13,
@@ -71,7 +66,6 @@ static const struct qcom_ubwc_cfg_data sa8775p_data = {
 
 static const struct qcom_ubwc_cfg_data sar2130p_data = {
 	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
-	.ubwc_dec_version = UBWC_4_3,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -81,7 +75,6 @@ static const struct qcom_ubwc_cfg_data sar2130p_data = {
 
 static const struct qcom_ubwc_cfg_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -90,7 +83,6 @@ static const struct qcom_ubwc_cfg_data sc7180_data = {
 
 static const struct qcom_ubwc_cfg_data sc7280_data = {
 	.ubwc_enc_version = UBWC_3_0,
-	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -100,7 +92,6 @@ static const struct qcom_ubwc_cfg_data sc7280_data = {
 
 static const struct qcom_ubwc_cfg_data sc8180x_data = {
 	.ubwc_enc_version = UBWC_3_0,
-	.ubwc_dec_version = UBWC_3_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
@@ -109,7 +100,6 @@ static const struct qcom_ubwc_cfg_data sc8180x_data = {
 
 static const struct qcom_ubwc_cfg_data sc8280xp_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -119,7 +109,6 @@ static const struct qcom_ubwc_cfg_data sc8280xp_data = {
 
 static const struct qcom_ubwc_cfg_data sdm670_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
@@ -127,7 +116,6 @@ static const struct qcom_ubwc_cfg_data sdm670_data = {
 
 static const struct qcom_ubwc_cfg_data sdm845_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 15,
@@ -135,7 +123,6 @@ static const struct qcom_ubwc_cfg_data sdm845_data = {
 
 static const struct qcom_ubwc_cfg_data sm6115_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
 			UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
@@ -145,7 +132,6 @@ static const struct qcom_ubwc_cfg_data sm6115_data = {
 
 static const struct qcom_ubwc_cfg_data sm6125_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_dec_version = UBWC_3_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
 			UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
@@ -154,7 +140,6 @@ static const struct qcom_ubwc_cfg_data sm6125_data = {
 
 static const struct qcom_ubwc_cfg_data sm6150_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
@@ -162,7 +147,6 @@ static const struct qcom_ubwc_cfg_data sm6150_data = {
 
 static const struct qcom_ubwc_cfg_data sm6350_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -171,7 +155,6 @@ static const struct qcom_ubwc_cfg_data sm6350_data = {
 
 static const struct qcom_ubwc_cfg_data sm7150_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
@@ -179,7 +162,6 @@ static const struct qcom_ubwc_cfg_data sm7150_data = {
 
 static const struct qcom_ubwc_cfg_data sm8150_data = {
 	.ubwc_enc_version = UBWC_3_0,
-	.ubwc_dec_version = UBWC_3_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 15,
@@ -187,7 +169,6 @@ static const struct qcom_ubwc_cfg_data sm8150_data = {
 
 static const struct qcom_ubwc_cfg_data sm8250_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -198,7 +179,6 @@ static const struct qcom_ubwc_cfg_data sm8250_data = {
 
 static const struct qcom_ubwc_cfg_data sm8350_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -209,7 +189,6 @@ static const struct qcom_ubwc_cfg_data sm8350_data = {
 
 static const struct qcom_ubwc_cfg_data sm8550_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_dec_version = UBWC_4_3,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
@@ -220,7 +199,6 @@ static const struct qcom_ubwc_cfg_data sm8550_data = {
 
 static const struct qcom_ubwc_cfg_data sm8750_data = {
 	.ubwc_enc_version = UBWC_5_0,
-	.ubwc_dec_version = UBWC_5_0,
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
@@ -230,7 +208,6 @@ static const struct qcom_ubwc_cfg_data sm8750_data = {
 
 static const struct qcom_ubwc_cfg_data glymur_data = {
 	.ubwc_enc_version = UBWC_5_0,
-	.ubwc_dec_version = UBWC_5_0,
 	.ubwc_swizzle = 0,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 0b5aa9d0343b..c3f9efae5db8 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -13,8 +13,6 @@
 
 struct qcom_ubwc_cfg_data {
 	u32 ubwc_enc_version;
-	/* Can be read from MDSS_BASE + 0x58 */
-	u32 ubwc_dec_version;
 
 	/**
 	 * @ubwc_swizzle: Whether to enable level 1, 2 & 3 bank swizzling.

-- 
2.47.3

