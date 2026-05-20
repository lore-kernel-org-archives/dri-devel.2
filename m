Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517BFCD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0C310F0B2;
	Wed, 20 May 2026 14:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uj5lADhC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aq1pDEWP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA7E10F0B9
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuZTs3680433
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SHppxJbIcnxAbn5e5BxkZY1HBroOaNwMncF5FMMJzNI=; b=Uj5lADhCgKZb1LaT
 D7zB9BClKwWbn05PR90+3hViJ/HU5K+8mWgMA6bYhecEEEuwtQscJmhyi9p6k31Y
 TDtguLgTNDw0mMfq/0zH1+LEJ/IuTMHdUSUerBakr9mbiPB+TzUhYj0w7ctG/g/m
 mCVHpNOe7E3aBepVBrqSXPCwN2Kv2zkXnMmsCFz4ZB/pxHmwFh3idfdQtdojL9R3
 e4Cm4Ct/4F8UpuaY4C4jTnDP4ourA7uzONJUuJUwZbcYhEQ/N2gH0CTj229drROg
 xL2TLmt5rGQW/IK1rTxyHuXJovUIfL+KOJGWkHT1YY5VVZb9RpYV1ggfRzmVzWNp
 C9Wt5w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j07p5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:44 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-956732444ffso9368190241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288704; x=1779893504;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SHppxJbIcnxAbn5e5BxkZY1HBroOaNwMncF5FMMJzNI=;
 b=Aq1pDEWPTS+wALSxvgeAg8NLFSFpyqTbP7phqD99cL0ssaLik+84eIlP9ZWZHeByXd
 nyIgccICGoCz1dvvATftj9jVzzC0/MtFU9yB7/Cn/9BSDy7WG0GI4SfoU+peK4X3oWeY
 Dmn43CBEvlYE78wOBliqIj/0IT4C6FDlrRNJ8diocsynUpPylvgZMlqDdUQ6xpdMtr1F
 x8lgIPST9E2uRrKpozPnVslNiOH3uRN/EK0QywTDkJcInrM2Z1pVQ3kp/YWXIwiP0SJ0
 OXnUHUA3M4650LOIu/rtINM72jK4ZeXkiBIoFPmdSnlOnK90x52bndoEmUEvd+ia0QHH
 TRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288704; x=1779893504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SHppxJbIcnxAbn5e5BxkZY1HBroOaNwMncF5FMMJzNI=;
 b=Lj08B4BvvPV/48etJZQTXssd4fDKF3SPZCPxh6mAXQQLO0O0Wmb4qADLE6edrrG7Nt
 RR7Lv6mGmj3EE8jOQ0OnOU0Vy5EznjvshIl59600t+u8m3UuMAuhN5nCHyKd3DWjx30N
 zjgC0AIu+BlGbfgSRq+DOJFAig3ykxkc6YrGLlyCs2CZkSdKxmU+pt6VaEIKzwQWMHGf
 nGDwXDaBWN7fupvxIsv5gMc18aKwt5VxuPfJKtczotpdViu/PgyMUPEvEjtfeM8RW7pV
 vmgjXIC1GIbtFLRIhu84oekyCPevsxwflgGQYYFQTkwQIrUOMb0OC4WJOmsvF2H+JUqC
 8zcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JGi4kpqCMCRahxeBX6/y5Cz2KQPhbGQ90h95t3xdiwkdAtS1NPYKwo0rkKZOgUVxqUfetDtIk7rk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxafK638kkIw0TgfD7E5DFymPfRKkN6AeukuXmY9a4TA12wxmb
 +oJgDtA8rSogMA981WKzd831wwsf9Hl3jetyRcqnGUEukE5+zmgbV4jl3PANh9LAsWRVAC1nRkf
 pIbN9SXupDDx5vhOw6/pKtoceV36M2wxL7gsNhYKMf6WapM1TS96mQOTwzpI368dgvyuJjpE=
X-Gm-Gg: Acq92OFiRIHh1LJj6zAEATK2PEW3hzpJMD7HtwyeQB2ZF0rSIDNcHbC1UwYVq/tDTyh
 ecbbraYbbmNeDEJw7LaH5KRJuOmubQ62OSekdirL2DqoVI/Al33P2NGwln4w59GG3qU/PkPyNEB
 sxEma0huHsQ93CzJ/Tvb/iUqVWdUleOvKK10H38q58GDeunioE+ZRy1/EHiq58EYVIF47yLbezG
 hk8nsTW09lywACAgISQ9Jd7cW5Hpy2TEnC71QRa1ak4nbesaDMVy+wCn/2JwGiOQYoQuVpC+4oQ
 0strXyLPdoIX5Z0QV3r3BhkFbCWGZ5VUIuNtVAYmc/+c/XRiTtqcdIJFsKZFG8gmlF55Yam2iMb
 3aspnyRQdAxsmZH5ed0bc8suKlqb7sLzv3V+HpVt+Mh0F2OQVgsAEbx/dQ1lAQ+V5cKUjicdHnr
 Mh2it/YmVtD5MrVxgbpAbrbVLUSOL5dknSr6zp2sCLOPeflQ==
X-Received: by 2002:a05:6122:3b87:b0:56d:9f2a:d6b1 with SMTP id
 71dfb90a1353d-5760c094366mr14488216e0c.12.1779288700856; 
 Wed, 20 May 2026 07:51:40 -0700 (PDT)
X-Received: by 2002:a05:6122:3b87:b0:56d:9f2a:d6b1 with SMTP id
 71dfb90a1353d-5760c094366mr14488131e0c.12.1779288700206; 
 Wed, 20 May 2026 07:51:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:17 +0300
Subject: [PATCH v5 10/28] drm/msm/mdss: use new helper to set
 macrotile_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-10-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gBDFjN7fs9zNZK1OT0Rge6uEp5iYTQNKw6PU4vljOxU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpn5CalDZqbTqL/Jq1BQ4go8L+gmdNsxQigR
 qilEu7iUXqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZwAKCRCLPIo+Aiko
 1S9RB/0UDuf0TK/Oq67GOhJEtwUfg6VhDxZ01giJdv3bCzs/5SdM0iUFUw5fYTVEIlaZgTk/ESO
 cCUT+jc/4d6rmWvD1+NTnVR10NrN9QxH8NFFjV14yP+I+s8Rpn9TlFr7Hevv/iKPGAciNqLduhH
 T/lAcw+wJi1HwTPm8k0XLEyEpNIYA/PfoNtqii4t2VtPF0kE9j3Fuocdndx5W+P6SA97FFC0WRS
 33D1kw27PsKDJrXyf8bK4RnVcUieLsScjrPPUtghYTIkww38p1WQTOJ9G/AR0/vonPil69JEctR
 abKoE/8hQnyMa1wB5qqhXeHXHcrLb4nSul2DLuiKqylYcCXZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dca80 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ujCctoy6CNRHcyqwK_8A:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: IgJAYh8qoe9A0Grsi9yGe4Kks467oCMy
X-Proofpoint-ORIG-GUID: IgJAYh8qoe9A0Grsi9yGe4Kks467oCMy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX/cKSBD24rDvB
 Rn+pC1dqWV5RAQ24Ytm2NEaHxH6nvZohaUybl05vvMatZK60F/IPTfM/bVCDa0dq9e+ta2S+L2+
 x2r1zqiCkrdx+tCcVJ/fSk+kRnbXQnw+GCP6G/OmRSxMaAjjJsoCVlWHL0yobnsLCM+CjyLTY+3
 hZNCUdas7/doBIZ9tXpp0BMyayGuHAJ3BHbH+TN491YynLSBxoalqHHk+NSgq3vAamLeyMSuNsi
 LmkDkMKY/7TQKFOoHCBd73r5mdFzt2bbfOObs8j7AOOG0WjaA/3kZpq0omhZov5qO1lK7XRn71i
 DZ1P5sT/YfOJfO/CveRANjwKw97sUa51S5A9+5mLPxn+lqAW/KAACG9R2G0grsd8SSbnHmQ1Lyi
 xSpMUVo9YaCeYsnY3CEPkt+a/wKsL4uGUUioxBBqou1RmB92c8w5ZUN/A+S+tOJEqsFuMXS6Sbf
 CVVumcWpb4L2M/3n9aQ==
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9f2b366d45fc..2742d4bb2a4d 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -183,7 +183,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
-	if (data->macrotile_mode)
+	if (qcom_ubwc_macrotile_mode(data))
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
 	if (data->ubwc_enc_version == UBWC_3_0)
@@ -204,7 +204,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
 
-	if (data->macrotile_mode)
+	if (qcom_ubwc_macrotile_mode(data))
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
 	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));

-- 
2.47.3

