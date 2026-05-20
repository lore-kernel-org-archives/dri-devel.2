Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6DFCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD6A10F0AE;
	Wed, 20 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzLKe+vl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NAQR+MLg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC7210F0C5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuSTm3680282
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EeHTbSP+g4o90DbKwuWwTMbeBF1qG02mPQpIYK/H3Bs=; b=HzLKe+vlJOGdZFCb
 PsUFvUy93hCDj9crUMpbjlJd5sdNZ3Pp4WboHxbc7KXc3X5F6RGLaPiTan8Aqz7F
 hEpips7DK+NAcbYZ075BXGNz5xIzH1K8/YsueZVKCf3mBw8ySqYIx/2TN+1xK+rj
 ubFX08/gdi35SZYUlykbBrk19XhijWNVqVygiEw3RN4tHsL4rY4AQfxEdSyvPOEA
 dwggpGhmqxz5yM20HLB0zsHvzF/p9WyKLsy5c5PI5+K+S4/zZPSp5IBhcm3Oscw0
 YyfI6AwlBEBAqh6yzuT9AopqGpogJZ1b3AkDjR3PaSJ/j1PA1lF9yWvxoa/r+9Rl
 VhJcqw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j07r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6322654bb6eso8495422137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288727; x=1779893527;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EeHTbSP+g4o90DbKwuWwTMbeBF1qG02mPQpIYK/H3Bs=;
 b=NAQR+MLgZDurNlVoZ/VlKQQmmSDGYFSRFn9MjXumANENSqiNjNz0HA5pRHSexx4sTS
 FR/1KB2eo1fCr0Cih22nETvv+5zjBtjPdKPG2guXB4IGSI+PAveem1L/ahfIRRXCCJkc
 cKXn6sHxt9ZVcPcggN7i2qFinVCCW0v2ot0sxjkkypm0DqOETIqYvVaw/hfjFr2eOghC
 7OpvAHGsZvDAQoPGl//qOuEdEBEsZJA+lsOtiaNzztReooA6z5UkLi/cyus+UnFdanMW
 4GbA81hiGRz8idTBAF3Fb4yi0ZCvF2Ctyi3O/HmWg1hgpsugPLXFHC3u5kqDRkuPBxN6
 d6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288727; x=1779893527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EeHTbSP+g4o90DbKwuWwTMbeBF1qG02mPQpIYK/H3Bs=;
 b=mBzIy6kNIRKTVECfb43QkPrQu5sErKIMvrCn8XAG5xuVBfmwFmbgGwM8l/ZfsexdDJ
 bccf5KKygWPMU8DqcIwwoLh7F7mO828VrUDjPTm9zw+HhDetUXGlUn1255t4NmS/WP/l
 6hMtDnFAaPOaO2xA/bytXu54I3onB0ls5IVhHPF4uA3Tn57+TQkY3BgkyiT3p+1spUVF
 s5FXD0rfgSE+J2XjkEtAt4bl/P+OL8FYdxUe4tmovk/pEGhRts9x4YBasIqXxQAkSMYo
 k7Xw67Kjt56enlH2q9vpWGGer+Apq2IMvs02zWGROgEVUwZCaG6upA/bvBogT19OViy1
 JIkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zq2MaZhaaw6sdkx/iB+FSUW8J42XkarhsVaeMRZlxyFFAQhvPJabMTuCIL/kLVRcckA9Go9swTMs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyF3Dzuy5nVHNaAXHChkD209tK9kfkjzCGK+QGarKTgextPdN/m
 HhT5Y28KaQcGKVjVSGXO6w+sSD5V/cc4Vi9XnqcNgNCg9+3ZiTSKlTbF7jlxc0PlcCxZ59vuond
 he+/kPrlZaLDW8YyIQyA9YgYRy4dwggOjdWG+8dBGmXDwuJlj75EIl+t7K1FwgGXeKQ8Gsvk=
X-Gm-Gg: Acq92OHI+lsX/0nAt6oOvD9/oV/qtEMoJdcY2FKKdVbjCtMlgwq3W9ZlNUpaxJ1/2nS
 8QOZDq9bLB5T2LJUe5mOXFHfOJF0xWbQQLyxKnGHecWub1XOSGiprvr/h8usPHELHPIHYMvhB7F
 skXpPW3Cg2TPylbG1YXalIBTEsWjzHvpZU/wI/rmKbEPE8EQ37zRHwNdhvCPYPnCj2/9wbCDFG5
 dzzOW75UWELDH6Hiyk3Lp9RdupicMlu3Oj/KqI0OAyh863HbTIcr03k+HP/tfffMcKaNtq0lEyX
 Sy1Cj6Rsi2YbADRfmKVcMzp53RLnLYYRfdEEjVzd2eBsqmpZ8ft6bexFEC3P5QLjW1yGoXmS67m
 aHchH3XmqTYK6ojmLwvTCTWTDldYGcq4lD3cFQd8LMLuhjFPkAKHvA9qYafg7mmjBWXKps/RNLL
 Iu7qX8qf18Ltw2AuitscCLC7SRW7v2PPpvr5c=
X-Received: by 2002:a05:6102:38cd:b0:631:ff40:22b5 with SMTP id
 ada2fe7eead31-63a3f38e58dmr13009425137.21.1779288726524; 
 Wed, 20 May 2026 07:52:06 -0700 (PDT)
X-Received: by 2002:a05:6102:38cd:b0:631:ff40:22b5 with SMTP id
 ada2fe7eead31-63a3f38e58dmr13009406137.21.1779288726059; 
 Wed, 20 May 2026 07:52:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:52:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:34 +0300
Subject: [PATCH v5 27/28] soc: qcom: ubwc: sort out the rest of the UBWC
 swizzle settings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-27-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4424;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=U6uzzgGbS8qZWP3kN5JzxaiSGepe+XDiW2H9yAY88hs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpqm9uACE6Obeqjp7N+IiijUm9UF0rYlM7Og
 kL3bWw+u/qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KagAKCRCLPIo+Aiko
 1ZMgCAChjWiZb+ZWT89KSax71gE7IS+zhHDqNg2IFQHu3tGtb7ho93TAWmauYXh4ZBykYhPJZ+F
 HQ75JL/YdzvD2KRT0/nBZmLRI9SR/4yTetmbqNFshgjVv+oCtmKz9ICnVyIedeb438Fvm2XjwJX
 i3Ocz7kbB3A4pzMyFzLflInl3gX768nK7vgQTfn25FqxXL86kuOGn1u5TgkMd1IucIveAqwheDM
 fhVZGCiVGhCgdOl8+7AeYw1sqhdt/J2wQYuoor+c11U+yTQMHxh2GywwO/B3DKUvNgX/EkI8gxz
 UTxtzEmD2bwf3Ypo4B0gPr3LDpqpqrsOB0QaaTaRsSQm5ecP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dca97 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3htL6sknLGLhwEng4zIA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: icOoXgnZpFvI0TNyrQlfL_DIzCykvs0b
X-Proofpoint-ORIG-GUID: icOoXgnZpFvI0TNyrQlfL_DIzCykvs0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX/yIDW5UDVJfc
 4SF1ToDzrwrWCmzgEfFK0McLYl8pOWPK69Mgcn8r7759wWPeltRsqGfW7BD6FabFQQ1dNTK9RxV
 DT4kJRlKMzko1Fw/SXtzNT+93EQLM2ikPK5NEPPxa64FNpy4Nw5oH/Fg0eZl6xKyNapBDzu8MAG
 ranxOoXTAKIV+meQ5KFSaINIeVG1Fx5k0UF7Dokps/QwBsjl4ZgzoLzjLeqEa2sdcHe9df/5AxF
 TweTkeNkbmeCYwrxWd2LPNRhDGiz1Z9eKMjee9xNSG1k0nU7EJO0FnBgwi9PA2cruq0ReSJXmO7
 vjeCGmKtE41hqo8Ad4UhiOeU+3CUCGZ2+NBcMNvBq1u2r8V65rih/Z956It+WJrVQPjS5fNxrx4
 VAcEnj2fR0xIYY/x9ER5+NvJTKp0ganYInVyv7kWn7SMPXJogOjrVqLdEHzN54Vygqc7Fx3lkfy
 6XEcsOcpOy7JhekxSmQ==
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

Sort out the remaining UBWC swizzle values, using flags to control
whether level 2 and level 3 swizzling are enabled or not.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 16 +++-------------
 include/linux/soc/qcom/ubwc.h  | 26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 7e321389a399..f27440d5c06f 100644
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

