Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F598CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6742B10F119;
	Thu,  7 May 2026 13:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uu9ocJ91";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NVLf/pBt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC9810F119
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:18 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647A6ErQ151176
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VGf89U6GYhkUCRMDjtnMSMgOlYsB5OBRKvGiOBHGpas=; b=Uu9ocJ91PN6+Ozbd
 QYQWijujKMLLrMBH9dh58k5kjc+EQxyjz2I7aSfPYuHpumm4KAMruALesF0GX6Dr
 fOA19pK6BLvR8ouykNMQJm1GjtgtVQuq+NwHYS/MemqHVBDXxlHzDRYdRPIkoj1t
 82N4YR7yL0+yIKDMgOdPj15ysp9eTfLe/g+HPRQdmuP+7iz0gx4hxjRmtCWHroG6
 PJXzMAD+PBvSRFwtZrq2q9Aa5Mf3lo+grCIbouFoK+K0lnV0ARi9YYd5Hf8iqika
 permiJt253sT0FVV1YDXuWXyc4qxeVmte5Cdwgp+XbBzVelws7B5G5GBhmTz+/OY
 u67n7Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kctsw2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba268cb5e6so10796725ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159057; x=1778763857;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGf89U6GYhkUCRMDjtnMSMgOlYsB5OBRKvGiOBHGpas=;
 b=NVLf/pBtVRFngG3igIdywlgS9alwWfvRDE5DilRTqTUL79nrIUo+6HI/j2cVX+tgYa
 qRFzKTJdXhFK8VWvcWmkCUeUQcYrr4UbjQNdPTTels0N3A+7ZnSxjkQc/eKQahUT3ni0
 Cm8Mazek0miO0Kd+1Dzj1MN38VmDJ2G3XD8sbmzmq+hA47X0ujMQt25q4OTA0defx78P
 VW2vlkEEW4y01ZudxH73zSRs9qTTmfFDfwFeT0NX2aB7+f9xL71NazIckV+zGwzjOAh0
 dkJedihdgrpq2xRl2XIQE1Qd5uvxy1u+jMMQWhFKcR0GfJO38S4XDpuI7RWp5KBVVnTT
 7qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159057; x=1778763857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VGf89U6GYhkUCRMDjtnMSMgOlYsB5OBRKvGiOBHGpas=;
 b=aVOYJ9qI+E+8VK5IZhsMfHx8EugNEnZmTC7V7PtPR/hEqxah70bt+uWFnyssY69xIY
 RuaAJqn9CCxvqOL2g6fhV5+AeIUAT5ZNlhNAsEdYEIPRRNzfYErQM8uMyVObR56VISv9
 aAoV2IXoYtwHkEl0a+v8865NAW9sFyKV8dnY88pPXMSaDHOD7uKkdrKBcWo4dPM00R1u
 49a0GE07AQx3moVXZrxz1MI5XUopObSNCdBPoweYLWuhH55ga9MfFng9PnQaXN2k4uLW
 AJ3W6+pGtcXWJsc19qe8Nu60MB5V0JTPpkcOxZGz35vEy0pATfQEnO09AzaH0QZ2UwRU
 9rzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tFOdxGk1yB3Obs2937Pq+e3K8FqhsgqsJcQpmdiGKQA4pYMl8pyM6ZlzUhD9qr70fSi6M4YmVgu8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1IThtTnK+3G+zGkM0qCE7OvWOS4QIIAx8enRRLPYCKxY/S5ms
 geFHhfVtoRimTzk2znLpBEzsMvW0m9SLK9EwSr32y6f6XNcQWy8odbNb6Q/+TyHt7g3DhXGKiJC
 nAObr2BVrtr2Kb70SlYPDLSPKeAITLctP3dQiH/h/cqmwBOMLJutEgUJi+aSju11dH7D7PPs=
X-Gm-Gg: AeBDievt0fWoK4e+0zTqe99A3SF3ISS7JANquTz6FCAnqs18zKLT9VHCdvPiGGY9DLy
 sbiaTs0M6qWs0+hEBzxofshSb7SH4hSYlXSZsOXvVcHlm9wXBQxJwq8YpmCDkiyUVqY/l9tW2Vq
 qo499YFP/3GJLLhzD2R8QwowY5fQ5royUuP3nb9DsF2av9BzfmAmwNMTw6Ub6AiOaLowEZT4e+T
 8xVzf2g642hhTK5dtl+QA4jz75mnkdncLS5vVvoI59gNAWHMn1CBYJeGOfS1t4ED8dtexPMeaMo
 VipvPuJOpBrttYZY/ng4vKn/wEygK0YT0YNHqZVBGn//RofySoIP5W1RDouqexVfbbEn5S7xdJH
 gEiSzWDDG2EWNg2obxfp/+8PmcuNR2cGiNIp2nx+cQ2QxgvVjST4/WCnpoiEzCFiN+t+FNsMjcs
 0DdFozyll7aqPjYJtbJI6dvp4rdp32NzPsIkAnUUnbym2wYA==
X-Received: by 2002:a17:903:bd1:b0:2ba:f5f:14f8 with SMTP id
 d9443c01a7336-2ba798b1bf1mr57238205ad.39.1778159056500; 
 Thu, 07 May 2026 06:04:16 -0700 (PDT)
X-Received: by 2002:a17:903:bd1:b0:2ba:f5f:14f8 with SMTP id
 d9443c01a7336-2ba798b1bf1mr57237485ad.39.1778159055766; 
 Thu, 07 May 2026 06:04:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:20 +0300
Subject: [PATCH v4 24/29] soc: qcom: ubwc: drop ubwc_dec_version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-24-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8355;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GaD3OADWseoOG5QeHpQmN/nkA6MzTACq4ooKbr03Zf4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2Hd2+yAAyg07S8UgV+8frAvzxAxCrxv7Ogb
 Bbze9as/SOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhwAKCRCLPIo+Aiko
 1XPcB/4qUiMOO0DqP5nQOqKItSdkd3L3mhTkDj6UD0Hf5V5jhHp9UtBJ4y4CrBkaBWyym2JixZZ
 grEfbo4YNDymDdbFLHCaYPge7wlp+zRDLoXMiGH9xg7kDsSM6zqk0l4bwApCMJS61H46ETjU+tW
 mZDALXozy8Gha+uqOKMDqoyzJ6ZMnk48AIIs4/XewFQHjLzpcR3Rnb8+fEbJ/unMujwgLHRvA7y
 i75P5ZxJ0xnPyGJnnH98g2P35EKTOL7NbznQhjPFiJTQMVV2zUvQtcl5afJYsCTxNg8atILPqOz
 HsVoW+QNYBmPegO1oY0cKcuMYy+5P3W384jvEk5R6kyx/57F
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fc8dd1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=BpkRCZfudPv80oEIFw4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: moL9nHANY5T6FPO0ULQdT80R_DIQNd9J
X-Proofpoint-ORIG-GUID: moL9nHANY5T6FPO0ULQdT80R_DIQNd9J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXyMuNIuwYz+/C
 VTmUrBOlZG/BmBDkbsIeeFxzQQRZYCLsPHZs2sPHB8RCMElLbcQbwSrw5x4bJw8J0FTAAa/ux3F
 c6x8Bs/VT2GMUcypaPL3A0wX5CCj3G39BSVFY+RFzsILlphyBlpEmWd1iHXP6v4yIiLP81nw74S
 iSd+wjH6fzylYCSgrEDjJq04Oah8kUBxVML2S7AVy/cnVTAWuV+N96r57fKprKMMIbbB3JcEs27
 FIJmqJLhASZDoRQ479Q/p+lDVFJzLxoVINOxKSICrGAu8XwLxt24m6MlHpZehW2E4XcOgHEL3Us
 5ePyrhaI5F9rLtseFxhDDbsrIz85Ff9blfW/VqpKM/O0aIvl4GYSYQCvYH54wJ92DU99UjFeKtx
 FOzcTpzfhnZUrAYu0rIMGWKHuzaZrYhGjWOzm9/UhnYqRjHJJOWYoOnz6mTcnTyWQPFBGTTIIiT
 4Fu8Zz5d2Nc0Tm9faLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
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

