Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B011CD5BAC
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93AAD10F0CB;
	Wed, 20 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="og5KHyzs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NdNm01of";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA1510F0D3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuSFd3680286
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qTpfvQmHC1O6sfmESwNnfLVFbxTN4AmdIuk7ii2SPpQ=; b=og5KHyzs3y4W5BY7
 n9XHxpkVpLY9YoB5rUQIn44v81HCB0RhlMj6k6sEwC949N2cvk9JmLCF5ZJuJIiQ
 Jx8KBYMNmMYZsrzq8dhkRQI68uiO6hzuxMVwLQ2amzaUmlhGV80hvlkURC1aIiRT
 LfImx+v6Y74ZPa0AuAl4/JV3lg1iipP3vT94Pom8URvQmU7LmDsRwJIeYxlI5cqU
 x4DVevW7NBRbDbsKAeWuBgbf+rPQXvpGZBvnKaHbXD+fvS/qyd+8OyycB9ivhRyj
 HcrtClFOiCZJFpY/eq0KcaIReLL7hzAgBXCcuETn369PZ7V7+WwoQnoEbgrEolA2
 aI5Clw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j07rn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:13 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6312aa1d7adso3926846137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288733; x=1779893533;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qTpfvQmHC1O6sfmESwNnfLVFbxTN4AmdIuk7ii2SPpQ=;
 b=NdNm01offgSwwLk2jGCVFkve6PeKAdolz5sBDL5dA9RfSbkG9gt5c5FE3yG/ir13KK
 hJKGULSLDGa4ZCMZzK4VwJLzeL2XtE7WZ7pXb3mTeE6e+t0I1gnU5TQZM/Z75Qt85rIh
 7rYvAXKO2h4McsXnxKJmZgr83HQ6thO4iITs9Ke1m4dhJ0cCulkhHxlPxRIZs4JcPlX0
 oGjRnhgYiIT7um4hM3Misme3ynjBdp05RAMUW4VLHL3yI8meieDLqh6rz+rL6dZYn+Vk
 8aKdfmTeqTYZQbPz7C0oqP/52VKYcjxXKQQtAo/dW8wIxke6YfJfPSSbvdf5z0jaECJi
 laqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288733; x=1779893533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qTpfvQmHC1O6sfmESwNnfLVFbxTN4AmdIuk7ii2SPpQ=;
 b=Ljley4owAkPrlmxVL9F3TuH9P23rkNsuvD7f9T+/+vvdvqu++xrkpZAnWP5L/NTsNk
 zuemdkdCnr49Eoh6xsJPFpj7roXv7nv0ZNIU7nZLlDeHEXte/zWpY/QQERuCQ+vmuMpy
 LpdyPuDGQXL+5RJlzV/i1q6Z08ooCvzCDs1LZ+tFVZ/R52uyD+xqjJ5YljPhMgAQNEf9
 9x4o+mmcaAQpyFo/66udVdpXCWnFBMy1PlWABbW0wd5WllFwyWuO9DvQheCBqGaeVaTi
 Co1s8FPzf1EU7BmsN6GwO6H4ZA65UIsrYvGYqlvVN4z8UR4CWUclWjRFdMmowp7FmbMw
 bcQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pbQEs0CO1drKhhDrkbgk6yqHdYMO3SfCILXExRFNM9TvFa3kBFCdgWbi9DJyXbm9qhErSwZ9o+OE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBaLEl2OL8tbhHmX0lkccvf3X56PdpvJ8ECeHlHSiw3QFgC8y+
 5OcZ0AIjE3Qn0H4pN33xGin9qEz3enRgZ720XhIGwNpsitDytrEo+H9aBOqtf8LXXl0iAChEBiK
 RApXMp0QQO8u6/O6Jj9aHKya5/+YO1Dr8QGngbPAOOOQfp39LYmB9UiLIWPgMVndWdy0e7Cs=
X-Gm-Gg: Acq92OF6pcFsKJVdOjmpOqTlKnLR5OX3Oo2vvs2xOGW8LAa/HpUyKYxtxc/DrVhNrnI
 /Znm2g5SPYgzJcvti/2zTk+oovzAWBdoMbXIo1TwnfeZRBwGXQaE5iXvir6EqEjldvuiZa3YBZo
 xZMgM4Kec5GOeBlwpobLkpLLGPB9PPojx9rbqW9gSEtMTg9Y17qzscUhbouk/IKSIqG4Lf3HhMG
 j/sdLzp4uPngbyJEi2Pj/mArmXrs5kCrmm+juouIbI3lnd/wf+ejEFjvqxsemzWgV77iWZWG7yn
 QATMxkK2Y2WYwOnJ1w92gaZOfaNOw40XSS6AtSdf9ug/dTTHuc+q7XjEKoGk3EZjpz524Xqq21A
 mV9p4WsvbByR46xfAhnDV7usZNSkgUgB8CVqQ/yA6Kmed64L569JVvMyynl3Yq5MJZyNoeIMIGo
 RAoVKqCHP4dUs0jAj15i+w3BSx7eW8rEuKJOU=
X-Received: by 2002:a05:6102:3a12:b0:632:425e:85eb with SMTP id
 ada2fe7eead31-63a3fb8f7d9mr11822953137.21.1779288732760; 
 Wed, 20 May 2026 07:52:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3a12:b0:632:425e:85eb with SMTP id
 ada2fe7eead31-63a3fb8f7d9mr11822711137.21.1779288727496; 
 Wed, 20 May 2026 07:52:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:52:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:35 +0300
Subject: [PATCH v5 28/28] soc: qcom: ubwc: deduplicate UBWC configuration data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-28-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11634;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7QAzgQCKghkMJSlTASwV4qFK8Or9Ebb07E1C+n2779c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpqblli44p3O+JdL6m0+GZ/bSS3IYHZ/QYJK
 B9GyjT0eJaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KagAKCRCLPIo+Aiko
 1RC7CACDx2T9yR5Sfjt6lijFQ2qhZI5joMoC7pKUu8Zvlc1xmwBt2qkldEAJ2V1j7tpwnyIF4ri
 o7X6CoCaYqzkAg2JkWXlvuNTMllBaOpMT9WpJuiOXS889PoW78c1YMLok1xopuVoW8x7hjWCbC4
 UgGif1lsEgOE/ZVhPwr17x11TUe/Upi4rNHEw3bdyIVpsP9g0oEzmCMQ+rNblJjy7s0jOKFI3G6
 dQHGhjneSXsF8GmCoNg3EPSf4ZOu/XCZes+10yZgChvhPiTFCHrrPEb47f8CczIOKF02188R4n/
 wPBqP9Jmqi2RsU70lmtsGu6b1BmKPg3HsoYU1IiinRi0sY4k
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dca9d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EdS0WidbVIiCbvCQNVEA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: zPTfKQWtGUe_rtDo5ZBRoxUTHIJ8eYg5
X-Proofpoint-ORIG-GUID: zPTfKQWtGUe_rtDo5ZBRoxUTHIJ8eYg5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXyoRZXDl4g2OZ
 YZ6w21srIzKqQJ2r3E1OCuqk6YbeNmpZLGrmSz9RygBZFz33V+ry1+aWwIc61pauy4j9I0bjuUZ
 V8vQPfNr4PCtFbt5Ss0xWCAd6tt9Ukzd8nWPBeEG258BYkI7t47feSLYgEWjT9dK9I8DiSpE+je
 +MjPOVMISNkq0H9viDCmwzeQa8PM0ji61c6M4rxEcHUo650ItXZEiogzB0SWwkToyiiOziJQJRW
 GazQuv22JPOJ4BZXYDT4KtVqpcvxPGHms4JvWtK1MJDUmoSf0e27lxcOZEtKjJg7Johyet2zDUE
 VlQePzt2yHnnRgl8ARk9cNSc+e5Ct9BUL5nlfiqynlCmAFHo0EjgDuK0Cd4o/sZKuDWyVJargbp
 1mYWqfPVn74rVv56YRCNRa8Jw69vw2KEwUHfvJbrf9tjjvnFgDyT9Hsux5i9kBX/H852Nuo3rQN
 9qUfoT7txXsMg4JZbLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200145
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

After removing all extra entries from the UBWC database it is easy to
define generic entries, common for all machine classes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 196 ++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 120 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index f27440d5c06f..4eb115a7fc50 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -16,125 +16,81 @@ static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 	/* no UBWC, no HBB */
 };
 
-static const struct qcom_ubwc_cfg_data eliza_data = {
-	.ubwc_enc_version = UBWC_5_0,
-	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
+static const struct qcom_ubwc_cfg_data ubwc_0_0_hbb15 = {
+	/* no UBWC */
 	.highest_bank_bit = 15,
 };
 
-static const struct qcom_ubwc_cfg_data kaanapali_data = {
-	.ubwc_enc_version = UBWC_6_0,
-	.highest_bank_bit = 16,
+static const struct qcom_ubwc_cfg_data ubwc_1_0_hbb14 = {
+	.ubwc_enc_version = UBWC_1_0,
+	.highest_bank_bit = 14,
 };
 
-static const struct qcom_ubwc_cfg_data msm8937_data = {
+static const struct qcom_ubwc_cfg_data ubwc_1_0_hbb15 = {
 	.ubwc_enc_version = UBWC_1_0,
+	.highest_bank_bit = 15,
+};
+
+static const struct qcom_ubwc_cfg_data ubwc_2_0_hbb14 = {
+	.ubwc_enc_version = UBWC_2_0,
 	.highest_bank_bit = 14,
 };
 
-static const struct qcom_ubwc_cfg_data msm8998_data = {
-	.ubwc_enc_version = UBWC_1_0,
+static const struct qcom_ubwc_cfg_data ubwc_2_0_hbb15 = {
+	.ubwc_enc_version = UBWC_2_0,
 	.highest_bank_bit = 15,
 };
 
-static const struct qcom_ubwc_cfg_data qcm2290_data = {
-	/* no UBWC */
+static const struct qcom_ubwc_cfg_data ubwc_3_0_hbb15 = {
+	.ubwc_enc_version = UBWC_3_0,
 	.highest_bank_bit = 15,
 };
 
-static const struct qcom_ubwc_cfg_data sa8775p_data = {
-	.ubwc_enc_version = UBWC_4_0,
-	.flags = UBWC_FLAG_DISABLE_SWIZZLE_LVL2,
-	.highest_bank_bit = 13,
+static const struct qcom_ubwc_cfg_data ubwc_3_0_hbb16 = {
+	.ubwc_enc_version = UBWC_3_0,
+	.highest_bank_bit = 16,
 };
 
-static const struct qcom_ubwc_cfg_data sar2130p_data = {
+static const struct qcom_ubwc_cfg_data ubwc_3_1_hbb13 = {
 	.ubwc_enc_version = UBWC_3_1,
 	.highest_bank_bit = 13,
 };
 
-static const struct qcom_ubwc_cfg_data sc7180_data = {
-	.ubwc_enc_version = UBWC_2_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sc7280_data = {
+static const struct qcom_ubwc_cfg_data ubwc_3_1_hbb14  = {
 	.ubwc_enc_version = UBWC_3_1,
 	.highest_bank_bit = 14,
 };
 
-static const struct qcom_ubwc_cfg_data sc8180x_data = {
+static const struct qcom_ubwc_cfg_data ubwc_3_1_hbb16  = {
 	.ubwc_enc_version = UBWC_3_1,
 	.highest_bank_bit = 16,
 };
 
-static const struct qcom_ubwc_cfg_data sc8280xp_data = {
+static const struct qcom_ubwc_cfg_data ubwc_4_0_hbb16 = {
 	.ubwc_enc_version = UBWC_4_0,
 	.highest_bank_bit = 16,
 };
 
-static const struct qcom_ubwc_cfg_data sdm670_data = {
-	.ubwc_enc_version = UBWC_2_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sdm845_data = {
-	.ubwc_enc_version = UBWC_2_0,
-	.highest_bank_bit = 15,
-};
-
-static const struct qcom_ubwc_cfg_data sm6115_data = {
-	.ubwc_enc_version = UBWC_1_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sm6125_data = {
-	.ubwc_enc_version = UBWC_1_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sm6150_data = {
-	.ubwc_enc_version = UBWC_2_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sm6350_data = {
-	.ubwc_enc_version = UBWC_2_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sm7150_data = {
-	.ubwc_enc_version = UBWC_2_0,
-	.highest_bank_bit = 14,
-};
-
-static const struct qcom_ubwc_cfg_data sm8150_data = {
-	.ubwc_enc_version = UBWC_3_0,
+static const struct qcom_ubwc_cfg_data ubwc_5_0_hbb15 = {
+	.ubwc_enc_version = UBWC_5_0,
+	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
 	.highest_bank_bit = 15,
 };
 
-static const struct qcom_ubwc_cfg_data sm8250_data = {
-	.ubwc_enc_version = UBWC_4_0,
-	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
+static const struct qcom_ubwc_cfg_data ubwc_5_0_hbb16 = {
+	.ubwc_enc_version = UBWC_5_0,
 	.highest_bank_bit = 16,
 };
 
-static const struct qcom_ubwc_cfg_data sm8350_data = {
-	.ubwc_enc_version = UBWC_4_0,
-	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
+static const struct qcom_ubwc_cfg_data ubwc_6_0_hbb16 = {
+	.ubwc_enc_version = UBWC_6_0,
 	.highest_bank_bit = 16,
 };
 
-static const struct qcom_ubwc_cfg_data sm8550_data = {
+static const struct qcom_ubwc_cfg_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
-	.highest_bank_bit = 16,
-};
-
-static const struct qcom_ubwc_cfg_data sm8750_data = {
-	.ubwc_enc_version = UBWC_5_0,
-	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
-	.highest_bank_bit = 16,
+	.flags = UBWC_FLAG_DISABLE_SWIZZLE_LVL2,
+	.highest_bank_bit = 13,
 };
 
 static const struct qcom_ubwc_cfg_data glymur_data = {
@@ -149,61 +105,61 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,apq8016", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8026", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
-	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
-	{ .compatible = "qcom,eliza", .data = &eliza_data, },
-	{ .compatible = "qcom,kaanapali", .data = &kaanapali_data, },
+	{ .compatible = "qcom,apq8096", .data = &ubwc_1_0_hbb15 },
+	{ .compatible = "qcom,eliza", .data = &ubwc_5_0_hbb15 },
 	{ .compatible = "qcom,glymur", .data = &glymur_data},
+	{ .compatible = "qcom,kaanapali", .data = &ubwc_6_0_hbb16 },
 	{ .compatible = "qcom,mahua", .data = &glymur_data },
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },
-	{ .compatible = "qcom,msm8937", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8937", .data = &ubwc_1_0_hbb14 },
 	{ .compatible = "qcom,msm8929", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
-	{ .compatible = "qcom,msm8953", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8953", .data = &ubwc_1_0_hbb14 },
 	{ .compatible = "qcom,msm8956", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8974", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8976", .data = &no_ubwc_data },
-	{ .compatible = "qcom,msm8996", .data = &msm8998_data },
-	{ .compatible = "qcom,msm8998", .data = &msm8998_data },
-	{ .compatible = "qcom,qcm2290", .data = &qcm2290_data, },
-	{ .compatible = "qcom,qcm6490", .data = &sc7280_data, },
-	{ .compatible = "qcom,qcs8300", .data = &sc8280xp_data, },
-	{ .compatible = "qcom,sa8155p", .data = &sm8150_data, },
-	{ .compatible = "qcom,sa8540p", .data = &sc8280xp_data, },
+	{ .compatible = "qcom,msm8996", .data = &ubwc_1_0_hbb15 },
+	{ .compatible = "qcom,msm8998", .data = &ubwc_1_0_hbb15 },
+	{ .compatible = "qcom,qcm2290", .data = &ubwc_0_0_hbb15, },
+	{ .compatible = "qcom,qcm6490", .data = &ubwc_3_1_hbb14, },
+	{ .compatible = "qcom,qcs8300", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sa8155p", .data = &ubwc_3_0_hbb15, },
+	{ .compatible = "qcom,sa8540p", .data = &ubwc_4_0_hbb16, },
 	{ .compatible = "qcom,sa8775p", .data = &sa8775p_data, },
-	{ .compatible = "qcom,sar2130p", .data = &sar2130p_data },
-	{ .compatible = "qcom,sc7180", .data = &sc7180_data },
-	{ .compatible = "qcom,sc7280", .data = &sc7280_data, },
-	{ .compatible = "qcom,sc8180x", .data = &sc8180x_data, },
-	{ .compatible = "qcom,sc8280xp", .data = &sc8280xp_data, },
-	{ .compatible = "qcom,sda660", .data = &msm8937_data },
-	{ .compatible = "qcom,sdm450", .data = &msm8937_data },
-	{ .compatible = "qcom,sdm630", .data = &msm8937_data },
-	{ .compatible = "qcom,sdm632", .data = &msm8937_data },
-	{ .compatible = "qcom,sdm636", .data = &msm8937_data },
-	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
-	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
-	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
-	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
-	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
-	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },
-	{ .compatible = "qcom,sm6150", .data = &sm6150_data, },
-	{ .compatible = "qcom,sm6350", .data = &sm6350_data, },
-	{ .compatible = "qcom,sm6375", .data = &sm6350_data, },
-	{ .compatible = "qcom,sm7125", .data = &sc7180_data },
-	{ .compatible = "qcom,sm7150", .data = &sm7150_data, },
-	{ .compatible = "qcom,sm7225", .data = &sm6350_data, },
-	{ .compatible = "qcom,sm7325", .data = &sc7280_data, },
-	{ .compatible = "qcom,sm8150", .data = &sm8150_data, },
-	{ .compatible = "qcom,sm8250", .data = &sm8250_data, },
-	{ .compatible = "qcom,sm8350", .data = &sm8350_data, },
-	{ .compatible = "qcom,sm8450", .data = &sm8350_data, },
-	{ .compatible = "qcom,sm8550", .data = &sm8550_data, },
-	{ .compatible = "qcom,sm8650", .data = &sm8550_data, },
-	{ .compatible = "qcom,sm8750", .data = &sm8750_data, },
-	{ .compatible = "qcom,x1e80100", .data = &sm8550_data, },
-	{ .compatible = "qcom,x1p42100", .data = &sm8550_data, },
+	{ .compatible = "qcom,sar2130p", .data = &ubwc_3_1_hbb13 },
+	{ .compatible = "qcom,sc7180", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sc7280", .data = &ubwc_3_1_hbb14, },
+	{ .compatible = "qcom,sc8180x", .data = &ubwc_3_1_hbb16, },
+	{ .compatible = "qcom,sc8280xp", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sda660", .data = &ubwc_1_0_hbb14 },
+	{ .compatible = "qcom,sdm450", .data = &ubwc_1_0_hbb14 },
+	{ .compatible = "qcom,sdm630", .data = &ubwc_1_0_hbb14 },
+	{ .compatible = "qcom,sdm632", .data = &ubwc_1_0_hbb14 },
+	{ .compatible = "qcom,sdm636", .data = &ubwc_1_0_hbb14 },
+	{ .compatible = "qcom,sdm660", .data = &ubwc_1_0_hbb14 },
+	{ .compatible = "qcom,sdm670", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sdm845", .data = &ubwc_2_0_hbb15, },
+	{ .compatible = "qcom,sm4250", .data = &ubwc_1_0_hbb14, },
+	{ .compatible = "qcom,sm6115", .data = &ubwc_1_0_hbb14, },
+	{ .compatible = "qcom,sm6125", .data = &ubwc_1_0_hbb14, },
+	{ .compatible = "qcom,sm6150", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sm6350", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sm6375", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sm7125", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sm7150", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sm7225", .data = &ubwc_2_0_hbb14, },
+	{ .compatible = "qcom,sm7325", .data = &ubwc_3_1_hbb14, },
+	{ .compatible = "qcom,sm8150", .data = &ubwc_3_0_hbb15, },
+	{ .compatible = "qcom,sm8250", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sm8350", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sm8450", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sm8550", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sm8650", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,sm8750", .data = &ubwc_5_0_hbb16, },
+	{ .compatible = "qcom,x1e80100", .data = &ubwc_4_0_hbb16, },
+	{ .compatible = "qcom,x1p42100", .data = &ubwc_4_0_hbb16, },
 	{ }
 };
 

-- 
2.47.3

