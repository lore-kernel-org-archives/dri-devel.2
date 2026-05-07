Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2894FCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FED010F11D;
	Thu,  7 May 2026 13:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+xa7thf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jFdfCCGo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C3710F0F0
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:02 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pU0N1424462
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nOhtk+T5Qeojg+oP0GMyR2EynxX1OfJWaHf6gSAwPPA=; b=o+xa7thf4YlEoVfX
 +SQQS25mphW2NL5GBsNLBD8jki8Zu22zEm8mtCw/JnyIraP7EOUbyyd9tTGO1rOf
 I0lQAOsk3IQ/YLO9pnp4NTtuLDGs9+a4tUJPG0jF4cGW8fltwsbyo5iPLwflXPw5
 ZPVAn6zilGWwMdSi/XlTQIGiXP9pYMK2s8AhnFLcN9r9yuJLvUvLpHNUm/UDU9Eo
 XqHL39xztDfA0migHqRcJ2CrFuO/yqL3ah3pS2qEZfYVRJu6AQwOJTWbI+g5Ps8S
 c+O+A9sJPJLhxSHExZSiAiZbkJ93oPAsFqA5VBxoFj04GHU8EpQNA1m75jc6bGQe
 /clbog==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfs46s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b9a6d84522so16271635ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159040; x=1778763840;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOhtk+T5Qeojg+oP0GMyR2EynxX1OfJWaHf6gSAwPPA=;
 b=jFdfCCGotwnRjabAvQF9csbg1bvf2rd0meV9pe1eeuCHguTAmv1MPlBrDlGuKv0wgl
 6zZ+YBrd+PgRMdMY/+U8FIzI9EmhZ3UW3sCG98Z2lFM6iQrIiwIvQtfPzGsJx/ruCRls
 KEc4ugFRVU4NFQsbzAz9TbXw4P8qLALfn4QeKmN+iAVeJPquFO87fOdvoBkNL+4vZ6xU
 v/4bwef2MhMH7EdS2IwNnY4bkZLvSHIE1Q4k8W/VasUVchAVyh4HvtS7c7askFiaGbN2
 5rGCRJkCnXRXLjrdOtSYcnDY/yDU37FuNbucXJoyabCiIRKk9iAxYauwHrw/Suct67UK
 Xnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159040; x=1778763840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nOhtk+T5Qeojg+oP0GMyR2EynxX1OfJWaHf6gSAwPPA=;
 b=n/vB9Kdd/odxOElup8pqDJzAo+g5V+XEv/EB1RyHMFiDv6N8qnUWdIHox+LftytgDp
 vby07GcBDONO7v728zvJdRhfIgbJwRoEuhCW4NUeYKHUDP4of3DwvnfCAbD8S2o+K9QV
 bsnq9LYNbFzTwt43UDR7foszmqe+CqSmwsJEjDJM3+E0O3Yl26Af+MW6kXtB6tPO7hLW
 P2VTstpLks+IEq9NSHfBrrN0YiblhCR9Sj7PxUdjdpDvpAoA4UmHVe2CmP9rIfVgWKKM
 GvUkcdUF76QBN7PndhZSXkasDvHkWo/3JI5VZxcbeqH/VS//SNW1dJzt18bzl8ETkIvN
 rsLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BgrtoQdjNd9L5LmD9DDKY5bgty/ICEekK/qsu9i0W0Ljr8di8bAMyaEvCgD+1BVPJ0DRyVEmvwd4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0J0lV8hZQ5Y35Y5i9GvPLY8YL8wxVhugOkiD5rNvWmvkrs0Ut
 LnBWbzy8khg4NCdepnit/USUEljqiflQkUZHBV/FH1xOvwY68CnnvY24Um2sP8i8kKtkih32hKF
 xvTJuuefTC0wq86NgwXbWuMyEx53mPV+01eEKjORFWh9SrYVmWPTy25h0tIhSvcuOVp2AhY4=
X-Gm-Gg: AeBDiescTt9a0OiOymaadtryUi0C+n3JOcmhwLjkz9H7JINXKpn3iBqj8Ghz5oe1/eI
 S4WRWDwCugAY9W+3wg+Meicu7/c66J4nq/XY+NOKhCL80hpM6P8w6kTiXIRKV8aQa1SV79KYdIx
 NM7AIxZ58W2WGZnOGp36gavC7sxfP2Vsae2FC3w6WLaACbPa8J3Q07p+ZkDSpg2EKKucwXaBuHK
 vPEtDREGz6ooQQYS25Bg1lqEMKWp2AlZLUGK/RgFH+DH5C0YtlKEN6PmecOPH7o+k7MLpQxRMNZ
 /Tszl3SJIRTxFeVWrQJOcF8K9L1ia3NUACz1QiNR5uW17Yf0TjOWserQOafIVsWNUaZU5qn/p72
 ococUj4aChQWJe3eE34niYl8357x/LFBmppRKFnYLue20jN8eUwzcIZKE12vdOQUF2bvFCN/Xiu
 yaCWarpveswTDCxjwnsiIfG2baOf06jNtpGemsDC2eWI/k3t1SXWosNYTU
X-Received: by 2002:a17:903:151:b0:2b4:5cea:f61c with SMTP id
 d9443c01a7336-2ba78b48767mr57604185ad.4.1778159040256; 
 Thu, 07 May 2026 06:04:00 -0700 (PDT)
X-Received: by 2002:a17:903:151:b0:2b4:5cea:f61c with SMTP id
 d9443c01a7336-2ba78b48767mr57603755ad.4.1778159039654; 
 Thu, 07 May 2026 06:03:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:14 +0300
Subject: [PATCH v4 18/29] drm/msm/adreno: use new helper to set amsbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-18-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ibw1W4RxXxm+xTq1o2582iDKALgKQbHejlJobaatd7Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2GdeQsVex3N6owpP2pA9FewFltQW5GK42rB
 dz4tBHATp+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhgAKCRCLPIo+Aiko
 1XWQCACgehnNB4GH/t78ejQi5pMD6T9QCqnBPc224Zs2w6wxkll2e1PSz4Rdl2BakSN0BD9lbqf
 lgatMMprwMfSfuMAHEjUflF60smTphqMqTp//8m8CaKjfsiLK6z8hrlwIO8dALiXOeJrOOSO/eH
 OqQva/bU3OVvAAp/MkwHMGGPVz7kcyFmlboECTg69GuP+SBeRp6voRakIdNEHqvOKpY29e9d2nj
 tAyZCO99prTbo6i1xDBmfl8MQfriIkd0hSXc3Se2X3lCjiz+XHH3R3/nfP3uQCXEaakffdpYa5v
 lkT3rZL++8OZBZQMyqeaFKeTnTHZ0IpdSmI5McMAbxSdfwGf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc8dc1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ZxXxw7YCAI2S9HbMwnMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX5jyIzMifeRp6
 0sXlvFtPkZcGq32Wc9Un7hBQYEV5IZAB+HnVzv6YF0IivOI85OvCRJrU3iq9y6KKD4d31nqkd4e
 CfG50SCWeGZv5cQlhNOksice1XN9MtoNuTlnLHSt7Dq6Yl8ZktUmoAsYB1jws3dxlGmD9NJ5oUA
 FacDJCBlfL+hVabkLYOPofP6I6b4pbSNmIww2oIiEe2yUmJYXLSkwrsQHG3rrTnsbzHFD/kHx85
 5hgIa3MGITVzITZ9nnP8+gWe1BOGgh4PXhd8KHQEWqbQLMTZgZWpZHorISPyqwKiTVs8cIblC+9
 br+lSIaw8sz4DzVAwhTejHCZWtGnIiHOCn+I8jfuOs8WQp5UbRSDKrbVX1MLuYBqNFoGplpTfg5
 XLFudCqXC7Dt7aFc7fhzckyYWFF1VjCzAXRc+bXmJmVYz9J0kEoA0g4P9sZDWc0G8azotSuKdLD
 ZdOjSCOOmv6G7VivJnA==
X-Proofpoint-GUID: ksaQI6l4SyivbJ153c5VnzEnvUqJoaQ4
X-Proofpoint-ORIG-GUID: ksaQI6l4SyivbJ153c5VnzEnvUqJoaQ4
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

Use freshly defined helper instead of checking the UBWC version
directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 5c17565b0499..a88489bdad9a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -747,7 +747,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
 	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
-	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
+	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
 	bool min_acc_len_64b;
 	u8 uavflagprd_inv = 0;
 	u32 hbb_hi = hbb >> 2;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 867c7d05f670..5c73a9ebb22b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -279,7 +279,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 level3_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL3);
 	bool rgba8888_lossless = false, fp16compoptdis = false;
 	bool yuvnotcomptofc = false, min_acc_len_64b = false;
-	bool rgb565_predicator = false, amsbc = false;
+	bool rgb565_predicator = false;
+	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	u32 ubwc_version = cfg->ubwc_enc_version;
 	u32 hbb, hbb_hi, hbb_lo, mode;
@@ -288,21 +289,17 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	switch (ubwc_version) {
 	case UBWC_6_0:
 		yuvnotcomptofc = true;
-		amsbc = true;
 		rgb565_predicator = true;
 		break;
 	case UBWC_5_0:
-		amsbc = true;
 		rgb565_predicator = true;
 		break;
 	case UBWC_4_0:
-		amsbc = true;
 		rgb565_predicator = true;
 		fp16compoptdis = true;
 		rgba8888_lossless = true;
 		break;
 	case UBWC_3_0:
-		amsbc = true;
 		fp16compoptdis = true;
 		break;
 	default:

-- 
2.47.3

