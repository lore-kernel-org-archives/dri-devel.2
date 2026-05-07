Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C190CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A3510F11E;
	Thu,  7 May 2026 13:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIJsswsB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4jUdmv2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BE310F11C
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:24 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AISMI879630
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UU2YSeVXfhEBEmAAjyzhaY7cQ/RaczZjSEOGJBsk4fE=; b=QIJsswsBaV3cBfW/
 wFS1zBHwJEBVpTasN9vDxtqYb6Fz8RjpRCvUY45wJ/Nsossf8KytS5GBbvxegyx/
 5fMtsliXxtosSV/v+OE+mToh7uyEW1WaXo6IYyE1/l6bi2+s+KLWabor7eiQ7JSM
 oE37hHejYb54RDBBjgof2XHmAtAAnLZqMBG6+6dC3vQGJ674vUxfU2Le00UaZ3Q8
 WJtPVKjfl/o3VnN1gfjn3NO4jaY2OxtCsZ2+1+mJoosnRiP2XpO4KErm7lAzcEVq
 AzXpszgyj2RNaYqcQLiBXUQVC+FRaXcTsXwWO0+PDLW3vulHnhrTccGMKy2v23E9
 GNh1/Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1vfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso8423925ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159063; x=1778763863;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UU2YSeVXfhEBEmAAjyzhaY7cQ/RaczZjSEOGJBsk4fE=;
 b=a4jUdmv2Gz8WCBB9EjEI0WZ6TDpcP6seTUE58zXURIKsOFh2ruoHTfMxsofj5XW3+R
 p91oP3bVS+aBCDvryNuwmkdmnXFOIV/qbiL87NXDPkEds63LS1NHDY1sElLzhFlr4hi8
 MRHW7XX4bmpbkRiJAAX+IzJzlymfk+w9eqhF4w13jdeRHoQbOLJP61PG/1JCTcKGa8xx
 sXATRB8EHTDqajPe3rrZrmW4SJgS8aa4c2nJJkXZLYbq8AYt0P1rfGtt4QOqK37Dzwdh
 DgF2NLZeViE6hLUocmj3DGXGC4mkOcWComRBv3a6Iw5Uw7k10d9k3IYYOf2UNdiVTPmw
 NYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159063; x=1778763863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UU2YSeVXfhEBEmAAjyzhaY7cQ/RaczZjSEOGJBsk4fE=;
 b=CLmNcZP32QE2VOD099nC3ICZNXzd0dTmuYbokrwhr2x4HRgUORTifnHU4a5IvMgmZA
 hWNsRcqscPaDHDAgycrSsa12p26Wz+dUbqumVIwNJBHkIFHGESlpD6qzriUGKEUqK+Cf
 uLQKeypQpY6aM01MPbzUvgSVjCG83HCryJgBgZ+yFL1PyXZnUjGfW9W7T6X5hV14cUln
 k8xriwHqac6cDj5ibR/PlRyrA6+4PeYkhWOtoqoYumrXwiCGCaSTptCgx0z1BgbDbLPF
 fvrFr218axvxG+6CtXPcXZ2Kd2srPx6bYuuMrvnWEJLP7cHiuz+oMR+p5Q7sXdvgDRv4
 AQGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sME3VqCeMncASUnCBvJPLvT0raDDZp0RQmIagJW/ZzbBRslZ+fOPSSThqxUvq63hrTnqqBCLiX/E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnZzapyfPC/NsLZSdR9Vf2PIBWU+JIUf2udZsmw2xsxFDl4b8r
 HDOZjoWj3+fQ7NWBcpzH7FgfsYxaUsypjnlZkHyGN0lV939lV7b3sZAhC351xlx6Wn/2UtiHZw1
 NN8GL++Xttyrz/c3YJ8zbgPdXN0gCdYO8ydfWRG7YeEiTbqEQCJ4MabhVbxzmqn5CA0LFkKw=
X-Gm-Gg: AeBDiesnF+4OQ4rA6aLtbVXkmq6s1QPsmNC3K9Ktnu0Ob9pwSQy6oXTXXBpJwAdnP9L
 oNQ5AYeVPEOD7b87vUUOiAeGN0iQb6OE0PBYPco4HmywecS0hRwOD0FrICSupeUgjOW+FA3fdTQ
 i9SUJ6Us+dnTbN80ieLqky0xkM7GyAfXhwT1sWBM4ohn+8ChbeIQINPlBZ78SZ/fGfVkfwmlFTH
 uNWMOfJulOAcYXA4Yv719PB+l4vsyXMu22JBZX034hhIUG0V8uO9t5LhIr4OCFogIeJZUYyU4qC
 Hro3edW4u0e3vGIZmwRDQboZiZV4dZlJpO6cCzOAdmq5eH6+KTIUTExH1ly2ODnD2B6ztka+D9C
 c/uVVaL1ycHBlk5hx3hcLaD+3Gnfwa2HHpQhomA1kYmEfhTRJ6DzDCn/74/66GX+WuWm1e4J86a
 QkNfGcC2V142jydh90lWZm082mx/U40Ue6zEsgMBIgORnwBw==
X-Received: by 2002:a17:903:28c6:b0:2b9:4eaa:7153 with SMTP id
 d9443c01a7336-2ba79c0b87cmr53539765ad.19.1778159062648; 
 Thu, 07 May 2026 06:04:22 -0700 (PDT)
X-Received: by 2002:a17:903:28c6:b0:2b9:4eaa:7153 with SMTP id
 d9443c01a7336-2ba79c0b87cmr53539355ad.19.1778159062100; 
 Thu, 07 May 2026 06:04:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:22 +0300
Subject: [PATCH v4 26/29] soc: qcom: ubwc: drop macrotile_mode from the
 database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-26-c19593d20c1d@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5443;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TQBWqrbntLsRW914iL/lLCPXeMzB5PW4D9i0dro5eT8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2IKQUemAYDaPbwp1eqn8buNyK99WTaDiAH8
 4q0ilCMSAmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNiAAKCRCLPIo+Aiko
 1V3+B/40zgyEk7XYIfbq4254GX5YzwNV1vsUQnEbtkeRa/pkexia3wvROYWvcD6/jRxgec5nEGD
 yfwjI5gl//YTheq6oIpzNVT/2JXzb61Lsh6/whA1jBMMLLTHCcfQBz37iMcfCI8sn9DtBYMfXGe
 Omej7tZdlj/AsrJQfE0HrD69xAUH5KK6yVlfBlzqcBG7wUv47amF+M9Pn9xLtPndCwc3ys9TsKe
 LWMJTGnMjK6Q6RGZkTbMv06ZUGs1chhTGwFdcIU+NUSA3w69/8F3JW6cTP2qsrFpiAHfsTtbwjl
 Yj80EPQ8yf6h5QO7NWffBuOm5iVw9icYtnniujQWAoYcYEEx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc8dd7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lOjMx_-Oxa8n0LcNG1gA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: QuCC9NCb5JDerFs-3FbduKc32W6R3zbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXzuvE+DpmpKXO
 yk7pv823D+gQ0onjXyEhpotuu7ofvMJPH1SHjmJ/R29V447o4cuYHmABtvpjZqssQIKsFrU1v0M
 NMuyIsW3xjOMKZ6pV9GPvei6xitu8eqkG4aNnD0Y1VRFN2JZe9sfY8rIUP1ufOcuYkObwnMNNaF
 5ideCtHck2ERyAoKkzdQANREw6RGINvVuOmcO+lPFqk7SvG4ZqzKtn26edJZ3bsWJJd4ngcHFbd
 Dv8bbqO6D3GdLWsUjnVXkm/u+pr3sCfVTF0ZSQNJDOVfy8m5DTmTh7G61pZVzyE8UJjTS38iywu
 AxzuVHDPKqcCcKNpFos4MEy50ZFfTh4jigx8D7CRUMNlVWj1mQoOyL/B3DSmArmVExhHb53XESR
 1ilEqTkcAQ/GqqYkHtRcVwOq2tPhovOsO3+NI7v0OnITkDwR7u25mUhMxw8F3LNTZslw6KeDs8G
 ackuhFF6Bru109xN94g==
X-Proofpoint-GUID: QuCC9NCb5JDerFs-3FbduKc32W6R3zbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070130
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

All the users have been migrated to using qcom_ubwc_macrotile_mode()
instead of reading the raw value from the config structure. Drop the
field from struct qcom_ubwc_cfg_data and replace it with the calculated
value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
UBWC_3_1 (with macrotile mode).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 16 ++--------------
 include/linux/soc/qcom/ubwc.h  | 18 ++++++++----------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 35cde4e9a238..b880f77f448c 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -22,7 +22,6 @@ static const struct qcom_ubwc_cfg_data eliza_data = {
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
 	.highest_bank_bit = 15,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data kaanapali_data = {
@@ -30,7 +29,6 @@ static const struct qcom_ubwc_cfg_data kaanapali_data = {
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data msm8937_data = {
@@ -58,15 +56,13 @@ static const struct qcom_ubwc_cfg_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 13,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sar2130p_data = {
-	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
+	.ubwc_enc_version = UBWC_3_1,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 13,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sc7180_data = {
@@ -77,11 +73,10 @@ static const struct qcom_ubwc_cfg_data sc7180_data = {
 };
 
 static const struct qcom_ubwc_cfg_data sc7280_data = {
-	.ubwc_enc_version = UBWC_3_0,
+	.ubwc_enc_version = UBWC_3_1,
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sc8180x_data = {
@@ -89,7 +84,6 @@ static const struct qcom_ubwc_cfg_data sc8180x_data = {
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sc8280xp_data = {
@@ -97,7 +91,6 @@ static const struct qcom_ubwc_cfg_data sc8280xp_data = {
 	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sdm670_data = {
@@ -164,7 +157,6 @@ static const struct qcom_ubwc_cfg_data sm8250_data = {
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sm8350_data = {
@@ -173,7 +165,6 @@ static const struct qcom_ubwc_cfg_data sm8350_data = {
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sm8550_data = {
@@ -182,7 +173,6 @@ static const struct qcom_ubwc_cfg_data sm8550_data = {
 			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data sm8750_data = {
@@ -190,7 +180,6 @@ static const struct qcom_ubwc_cfg_data sm8750_data = {
 	.ubwc_swizzle = 6,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct qcom_ubwc_cfg_data glymur_data = {
@@ -198,7 +187,6 @@ static const struct qcom_ubwc_cfg_data glymur_data = {
 	.ubwc_swizzle = 0,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
-	.macrotile_mode = true,
 };
 
 static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 254721f5ea3c..fee778360ac2 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -33,15 +33,6 @@ struct qcom_ubwc_cfg_data {
 	 * DDR bank.  This should ideally use DRAM type detection.
 	 */
 	int highest_bank_bit;
-
-	/**
-	 * @macrotile_mode: Macrotile Mode
-	 *
-	 * Whether to use 4-channel macrotiling mode or the newer
-	 * 8-channel macrotiling mode introduced in UBWC 3.1. 0 is
-	 * 4-channel and 1 is 8-channel.
-	 */
-	bool macrotile_mode;
 };
 
 #define UBWC_1_0 0x10000000
@@ -77,9 +68,16 @@ static inline bool qcom_ubwc_min_acc_length_64b(const struct qcom_ubwc_cfg_data
 	return cfg->ubwc_enc_version == UBWC_1_0;
 }
 
+/*
+ * @qcom_ubwc_macrotile_mode: whether to use 4-channel or 8-channel macrotiling
+ *
+ * The 8-channel macrotiling mode was introduced in UBWC 3.1.
+ *
+ * Returns: false for the 4-channel and true for 8-channel.
+ */
 static inline bool qcom_ubwc_macrotile_mode(const struct qcom_ubwc_cfg_data *cfg)
 {
-	return cfg->macrotile_mode;
+	return cfg->ubwc_enc_version >= UBWC_3_1;
 }
 
 static inline bool qcom_ubwc_bank_spread(const struct qcom_ubwc_cfg_data *cfg)

-- 
2.47.3

