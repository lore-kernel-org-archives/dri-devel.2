Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0851CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 521F710F11B;
	Thu,  7 May 2026 13:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAiAfS7A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jN1XEG0c";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB0310F11B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:21 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pYdG1424508
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6pPTtabF6OA9v/5Dtpi3YOgqhDzAT72mJRYat9rS4JA=; b=UAiAfS7AXSl9KxLy
 vEUpzbidgXolvBSGbVAVDiMUcywD7E8g/xelkhGobn7UC4zFD2wegrHfxtZe2Ax2
 mrE7RU6Vqn/cnr8y2lDingpzlh0Li9qzaUsGaDZN+wwX3bvsueKpnuRpeQnlHmKq
 8oTDKZgM4J+dfacJMFeQRYhVFwgCzxczhtug/FKD9VtD3Ox06Y6Xn1dOg6VIuZmZ
 z0UFNkotPAVfD5zyAUWadBfH4+whx+6kO2DedAmr+0pKz5BWduhCGiKO0O0WQggp
 2qPAyXkHUMkR/fRTcg2WptOgHI35SiE8dPIj0JRcNTce5l8od3pSZzvWtlhdTDtT
 iiKDIA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfs48c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso10637395ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159060; x=1778763860;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6pPTtabF6OA9v/5Dtpi3YOgqhDzAT72mJRYat9rS4JA=;
 b=jN1XEG0cILHnJrMlyzD+k7nWygsbI1YQ+xStRYD5wNXh/oBD1DzKq6QkRG5itAt6vf
 AK8DYHWY+P2U08+LexRarIu6F1UDdXLVYlPa87xkFexF7o0wfM9/ryF4UqbMtKT9EWZ/
 NZinZkLQUPK3fnLNdpdv7DAPvUiCmVFCITbLS0IBfgNVsDYA47tzpdwJPsKaCd7HChiO
 2hCeXfQN1CWGAQ2BZ4F0seVk7lDOcJ20GqMrHAWRkNOYTNR/nvt+WT1sPZaXJREG6stC
 hpvCHkMKku90g7zsHjk1GQG/cqr9e/9WXTGGojHhU/aVtoU1+kFK7ZUDEH1Ibw6U6vnt
 dw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159060; x=1778763860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6pPTtabF6OA9v/5Dtpi3YOgqhDzAT72mJRYat9rS4JA=;
 b=VKafN1XsvvnJmfUhR7ZhK80PnIrS/0Ef/MvRkEih2kuRSL3nF6o9mZXto4yuUrbERC
 c99URvqQzaRwjQvI146ceC5k3aPXWwnL1MbAstytK06M2PfXAsGc3/tktv7rx+6gMjvl
 SOCYvUoFmtywOFdTGTOjRPn9a9XFpbUElFQc+aNH9x3/8+WL5bAWlHi0N/yzRUhJVR54
 Ya6dL2i07kNZMmA2t8Hdy7CZr9HQCMiGq9JPD1i4lID6wi/pjNSrMfsbuS9QhYtnZfiT
 SmJqYO6Jp6iQ15SxvyTSZTcydQAPoJjUJfC5DlTqX30bcro5O4eEkiYAS62QJxzWKsHx
 2E3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/w3xJ4p4ZTMrnO8heSdtIaGtdkiBclXdBzhE6/uZX/yFvo6yWAOfKNyJES4AlDLgaTSCYRK+eJb98=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXg8Qncr/tucmis3dNYEiuWEfsvNdLliRMDj/Aq5GpG+YuE3dv
 snr8b9bNJZECvXeOM+CqEunxWu5ODxWfkDcIjtjRJOicsjraM/YuIUwVPBAykt8wmoQEwbdUm3z
 MHggkM3W4BId6dimPvFicDQY6Sw/OYRNYDaRLbE+SXmilBKdxtObU7H/u9YNzhQ3mS5NRud8=
X-Gm-Gg: AeBDievUGj6RF7QtiAg6AovT13fx+MyJ4SdmC6agnVHjbpmPuAmqhStwmJKSrtSIHud
 O5TtLoVMMR66yrqf1Bp/c3XHZ6rov8vdN3PQJpyn3BESZwmyf/gmiO3+tG9UEO/dvQd+bOmHVKF
 mA6s3qKXpzB2tjD2eWPKwOnFaXpYVRhn6zkQTv8c+1kEsPGBJStHyGfTpMqAjSELYx2792VH2+r
 hpBzlHFLO+T9/apgVZSgMyEnuGfQDA8y4GsfBRfgsuEjt2twNLF3DMclkLVZt9jBOBKyX4RU7Ll
 HrP+GgM+QRZHlMtVbktIdolG5rcAHsNsJ1s14RAtU8GWzsABh8XubZZIsjnn2TjGppgzBexeveY
 Lrmo/RvcHnRNlqn6pzcN+ISmIpFYuwEVNnC9G+/f3ed8adKqsZGlsDnwz98VbdsD+7Xi46GxJ71
 SfdYymxvAj/LY2IeXvd0wyZkxMHkw3z/LM4GBGX2QQLO+5GQ==
X-Received: by 2002:a17:903:390d:b0:2ba:bfb5:9b9 with SMTP id
 d9443c01a7336-2babfb50f3cmr24843065ad.7.1778159059635; 
 Thu, 07 May 2026 06:04:19 -0700 (PDT)
X-Received: by 2002:a17:903:390d:b0:2ba:bfb5:9b9 with SMTP id
 d9443c01a7336-2babfb50f3cmr24842145ad.7.1778159058842; 
 Thu, 07 May 2026 06:04:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:21 +0300
Subject: [PATCH v4 25/29] soc: qcom: ubwc: drop ubwc_bank_spread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-25-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5607;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ELfSfo30Xq2szDKMHs49lszh5EmDwoOzMcxayrSn7iI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2IcTMhxTq2oUuXpm5Li7mlEyZ5Nr/PM6smi
 UoEdM5tyUyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNiAAKCRCLPIo+Aiko
 1UKzCACMTOpnFjz+6rQTWxRwHu/yhRdR8qZNoL3cqc3zSjWRqxL6EgLacUWyQymv79MkwTKn+a2
 7Mi0JH+b2XTo9wQkHQ7+7rimjiun2iAKeNQf1ez4edCbb7P8oHTfZc8kH3lmy38k0+kZWJ5vmlH
 EcHVZFV2+jqC1/Ne9b5fSGGfJgwYxzlDdT/iSbGPKWpgAPRebQ+G/8oLTQL4tyTNJ8l8ZKkGuHX
 zer9jVBe4xZ3JmtysK4QBtvCDAosCZvXvdYFgNV6C9ZTgzAvamDVerx+CZFBNq0eddTOHHfVrre
 SHz8zOkE/hEEPbQQsvEH3rnINZ/ic87tw/6NcQQsd9gP03ji
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc8dd4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VGmcmSc_WkMUHOMtpCQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX4exlZeigbXOy
 bcp/gBFxxePn4dQQsBcKufcjTU0pqULzJeVX+n104T5FZIHnnvY0uBPnMvDXAvRRLFtDAMLUTl3
 2k5gZEqfILHm1N8SfkH0tYfBlj24DfoAmKHnA4UAwGajcRlR6Bu61s9a7hRLiMKCH3Rl2Kg+QkL
 NlnVF6y0Ow8uHPs2fMkKgAXXywMy4k5GSjOGALQFqnLdSMzMn3mTgRz2FdtIDg6CTrcHX5ugFbH
 ka4v14zw2VijrZGqBC5H+VLlqbTDh+2yYWrtPWaEnmblnen8bghq6cnPHl17iNLQcG1Ny0p+zBU
 uwgJSpE+vLkN18PU7zhhzTflNzpfm4jrNE4BRzZ8JS7ZnYUNuuskvzmyHyElN+JTZ8WaFJmT/Ly
 rzX2BFzD8WeScRC8w30mZm2z8pa7/DyfnXkT4vkkFdxJ/gqO+7PgjcDykM2qCIlXxb4XaLvHFH1
 BzFbYZ22+iUVs5YYcYQ==
X-Proofpoint-GUID: JW_ldHtPsuxrpP2lsC2JDus8BgUn2x-f
X-Proofpoint-ORIG-GUID: JW_ldHtPsuxrpP2lsC2JDus8BgUn2x-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
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

