Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F66CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E08C10E215;
	Thu,  7 May 2026 13:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZnzAd7d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AW2qIt4O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2E110F110
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:27 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6479v2FT1669567
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y4Spcrvj56zhlbuoqjcYCgamAfaIhEXR+CzRTdPPVyQ=; b=KZnzAd7dboJyvw3b
 QEeY/og+Gq43AuAYkG4zoKG4udQJAW3jscRuhDLimAKL78JqMRABdTDBp7ndXx4E
 gaM4PBeKM3FEtoLaXHz951LYHPuH9nJGX1Qg3SLmdL9TU76SyChUJ8Tbf8hYFQ4G
 ie8waFEUtFKK46xsbnj6JzTTtsVvJcJ/9YO8ujjwmrMpsCReZ3Q4r5caYMuKHGri
 cOu8qtWft8JfYQKLgaoSI116939z2qlF/FW1HzrD6onpxCtEKPXKjK9ZLmwi4frr
 vfHVeIyzetf1HOCiAdvZLBR7HaIeP0kfj+Z53DKc6fNdAACPYfPVbsSnX6YFORsa
 IktPvw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p1xk6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:26 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7dce1e67fccso797131a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159066; x=1778763866;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y4Spcrvj56zhlbuoqjcYCgamAfaIhEXR+CzRTdPPVyQ=;
 b=AW2qIt4O09pPPJB/ob45sOhsoaXCXk45SMMkQcWEoi/fcC42AXttgQ/ITRqccNXGyo
 c+cS4GoYbQDLvzHZP3nlmIaXEPNPnkZaCHmqgPgcMLmEBbgGK5YEvTDDFbQtWBA3O3ik
 +bRmGw7dAX7dtrS5EHIt3LroKKMWZzwhIE7Ijg3QYQxVAnCQ2doaFDVMVo+oj5xF/Cjm
 CYc0TQ28lT25repQIRmdnd0qX5mw39FAj0Ij6SIFsxy8HbyzYEUfHIsii6USHx2bHZqP
 HMPKxH++oc8EIyBlZDVib4VhH49OcEC6axcqN1bVxTSq0CZINcZ/kyTwX7yiqDClpDVS
 TQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159066; x=1778763866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y4Spcrvj56zhlbuoqjcYCgamAfaIhEXR+CzRTdPPVyQ=;
 b=oGQne1h/aY5kKRLZsOM7f2gQo908/OohvCxwVUXvqjNpy1kLn3FQDd1dvwlA3Nqyqs
 HjUns2A+HArY9dTrx/Q6oavvhU5mctF4UpShv2qD2SPBa5I2zJ2ZYUd6n//QojYjDaX6
 fhMl9wLYFl9Dh4P2HHgC7dciaXPEVpNhftmb90n3oUOa7ZKa91qabzVdoAHwT1F3TOuq
 dvGENB48bIm2IMYSnYRY5Jg+M7bEQzoTGPPPR4qplsKLtLbDq5nsvM8GVOfl5DCFIRFU
 vcgYRO+z7BNBd3F9gb0qiXcgyL4+9ouvOG8tpN2upWPige6/UqZtkrJLIdUasjYv4H74
 U+Yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+we3lyQ4qIaT2qXbSw+OaP4LQDykzarorKGZ5wqDRth9zacXhfdjDmwBClvhDhL3H0+Ay5EaAF00w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6ZUiNdojOaxe3AF35JF/iXNntRrRW3QvyHI5ONqCKVd0oTHaF
 hnM7zDjwQ23gQ4O9AKSVHh1HnFDtqsY6ItILwVNnKvelba14eB52Cb8Zry+kdRgrKcV+ORIMqoM
 lXt6fDq0MIoCQhVNEFderw3NX3qbk5CMIwllWmZVD0gM57PVR80uQl+WL55p/ol34wzwbDqs=
X-Gm-Gg: AeBDietPS0WjmVeN2oT3O7N8nJwqvbTzBZz5ZrL5cvHvvAtWSDFq3GvYk4nZdxBgK8M
 IiFE0XndCwQCmp9mn9Gd0BYLnSmtB4GGtwpdGZ6uj2PTA23+bCAPB04p17QACwbd+MIXd9vf4wu
 j7ufOKuudoUXFiVjAo95vlYRzIKa9jKk3CK2C8fNzSpW+zm1XQXmX26XWJmv/AkgA5JnMSshLxD
 /iss5Ap/uexWRUgmtS0ML51AILsmFYpMVHPmMrCe2XRnjJu52KdhO0P20KWkXAKynVmB+h97eA0
 V/2pJxbv1gMh0V0rHKnMsGKPDNjPaxC/4GqO4BP7WFEBWC3uCABQZozxya2exmptY2E8PHCWcmR
 G4pJ1U5etYUHKBe59+GV2qmS6f6oeY47wYDeH83NgaSOtMofxrVM1yp1aJdmzY3FCz/YEZX+hR7
 XJvMgAMIEukbbRJ/fwTrD7bBY2yMV79eJWoXDrqyDlUi6NcQ==
X-Received: by 2002:a05:6830:6d15:b0:7d9:71e7:abe5 with SMTP id
 46e09a7af769-7e1dee9096amr4806013a34.10.1778159065539; 
 Thu, 07 May 2026 06:04:25 -0700 (PDT)
X-Received: by 2002:a05:6830:6d15:b0:7d9:71e7:abe5 with SMTP id
 46e09a7af769-7e1dee9096amr4805946a34.10.1778159064857; 
 Thu, 07 May 2026 06:04:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:23 +0300
Subject: [PATCH v4 27/29] soc: qcom: ubwc: use fixed values for UBWC
 swizzle for UBWC < 4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-27-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6082;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/5g4ZeJetQrIZ/OLIdACHZoyX6KSJ172mYU4QYqK3To=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2I84EjPL05HMIn4nKfUOTI20skhdFu77lwU
 7T0ZHaspyCJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNiAAKCRCLPIo+Aiko
 1feVB/daTkBr9fSmmy0neS1IRKcDx1F+/xbzR35fHVHKFWq5T3vh19Dk+kqbBA6iYl3IhPXzDd4
 KTvnvnWdUo3Ef+fqn2MhAk14ZMijGADt9os+idQYt85gPrZ2s5vkJtB09cyoDLruXMwfO03jHEM
 dDvETQ062Uywo7vKbgCeUz3QSxj3K1SmkmYHBOgtkKFmZasCL9RuQdxea9rDrwOi5Ymb9SLCV/J
 p0/9xZK0Mub/d9ZeJl4M62f8yG3RuOXhWuoXjaNxHsv4qHYu6fPP42N31sevhYIX6uuYW8B6dOK
 Olix2Cx9iNR3oBicygeHAvQxKnNmPk+CIjncnaVI3HN5vvI=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX1OoTaxpoAVaH
 cqlkEf+fCqHV0PGnvT0a2pTvUYMO76AQ2cuhmuqr1QLMrXPxTpBaf+5KMumpQttbTeKuzL9ywZA
 j/SxsuOnWz7Ij3OC0PV5zqICBkAi93IDmxRVYHp6GwIbKpUPMf2tWgCirYkI8YMvBcyUtnVvWwT
 8KJ4YeA4YEfPh9+bOWe80sYPP82nQPZqEGs0U3tvDfjfOCsvr6EYE3kkrP4vI43obVcx89npyaW
 vCZH1n1R0jOBrFUMz7pHbdORs87LZH0a+F2sU52ZD7uYZN7eqHL+5Km6TfD2id5DpIq/ZGPjmuL
 nEz1fSsJCUydoUbtitKmLI++RCKhhJt5CO7BC/cC5NIe/bwI8gKszPhIX823Y9uJ2C+NW2v4lgS
 H4sOG7IyJYO0DpXaEGTeUDun6UPRaKPoiuAJwA6w8XpWRDNW1yLtGUNQmF2OWqzMpkE8mcb3aH4
 lzdHkTeYazq+OiGrLig==
X-Proofpoint-GUID: -GIbKnDcbehlRAUzM1BXTS85_qFbbmDq
X-Proofpoint-ORIG-GUID: -GIbKnDcbehlRAUzM1BXTS85_qFbbmDq
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fc8dda cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=vmkA5Hdfq4WBgaw8N_IA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
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

UBWC devices before 4.0 use standard UBWC swizzle levels. As all the
drivers now use the qcom_ubwc_swizzle() helper, move those values to the
helper, leaving UBWC 4.0+ intact for now.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 34 ----------------------------------
 include/linux/soc/qcom/ubwc.h  | 33 ++++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index b880f77f448c..2509aed0e743 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -33,17 +33,11 @@ static const struct qcom_ubwc_cfg_data kaanapali_data = {
 
 static const struct qcom_ubwc_cfg_data msm8937_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
-			UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data msm8998_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
-			UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 15,
 };
 
@@ -60,94 +54,66 @@ static const struct qcom_ubwc_cfg_data sa8775p_data = {
 
 static const struct qcom_ubwc_cfg_data sar2130p_data = {
 	.ubwc_enc_version = UBWC_3_1,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 13,
 };
 
 static const struct qcom_ubwc_cfg_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sc7280_data = {
 	.ubwc_enc_version = UBWC_3_1,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sc8180x_data = {
 	.ubwc_enc_version = UBWC_3_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
 };
 
 static const struct qcom_ubwc_cfg_data sc8280xp_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
 };
 
 static const struct qcom_ubwc_cfg_data sdm670_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sdm845_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 15,
 };
 
 static const struct qcom_ubwc_cfg_data sm6115_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
-			UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sm6125_data = {
 	.ubwc_enc_version = UBWC_1_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
-			UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sm6150_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sm6350_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sm7150_data = {
 	.ubwc_enc_version = UBWC_2_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
 static const struct qcom_ubwc_cfg_data sm8150_data = {
 	.ubwc_enc_version = UBWC_3_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 15,
 };
 
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index fee778360ac2..7c9506741001 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -22,9 +22,6 @@ struct qcom_ubwc_cfg_data {
 	 * UBWC 4.0 adds the optional ability to disable levels 2 & 3.
 	 */
 	u32 ubwc_swizzle;
-#define UBWC_SWIZZLE_ENABLE_LVL1	BIT(0)
-#define UBWC_SWIZZLE_ENABLE_LVL2	BIT(1)
-#define UBWC_SWIZZLE_ENABLE_LVL3	BIT(2)
 
 	/**
 	 * @highest_bank_bit: Highest Bank Bit
@@ -55,12 +52,7 @@ static inline const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
 
 static inline bool qcom_ubwc_get_ubwc_mode(const struct qcom_ubwc_cfg_data *cfg)
 {
-	bool ret = cfg->ubwc_enc_version == UBWC_1_0;
-
-	if (ret && !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL1))
-		pr_err("UBWC config discrepancy - level 1 swizzling disabled on UBWC 1.0\n");
-
-	return ret;
+	return cfg->ubwc_enc_version == UBWC_1_0;
 }
 
 static inline bool qcom_ubwc_min_acc_length_64b(const struct qcom_ubwc_cfg_data *cfg)
@@ -85,8 +77,31 @@ static inline bool qcom_ubwc_bank_spread(const struct qcom_ubwc_cfg_data *cfg)
 	return true;
 }
 
+#define UBWC_SWIZZLE_ENABLE_LVL1	BIT(0)
+#define UBWC_SWIZZLE_ENABLE_LVL2	BIT(1)
+#define UBWC_SWIZZLE_ENABLE_LVL3	BIT(2)
+
+/**
+ * @qcom_ubwc_swizzle: Whether to enable level 1, 2 & 3 bank swizzling.
+ *
+ * UBWC 1.0 always enables all three levels.
+ * UBWC 2.0 removes level 1 bank swizzling, leaving levels 2 & 3.
+ * UBWC 4.0 adds the optional ability to disable levels 2 & 3.
+ */
 static inline u32 qcom_ubwc_swizzle(const struct qcom_ubwc_cfg_data *cfg)
 {
+	if (cfg->ubwc_enc_version == 0)
+		return 0;
+
+	if (cfg->ubwc_enc_version == UBWC_1_0)
+		return UBWC_SWIZZLE_ENABLE_LVL1 |
+		       UBWC_SWIZZLE_ENABLE_LVL2 |
+		       UBWC_SWIZZLE_ENABLE_LVL3;
+
+	if (cfg->ubwc_enc_version < UBWC_4_0)
+		return UBWC_SWIZZLE_ENABLE_LVL2 |
+		       UBWC_SWIZZLE_ENABLE_LVL3;
+
 	return cfg->ubwc_swizzle;
 }
 

-- 
2.47.3

