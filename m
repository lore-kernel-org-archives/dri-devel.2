Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFDBCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF5010F0AA;
	Wed, 20 May 2026 14:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RQ0RXCA6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCf2D/g3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7338A10F0AA
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE2RwC826685
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FqMqhI5UYkOHH0CWlGEm+fCS4mKO20wPw4ekmFs5Kkg=; b=RQ0RXCA6PbqLb/Fx
 WlXE3RChKqir9pgSvrG+scBdVL8hkGPu0CC50TNpLGr/DBpoqynSgUZFbg+aMvi0
 QXPkHFX0XG8HfIVwE6D7S9XcOWl5PJDLC/KfJBhnR1KdXuG3XqhFlqBzuNoynnTE
 k3xdi7IqzPLBmi8AGkPQ7R4WRSXnVVqkMU5qU06QsTEZuMOg8iVkTbcZpACq8C7u
 0d8TI6OvnL6ihaWmfuidvY4ipsxbOrqAElF/JYfWvKqH/UGMaBFTaK9XEXudShLV
 mojhsnur7LO/riw0ls96Scu9R5hace9g8zjya3ZhVWzOsSWsWe/iaSZSKHi/kqEQ
 xV5bNw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ecag6dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:33 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-57584c23424so13265479e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288693; x=1779893493;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FqMqhI5UYkOHH0CWlGEm+fCS4mKO20wPw4ekmFs5Kkg=;
 b=ZCf2D/g3SxHuBiROYc6uyov9FaoAg610jBuS1Sc6lJi2ZmUxD9kdWCm3NAH3+eExqA
 TbapEEvVmdQaW1t0au3wqA+0Bwwmk4wgHkJrQt3kZyHfHntkIM0ln1hpn35QWdmXJYrt
 qT/CP5H0HGzVEnaQKqOIA6pCrq3efVqM7xntLz2mHiM9Pmq3DcBnuYqtIZfMUzvQQsxM
 bgitkH3Wxxpob4O15pFpKpGRK54XqLUU208yQs1ETGBM6/kugVeilLjlZ0Nv7FjSzn6A
 5XFSGEnE6iMgjFfXIqpZABEBkl+QRZe1/NUkPek1NyApdYg8ZCoo9Nc0UCMvrJZHdCu9
 cl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288693; x=1779893493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FqMqhI5UYkOHH0CWlGEm+fCS4mKO20wPw4ekmFs5Kkg=;
 b=g32MPKezAuuvGTd03xGBN4u8B+Af/M7QCQTLU3yL8nOTVPZVPUsryaOG/hCdPaw5gG
 exE7VnwO1qxjoHn2wDkUaU+eSu1LCimscCaq9zPE7GumhC4onnOcPnxFKydHOFzXKWw+
 mTG0BHkZ+IlulR/H5Ic73DWwoTgDdfQdqRdIsoN3Cq3sjpBKJq/y0cOJukyCiSXsklfX
 cCc013Xl2JHV9/XUjkP4ZRX0VlKZ9sivYVZioaeL2FvORIH5SGjhvbkfr1NTWauWLpDV
 WSkPvLLDTHkMfUCkcJYMnZa2+SyY65BaBARK8hssee6AgK7wByRZYeImm/vG7etm5aaE
 pPVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/r0Rcr/8CKglIp22Ey7rL9iO1g2D4UHx7WZKIDbNAdrFVbgzLvC5GzLtBXS6tWWiSVBayJGTi6pFI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIFHHBSCBpfUs8XL5EQrLaB5hDETF+nMxVzrFz7rMPK8T11AK+
 qlWYeyNgA+Dxc4B1pW1dXzYiUfrK8zTQ6q4w4s5CBGwjS0NxBwj/+EPrmmBSI9xw8XM1NdXsZl4
 ABBrAiP57GFMQQBuBjbH5Ndg8ZxMRqLoomu/fnYt5tzoR1dZV+xYrJYI/GUy75rnudOSBVIA=
X-Gm-Gg: Acq92OEE77vpOST0yO6lPrXEHW9GyhJjvEglWb5uA9WBbIGdkbeqcGWOQRB4qfHyOGR
 IYKVNJbOJH1aEANb95Ns4d4N911EcO48dWqEA7//F0oM6FCBOB3DfvgTFM4OTT+huq3jEFZgV9s
 uflU7IPhAO1W7CiDWFM8eGtayUrUkFVuqwup4WGFyHZh/axPvv+T3wU21WaKfvGabImfxqukXfT
 fQLZY0fAYfFt/alJIAIlt7XYmgVzEuurbzwKOS2Ek5X2rz5w1uPasXkb/we73vZcKyxyCwuHAbI
 oZtahSvm8Ng0U1pLz6YBNNGH2mY8ywirmbDXXy0tFHL1k4TcB9qLteCE2PXnPIFOMl8C+mVH1Lh
 ITewhyppC4NI4fsvR2mjwpSHdWWJhvmyHDdZlKCJKvHUujGr2kDrkRbDN7Yj15bw1FEu1+TR2fe
 ifUHvYroO0U0KtsqhR8VH8LMzFmSvUB0fxxXI=
X-Received: by 2002:a05:6122:920:b0:574:6c7d:ff08 with SMTP id
 71dfb90a1353d-5760bfb8c49mr14718733e0c.1.1779288692973; 
 Wed, 20 May 2026 07:51:32 -0700 (PDT)
X-Received: by 2002:a05:6122:920:b0:574:6c7d:ff08 with SMTP id
 71dfb90a1353d-5760bfb8c49mr14718621e0c.1.1779288691430; 
 Wed, 20 May 2026 07:51:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:12 +0300
Subject: [PATCH v5 05/28] drm/msm/adreno: use qcom_ubwc_version_tag()
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-5-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0l58tGlCZ3KJhlnY7QHsm5XAPXWOlSpowmtYXNxh9w4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpm+jKgocPYblJFNAWl3I+e8kco9lDn6wZwP
 H6K0qUhOxGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZgAKCRCLPIo+Aiko
 1SVyCACsyXzB2/3qJ9oEITmYeNPQ8pb5ecPBHWIyxss0NLfSG09OY1LszIQJbDAOElFDIi0BwyD
 /2QUMiU12+O/Iw2EOSwJkLruPtrNxlZMEKphxlEu1/5bzoo1rmNODFavRQNjcPcrU5zpFxRY77e
 ZC/DSsA3U1I9i9apqLif4jP8eC6m1HSN7vGXcldD+7stgh5QIYZKorw0YuvMC01sZlm8DZeOCGp
 ZZxJvsnTYVv65cuV2132BRV4JL+tCnbvANSP0g4e/kXm9QCnUQFFQYLXCerDMvx5TbKmpiG0C0J
 /endi0aQSN7Ef5RAnGWawBPg9eSN5wzLSVZoVXyc6ZvO8bW7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: tDY4zVnEUidiCxjTXVzjuGI1fMTfU5C4
X-Authority-Analysis: v=2.4 cv=WqMb99fv c=1 sm=1 tr=0 ts=6a0dca75 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=xoTxleRWwXRO4XdZWWkA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX7F7zWiAx4p+q
 UHTU7/hQLQh5nOju/eHodu+KVkcK6Fa8UZWW4xChxTyLtLycCBUIjRSQrlV5cUp5vQcGuAIwqR9
 RlhCWuhVAfbKz+lSTHKxYIcThMWVH68a9/4RqNeOESWkMwKZEtVPSFv9yrbGLImsZrslbDsapEG
 tf5aSnE8eN6AmXMSA6o9lBZv/k9/LS9RZp566VTWSG9Zc1dDRHCERxAsqplXjdkWH4Hk7fmyLyd
 m3v3IVMC9gL/3rWwGhesOTLVexBllEPtDuR7aJtv1OZCfcnml786Fab4ZKxhMo5uV6nHovMGnAf
 WfUHc6t9U6TtPI5MX1s8qckLjEGhEJZMmYzod0BPDmfZJSAiUeHLUOeoY/N99VFFc+79O8wlvHr
 3w+oOU1I6mK+rz+/j9EbR23DQz5bi54rO+vQGN0KyAjiVAGClKwrhS7e5R7/T/4IYz65J0yf7nE
 OYTZ0cYGxMmMeyLS5Mw==
X-Proofpoint-ORIG-GUID: tDY4zVnEUidiCxjTXVzjuGI1fMTfU5C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
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

Use new helper defined to program UBWC version to the hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

