Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ABCCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1A310F0C4;
	Wed, 20 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XauMLZbK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6UJiVbm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1295310F0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:07 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6d0B119200
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z0x04teL0xC69U692R2wb4fDmKgXpTUZPxuDE0l28kc=; b=XauMLZbK+tvHEEOd
 Mhfa3km3kT2M/q/iIOv/2nvbN2R0sX5KQDn0DX9aSds5dhtbuVejXWxQTv+fqnIC
 Y+4IuVHFMHvdu93zpQoOdYC6TYU9F6w6s905d/mnebhC1cAh/Tmc64oQX7xb45KL
 0Zv/j9lgKNrlzutDgq+s1bf24UjddICwJhefey1siSg966/zb2H+tNT8HIFHNVZm
 +ly4kOpTR5L2RhpZNykyUsGyLIL4IWP+sU18wuR69TaZoVW2U0Dx+4FNhRs3+cVx
 5r1+KHlNGo7GU107DTYI3mtpQh2i2kXYSxYM15c+ggqi9ptviDaEUtnmEzDs+6+v
 oenbtw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51494d74d4bso133971161cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288726; x=1779893526;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z0x04teL0xC69U692R2wb4fDmKgXpTUZPxuDE0l28kc=;
 b=C6UJiVbmJ5rpwQjV1vHhhJr1rbAlVKRtfym/4hAivwXzB0FNWHtSQq2Y/d8lyLvRXp
 xGc+LNIYS7Z0Wd15Teh5oeL5BJq0rt0TIRdeUsSdPetqLEjzO6wd/vUvf5eM+QGuT/aR
 snwKKzc6WU+d5sOXbhAuGzqoAnkt+rRd0e+2FtKWRX8magW4mCdhop47MCi82hqcxHuL
 FNiwUA50PNHIHpTGD0iBQN4U0Zp+FZmfXlGT3FefH2myu6wUBVY5LBOqVY5c/eMkaFFN
 9l5TF33IfsIMo9G0CMbO9YquD8qC/dsa7tiz6S3Mtvv15hXgZA732JAkpqYcU1A9WOqc
 +MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288726; x=1779893526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z0x04teL0xC69U692R2wb4fDmKgXpTUZPxuDE0l28kc=;
 b=EFAaCddzgyQDl/S1naaYbGPzMgDq4ojexc7niDAaHWpggVRcUBNGoLltT/1fNThUb5
 nN8qhv+S9jnqFzx8VvNA3msIZFziIlCsfpCHvPRioOqa9Uk+Oo24r7QumtlOLfemLrSP
 PR4lJFiQyP5bnyCIjgA2Zl55JjbLh8bO8rJgDb9bWN/dw8hK5fw+Ka+s586dpJSQTUCe
 eP3ZT9OQpQuSui4Sg9qChK6AvQi9HBGxFZPmivwfXzPlRjxzdklI/NVUcerWGPrDt6K+
 STR+0eDyP03jOp2wRJSYgGahVH3C/pHg4KO/CGzbV8Z2g41/HmlKJnRIj8eeNFhrUKvT
 wLxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/81mh64T/yglc0nEi6vY8NW8HaJTvpaZNb1S1nBMKb1Y8mX02VqIb9Ag+DlsywsLdXBtCTbZh8QVM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSO2GN3dKDKXTJ9jawrKLrj2Swcywdq8w7WUbSGMH8V0t70zZJ
 0rZut9v6RtLV9be5SgSmkPgjpWh/vZRdcF9pbs2hgWB+h85zQ7sGJyCKyo69keQpwTEf1ETI8vB
 vC6z0Xfd92+scJLogkg9faDxTMnWWnEOYaGQo16iD31wOfhKLJrISxUaJ2WnD4ZTL2RLcfPI=
X-Gm-Gg: Acq92OHWYphwxTTJp53CnU3p/OoS2IzM0ONGhCb87hbiQmdDdtQQWEmTfXQ/YejD5PU
 8Gj9Cz4Jj916xdxEUNrMiIH1MthxXsG3HJMp2zIETMPRs3HQckrLpZtT2KfBpPTSaEEc425P85e
 OowOdvSoGhAC4PqP5LHgyqzMpLXT/ndZsEOq49sEKSl5y+C7nqSwPB3jlIoC5ddiW4dcysMLK6L
 sJbbcsX02v5ZuN2ZjyjJb4abE/BzUVNYyaXG9fpAlAYooa9mO6tUCj3DIcFJ4YVCoszvoJiFHXy
 5AYhONm6NijfeWYXetZvJ+VZeKhIU6kmSpS1vIrtDm8K5AutBgRx3BuEpoUxav6cAkjJS02C98B
 kQLhs5IngT9vOuFFmYdkR1Puh7zko6gM3Vr57e+9VroZfXUersa1FHs8z2xATgt4pK4DNJ8K79K
 xfiYisc/BwdgjcNoHqKA1C6pMbXzwybPvDXfo=
X-Received: by 2002:ac8:59c3:0:b0:50e:474a:47e1 with SMTP id
 d75a77b69052e-5164159e60bmr355622681cf.10.1779288725336; 
 Wed, 20 May 2026 07:52:05 -0700 (PDT)
X-Received: by 2002:ac8:59c3:0:b0:50e:474a:47e1 with SMTP id
 d75a77b69052e-5164159e60bmr355621971cf.10.1779288724620; 
 Wed, 20 May 2026 07:52:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:52:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:33 +0300
Subject: [PATCH v5 26/28] soc: qcom: ubwc: use fixed values for UBWC
 swizzle for UBWC < 4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-26-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6082;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=o9JUkbRpVoaqtqVf/XyHTRO9fA3cJ05Ua+3YfNy0bNM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpqYITPjDh9VNzdWMyu/0fkcO66YkZx3DHdb
 dOvhzBt2l+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KagAKCRCLPIo+Aiko
 1R98B/441iw213VarJMVAPKJ8r4uxxPpk/28lve6J/XN4YKQQTo5QusuGTcB2CM5afK/jeAEBy7
 Nij//lLLSlUdmI4tlFDJoVQEO0vU0EIARxdeRHXzYkYAgM8TnvKkcqfmdShDXR1EGssQdkdKf+2
 N6Di8r+b5Zseqyk8z6LYUCVcbcDXulF7QWznDyiCptiCe1cZeDJL1DddEh9xF3417i9Ohvnz/o0
 w+sqM0E91IMR0kqSZPrwxnWxW3ITcjMagxd5GqoIri6i8Rjet4iVXt6TVIeiXjZ5R0o7GsRDYsY
 mRLYLE9yBfSVQrOOlnBKjePFfYi5PIiCUoQwbcBRGU3ZHbx4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 9nwGZ3KzIzOnG04PNxcgd1OPceVwm6t_
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca96 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=8a_ODPMxA7UucN5sxwIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXzmU8oeGgxgrS
 W86ItHvGusVmXZJBnN7fFHxpmMymi+nsbvMiHAxgCIJE9Ly8SNQY2Hw1ZpikuGlagTx5pnaO7OQ
 R3s1+4lu8fPkC0Z/s2G/uWtUv0cwHNYm3Y9yqxmfQCVhzYBulqLaH6oiDcx/Gv4xcwDctwAU807
 zNodpRNJDdaMDdQWxbg0q0kkFqGiFKUdTfv5UphixQbTNWeTP2plfJ1tGA0/O6KURcABsY7ark1
 +5KPq+cBgDoajOJdhUzDzazZo9bgZavOzQMZ0NeyYybbQK5IMGo+t0lpy1cAvHszVctan5//MsA
 6SbKSO3Sd1H3sVnvzaaRWD1zOBRJaIR4iYuRh4JCWDSbLwnMqgCrudL3uwZnSvSs2LjjtMna8Co
 iJm0tKgyiZc9bfe9yvdlZhTmd2MGGz43OS8/pAbcEgxn7Ot59j0kLkXzvT0UTY2DxHnv12ztjsG
 j+FjG61xP0V+GIPzGZQ==
X-Proofpoint-GUID: 9nwGZ3KzIzOnG04PNxcgd1OPceVwm6t_
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
index 8dd91d0b3974..7e321389a399 100644
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
 	.ubwc_enc_version = UBWC_3_1,
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

