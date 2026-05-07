Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD567CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA0610F115;
	Thu,  7 May 2026 13:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAT2o7Fy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fe56tY0n";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924AB10F115
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:30 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AGtkd879589
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4qvxpoQH2bQDtPLlCKngSNqf1Sqrv1yauYDlLuj2z2E=; b=jAT2o7Fydhfp38/1
 bxu/JYB/3nMY2RtJgEByutw9KgcXpuUyeaHeYt1nZdR3zm9RZejBpyLbhcYA1mvD
 1Oy0JtznyiaFV9zOgtFmyumY0k+k47upz3xBC8Za7PRdBCwjlxocidblZ0/9uXLB
 hnt5LvUnM+Kn++L1jIt57Xko9riY7A0YMgyxF7SOaFZ6x+ksrSGw5CQviZhacaxv
 ASdpCE4WphNKsXozJ+i3Dxe1LQGTq3TGQ68icvl4B8rKtGgonuEct4LwUFvE6wXL
 bP2Bflf035n/Xu/XzEz7eMMnFeSKy4YoyJgI0V9JyU9CUS8dM/byy8ZROxrEn8pE
 ksKwxg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1vg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba6fe41283so10315875ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159069; x=1778763869;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4qvxpoQH2bQDtPLlCKngSNqf1Sqrv1yauYDlLuj2z2E=;
 b=fe56tY0nmBBSqc5EGvRPR9AP1KW6R561jQGPYkE0OlZhES8WVBw+1V3j0j2OilYylB
 2MljNomAylZ4BOUp2g/6J16EdXdUSuEMiWhXAjFOHjDEWVB1g9hpTqA1SeD5p/4CSiZa
 XxGFZurBdcWeJUZ/Gp5WrAAoRW49faWQEfsxenfpQwa5cAeGV0mV4Czn2G8JeLoIH7wr
 TWe0Al7MO8LFvltHpc30JcxkJMhkiovZskUfmw3GnYp+eDRffCCSuOlF9cWnDaGKb28o
 2hzjCV8nwMkXDU4KoN8ibpH6M+Q2oI8TY5jVpkh5svMzuClWtrcKwNOuTm8XVBbhqCmI
 HD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159069; x=1778763869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4qvxpoQH2bQDtPLlCKngSNqf1Sqrv1yauYDlLuj2z2E=;
 b=BoOsuGko3NTYLzi0XI7Vk+Y3X51Hee1htzfM22VgbtOQEC+ncu5R1V1BMVXk8KFeT1
 V4STjfXzdU0ugs8d3yf9UxicaksOJZt8QHyd4DAZe/6nxYyuB+DNB/IMy7C7v9JWwRKk
 GXTCTP45qGHPWOtfkhmUTyN7L60Il1tV6ArtFDEfycrZLVkmwduRryGu6Y3LQktsmbLp
 N2NfHYHplsTe/+ayga6AQqW+jOwQHnqwbdSL8fADNktR76r+A93wEHW1Q+9ega4byae2
 /z3CqWyLL7nDDsm0cF7L7ds7N8lMxY7LvHwKTrBtWCUTMa4Dtesf0/DvJMyCON5dElZ2
 jQcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NnL/fBfVCzXN8BuzVDvCZn/rlhZbE1IKzr7wohxaMtpASq/aqTH9AIFEtFEhrxaV4K4PRECPRfbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyIhwhvCHdE60Shc9wDlA7C8iyb+sb4xdLDhv9i+/YVwSqK8Fx
 1H67F8k+CjcS5VoZM07iHX3VPAEqT7otj7n4pDn4KswNH5q8ICxedwMa8Q8nk4BJVMcRaCCDkcN
 CAAGv7zIXGTh43pxfuqyX61dmo/mjci/PadYLOXVviBAs7uh8jAb2wIOywLL6D2oCKdutCHU=
X-Gm-Gg: AeBDieuLnUPJ94zc/GlYlTjfmp9Wh3mCDflUsDSMRWcMqu4ZFYRK30Q73Iahl17ZwvC
 bUAl1yIh36YkyPDXgsnNsa7K80rp6T4mqhdTQ+7wsx8PPi4WiJrp9DaQb2MiGLLRM8y6ySLFcvc
 +OtIPpff7AURNUOFpvrieePcJlLSXw3GQpFThYS2OvsselDaJiJ69qiRcTuaUaL5cUeI+aii5td
 atTGUNmpQ/0yiylBLULenSBUbpktWN09b1lMPSnPNcibzD9EMl+/XmvOxvbbU8dkpakEzHQrQRc
 e2y8lGe++QJWi9k45EPea2PKUbAcv54fLRI1H8AjHcjKcRCbHYGUq/zCd/rjesLJzMKUP6d7Pa9
 rdte+1T6lxb2THAWuEzSvEtzLY6cqge2bClRiMF8xRFDL5nKZ4NgYoWseYHOeE5xTrmqTD7hrDO
 bM/hzZdhOgU4rhF7lkXpIqxJI0YV7NFV2RtVAsXIg7uQSYQg==
X-Received: by 2002:a17:902:ebc9:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2ba7928e644mr86459825ad.15.1778159068384; 
 Thu, 07 May 2026 06:04:28 -0700 (PDT)
X-Received: by 2002:a17:902:ebc9:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2ba7928e644mr86458955ad.15.1778159067613; 
 Thu, 07 May 2026 06:04:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:24 +0300
Subject: [PATCH v4 28/29] soc: qcom: ubwc: sort out the rest of the UBWC
 swizzle settings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-28-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4424;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gvMDo6slYGiqJv3R26vftFLiDexyE8LeQxJKV4S7Idw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2Id2NKe/WGj9GWDX+yBm6UHibLIS83qp3aH
 ga0aLNmTpCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNiAAKCRCLPIo+Aiko
 1fjmB/979mhR6QqIm1YCLdRJ5GbJ1Hc4YUqVoo0XetJAndmbFzBLdLfvJjP46SjkIYTlNPz0OuA
 ABe3Hei0V2jrMSqVWFxitVIl6LKoV4EL5vf205bF7/fnuRNH6x9dKrWtjHEkOKY0mMAlzZHRjbC
 3+rnl2+1dwlVvquF5qRF+nmc8uSsCq/ZENw45MeDkTDBa8WjyuNL+7hLij+Y+bMiLAV+mDa7zCQ
 6NX29CRaa5TIq6EJ0nr7161es1HeBUzIrKis1Y2+L3LJm10kL7l8NsQJqps9/PRMnBiFYFvHo8x
 OYu9z0hwCS6/EE/7lCV+Jr0R2LUDGrOQCSpF1dva0Mf3RhUS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc8ddd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=3htL6sknLGLhwEng4zIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: EtMV31HCe7SSR-2Bgj1SxpLfSva1sGGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXw8BQybd1E8b6
 70SnRB1Cft5Ft9xtNNaGpbCnB0hs5IpXOkc9XiY50mRHP5yVT8vtzsEH6cK7PCHTZkM4lWDkiqm
 AEgXibZbP/bO1WpnM4kESd1Rx5cnHW6GUwk9YmjqOhv1Rf7BCCi4qNhVyQadkZJQEi/Lmk0Qma6
 4r9haq6SGmQMmGr9eEmR3NDNX429pflxin3rNNOc+UdhnDTRmEWH9NMWZI61xvH3Wygcv4PYIok
 0pBQ2dXLzu+NaWG5zKAZbxIZDd/u1El/1EFHuloQB7d09+89hPqsEqshM5IW5KWhj4lw3AIsfdO
 wttOElWJ7P1p2HFJgbDnhoyWhTt+frEvxXDG0cVKUXjB4sERJPIWnsszLg1FshKlmtUhh2r8sUt
 oX+k1HzGc9pxXJIYJL6PwC0AvCrZPxxlK9KdHAHSQ2JsEKs19nda2CUabS6U6K4WEUi1DrvgObT
 N1DLXshIibZiaYdzijg==
X-Proofpoint-GUID: EtMV31HCe7SSR-2Bgj1SxpLfSva1sGGh
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

Sort out the remaining UBWC swizzle values, using flags to control
whether level 2 and level 3 swizzling are enabled or not.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 16 +++-------------
 include/linux/soc/qcom/ubwc.h  | 26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 2509aed0e743..e9a6063e9297 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -18,16 +18,12 @@ static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 
 static const struct qcom_ubwc_cfg_data eliza_data = {
 	.ubwc_enc_version = UBWC_5_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
 	.highest_bank_bit = 15,
 };
 
 static const struct qcom_ubwc_cfg_data kaanapali_data = {
 	.ubwc_enc_version = UBWC_6_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 16,
 };
 
@@ -48,7 +44,7 @@ static const struct qcom_ubwc_cfg_data qcm2290_data = {
 
 static const struct qcom_ubwc_cfg_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL3,
+	.flags = UBWC_FLAG_DISABLE_SWIZZLE_LVL2,
 	.highest_bank_bit = 13,
 };
 
@@ -119,38 +115,32 @@ static const struct qcom_ubwc_cfg_data sm8150_data = {
 
 static const struct qcom_ubwc_cfg_data sm8250_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 };
 
 static const struct qcom_ubwc_cfg_data sm8350_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 };
 
 static const struct qcom_ubwc_cfg_data sm8550_data = {
 	.ubwc_enc_version = UBWC_4_0,
-	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
-			UBWC_SWIZZLE_ENABLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 };
 
 static const struct qcom_ubwc_cfg_data sm8750_data = {
 	.ubwc_enc_version = UBWC_5_0,
-	.ubwc_swizzle = 6,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 };
 
 static const struct qcom_ubwc_cfg_data glymur_data = {
 	.ubwc_enc_version = UBWC_5_0,
-	.ubwc_swizzle = 0,
+	.flags = UBWC_FLAG_DISABLE_SWIZZLE_LVL2 |
+		 UBWC_FLAG_DISABLE_SWIZZLE_LVL3,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
 };
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 7c9506741001..a7372d9c25fb 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -14,15 +14,6 @@
 struct qcom_ubwc_cfg_data {
 	u32 ubwc_enc_version;
 
-	/**
-	 * @ubwc_swizzle: Whether to enable level 1, 2 & 3 bank swizzling.
-	 *
-	 * UBWC 1.0 always enables all three levels.
-	 * UBWC 2.0 removes level 1 bank swizzling, leaving levels 2 & 3.
-	 * UBWC 4.0 adds the optional ability to disable levels 2 & 3.
-	 */
-	u32 ubwc_swizzle;
-
 	/**
 	 * @highest_bank_bit: Highest Bank Bit
 	 *
@@ -30,6 +21,10 @@ struct qcom_ubwc_cfg_data {
 	 * DDR bank.  This should ideally use DRAM type detection.
 	 */
 	int highest_bank_bit;
+
+	unsigned int flags;
+#define UBWC_FLAG_DISABLE_SWIZZLE_LVL2	BIT(0)
+#define UBWC_FLAG_DISABLE_SWIZZLE_LVL3	BIT(1)
 };
 
 #define UBWC_1_0 0x10000000
@@ -98,11 +93,16 @@ static inline u32 qcom_ubwc_swizzle(const struct qcom_ubwc_cfg_data *cfg)
 		       UBWC_SWIZZLE_ENABLE_LVL2 |
 		       UBWC_SWIZZLE_ENABLE_LVL3;
 
-	if (cfg->ubwc_enc_version < UBWC_4_0)
-		return UBWC_SWIZZLE_ENABLE_LVL2 |
-		       UBWC_SWIZZLE_ENABLE_LVL3;
+	u32 ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			   UBWC_SWIZZLE_ENABLE_LVL3;
+
+	if (cfg->flags & UBWC_FLAG_DISABLE_SWIZZLE_LVL2)
+		ubwc_swizzle &= ~UBWC_SWIZZLE_ENABLE_LVL2;
+
+	if (cfg->flags & UBWC_FLAG_DISABLE_SWIZZLE_LVL3)
+		ubwc_swizzle &= ~UBWC_SWIZZLE_ENABLE_LVL3;
 
-	return cfg->ubwc_swizzle;
+	return ubwc_swizzle;
 }
 
 static inline u32 qcom_ubwc_version_tag(const struct qcom_ubwc_cfg_data *cfg)

-- 
2.47.3

