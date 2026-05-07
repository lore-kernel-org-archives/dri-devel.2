Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BED8CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C0D10F0D3;
	Thu,  7 May 2026 13:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VUMptlAl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z7+Pjan1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1210410F0BF
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647A4PSa879573
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X6KUz3wSpH7ohTMCjp5EmeujJBZNyid0Bpvz882EV38=; b=VUMptlAlo1TVA70F
 61wpVKQ1v996U4LqVu2BBGgtvmovvg0BYn3Z2NxLU8fCqfS6CDyK1kCDilzXTkCT
 in7QpARgnigAnGjcMfEMkxqplib5EPXRzOCRXpqx3Lkkw2LeCIRv06vKsKvVAvTu
 TWQwaWd/A1B1i3NljhonbJia70FJGEMlVTYzcrZBXq6lITkoEZZR8WSozUo4DECd
 I/SqRugFuZqwbGalVaisugiVT2PP45ERn98ZMTH1dgBDIvt5LtqW0YnPJGzpTMLh
 bojmZiF8jYk++nZwFV6/1t3HONfvoUH8oD2HxoIcfuO/3qxNooG4Zv2raG67sjlg
 o1bccg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1v84-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2ecc96a9aso9446495ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778158993; x=1778763793;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X6KUz3wSpH7ohTMCjp5EmeujJBZNyid0Bpvz882EV38=;
 b=Z7+Pjan1gsRCnez8O+C5rWGIOLh2sk2U+LBDlIZuw9a9TH0V2OwzEI9F3OxAh5tre4
 vjsw7ihxc8ryG7JXNC/X7v2M8joNphY+HGFtEK/i08lKO/sBKCOHdbvS1Ta87RlUZZsh
 buRO1PPctiZ6hYvchsdME+GexWrxpJDf63BOELiqUbr+G7IvNN9KYHQd8avaMogTZJRZ
 yVEYI5Eptkx2taYfP4j9LdbfpBNSEfaax9RI0DAfA2QQSjTejr+JIViVN5FqPNF4oVs1
 IzvkmhYpa6dgscM1iG/u41wLyB367qyfzcy/Gt9tcRSi9yuw7QdXPiqO04IWiQuxy22a
 5JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158993; x=1778763793;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X6KUz3wSpH7ohTMCjp5EmeujJBZNyid0Bpvz882EV38=;
 b=M1y1udtEp57y0lyCd0du3WByxsZFQvDOauExalu5t6cmV2TvHUyIItu+vHXKs92v1e
 T2mYl3LztRUZxLF6npCeKlasps9DqN8J6yS6gDP6GnCVRsVflwGjvDe1FtK00TKeby9E
 WMk9ittWkeNse8mC8ch9FZhzUhEqkTVXcUCJe5hFQgqH02NKd5eDA+NjZ/eAmBKtAimp
 /OAMx3TuhSsVTkcvrW11bD404rULs57aEyyADSxBJA5A74LQ+pHuwS91IHwpWuiZR1WS
 JBycyQXy69nyRFXhKmXRQjAJA9GTPhWXEsZomdcbPPSBR5pXzNOGmoKKm3iBtr4nX72q
 RiYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8az44x3XRUKSQuCQaH3FvoCWP1BPSTBlY7ZEBgCOUV5Ab43j7/b5sDD2c4E6ebsGtqJERNQvcWwRk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZIRYzEvJh7GTxeKA1pYG5xiZZVCyFK1WboVdg4xlWWVHwEvRZ
 BJU5EzH/GIsccAs1HuaxuznMaV1VbPu6/h+76owp8tK1NBWXA8Hng2nGEcu9FU+DJIcPQtypLdC
 Giy/QAx+NeHksekG7lXot7CsIOzEajLq+jz4VtRQVRQ5OOTkrX7Xe2evOi5h1ayJG84a4plw=
X-Gm-Gg: AeBDiesQhv0Eww851/8MTxUb4UBlk3srTx57CwQQ3wAzToJ2LzxqP1ClVCFX3nRqe60
 irJk3FXGvROgciw8Aiso1V6hMhGJIwWp8/Apy44oXAduGV6zKsGR6zOEyShGzSE2cXTfPT2On2U
 AktXXRxkYD2w1oCf1h7TS+13s5J2sSVSX1x57G1W65EDqVxkX9+epG5wn2G+xdrRS1iJ7mjFWX6
 AKlFstFWH2AAgskw2Np/T6Z8sAL26ZR5I8mWJALr3XEAToX6As7/AkRtwP6f+rw1vden+HJwhIy
 WHGWLrFk+6mCY5IV9Q73XL9Ty2Qjv5jJD2xC1tENs1XEaNgDkN24piPJqgJKGYRBwnJK115M4tW
 4skrjaVzbl/hQpuJa0MEl15iWW0jnJETXX5v+QMZSEq2chkB6rGdr2PDHISrTlfdxEpSeipbTsT
 FN5smhgt8rgBlEy04AQwn0PWq8ILgTkcah14nHX+u5mwBkng==
X-Received: by 2002:a17:902:8c82:b0:2b7:8a56:7cda with SMTP id
 d9443c01a7336-2ba79285cc2mr58205355ad.4.1778158991388; 
 Thu, 07 May 2026 06:03:11 -0700 (PDT)
X-Received: by 2002:a17:902:8c82:b0:2b7:8a56:7cda with SMTP id
 d9443c01a7336-2ba79285cc2mr58203655ad.4.1778158989667; 
 Thu, 07 May 2026 06:03:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:02:57 +0300
Subject: [PATCH v4 01/29] drm/msm/mdss: correct UBWC programming sequences
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-1-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6675;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kozu0wunncGvYwCG5EH0ZsQjFu8nlXDiqIvydxEUX6s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2E/+1U6HEdnE740NkmOXVyfKbayNLqAo9yZ
 Dtd+73Xiu6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhAAKCRCLPIo+Aiko
 1aSfB/4gonTvop5lJAUXSXXvIwDUphUXziJNTZU3Aa3tL2ndJdNPg5yB86gIYa3ZH7nfKERX0Gq
 PYhZ+jF6MQhuZTSvCeSc6C64q+XyI6xxqBnsOSaiINkjZ3d/zcqNhzOJjvhsi2I8p95Rwjk0YH2
 WgR6HxMikNQyGdZpkb2q0aWBqVJBhIAe8TXpV857f8HbqwIVx+Irovjx8BjcUA2vVYQzPPUQ+9C
 BwYwvfaJz2d/PALHzUfNAS3tPa/du6C/5kyJL7FWUQRez4J3llME/b3q6uztt/rx69oKN3VJgOD
 FjIddyeP7h0a88l6C9H40Lnoz174Kr5cI8vIo4vUYeTAzf0n
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc8d92 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=hQCg4X1xv2bm5S_WMKMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: VYWzXos6p40CyY1TZouFP53UMKle-wBc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX09JNIAjDlIpN
 Ct2TVyKI/tf6E9hDszaeJGkQHUO9uMkDh/9VINzYomf+vmRPjJeB7fw/Mr0LdNcPycxPoB4389p
 wP5RS0i6TVkChUlx606xF//zIKLo0O2qEDJD6+C/rTYUDUepmltf0oL1mroYw6t92TldcBCxo1F
 b8uEl0sEYEM3dt3JPfSwtcsHE4LhnLfXKOX/mAnw8HqHZrGK0rnnKag+930F6InLVNMUlRpGw7P
 fNh3dspZwfAyoaVqpS2jmzEKwzdx8Cb4SbrHnivbYT0Lg6VRJQccvi7QoiN9gAEXbpZsJgOgbp2
 b2nqvNa1+u5kBXdISQwE4TCohvNFj+jJl7IJe0NI85LpUgyFcAaosu8QNSz7HqayetJtszEDGy4
 DOoM5o4xWL8QR+pmaT9KVwC5it4YI2p976LdQjcK/gKNtGG6OJ5INqpeZAPUEXPToxAqswrfBc0
 XWDmGq5WRJH3xp2cVxA==
X-Proofpoint-GUID: VYWzXos6p40CyY1TZouFP53UMKle-wBc
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

The UBWC registers in the MDSS region are not dependent on the UBWC
version (it is an invalid assumption we inherited from the vendor SDE
driver). Instead they are dependent only on the MDSS core revision.

Rework UBWC programming to follow MDSS revision and to use required (aka
encoder) UBWC version instead of the ubwc_dec_version.

Fixes: d68db6069a8e ("drm/msm/mdss: convert UBWC setup to use match data")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 115 +++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 90c3fa0681a0..4a6acd468bc8 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -166,22 +166,19 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *msm_mdss)
 	return 0;
 }
 
-static void msm_mdss_setup_ubwc_dec_20(struct msm_mdss *msm_mdss)
+static void msm_mdss_4x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
-	if (data->ubwc_bank_spread)
-		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
-
 	if (data->ubwc_enc_version == UBWC_1_0)
 		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(1);
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
 
-static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
+static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
@@ -199,11 +196,12 @@ static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
 
-static void msm_mdss_setup_ubwc_dec_40(struct msm_mdss *msm_mdss)
+static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
+	u32 ver, prediction_mode;
 
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
@@ -211,45 +209,42 @@ static void msm_mdss_setup_ubwc_dec_40(struct msm_mdss *msm_mdss)
 	if (data->macrotile_mode)
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
-	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
-
-	if (data->ubwc_enc_version == UBWC_3_0) {
-		writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
-		writel_relaxed(0, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
-	} else {
-		if (data->ubwc_dec_version == UBWC_4_3)
-			writel_relaxed(3, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
-		else
-			writel_relaxed(2, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
-		writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
-	}
-}
-
-static void msm_mdss_setup_ubwc_dec_50(struct msm_mdss *msm_mdss)
-{
-	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
-		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
-
-	if (data->ubwc_bank_spread)
-		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
-
-	if (data->macrotile_mode)
-		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
+	if (data->ubwc_enc_version == UBWC_1_0)
+		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(1);
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 
-	if (data->ubwc_dec_version == UBWC_6_0)
-		writel_relaxed(5, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
+	if (data->ubwc_enc_version < UBWC_4_0)
+		prediction_mode = 0;
 	else
-		writel_relaxed(4, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
-
-	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
+		prediction_mode = 1;
+
+	if (data->ubwc_enc_version >= UBWC_6_0)
+		ver = 5;
+	else if (data->ubwc_enc_version >= UBWC_5_0)
+		ver = 4;
+	else if (data->ubwc_enc_version >= UBWC_4_3)
+		ver = 3;
+	else if (data->ubwc_enc_version >= UBWC_4_0)
+		ver = 2;
+	else if (data->ubwc_enc_version >= UBWC_3_0)
+		ver = 1;
+	else /* UBWC 1.0 and 2.0 */
+		ver = 0;
+
+	writel_relaxed(ver, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
+	writel_relaxed(prediction_mode, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
 }
 
+#define MDSS_HW_VER(major, minor, step)	\
+	((((major) & 0xf) << 28) |	\
+	 (((minor) & 0xfff) << 16) |	\
+	 ((step) & 0xffff))
+
 static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 {
 	int ret, i;
+	u32 hw_rev;
 
 	/*
 	 * Several components have AXI clocks that can only be turned on if
@@ -283,43 +278,15 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	if (msm_mdss->is_mdp5 || !msm_mdss->mdss_data)
 		return 0;
 
-	/*
-	 * ubwc config is part of the "mdss" region which is not accessible
-	 * from the rest of the driver. hardcode known configurations here
-	 *
-	 * Decoder version can be read from the UBWC_DEC_HW_VERSION reg,
-	 * UBWC_n and the rest of params comes from hw data.
-	 */
-	switch (msm_mdss->mdss_data->ubwc_dec_version) {
-	case 0: /* no UBWC */
-	case UBWC_1_0:
-		/* do nothing */
-		break;
-	case UBWC_2_0:
-		msm_mdss_setup_ubwc_dec_20(msm_mdss);
-		break;
-	case UBWC_3_0:
-		msm_mdss_setup_ubwc_dec_30(msm_mdss);
-		break;
-	case UBWC_4_0:
-	case UBWC_4_3:
-		msm_mdss_setup_ubwc_dec_40(msm_mdss);
-		break;
-	case UBWC_5_0:
-		msm_mdss_setup_ubwc_dec_50(msm_mdss);
-		break;
-	case UBWC_6_0:
-		msm_mdss_setup_ubwc_dec_50(msm_mdss);
-		break;
-	default:
-		dev_err(msm_mdss->dev, "Unsupported UBWC decoder version %x\n",
-			msm_mdss->mdss_data->ubwc_dec_version);
-		dev_err(msm_mdss->dev, "HW_REV: 0x%x\n",
-			readl_relaxed(msm_mdss->mmio + REG_MDSS_HW_VERSION));
-		dev_err(msm_mdss->dev, "UBWC_DEC_HW_VERSION: 0x%x\n",
-			readl_relaxed(msm_mdss->mmio + REG_MDSS_UBWC_DEC_HW_VERSION));
-		break;
-	}
+	hw_rev = readl_relaxed(msm_mdss->mmio + REG_MDSS_HW_VERSION);
+
+	if (hw_rev >= MDSS_HW_VER(6, 0, 0))
+		msm_mdss_6x_setup_ubwc(msm_mdss);
+	else if (hw_rev >= MDSS_HW_VER(5, 0, 0))
+		msm_mdss_5x_setup_ubwc(msm_mdss);
+	else if (hw_rev >= MDSS_HW_VER(4, 0, 0))
+		msm_mdss_4x_setup_ubwc(msm_mdss);
+	/* else UBWC 1.0 or none, no params to program */
 
 	return ret;
 }

-- 
2.47.3

