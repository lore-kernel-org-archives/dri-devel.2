Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A5CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77F810F0C7;
	Wed, 20 May 2026 14:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cnkxh5Ra";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lwg51NaS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AF710F0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oTVr1178134
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xm0vNFmSC6On7sSlFzQL1hlJJzBLrMhRxyzus5igF6c=; b=Cnkxh5Ra7I9FJHHD
 K9yx56yLhwuX1AZCGbU6zkM/Z5w3X7HIvbLPeDcRCmrtdg6LH6KhJIYZMArEksrM
 be6kJEvLRZsUwPQiXm6m8DpnR0BD7L7pQxtsvBNTy+RfQvXF3SDPB4C3q1BWY6+3
 4ui0sddovD0apB6jrUntKWVPyN7iWN9UhFv6JeeJneOboaIn3eRm1blPPrejuWwL
 9RUm32+nX/aqDN+hks/APwgCF2Q1fSRRu99GHsNMWviRASYv4sN9e6v0kwu5Fr3H
 9pHVNHhJrBQ/pwvUkAp9jPAuS2UgDwJxTc0Gmz6eCsddZTlEBrmCY+P0cyqQzgTO
 c8fPUQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6s3n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:04 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6343bea7909so1925120137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288724; x=1779893524;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xm0vNFmSC6On7sSlFzQL1hlJJzBLrMhRxyzus5igF6c=;
 b=Lwg51NaSbqffxl2+g+iEo6sOW7SRe5VThbh9UfdA9fJqqF9ppxD30gdrY/dCaCukwT
 6MvSqsq80owi8oRZ8FYbej6yfqvxmpEKO3FwSJ/NmMC1B8/BT0xDmNOhmGpmYktLthjz
 Hwh2OYHmGTACM4ONGVePU96nKzU/lLuM4OD4NfGI9J0/mN4ST47LtIU4ywVq079DO+Wv
 jyT9nH82ZTgZ2o7Sniq3+y77x6qqkYNx87JahG9JdFn3IV58LKPRxA/IarcCotKy8ur4
 FB9y89IDif7Ju1r2657/5vka67Cz9NZW6OO5GT9xrvYs3xDFiyAnDw7w9douiylNiwDD
 yuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288724; x=1779893524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xm0vNFmSC6On7sSlFzQL1hlJJzBLrMhRxyzus5igF6c=;
 b=ZrXsBHyNYCkdn6TsWLsXoO6nlczcsmldepMFfGtdTPbWp99uvHb4R2lsnIERYQQ+Eq
 D6dLVp0j6K79r79s+NdHAlV0Q+RxqyBtFfdXf22YwI7Lg7AiRf66PM2qmqLQqtZSNDDr
 r3d/4irS+Z3+NvMRJqc6Gl5Sz4LES2Xm7NDM7mEPGxA5PYfta3zL9nbJAYn7eKvg2KFl
 mMsgrL1q3FEGkYsdQUT3f4FOlzrEkldAljD+KEACkwfOvAr04RC9JWijaAJO93ibjpTZ
 5t9ZcPeBku6MBKzNnbNDRYjFHM5Y4Iycxzo3f7QDe1Ltbskj0Y6VKQ7ITXoqomduIsyQ
 i9mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PCSaaCVI9u6RrkVh4Y8jc4lzbHYz5Nh+yBuIBgbU0kcIErOADSqe31cX6qSWpdnKqBCBcotwyOyU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5eJHN8l4suiYRIFMS1ROFsOr2FwbRfc/Xjsp/ear4zyy00XGw
 Y6zL2N2r0YwBf6SidMQNDEnMF3tn5fgzBNgZNDMoI6Gsmlw6KHW3apTqrIB7ciw3XAnk3zZRqnt
 5nw/MhQvXv1FKuohDv7Z11ai7rCKaEzUfOZbKrAZo3QN8vYftbBGMUUVY0yujhmkSLSjnR+Q=
X-Gm-Gg: Acq92OGwqA6IRT8GdyoZbAogj1SgmtvZvlb3m+atVB47pjeTI8F8z+ntJt6kVfP0MTw
 y/uBBNt6CRbTp/ThMZHVE9yhNtzvsh37E9039gpqi6cWXavkDEJJmsCto9lZ2Da+EtGQxQvix9s
 xFEFJDPnsQDn9qDJZzfwsPNL5dqe8wpv1JExrcx+wPRoAMi26rESxXDVWvazhI0dfcZBCO+FYMq
 iKR4MO86rcsFF0PUM68aRYJhQyAmWUji/rjidcLX7Aj7I0otaCQo6+FMJUfPfjbgrf8CWwIWCOS
 AoKXXesrMYjs8NmRFM12j56ajEfYRwlPxX7FJRPQYY5fZed3p07zOncWkvJK4bRfkmytBdCVB25
 /MjKAsPAWQ04UThWpNlOvBOqObQnXDw2bovvq9AQcJ+VlYHgqgV6nh8OyuhB0cY6SfLUY1w2zgn
 6lzSzfQFVAqeZmaB+LWipmf0cPARsvgxzta3U=
X-Received: by 2002:a05:6102:304d:b0:62f:2f1f:599b with SMTP id
 ada2fe7eead31-63a3d21f6e7mr12724981137.7.1779288723689; 
 Wed, 20 May 2026 07:52:03 -0700 (PDT)
X-Received: by 2002:a05:6102:304d:b0:62f:2f1f:599b with SMTP id
 ada2fe7eead31-63a3d21f6e7mr12724951137.7.1779288723180; 
 Wed, 20 May 2026 07:52:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:52:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:32 +0300
Subject: [PATCH v5 25/28] soc: qcom: ubwc: drop macrotile_mode from the
 database
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-25-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5497;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=H0u9J4NpHkoALoZnkr4HzilolgHdpafpbEfxO94JORk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpp5Sb3LBHh+2rpBKEPah7kJGpYSpLI6Yojz
 aX2WLcqljSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaQAKCRCLPIo+Aiko
 1b3EB/0ciDXMWMsPPlje7FI4s1MFvATWI/xuJnxAk9fzWaN3Doq0OZdFsE3dw1i25WLHiEqjhFK
 1Y2B6pELjE7EdcTdT/wKz4oLhNAoZZNvfMd3lARKS4HsW7qO4CfNFg3txZxAaXrBrlYJ3hTWA2i
 WDgfHKj5kxEAGVkpXkLyyA8NxnmJANmQy5rzeSYHksymm9CUAMlmtmOz2zaT7Xwa4T6a2ePlE26
 8pwEnkq9XO077+KQpU2nJT2/JS6RxOOEsHImnCVq6ae10YhKBBeVtYxKixPn4kHWIEbPR1GUqKA
 mzc7YyAi0Vov2hwIWqRe5SxMtr+qJLb+PNMOTBihxdZMbDUz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: P0Ih1IG6ztOaEGr7s6oyNiut0gYIi-Dd
X-Proofpoint-ORIG-GUID: P0Ih1IG6ztOaEGr7s6oyNiut0gYIi-Dd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXx2GHvaOfgL1Q
 e2t+WoGgJBVjgxcjwhg+ObzBXS3YzOSUOa7tLN/QLB2Ei8HjcdQqZf0Tq1Mowul7atb/XW380Ck
 qhpHtoXSI7QGuMw+N7WfH/17hxPY3q/seZO2ftff1rsj5G0sZXTfA6NGWZ2OwVkiDyQwrMEOFuI
 h20YRZFAbp6YMdUWtTHnFhC2VpVZZNUkqmxKnfzfdkXQzVUO8Kja2she/k6SxQccTUtRX7ieZqu
 CMuCpNH5wTLLFQB6pNQetzO821TmL4mN3Ctgo2BRW201HgatVYAFUTGdtXTEp/hN2g+ouo3WNck
 abcvTgRsteFO6l3Qa/Ge908id4TjfgxsFagfYBi9PgRP+CVrPYPHbWNGfZcEKlixRrNZdIGMPQI
 V+9MB0GW1IMuIkt7/aWVTRrX6n+es0tm62nVOzPs4g1m9ByAas6F8Kog0DWn5faEbM+zarPAZ4U
 1E9bpI5vkcwc7IXliEg==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dca94 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lOjMx_-Oxa8n0LcNG1gA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
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

All the users have been migrated to using qcom_ubwc_macrotile_mode()
instead of reading the raw value from the config structure. Drop the
field from struct qcom_ubwc_cfg_data and replace it with the calculated
value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
UBWC_3_1 (with macrotile mode).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 18 +++---------------
 include/linux/soc/qcom/ubwc.h  | 18 ++++++++----------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 35cde4e9a238..8dd91d0b3974 100644
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
@@ -77,19 +73,17 @@ static const struct qcom_ubwc_cfg_data sc7180_data = {
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
-	.ubwc_enc_version = UBWC_3_0,
+	.ubwc_enc_version = UBWC_3_1,
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

