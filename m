Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93133CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63B210F123;
	Thu,  7 May 2026 13:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGkqHeF1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6vBnQIZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A2D10F11F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BZ2pg682842
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ldlgil6T6/5NKJw8KrYulsZxvlpSBIcIWd4s+HQX6w4=; b=ZGkqHeF1URW+SCws
 e9IK+7TJRn6F/L5exOtydPHDI2U/ZaVuyWvSDNjjJYtPAImLL5e2y8IDkwZHaBb9
 H5w2Rits0o5L1Ysk5avfwnDbAYcLdeanRQu0qNnSRygjvyAuS4xzjX906Baa+7GX
 shj7zB/8xcOvPDEP5raWDQttkBWDQN7ZkGV7GhE7kfWb9aa1wLDjV9e4RqMOJfY9
 5ZTakvA904rUPyetsdOf+mLrQ4Ly7Toyi0PvwV60zgLlIvrK0qbodJpsiXZY+Ayy
 kHhTbO679wHBG3pcapmLQz34OZV3mJe47y2j+PLZ6J7uCrKxH7B7bKQ04USEc90m
 2/5e5w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhasn0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba3245a43dso9377835ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159043; x=1778763843;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ldlgil6T6/5NKJw8KrYulsZxvlpSBIcIWd4s+HQX6w4=;
 b=c6vBnQIZGwYeJ5zAoXSoLvennMl8x5sxJdfD/Hd/cYLDnaux9/xRsZxnrr4wCX5aKS
 z1mTKVq0fU7zWgFfDwnIFYASFbXuOpZta+daTxlLqK7QZ59W2CRjB6Ikvgi09tF1F5iE
 9hhjHsyBphaHC5B03aepFcye6YlWuFeyPcUsBhLIXhumBM5qxBTiA3tNboAeI9Ass6z4
 6xJ/SiZgeOGkZcmlUz56MKYdiLBXFKjUHHRA+gr0Isk11ra1gdZuUsfqNvcOF+Qq/E9Y
 f2s9t3xLCNEHlRHVU4DEl2agQxJjP1q9eN61We9XEeH5gK70k3bdHDya13/kqWe+2jXp
 lDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159043; x=1778763843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ldlgil6T6/5NKJw8KrYulsZxvlpSBIcIWd4s+HQX6w4=;
 b=X2Wh4mGUK086TNWHkk4FGFgEzfvSfttIcVR+SYfBUmgtGKcO4W/bXFSb46Wh1Jlv0p
 NnVgpqHJtn8gq9+TwV+2846wEpc5VR9nYSpoDpqRKe3r0W67P3Vw5cyBdbr90iBHoUaa
 QvANvdVmjF3XU4VQA8J5m6sBC0D0jtPOt2PEg803okEtWIrSghmwLQ844itpg+KRBAas
 rWohlN6yMNUIVvX1nd6BEf/Kg3Rm0fYE1ucgZBs7pdcIWyAaE0SLpTpXGrWAEqrQFL9g
 vTzUWoCCV0b039Jy8lX6tY+OJMNsllJiO0ZZsvJbGMQX33+QaKRvL6xU6mVlHCVyYh3+
 PfyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ89pKtuCfRZ2xI1qOfP1JOzAu4PbmrBppwSEH4X9hpZFm7DSSwfA8sHbcZFoEuV57ZJ+4ry4c/Z8oA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVFnfDC9vDyCNrclKFK4+lTsUXHGoPAh863Bx95sHn+yojeVbN
 sfDU3auRZbdPpGH78V/oNqiM+PiG9RACZYz2gkTqgygglXB8I5yuH0rw0+vVjJAlSbEZN8ZzUWH
 KjJPExl33rA29HRK6uylt7XX93WICeum/1AWVlCzdWG8AxWrm4nc8VRfpt9VifauJQrZfJI4=
X-Gm-Gg: AeBDieuX/116Zjx96pxa7IAnkSCGiFHKRSRAhMSQn7tuWI04JuVWNp1yXfWyFMyIURL
 utiLYrNbGlj6fIqTrG9tmtBrhYbZE5GRhhyiSdXS4pvzWEukqWqALIGowI62jZpXAnc1miNSknv
 RV1trkcwaqvpgTR1CMH0OIz7v+CTTtw0VJvPdtQdJ1Mw0l7XMXZMThPbv3MOz/f4ZbAyPljIZSa
 vI2kFvoJGAIUS/KgbgfI5Ryh1x8ad5CcUe3ow+GI0nV2oxEIKvGpJmOkGTZr8enFH5DToQ7rGz6
 LJdqg/Q7H+QT1xfln3Oajw/PFKoy4nPmn+5hBk1HukTdHBdW+qD7GcijWfkE2TgCtwyVvDOKoma
 QdEEAYAEfu35OfI/8Bz43M2ic3bV9++mLqDDJe0ABTWHE1xTtSJfPzNlXuBr285Ee6sMu3kEp+1
 GjNooxD5ycMhvXAHLKn7fjEfl7PI715i82PaD0bgpFnfc1hKBn6QWxkQ9h
X-Received: by 2002:a17:902:e98e:b0:2b4:5e65:5d0e with SMTP id
 d9443c01a7336-2ba78c40260mr59501255ad.10.1778159043037; 
 Thu, 07 May 2026 06:04:03 -0700 (PDT)
X-Received: by 2002:a17:902:e98e:b0:2b4:5e65:5d0e with SMTP id
 d9443c01a7336-2ba78c40260mr59500525ad.10.1778159042416; 
 Thu, 07 May 2026 06:04:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:15 +0300
Subject: [PATCH v4 19/29] drm/msm/adreno: use version ranges in A8xx UBWC code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-19-c19593d20c1d@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7nrYY1d9un3JHGJyq3BRJ2z/M2VzjkpGLEXSGdy8WNA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2HFV4iNIrPevcsyGW3PsJzGnufpXhvHluG9
 3Ff4QHdI3GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhwAKCRCLPIo+Aiko
 1QDcB/437NhF9MKKW93Zd05HQPiicGhTU0u6hIPpew+wfkTAC4xq4RwTh1ts1t189E9zzu6VKar
 tW+jE/Bo4MLyoAjJmlMAyprUwA0p6rWl0pgjYNsd25R/FfA8cx6XywsVi6CLTM6JXP1/7nM1VJX
 N21pjP9hgGrVg5J2H7F2dCVWkn4fjK69vxr3q03fJFSiug2T678vJRKJI7oS4d0WHl8XQbbNCZv
 YxRtg3UX7IBa739UqCGDxo6M0dFFz2oDQ7wxVVhlESxhRljaCQr16B554hxXHXI1tMMvm7s7Lc4
 9bMW2hILye+7e8SSFqEzQOdveSaT83ye8L34Wowi2XpNoZ7o
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX0Rhapubuo/Mq
 72OZRahW0cY2nURm/NmgbOuudVV3pKm34iHtF1L32sR3/+GMsw+caLq9I140CZCqz/7uxcnHWlH
 mwULcPqKordpZuP1cDjJmyFi8vbaqdO8NH+5h2tjWumj/r6BI+i+Pds2HjscjT0UQOCbcuvrAs0
 ITydXDOzSVSuGfAZAYZM050/t6KU/I8qf4xtldY3rNwX2UxjhUZCGATzOOmOEa0BtXClYUaDmst
 QqrCCX1ZLNL58bAtYJVyr623antMd2UdzPp5E/erPzIKyp+P25VrJ7YO0zm50qaC/ySip4WN5B9
 zBARJA30fzcdaBuPfvAkiuqq6H2Ii4TY5lw11/ulmXvAqScg2IOhoCdKl4MJ/qi/nEeJ5TNJQ/E
 0rXTSbX76we6DBSuEoJkyCPSEvCbcTKWReEsL100CCCCvNnGiPdNTW6LPjitkE4aGJ19JTkBlag
 7ue1/pTyNpD3+JGTdzA==
X-Proofpoint-ORIG-GUID: --bD1Xj9k_NWlfTsYMiquH1hKw4fqWB3
X-Proofpoint-GUID: --bD1Xj9k_NWlfTsYMiquH1hKw4fqWB3
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fc8dc3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=gyY6hpWVHAyQZ-18BSkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
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

In order to simplify handling of UBWC minor revisions (like 3.1 or 4.3)
use version ranges instead of a case switch.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 5c73a9ebb22b..29d559fe4683 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -286,26 +286,24 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 hbb, hbb_hi, hbb_lo, mode;
 	u8 uavflagprd_inv = 2;
 
-	switch (ubwc_version) {
-	case UBWC_6_0:
+	if (ubwc_version > UBWC_6_0)
+		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
+
+	if (ubwc_version == UBWC_6_0)
 		yuvnotcomptofc = true;
-		rgb565_predicator = true;
-		break;
-	case UBWC_5_0:
-		rgb565_predicator = true;
-		break;
-	case UBWC_4_0:
-		rgb565_predicator = true;
-		fp16compoptdis = true;
+
+	if (ubwc_version < UBWC_5_0 &&
+	    ubwc_version >= UBWC_4_0)
 		rgba8888_lossless = true;
-		break;
-	case UBWC_3_0:
+
+	if (ubwc_version < UBWC_4_3)
 		fp16compoptdis = true;
-		break;
-	default:
-		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
-		break;
-	}
+
+	if (cfg->ubwc_enc_version >= UBWC_4_0)
+		rgb565_predicator = true;
+
+	if (ubwc_version < UBWC_3_0)
+		dev_err(&gpu->pdev->dev, "Unsupported UBWC version: 0x%x\n", ubwc_version);
 
 	mode = qcom_ubwc_version_tag(cfg);
 

-- 
2.47.3

