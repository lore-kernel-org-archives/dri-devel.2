Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48805CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5CC10F0E3;
	Thu,  7 May 2026 13:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBexpJWU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I41ZiqHp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3EB10F0E6
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AISM4879630
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KrGdZ6Bna8qkROGke7rL/1evORye3ZzPkLd+P26j6Fs=; b=GBexpJWUB7j3H2Vs
 gh0De5AnopuN2Awsfv78GrepAEtx+UtVwH6f+0BxVfE+yzc4YIRxYzS3RCVYPgpP
 zRBPy+gyQXC/Kn71FX7jDnKhm0HcibpjrGTf72eRVLylmEpNFNh3NV90NFIW7Rg2
 cUCs7ATJr7D83jIR37Hyg9GefPyZZwcdE9mJG1thdOXSQdQqhumzJ9F8U75IvDlv
 qyVmFCxfAAjAXj0bSEErYB4AmUkg/MIFmXrgDj/B2qcjdcuXoyBiLKAxCe+OQ+Cz
 tb0opRS3w7OjLnl840wJjxrDkJ7QlMzIrllI/LIro2MHTyxOdDX5omOt9V788W7T
 yh00CA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1v9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2e91add2aso10855675ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159008; x=1778763808;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KrGdZ6Bna8qkROGke7rL/1evORye3ZzPkLd+P26j6Fs=;
 b=I41ZiqHptDeLNvKjquDyieQ+R46RmRwvLt4T65/rJvz8l0LPiy5+ww7oxOHn91TN+R
 lfWXLk/v4QSgnkX+5hNMrJv1cYyPsavWEruqZHNz8uJlbanS05tWB+hn2EMqyui6257j
 NCdrozXmUUGTbJkP5n/VIV2CFCNU91iAv3R9Lu9fNdyN6SezHU66vCanKIBNmL2BmK39
 d9UgJ/vrPo2XWMhVajQ66ZshDF+WyxMPVRD7PMNxEKBJ6/s68TYymDYPfZlkUC18r+Ss
 zXfxx3s5b9hwcRrlLKdHOeexgAltYNdLukUwJwTzc14kZhZs1JJxtTDF51soF0S06zjZ
 goIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159008; x=1778763808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KrGdZ6Bna8qkROGke7rL/1evORye3ZzPkLd+P26j6Fs=;
 b=Ul3rZRtRLLakEj75EU85YVo9nSU/hv8N4kFKIA3LSEF0XdE7fsset6sLcr8KjRp1WN
 1ZMyujyj4x3O3WcmMbNv8w0Z8T3YmzvY77ae/d2+A96NkJxtDYNZ6E0Ufs4x7l84uSlQ
 Y2IYnzuMLcnLAwXjIDEOFKIaxt8BguyTIo222doVBl3tHJ7pbpYUeFDYIRyL9Xeyl4km
 oOLZSNaqhbvDnAgpjnfeB5mcRXgrP6QZp0LzjV/E70aGl9PHqeLEDSpTceU9nJrRNzEH
 VL2fjHUj/OFNBQCtCtrGAdNnW10zeZrXmJUJmmZxtnwhjD6PoRUdRL25BbaoEgYexits
 TklQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ835S0YJaDC2Xq0rZAVu3eTnDMBmyBGOdp6Lna7+UyB3NuwhSrYeQ4xjs6hJBkUgc5i4ZJxaNLpWMM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDp2voD6EVkZlpjP9eKQ0eLUpQ02oaJu5rveVsY7Qkk3olg0ob
 /ioQB3Vy4g2UdU+KVe37fyItI1+ygis/eIeX5wZMIPF5cTBrmsU93lnEM2ZmpPslQJXgXr9VRKX
 Wtz2DHfD79eEN3kL2P4617oYcQ3CFkcGjgMZbGdKemIITIbI/qsFxKoHRlxiHyYqvJmffX6Y=
X-Gm-Gg: AeBDieuUO9kJYtiiffIPmm+31vwxuUUdKbrtivcHMb1jky5a4rK3/RFk7rImK4uS4ja
 rosSIEqrVUGpUnvxYeyQ0z5zhJwGDZ69DyHpeZiTds2v9oVXk11PPE68ImdMN6EnIMsJE0vApZh
 4QxuXwfwbgYeHsikeKbWJFr86xiTVyJLaMYxoj60Qdgke6EWQCwBseEDbu2U6uyx9WS5zodRE7Q
 w8ID+cVuKP6Tc0hSANQzJkplLn8YcqwxN/cBn3ysuHfgQZPMTiIQAp6io9lICL49QP3wTca9oJS
 26rBtcYe0hNDch2G/eTpnAaaIgrf2nHPvxB/p47HtyNHsIV4fUx/jtsJBLgRutKP90PbH6E9kWk
 BNxG1i9o04KBYw2ORAPUK6VEUeTBfcntCJku8QNAaOtm/9mfxaZoFJLQrUVcYtcRb2Mss+P+Nu5
 2y/D8hvDc/K+g4brAM5k/t+4H9vRYYgMaPPRekuwZMkjOXhw==
X-Received: by 2002:a17:903:291:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2ba799d39c8mr77213125ad.39.1778159007529; 
 Thu, 07 May 2026 06:03:27 -0700 (PDT)
X-Received: by 2002:a17:903:291:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2ba799d39c8mr77212145ad.39.1778159006887; 
 Thu, 07 May 2026 06:03:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:03 +0300
Subject: [PATCH v4 07/29] drm/msm/mdss: use qcom_ubwc_version_tag() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-7-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pQcZSLClq75f0H7mdOxTbEo5DpGKFB3n0GBshQz7Fb8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2F69Gf0+wrJZ+PAcIYbdCZBc3bLgBJpG3EJ
 0+hZRvmqt2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhQAKCRCLPIo+Aiko
 1YrBB/oDsZ6AVPY2ZhV7yKScT8oIWVeq2n5oJtdKLpgtIMphPmRL+a82CLnLw1RhBcNnlqpCFlZ
 cNiZPg4pWyklMEENCYwQ+zezrwoKmGcgl4cTjnHxqgOIFMgCL3YKmZQFwUpi/j+l0REimJwbl3B
 8TrPkOFEwEKmz6nOB9FAfEqW2EvPQWmRTqhVdSj0cUUK/2vUYSsktZ+EtBH/iC1TGvjMO8a2bf0
 OwieVYHZIOTH1AN64R2+6rJFspKZ2wydps8vAtybEyf9eVevJAQhFvdjsx/4UaiCKTvvaIOPVKg
 YR/4+lH4qMq8FEgn8ZUkD0Kj4+G9bZZ1xBy20PwJClCsUA34
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc8da0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=qBJULKV797PGQuHHbA8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: WMlkYSlG3x1v8TJUum-ZO7mA_LLz1rKS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX3c+MMQl8z/85
 eKCtzMf0pxXKIaBfo7bJnvNUlAK7UWT//aAwpbaCIuaOVDBb0tx7v/0HP26bxTvDryPubBuvgcs
 Y/HhbygomMQ2yV6O459pgEk6pVvIZyWhc7KMNhH0XEX7WXxnuuaTnei95tA98e3yQOIIdPmv3yc
 0rYRc7SxbywxH5xgiFAdyNvO6N1U+KNEnMTsx3M9XkMZ3vXnC/oUpwnIQR47Bgb9s9itZx46RKi
 qTMBdVOXT69sPX/qv+oHHMYzE8u846XYsmMRCR2519GErtggovo4vY3m7LG/gZPxbD5o3KpEMUy
 ucGNmzBd+eZU03H485qqoDq57/JBiioiF1v9r73JSjsGvE2zjbbtOegE5XTj4LtCXylhLzq2tD7
 vaicb5P8juCUbfeiTgBI9MXJ+fGLd/C+V1guRwGJWTvB1uRPvA2mLOdJOXyVTne4pUA06K/Xomf
 fjCNKn+XmBKw0Xe3TDQ==
X-Proofpoint-GUID: WMlkYSlG3x1v8TJUum-ZO7mA_LLz1rKS
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

Use new helper defined to program UBWC version to the hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 4a6acd468bc8..229b47415f29 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -201,7 +201,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
-	u32 ver, prediction_mode;
+	u32 prediction_mode;
 
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
@@ -219,20 +219,8 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	else
 		prediction_mode = 1;
 
-	if (data->ubwc_enc_version >= UBWC_6_0)
-		ver = 5;
-	else if (data->ubwc_enc_version >= UBWC_5_0)
-		ver = 4;
-	else if (data->ubwc_enc_version >= UBWC_4_3)
-		ver = 3;
-	else if (data->ubwc_enc_version >= UBWC_4_0)
-		ver = 2;
-	else if (data->ubwc_enc_version >= UBWC_3_0)
-		ver = 1;
-	else /* UBWC 1.0 and 2.0 */
-		ver = 0;
-
-	writel_relaxed(ver, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
+	writel_relaxed(qcom_ubwc_version_tag(data),
+		       msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
 	writel_relaxed(prediction_mode, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
 }
 

-- 
2.47.3

