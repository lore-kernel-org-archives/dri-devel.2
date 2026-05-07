Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800AECD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB33E10F0DD;
	Thu,  7 May 2026 13:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IDWHqlYf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpcfzEmU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2517510F108
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AKWwo1669936
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lRizh296idxaeGEPnbWh+8suGLFulwB7M6vVue2aYVg=; b=IDWHqlYf2XmYUPKH
 sJFnDRMRH16Gy9+uC1UG2Y+xpZdJqptWtvg1/qU2c6wgK9s9MI+kkz82w1JdKCQR
 EqVlj3h4fFuOzP7dHm0g/H7DmcMowDcqYzcifr8X1LUfIlkaoKHLrLkXripbQrlr
 iBt1Xnnu+vzdGMVz1VR6MZEnxY3GuHLpqjtjL/BR9plCElaGsouWS7EAhBdPmphi
 tnx2SPEZflzC3qRSSlZXpvcZf3HLd7t6+KRbBhR6Gskl+Ge8D9ulBE+36TZRe7+d
 jXYYNDf/7/SS28Pw5EDlWQK4gR3PO2uAxtF6ugcA2YIQa+Yy1MOEchO4tqe68UnW
 O48HFA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p1xek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b9a3c3c4eeso9504675ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159005; x=1778763805;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lRizh296idxaeGEPnbWh+8suGLFulwB7M6vVue2aYVg=;
 b=RpcfzEmUok85Ac5Wio8aw2vsj5H9+kV+I55m9IBB/Km9HPo3wD+gHfQURAZu/0r766
 3xHQLDmCUS5At+Myf3qyyj0bdlQPXnV6/U611ch5EDs4v/SWWL4agdDUtuHrZMR3+m2H
 zs5PlohGh869rUA9DtGY+MdC6XXmcF/CMU1GNOlJGpbueEbIN2gZJ/Gh4MH+OiDKPTE6
 o0dIDPhJtbBcSY8g6IzVy4wXqvhtD2IudmsRIfhRex62nqJfRI4GlkxYOJwPXCEhQgkt
 I2Bbg0YDJzPuBfw4ptjFOSJLFOsz8ip8zkcVvTPJgMBLTC6n26itqsalP5v21IcmIdBw
 wo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159005; x=1778763805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lRizh296idxaeGEPnbWh+8suGLFulwB7M6vVue2aYVg=;
 b=EJngmFPxAtaFvC+y9uakbsdU2RL9+JeC4AKPVs48OtfD7HjDODjNMpZKTnyVAiJ8qL
 vxH0Pzg3R5B6hcgGOKF1GYKm+asZj1Ob926GplEqwx71YLjrQ3QIDy2PfRe4+rYM5jGR
 8TAn6xYXeP3nRWqA1cHRynvQjIVVXV+EV7NtWkN9rwhPYIv4DDxXuuE+Hbu4LYDZgtzL
 FYbwc9oAvDSVC2OHCBnSBTC8f0WxDzhFUUdQ3B/h3X09+Ps014geuY1HoKra4Of6dNHY
 GDy2jk3xfXM/a+9O53USxzPUw9m/s6xXFF1OBNTaeQ26M43wezXBMOYXDVduVQCn/HkL
 HTCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9agS1fkJZAHr/0+6XyWaotm4bF/UKyA/CE99gQ2UiiC7rBYiqK8lJR985m72SvkYgs+uRpfXnJB+4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2iGRuGXfEhMOhhB9EGO6vbZ7b0GzUkfySWN55pgFV/0HX75WU
 clpkQG549K0Nvs0/CzAqrKdQftHF9IgeH6RGxMT09lMZguvBeeXpuTbxiQaWBgivspyqS7BhIkz
 0o8kLuFu39sIpTylRAoA2M7E541THg2Mb5I8tbXppFevyQgv7z1WKxSxUuEqCeMM6gGRU5iU=
X-Gm-Gg: AeBDiesuu4W1RUnkoaxJ5qci3Al3KVYfk6aUIKfa+gDo6Bon/6HxtLb8ogAoqFUrQvb
 dmbB7qcibc5RCXIaQYSRiACnBiS4wDnmEWH4/PFG0bGs7GxTjDfsx//Lm7zg8qekJskUS/Od0xw
 yIrXLg/J+Vg2eK9X0iK8T1dPKE/SW/rX/d5gPsMieSAjodUtsoNqtrTBg9y4gREtj/mIembGnZu
 3etzNs+GSJzaFENKT5vHtVS1GI3OoJj6se4l8oC3g7scZeTac3rAedHNK4IyEJmxxdJuvEi7mS2
 02dM0MT5UB57guVErFM/ohwpmIej2YYfxyGbQZPVjF4/d0RpY04kTaf/gx+fOE/k9+4JUWLm7mN
 X9Xo7/LbyD9rFlFUe3L6zFES6iprr7Q3CEbcUNqbGH8Q8mQSEubKrghAdzqFn28ZONAk9F2M4aw
 6bg5pnHauwVqbG5r4t2IS043MUuxcPYmY9N9cjlWYQ+hRmYg==
X-Received: by 2002:a17:902:e790:b0:2ba:bfc:76b5 with SMTP id
 d9443c01a7336-2ba78b40166mr83458675ad.4.1778159004361; 
 Thu, 07 May 2026 06:03:24 -0700 (PDT)
X-Received: by 2002:a17:902:e790:b0:2ba:bfc:76b5 with SMTP id
 d9443c01a7336-2ba78b40166mr83457155ad.4.1778159003317; 
 Thu, 07 May 2026 06:03:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:02 +0300
Subject: [PATCH v4 06/29] drm/msm/adreno: use qcom_ubwc_version_tag()
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-6-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=taU2aKAGQBJ6W2MyCZ4bOSBa16fxBG0Rs7Rtqck5Xao=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2EnmzZQ9Ysoo2V1PXmrQNKg0nbhsvvYayiU
 vxiP7NzJRaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhAAKCRCLPIo+Aiko
 1RrhCACrPvBm62tRCkk7HoECYx2MJcGTM/IlTReOG3sDeHdoUQnzfkbAVF9yYO6JRXa9vF998pC
 y6+lGq0kFFtPSew2q9ggzIKfHpWgA9NviJ0EGGsjADx9A0ZJs4Dq8JBoQOQxaYPS3j3G6YClaE7
 lifQEGGfy3UiQjT/Gvv22N2JECkALgXBGCvISbjfjKQ/AECXgCFeumjCcmmQxQ3OkWHqhO+2wVn
 C2UbpoNLvCUB9qwPF+jiOIzA+DuZBuZQZfGDlHvnMy6IWi7rYe+ptPm62Zh1Ioye/RfosCi8zo+
 h4FMml3CgoBS1upR4DTxUoBeK74mZUbwHGVjlig621jDhjYe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX3uY+ZjLO/qog
 owBGTbN6PssWUTOnb5UK/evsFo3sgwFTDpf9xPgabt2TlqaLwTLGbX3dfGY8ti7r5z8XWZAmp89
 FhMxuSYjA/ryN+j52GIOYWtWanaRb1nHhj5ByjamAen2KDEuVVdFr+penMD1eaJEJsJLBLRi8C7
 oujm/8Qv7mKFdyYKQWvxnBuNiRUHTvs17aHXHXTneuDaWyASvXiEBMrdst78oaqBLWbSfYZt8B7
 6FQ6OUXJverOTgyp2IWbyl97ZIGzEHlu9EQQ83Ag3bVHa69vO19R+9OQdEgEcrxzl5DENU2w5Pq
 g+n6BbUpXMRrYmjNS2kRNptdE5tLiDvwQQObSFpjUNj33fwwXFeY2K38EUXD5qHfdQSeF8oQWoe
 gmZBz+ZKfEj7diNHzL0DCvJlOq0LD78Lg5KOvhsJkPuAAZQOiZ+rcoiPMF09hXeXz5CdIoXOw15
 dQJ8DC2+2w4g9iOA0WA==
X-Proofpoint-GUID: XAQ1haVbbU-YGElHBqAuhloI7FM9nbWC
X-Proofpoint-ORIG-GUID: XAQ1haVbbU-YGElHBqAuhloI7FM9nbWC
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fc8d9d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xoTxleRWwXRO4XdZWWkA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
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

Use new helper defined to program UBWC version to the hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index ccfccc45133f..1923f904d37d 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -282,35 +282,33 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	bool rgb565_predicator = false, amsbc = false;
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	u32 ubwc_version = cfg->ubwc_enc_version;
-	u32 hbb, hbb_hi, hbb_lo, mode = 1;
+	u32 hbb, hbb_hi, hbb_lo, mode;
 	u8 uavflagprd_inv = 2;
 
 	switch (ubwc_version) {
 	case UBWC_6_0:
 		yuvnotcomptofc = true;
-		mode = 5;
 		break;
 	case UBWC_5_0:
 		amsbc = true;
 		rgb565_predicator = true;
-		mode = 4;
 		break;
 	case UBWC_4_0:
 		amsbc = true;
 		rgb565_predicator = true;
 		fp16compoptdis = true;
 		rgba8888_lossless = true;
-		mode = 2;
 		break;
 	case UBWC_3_0:
 		amsbc = true;
-		mode = 1;
 		break;
 	default:
 		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
 		break;
 	}
 
+	mode = qcom_ubwc_version_tag(cfg);
+
 	/*
 	 * We subtract 13 from the highest bank bit (13 is the minimum value
 	 * allowed by hw) and write the lowest two bits of the remaining value

-- 
2.47.3

